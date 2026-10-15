
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace MobileShoppingCatalog
{
    public partial class Wishlist : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["MobileDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindWishlist();
            }
        }

        void BindWishlist()
        {
            string cartId = CartHelper.GetCartId(Context);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT M.Id AS MobileId, M.name, M.price
                    FROM WishlistItems W
                    INNER JOIN MOBILE M ON W.MobileId = M.Id
                    WHERE W.CartId = @CartId
                    ORDER BY W.WishlistItemId DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CartId", cartId);

                    DataTable dt = new DataTable();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }

                    gvWishlist.DataSource = dt;
                    gvWishlist.DataBind();
                }
            }
        }

        protected void gvWishlist_RowCommand(
            object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "RemoveItem")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int mobileId = Convert.ToInt32(
                    gvWishlist.DataKeys[rowIndex].Value);

                string cartId = CartHelper.GetCartId(Context);

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"
                        DELETE FROM WishlistItems
                        WHERE CartId = @CartId AND MobileId = @MobileId";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@CartId", cartId);
                        cmd.Parameters.AddWithValue("@MobileId", mobileId);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMessage.Text = "Mobile removed from wishlist.";
                BindWishlist();
           }
       }
   }
}
