
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace MobileShoppingCatalog
{
    public static class CartHelper
    {
        private static string CS
        {
            get
            {
                return ConfigurationManager
                    .ConnectionStrings["MobileDB"].ConnectionString;
            }
        }

        public static string GetCartId(HttpContext context)
        {
            string cartId = null;

            HttpCookie cookie = context.Request.Cookies["ShoppingCartId"];

            if (cookie != null)
                cartId = cookie.Value;

            if (string.IsNullOrEmpty(cartId))
            {
                cartId = Guid.NewGuid().ToString();

                HttpCookie newCookie =
                    new HttpCookie("ShoppingCartId", cartId);

                newCookie.Expires = DateTime.Now.AddDays(30);
                newCookie.HttpOnly = true;

                context.Response.Cookies.Add(newCookie);
            }

            using (SqlConnection con = new SqlConnection(CS))
            using (SqlCommand cmd = new SqlCommand(
                "IF NOT EXISTS (SELECT 1 FROM ShoppingCarts WHERE CartId=@id) " +
                "INSERT INTO ShoppingCarts (CartId) VALUES (@id)", con))
            {
                cmd.Parameters.AddWithValue("@id", cartId);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            return cartId;
        }

        public static DataTable GetCart(HttpContext context)
        {
            string cartId = GetCartId(context);

            DataTable cart = new DataTable();

            using (SqlConnection con = new SqlConnection(CS))
            using (SqlCommand cmd = new SqlCommand(
                "SELECT m.Id, m.name, m.price, m.image, ci.Quantity AS quantity " +
                "FROM ShoppingCartItems ci " +
                "INNER JOIN MOBILE m ON ci.MobileId=m.Id " +
                "WHERE ci.CartId=@id ORDER BY m.name", con))
            {
                cmd.Parameters.AddWithValue("@id", cartId);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(cart);
                }
            }

            // Keep a temporary copy in Session too.
            context.Session["Cart"] = cart;

            return cart;
        }

        public static void AddItem(HttpContext context, int mobileId)
        {
            string cartId = GetCartId(context);

            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();

                using (SqlTransaction tran = con.BeginTransaction())
                {
                    try
                    {
                        using (SqlCommand check = new SqlCommand(
                            "SELECT COUNT(*) FROM MOBILE WHERE Id=@mobileId",
                            con, tran))
                        {
                            check.Parameters.AddWithValue("@mobileId", mobileId);

                            if (Convert.ToInt32(check.ExecuteScalar()) == 0)
                                throw new Exception("Mobile not found.");
                        }

                        string query =
                            "IF EXISTS (SELECT 1 FROM ShoppingCartItems " +
                            "WHERE CartId=@cartId AND MobileId=@mobileId) " +
                            "UPDATE ShoppingCartItems SET Quantity=Quantity+1 " +
                            "WHERE CartId=@cartId AND MobileId=@mobileId " +
                            "ELSE INSERT INTO ShoppingCartItems " +
                            "(CartId, MobileId, Quantity) VALUES (@cartId, @mobileId, 1)";

                        using (SqlCommand cmd = new SqlCommand(query, con, tran))
                        {
                            cmd.Parameters.AddWithValue("@cartId", cartId);
                            cmd.Parameters.AddWithValue("@mobileId", mobileId);
                            cmd.ExecuteNonQuery();
                        }

                        tran.Commit();
                    }
                    catch
                    {
                        tran.Rollback();
                        throw;
                    }
                }
            }

            GetCart(context);
        }

        public static void RemoveItem(HttpContext context, int mobileId)
        {
            string cartId = GetCartId(context);

            using (SqlConnection con = new SqlConnection(CS))
            using (SqlCommand cmd = new SqlCommand(
                "DELETE FROM ShoppingCartItems " +
                "WHERE CartId=@cartId AND MobileId=@mobileId", con))
            {
                cmd.Parameters.AddWithValue("@cartId", cartId);
                cmd.Parameters.AddWithValue("@mobileId", mobileId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            GetCart(context);
        }

        public static void UpdateQuantity(
            HttpContext context, int mobileId, int quantity)
        {
            if (quantity <= 0)
                throw new ArgumentException("Quantity must be greater than zero.");

            string cartId = GetCartId(context);

            using (SqlConnection con = new SqlConnection(CS))
            using (SqlCommand cmd = new SqlCommand(
                "UPDATE ShoppingCartItems SET Quantity=@quantity " +
                "WHERE CartId=@cartId AND MobileId=@mobileId", con))
            {
                cmd.Parameters.AddWithValue("@quantity", quantity);
                cmd.Parameters.AddWithValue("@cartId", cartId);
                cmd.Parameters.AddWithValue("@mobileId", mobileId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            GetCart(context);
        }

        public static void ClearCart(HttpContext context)
        {
            string cartId = GetCartId(context);

            using (SqlConnection con = new SqlConnection(CS))
            using (SqlCommand cmd = new SqlCommand(
                "DELETE FROM ShoppingCartItems WHERE CartId=@id", con))
            {
                cmd.Parameters.AddWithValue("@id", cartId);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            context.Session["Cart"] = new DataTable();
        }
    }
}
