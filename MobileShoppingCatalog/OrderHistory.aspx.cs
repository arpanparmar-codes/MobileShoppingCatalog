
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace MobileShoppingCatalog
{
    public partial class OrderHistory : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["MobileDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindOrders();
            }
        }

        void BindOrders()
        {
            string cartId = CartHelper.GetCartId(Context);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT OrderId, OrderDate, TotalAmount
                    FROM Orders
                    WHERE CartId = @CartId
                    ORDER BY OrderDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CartId", cartId);

                    DataTable dt = new DataTable();

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }

                    gvOrders.DataSource = dt;
                    gvOrders.DataBind();

                    if (dt.Rows.Count == 0)
                    {
                        lblMessage.Text =
                            "No orders found for this browser yet.";
                    }
                    else
                    {
                        lblMessage.Text = "";
                    }
                }
            }
        }
    }
}
