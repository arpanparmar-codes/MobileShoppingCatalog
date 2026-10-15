


using System;
using System.Data.SqlClient;
using System.Configuration;

namespace MobileShoppingCatalog
{
    public partial class MobileDetails : System.Web.UI.Page
    {
        int mobileId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] == null)
            {
                Response.Redirect("WebForm1.aspx");
                return;
            }

            if (!int.TryParse(Request.QueryString["id"], out mobileId))
            {
                Response.Redirect("WebForm1.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadMobileDetails();
            }
        }

        private void LoadMobileDetails()
        {
            string cs = ConfigurationManager
                .ConnectionStrings["MobileDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query =
                    "SELECT Id, name, price, image FROM MOBILE WHERE Id = @id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@id", mobileId);

                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            lblName.Text = dr["name"].ToString();

                            decimal price =
                                Convert.ToDecimal(dr["price"]);

                            lblPrice.Text = price.ToString("N0");

                            imgMobile.ImageUrl = ResolveUrl(
                                "~/Images/" + dr["image"].ToString());

                            imgMobile.AlternateText =
                                dr["name"].ToString();
                        }
                        else
                        {
                            lblMessage.Text = "Mobile not found.";
                            btnAddCart.Enabled = false;
                        }
                    }
                }
            }
        }

        protected void btnAddCart_Click(object sender, EventArgs e)
        {
            try
            {
                CartHelper.AddItem(Context, mobileId);

                lblMessage.Text =
                    "Mobile added to cart successfully!";
            }
            catch (Exception)
            {
                lblMessage.Text =
                    "Could not add mobile to cart. Please try again.";
            }
        }
    }
}
