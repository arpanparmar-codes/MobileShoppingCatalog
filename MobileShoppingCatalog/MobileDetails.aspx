
<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="MobileDetails.aspx.cs"
    Inherits="MobileShoppingCatalog.MobileDetails" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Mobile Details | MobileHub</title>

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
            max-width: 1050px;
            margin: 35px auto;
        }

        .breadcrumb {
            color: #64748b;
            font-size: 14px;
            margin-bottom: 22px;
        }

        .breadcrumb a {
            color: #2563eb;
            text-decoration: none;
        }

        .product-card {
            background: white;
            border: 1px solid #e7ecf4;
            border-radius: 14px;
            padding: 30px;
            overflow: hidden;
        }

        .image-column {
            float: left;
            width: 45%;
            text-align: center;
            padding: 15px;
            background: #f8fafc;
            border-radius: 12px;
        }

        .product-image {
            width: 100%;
            max-width: 330px;
            height: 350px;
            object-fit: contain;
        }

        .details-column {
            float: right;
            width: 50%;
            padding: 10px 5px 10px 20px;
        }

        .product-tag {
            display: inline-block;
            background: #eaf1ff;
            color: #1d4ed8;
            padding: 7px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .product-name {
            font-size: 30px;
            line-height: 1.35;
            margin: 0 0 18px;
            overflow-wrap: break-word;
        }

        .price-label {
            color: #64748b;
            font-size: 14px;
            margin-bottom: 6px;
        }

        .product-price {
            color: #0f766e;
            font-size: 30px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .divider {
            border-top: 1px solid #e8edf5;
            margin: 20px 0;
        }

        .description-title {
            font-size: 17px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .description {
            color: #64748b;
            font-size: 14px;
            line-height: 1.8;
        }

        .benefit {
            margin: 12px 0;
            color: #475569;
            font-size: 14px;
        }

        .benefit-icon {
            color: #15803d;
            font-weight: bold;
            margin-right: 8px;
        }

        .btn {
            display: block;
            width: 100%;
            border: none;
            border-radius: 7px;
            padding: 14px;
            margin-top: 13px;
            font-size: 14px;
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
            margin-top: 17px;
            color: #0f766e;
            font-weight: bold;
            line-height: 1.6;
            overflow-wrap: break-word;
        }

        .footer {
            text-align: center;
            color: #64748b;
            font-size: 12px;
            padding: 25px;
        }

        @media screen and (max-width: 750px) {
            .container {
                width: 92%;
                margin: 25px auto;
            }

            .product-card {
                padding: 20px;
            }

            .image-column,
            .details-column {
                float: none;
                width: 100%;
            }

            .image-column {
                padding: 10px;
            }

            .product-image {
                height: 280px;
            }

            .details-column {
                padding: 25px 0 5px;
            }

            .product-name {
                font-size: 25px;
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
            .product-card {
                padding: 15px;
            }

            .product-image {
                height: 230px;
            }

            .product-price {
                font-size: 26px;
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

        <div class="breadcrumb">
            <a href="WebForm1.aspx">Home</a>
            &nbsp; / &nbsp; Mobile Details
        </div>

        <div class="product-card">

            <div class="image-column">

                <asp:Image ID="imgMobile" runat="server"
                    CssClass="product-image"
                    AlternateText="Mobile phone image" />

            </div>

            <div class="details-column">

                <div class="product-tag">
                    MOBILE DETAILS
                </div>

                <h1 class="product-name">
                    <asp:Label ID="lblName" runat="server" />
                </h1>

                <div class="price-label">
                    Price
                </div>

                <div class="product-price">
                    ₹<asp:Label ID="lblPrice" runat="server" />
                </div>

                <div class="divider"></div>

                <div class="description-title">
                    About this product
                </div>

                <div class="description">
                    View the selected mobile's price and product image
                    before adding it to your shopping cart.
                </div>

                <div class="divider"></div>

                <div class="benefit">
                    <span class="benefit-icon">&#10003;</span>
                    Add this mobile to your shopping cart
                </div>

                <div class="benefit">
                    <span class="benefit-icon">&#10003;</span>
                    Review your order before checkout
                </div>

                <asp:Button ID="btnAddCart" runat="server"
                    Text="Add to Cart"
                    CssClass="btn btn-primary"
                    OnClick="btnAddCart_Click" />

                <asp:Button ID="btnBack" runat="server"
                    Text="Back to Catalog"
                    CssClass="btn btn-secondary"
                    CausesValidation="false"
                    PostBackUrl="~/WebForm1.aspx" />

                <asp:Label ID="lblMessage" runat="server"
                    CssClass="message" />

            </div>

        </div>

    </div>

    <div class="footer">
        MobileHub | Your mobile shopping catalogue
    </div>

</form>
</body>
</html>
