
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace MobileShoppingCatalog
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string cs = ConfigurationManager
            .ConnectionStrings["MobileDB"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMobiles("", "", "", "default");
            }
        }


        private void BindMobiles(string search, string minPrice,
                                 string maxPrice, string sort)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT Id, name, price, image FROM MOBILE WHERE 1=1";

                if (search != "")
                    query += " AND name LIKE @search";

                if (minPrice != "")
                    query += " AND price >= @minPrice";

                if (maxPrice != "")
                    query += " AND price <= @maxPrice";

                if (sort == "low")
                    query += " ORDER BY price ASC";
                else if (sort == "high")
                    query += " ORDER BY price DESC";
                else
                    query += " ORDER BY Id ASC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (search != "")
                        cmd.Parameters.AddWithValue("@search", "%" + search + "%");

                    if (minPrice != "")
                        cmd.Parameters.AddWithValue("@minPrice",
                            Convert.ToInt32(minPrice));

                    if (maxPrice != "")
                        cmd.Parameters.AddWithValue("@maxPrice",
                            Convert.ToInt32(maxPrice));

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvMobiles.DataSource = dt;
                        gvMobiles.DataBind();

                        if (dt.Rows.Count == 0)
                            lblMessage.Text = "No mobiles found.";
                        else
                            lblMessage.Text = dt.Rows.Count + " mobile(s) found.";
                    }
                }
            }
        }

        protected void btnBrowse_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            txtMinPrice.Text = "";
            txtMaxPrice.Text = "";
            ddlSort.SelectedValue = "default";

            BindMobiles("", "", "", "default");
        }

        protected void btnSearchFilter_Click(object sender, EventArgs e)
        {
            int min;
            int max;

            if (txtMinPrice.Text.Trim() != "" &&
                !int.TryParse(txtMinPrice.Text.Trim(), out min))
            {
                lblMessage.Text = "Enter a valid minimum price.";
                return;
            }

            if (txtMaxPrice.Text.Trim() != "" &&
                !int.TryParse(txtMaxPrice.Text.Trim(), out max))
            {
                lblMessage.Text = "Enter a valid maximum price.";
                return;
            }

            if (txtMinPrice.Text.Trim() != "" &&
                txtMaxPrice.Text.Trim() != "")
            {
                min = Convert.ToInt32(txtMinPrice.Text.Trim());
                max = Convert.ToInt32(txtMaxPrice.Text.Trim());

                if (min > max)
                {
                    lblMessage.Text =
                        "Minimum price cannot exceed maximum price.";
                    return;
                }
            }

            BindMobiles(
                txtSearch.Text.Trim(),
                txtMinPrice.Text.Trim(),
                txtMaxPrice.Text.Trim(),
                ddlSort.SelectedValue
            );
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            txtMinPrice.Text = "";
            txtMaxPrice.Text = "";
            ddlSort.SelectedValue = "default";

            gvMobiles.DataSource = null;
            gvMobiles.DataBind();

            lblMessage.Text =
                "Filters cleared. Click Browse All Mobiles.";
        }

        protected void gvMobiles_RowCommand(
            object sender, GridViewCommandEventArgs e)
        {
            int id;

            if (e.CommandName == "ShowDetails")
            {
                if (int.TryParse(Convert.ToString(e.CommandArgument), out id))
                {
                    Response.Redirect("MobileDetails.aspx?id=" + id);
                }
            }
            else if (e.CommandName == "AddCart")
            {
                if (int.TryParse(Convert.ToString(e.CommandArgument), out id))
                {
                    try
                    {
                        CartHelper.AddItem(Context, id);
                        lblMessage.Text = "Mobile added to cart and saved!";
                    }
                    catch (Exception)
                    {
                        lblMessage.Text =
                            "Could not add mobile to cart. Please try again.";
                    }
                }
            }
            else if (e.CommandName == "AddWishlist")
            {
                if (int.TryParse(Convert.ToString(e.CommandArgument), out id))
                {
                    try
                    {
                        string cartId = CartHelper.GetCartId(Context);

                        using (SqlConnection con = new SqlConnection(cs))
                        {
                            string query = @"
                                IF NOT EXISTS
                                (
                                    SELECT 1
                                    FROM WishlistItems
                                    WHERE CartId = @CartId
                                      AND MobileId = @MobileId
                                )
                                BEGIN
                                    INSERT INTO WishlistItems (CartId, MobileId)
                                    VALUES (@CartId, @MobileId)
                                END";

                            using (SqlCommand cmd =
                                new SqlCommand(query, con))
                            {
                                cmd.Parameters.AddWithValue("@CartId", cartId);
                                cmd.Parameters.AddWithValue("@MobileId", id);

                                con.Open();
                                cmd.ExecuteNonQuery();
                            }
                        }

                        lblMessage.Text =
                            "Mobile saved to your wishlist!";

                    }
                    catch (Exception)
                    {
                        lblMessage.Text =
                            "Could not save to wishlist. Check that the WishlistItems table exists.";
                    }
                }
            }
        }
    }
}
