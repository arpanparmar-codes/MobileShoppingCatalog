
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="MobileShoppingCatalog.Cart" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>MobileHub | Shopping Cart</title>

    <style type="text/css">
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f5f7fb;
            color: #172b4d;
        }

        .nav {
            background: #111c35;
            padding: 18px 5%;
            overflow: hidden;
        }

        .brand {
            float: left;
            color: white;
            text-decoration: none;
            font-size: 27px;
            font-weight: bold;
        }

        .brand span {
            color: #60a5fa;
        }

        .nav-links {
            float: right;
            padding-top: 8px;
        }

        .nav-links a {
            display: inline-block;
            color: #e2e8f0;
            text-decoration: none;
            font-size: 13px;
            font-weight: bold;
            margin-left: 18px;
        }

        .nav-links a:hover {
            color: #60a5fa;
        }

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 35px auto;
        }

        .heading {
            margin-bottom: 25px;
        }

        .heading h1 {
            margin: 0 0 10px;
            font-size: 32px;
        }

        .heading p {
            color: #64748b;
            line-height: 1.6;
        }

        .cart-panel {
            background: white;
            border: 1px solid #e7ecf4;
            border-radius: 13px;
            padding: 22px;
            overflow-x: auto;
        }

        .cart {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        .cart th {
            background: #172b4d;
            color: white;
            padding: 15px 10px;
            text-align: left;
            font-size: 13px;
        }

        .cart td {
            padding: 15px 10px;
            border-bottom: 1px solid #e8edf5;
            text-align: left;
            vertical-align: middle;
            font-size: 14px;
        }

        .cart tr:hover td {
            background: #f8faff;
        }

        .mobile-image {
            width: 95px;
            height: 75px;
        }

        .quantity {
            width: 65px;
            padding: 9px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
        }

        .btn {
            display: inline-block;
            padding: 11px 14px;
            margin: 3px;
            border: none;
            border-radius: 7px;
            background: #2563eb;
            color: white;
            font-size: 12px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
        }

        .btn:hover {
            background: #1d4ed8;
        }

        .secondary {
            background: #eaf1ff;
            color: #1d4ed8;
        }

        .secondary:hover {
            background: #dbeafe;
        }

        .remove {
            background: #fee2e2;
            color: #b91c1c;
        }

        .remove:hover {
            background: #fecaca;
        }

        .message {
            display: block;
            margin: 0 0 18px;
            color: #2563eb;
            font-size: 14px;
            line-height: 1.6;
            font-weight: bold;
        }

        .summary {
            margin-top: 25px;
            padding: 22px;
            background: #f8faff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            text-align: right;
        }

        .summary h2 {
            margin: 0 0 18px;
            font-size: 25px;
        }

        .total {
            color: #0f766e;
        }

        .empty {
            padding: 20px;
            color: #64748b;
        }

        @media screen and (max-width: 750px) {
            .nav-links {
                float: none;
                clear: both;
                padding-top: 18px;
            }

            .nav-links a {
                margin: 0 12px 8px 0;
            }

            .container {
                width: 94%;
                margin: 24px auto;
            }

            .cart-panel {
                padding: 10px;
            }

            .cart th,
            .cart td {
                padding: 10px 7px;
                font-size: 12px;
            }

            .mobile-image {
                width: 65px;
                height: 60px;
            }

            .btn {
                padding: 9px;
                margin: 2px;
            }

            .summary {
                text-align: left;
            }
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

    <div class="nav">
        <a href="WebForm1.aspx" class="brand">
            Mobile<span>Hub</span>
        </a>

        <div class="nav-links">
            <a href="WebForm1.aspx">Home</a>
            <a href="Wishlist.aspx">Wishlist</a>
            <a href="Cart.aspx">Cart</a>
            <a href="Checkout.aspx">Checkout</a>
            <a href="OrderHistory.aspx">My Orders</a>
        </div>
    </div>

    <div class="container">

        <div class="heading">
            <h1>Shopping Cart</h1>
            <p>Review your selected mobiles and update quantities before checkout.</p>
        </div>

        <asp:Label ID="lblMessage" runat="server"
            CssClass="message"></asp:Label>

        <div class="cart-panel">

            <asp:GridView ID="gvCart" runat="server"
                AutoGenerateColumns="False"
                CssClass="cart"
                DataKeyNames="Id"
                GridLines="None"
                EmptyDataText="Your cart is empty. Browse our collection to find a mobile."
                OnRowCommand="gvCart_RowCommand">

                <EmptyDataRowStyle CssClass="empty" />

                <Columns>

                    <asp:TemplateField HeaderText="Mobile">
                        <ItemTemplate>
                            <asp:Image ID="imgMobile" runat="server"
                                CssClass="mobile-image"
                                ImageUrl='<%# ResolveUrl("~/Images/") + Eval("image") %>'
                                AlternateText='<%# Eval("name") %>' />
                            <br />
                            <strong><%#: Eval("name") %></strong>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Price">
                        <ItemTemplate>
                            <strong>₹<%#: Eval("price", "{0:N0}") %></strong>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Quantity">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQuantity" runat="server"
                                CssClass="quantity"
                                Text='<%# Eval("quantity") %>'
                                TextMode="Number"
                                ToolTip="Enter quantity">
                            </asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Subtotal">
                        <ItemTemplate>
                            <strong>
                                ₹<%#: (Convert.ToDecimal(Eval("price")) *
                                      Convert.ToInt32(Eval("quantity"))).ToString("N0") %>
                            </strong>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>

                            <asp:Button ID="btnUpdate" runat="server"
                                Text="Update"
                                CssClass="btn secondary"
                                CommandName="UpdateQuantity"
                                CommandArgument='<%# Eval("Id") %>' />

                            <asp:Button ID="btnRemove" runat="server"
                                Text="Remove"
                                CssClass="btn remove"
                                CommandName="RemoveItem"
                                CommandArgument='<%# Eval("Id") %>'
                                OnClientClick="return confirm('Remove this mobile from your cart?');" />

                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>

        </div>

        <div class="summary">
            <h2>
                Total: <span class="total">₹<asp:Label
                    ID="lblTotal" runat="server"></asp:Label></span>
            </h2>

            <asp:Button ID="btnContinue" runat="server"
                Text="Continue Shopping"
                CssClass="btn secondary"
                PostBackUrl="~/WebForm1.aspx" />

            <asp:Button ID="btnCheckout" runat="server"
                Text="Proceed to Checkout"
                CssClass="btn"
                PostBackUrl="~/Checkout.aspx" />
        </div>

    </div>

</form>
</body>
</html>
```