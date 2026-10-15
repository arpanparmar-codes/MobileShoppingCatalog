```aspx
<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Checkout.aspx.cs"
    Inherits="MobileShoppingCatalog.Checkout" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Checkout | MobileHub</title>

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

        .navbar {
            background: #111c35;
            color: white;
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
            margin-left: 18px;
            font-size: 13px;
            font-weight: bold;
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
            margin: 0;
            line-height: 1.6;
        }

        .checkout-layout {
            overflow: hidden;
        }

        .items-column {
            float: left;
            width: 62%;
        }

        .summary-column {
            float: right;
            width: 35%;
        }

        .card {
            background: white;
            border: 1px solid #e7ecf4;
            border-radius: 13px;
            padding: 24px;
            margin-bottom: 22px;
        }

        .card h2 {
            font-size: 20px;
            margin: 0 0 20px;
        }

        .product {
            overflow: hidden;
            padding: 18px 0;
            border-bottom: 1px solid #e8edf5;
        }

        .product-image {
            float: left;
            width: 105px;
            height: 105px;
            object-fit: contain;
            padding: 7px;
            background: #f8fafc;
            border-radius: 9px;
            margin-right: 16px;
        }

        .product-info {
            overflow: hidden;
            padding-top: 5px;
        }

        .product-name {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .product-price {
            color: #64748b;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .quantity {
            color: #64748b;
            font-size: 14px;
        }

        .item-total {
            color: #0f766e;
            font-weight: bold;
            margin-top: 12px;
        }

        .summary-line {
            overflow: hidden;
            margin: 18px 0;
            color: #64748b;
            font-size: 14px;
        }

        .summary-label {
            float: left;
        }

        .summary-value {
            float: right;
            color: #172b4d;
            font-weight: bold;
        }

        .free-delivery {
            color: #15803d;
        }

        .total-line {
            border-top: 1px solid #e5e7eb;
            padding-top: 20px;
            margin-top: 22px;
            font-size: 20px;
            font-weight: bold;
            color: #172b4d;
        }

        .total-line .summary-value {
            color: #0f766e;
        }

        .secure-note {
            background: #f0fdf4;
            color: #166534;
            border-radius: 8px;
            padding: 13px;
            font-size: 13px;
            line-height: 1.6;
            margin: 22px 0;
        }

        .btn {
            display: block;
            width: 100%;
            border: none;
            border-radius: 7px;
            padding: 13px;
            margin-top: 12px;
            font-size: 13px;
            font-weight: bold;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
        }

        .btn-primary {
            background: #2563eb;
            color: white;
        }

        .btn-primary:hover {
            background: #1d4ed8;
        }

        .btn-secondary {
            background: #eaf1ff;
            color: #1d4ed8;
        }

        .btn-secondary:hover {
            background: #dbeafe;
        }

        .message {
            display: block;
            margin-top: 16px;
            line-height: 1.6;
            font-weight: bold;
            overflow-wrap: break-word;
        }

        .footer {
            text-align: center;
            color: #64748b;
            font-size: 12px;
            padding: 20px;
        }

        @media screen and (max-width: 800px) {
            .items-column,
            .summary-column {
                float: none;
                width: 100%;
            }

            .container {
                width: 92%;
                margin: 25px auto;
            }

            .nav-links {
                float: none;
                clear: both;
                padding-top: 18px;
            }

            .nav-links a {
                margin: 0 13px 8px 0;
            }
        }

        @media screen and (max-width: 450px) {
            .heading h1 {
                font-size: 27px;
            }

            .card {
                padding: 17px;
            }

            .product-image {
                width: 80px;
                height: 85px;
                margin-right: 12px;
            }

            .product-name {
                font-size: 14px;
            }
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

    <div class="navbar">
        <a href="WebForm1.aspx" class="brand">
            Mobile<span>Hub</span>
        </a>

        <div class="nav-links">
            <a href="WebForm1.aspx">Home</a>
            <a href="Wishlist.aspx">Wishlist</a>
            <a href="Cart.aspx">My Cart</a>
            <a href="Checkout.aspx">Checkout</a>
            <a href="OrderHistory.aspx">My Orders</a>
        </div>
    </div>

    <div class="container">

        <div class="heading">
            <h1>Checkout</h1>
            <p>Review your selected mobiles before placing your order.</p>
        </div>

        <div class="checkout-layout">

            <div class="items-column">
                <div class="card">
                    <h2>Order Items</h2>

                    <asp:Repeater ID="rptCheckout" runat="server">
                        <ItemTemplate>

                            <div class="product">

                                <asp:Image ID="imgMobile" runat="server"
                                    CssClass="product-image"
                                    ImageUrl='<%# ResolveUrl("~/Images/") + Eval("image") %>'
                                    AlternateText='<%# Eval("name") %>' />

                                <div class="product-info">

                                    <div class="product-name">
                                        <%#: Eval("name") %>
                                    </div>

                                    <div class="product-price">
                                        Price: ₹<%#: Eval("price", "{0:N0}") %>
                                    </div>

                                    <div class="quantity">
                                        Quantity: <%#: Eval("quantity") %>
                                    </div>

                                    <div class="item-total">
                                        Subtotal: ₹<%# String.Format("{0:N0}",
                                            Convert.ToDecimal(Eval("price")) *
                                            Convert.ToInt32(Eval("quantity"))) %>
                                    </div>

                                </div>
                            </div>

                        </ItemTemplate>
                    </asp:Repeater>

                    <asp:Label ID="lblMessage" runat="server"
                        CssClass="message" />

                </div>
            </div>

            <div class="summary-column">
                <div class="card">

                    <h2>Order Summary</h2>

                    <div class="summary-line">
                        <span class="summary-label">Subtotal</span>
                        <span class="summary-value">
                            ₹<asp:Label ID="lblSubtotal"
                                runat="server" Text="0.00" />
                        </span>
                    </div>

                    <div class="summary-line">
                        <span class="summary-label">Delivery</span>
                        <span class="summary-value free-delivery">Free</span>
                    </div>

                    <div class="summary-line total-line">
                        <span class="summary-label">Total</span>
                        <span class="summary-value">
                            ₹<asp:Label ID="lblTotal"
                                runat="server" Text="0.00" />
                        </span>
                    </div>

                    <div class="secure-note">
                        Review your items and quantities before confirming your order.
                    </div>

                    <asp:Button ID="btnPlaceOrder" runat="server"
                        Text="Place Order"
                        CssClass="btn btn-primary"
                        OnClick="btnPlaceOrder_Click" />

                    <asp:Button ID="btnContinueShopping" runat="server"
                        Text="Continue Shopping"
                        CssClass="btn btn-secondary"
                        CausesValidation="false"
                        OnClick="btnContinueShopping_Click" />

                </div>
            </div>

        </div>

    </div>

    <div class="footer">
        MobileHub | Your mobile shopping catalogue
    </div>

</form>
</body>
</html>
```