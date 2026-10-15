using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace MobileShoppingCatalog
{
    public partial class Checkout : System.Web.UI.Page
    {
        string cs = ConfigurationManager
            .ConnectionStrings["MobileDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowOrderSummary();
            }
        }

        private void ShowOrderSummary()
        {
            DataTable cart = CartHelper.GetCart(Context);

            rptCheckout.DataSource = cart;
            rptCheckout.DataBind();

            decimal total = 0;

            foreach (DataRow row in cart.Rows)
            {
                total += Convert.ToDecimal(row["price"]) *
                         Convert.ToInt32(row["quantity"]);
            }

            lblSubtotal.Text = total.ToString("N2");
            lblTotal.Text = total.ToString("N2");

            btnPlaceOrder.Enabled = cart.Rows.Count > 0;

            lblMessage.Text = cart.Rows.Count == 0
                ? "Your cart is empty."
                : "Review your items before confirming your order.";
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            DataTable cart = CartHelper.GetCart(Context);

            if (cart.Rows.Count == 0)
            {
                lblMessage.Text = "Your cart is empty.";
                btnPlaceOrder.Enabled = false;
                return;
            }

            decimal total = 0;

            foreach (DataRow row in cart.Rows)
            {
                total += Convert.ToDecimal(row["price"]) *
                         Convert.ToInt32(row["quantity"]);
            }

            string cartId = CartHelper.GetCartId(Context);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                using (SqlTransaction tran = con.BeginTransaction())
                {
                    try
                    {
                        int orderId;

                        string orderQuery =
                            "INSERT INTO Orders (CartId, TotalAmount) " +
                            "VALUES (@cartId, @total); " +
                            "SELECT CAST(SCOPE_IDENTITY() AS INT);";

                        using (SqlCommand cmd =
                            new SqlCommand(orderQuery, con, tran))
                        {
                            cmd.Parameters.AddWithValue("@cartId", cartId);
                            cmd.Parameters.AddWithValue("@total", total);

                            orderId = Convert.ToInt32(cmd.ExecuteScalar());
                        }

                        foreach (DataRow row in cart.Rows)
                        {
                            string itemQuery =
                                "INSERT INTO OrderItems " +
                                "(OrderId, MobileId, MobileName, Price, Quantity) " +
                                "VALUES (@orderId, @mobileId, @name, @price, @quantity)";

                            using (SqlCommand cmd =
                                new SqlCommand(itemQuery, con, tran))
                            {
                                cmd.Parameters.AddWithValue("@orderId", orderId);
                                cmd.Parameters.AddWithValue("@mobileId", row["Id"]);
                                cmd.Parameters.AddWithValue("@name", row["name"]);
                                cmd.Parameters.AddWithValue("@price", row["price"]);
                                cmd.Parameters.AddWithValue("@quantity", row["quantity"]);

                                cmd.ExecuteNonQuery();
                            }
                        }

                        tran.Commit();
                    }
                    catch (Exception)
                    {
                        tran.Rollback();

                        lblMessage.Text =
                            "Order could not be saved. Please check the database tables.";

                        return;
                    }
                }
            }

          
            CartHelper.ClearCart(Context);

          
            rptCheckout.DataSource = new DataTable();
            rptCheckout.DataBind();

            lblSubtotal.Text = "0.00";
            lblTotal.Text = "0.00";

            lblMessage.Text = "Order placed successfully!";

            btnPlaceOrder.Enabled = false;
        }

       protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("WebForm1.aspx");
        }
    }
}

