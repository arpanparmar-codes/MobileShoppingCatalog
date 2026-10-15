
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MobileShoppingCatalog
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCart();
            }
        }

        private void BindCart()
        {
            DataTable cart = CartHelper.GetCart(Context);

            gvCart.DataSource = cart;
            gvCart.DataBind();

            decimal total = 0;

            foreach (DataRow row in cart.Rows)
            {
                total += Convert.ToDecimal(row["price"]) *
                         Convert.ToInt32(row["quantity"]);
            }

            lblTotal.Text = total.ToString("0.00");

            lblMessage.Text = cart.Rows.Count == 0
                ? "Your cart is empty."
                : cart.Rows.Count + " mobile type(s) in your cart.";
        }

        protected void gvCart_RowCommand(
            object sender, GridViewCommandEventArgs e)
        {
            int id;

            if (!int.TryParse(Convert.ToString(e.CommandArgument), out id))
                return;

            try
            {
                if (e.CommandName == "RemoveItem")
                {
                    CartHelper.RemoveItem(Context, id);
                    lblMessage.Text = "Mobile removed from cart.";
                }
                else if (e.CommandName == "UpdateQuantity")
                {
                    GridViewRow gridRow =
                        (GridViewRow)((Control)e.CommandSource).NamingContainer;

                    TextBox txt =
                        (TextBox)gridRow.FindControl("txtQuantity");

                    int quantity;

                    if (txt == null ||
                        !int.TryParse(txt.Text, out quantity) ||
                        quantity <= 0)
                    {
                        lblMessage.Text =
                            "Enter a quantity greater than zero.";
                        return;
                    }

                    CartHelper.UpdateQuantity(Context, id, quantity);
                    lblMessage.Text = "Quantity updated.";
                }

                BindCart();
            }
            catch (Exception)
            {
                lblMessage.Text = "Could not update the cart.";
            }
        }
    }
}
