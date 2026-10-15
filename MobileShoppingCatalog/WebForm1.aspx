
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="MobileShoppingCatalog.WebForm1" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>MobileHub | Find Your Next Mobile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <style type="text/css">
        * {
            box-sizing: border-box;
        }

        :root {
            --navy: #101b32;
            --blue: #2563eb;
            --blue-dark: #1d4ed8;
            --text: #172b4d;
            --muted: #64748b;
            --border: #e5eaf2;
            --surface: #ffffff;
            --background: #f4f7fc;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: var(--background);
            color: var(--text);
        }

        a {
            transition: color 0.2s ease;
        }

        /* Navigation */
        .nav {
            background: var(--navy);
            padding: 17px 5%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            flex-wrap: wrap;
            box-shadow: 0 3px 15px rgba(15, 23, 42, 0.12);
        }

        .brand {
            color: white;
            text-decoration: none;
            font-size: 27px;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .brand span {
            color: #60a5fa;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 25px;
            flex-wrap: wrap;
        }

        .nav-links a {
            color: #dbe5f5;
            text-decoration: none;
            font-size: 13px;
            font-weight: bold;
        }

        .nav-links a:hover {
            color: #60a5fa;
        }

        /* Main container */
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 32px auto 55px;
        }

        /* Hero section */
        .hero {
            position: relative;
            overflow: hidden;
            background: linear-gradient(120deg, #111d38 0%, #1e40af 65%, #2563eb 100%);
            color: white;
            padding: 48px 42px;
            border-radius: 20px;
            margin-bottom: 28px;
            box-shadow: 0 12px 28px rgba(37, 99, 235, 0.15);
        }

        .hero:after {
            content: "";
            position: absolute;
            width: 260px;
            height: 260px;
            border: 35px solid rgba(255, 255, 255, 0.06);
            border-radius: 50%;
            right: -65px;
            top: -105px;
            pointer-events: none;
        }

        .hero-tag {
            display: inline-block;
            background: rgba(255, 255, 255, 0.12);
            border: 1px solid rgba(255, 255, 255, 0.17);
            color: #dbeafe;
            padding: 8px 13px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: bold;
            letter-spacing: 1.3px;
            margin-bottom: 17px;
        }

        .hero h1 {
            position: relative;
            z-index: 1;
            font-size: 39px;
            line-height: 1.2;
            letter-spacing: -1px;
            max-width: 650px;
            margin: 0 0 15px;
        }

        .hero p {
            position: relative;
            z-index: 1;
            color: #dbeafe;
            line-height: 1.8;
            font-size: 15px;
            max-width: 610px;
            margin: 0;
        }

        /* Filter panel */
        .panel {
            background: var(--surface);
            padding: 27px;
            border-radius: 16px;
            margin-bottom: 35px;
            border: 1px solid var(--border);
            box-shadow: 0 5px 20px rgba(15, 23, 42, 0.035);
        }

        .panel h2 {
            margin: 0 0 9px;
            font-size: 22px;
            letter-spacing: -0.4px;
        }

        .panel-description {
            color: var(--muted);
            font-size: 14px;
            line-height: 1.7;
            margin: 0 0 24px;
        }

        .filter-fields {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 18px;
        }

        .field {
            min-width: 0;
        }

        .field label {
            display: block;
            font-size: 12px;
            font-weight: bold;
            color: #475569;
            margin-bottom: 9px;
        }

        input[type=text],
        input[type=number],
        select {
            width: 100%;
            min-height: 44px;
            padding: 11px 12px;
            border: 1px solid #d8e0ec;
            border-radius: 9px;
            background: #fff;
            color: var(--text);
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s ease,
                        box-shadow 0.2s ease;
        }

        input[type=text]:focus,
        input[type=number]:focus,
        select:focus {
            border-color: var(--blue);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.11);
        }

        /* Buttons */
        .filter-actions {
            margin-top: 22px;
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 9px;
        }

        .btn {
            display: inline-block;
            padding: 12px 17px;
            border: 1px solid transparent;
            border-radius: 9px;
            background: var(--blue);
            color: white;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 13px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: background 0.2s ease,
                        transform 0.2s ease,
                        box-shadow 0.2s ease;
        }

        .btn:hover {
            background: var(--blue-dark);
            box-shadow: 0 4px 10px rgba(37, 99, 235, 0.18);
            transform: translateY(-1px);
        }

        .secondary {
            background: #eff5ff;
            color: #1d4ed8;
            border-color: #dce8ff;
        }

        .secondary:hover {
            background: #dce9ff;
            color: #1d4ed8;
        }

        .muted {
            background: #f1f5f9;
            color: #475569;
            border-color: #e2e8f0;
        }

        .muted:hover {
            background: #e2e8f0;
            color: #334155;
            box-shadow: none;
        }

        .message {
            display: block;
            margin-top: 17px;
            color: #1d4ed8;
            font-size: 13px;
            font-weight: bold;
            line-height: 1.7;
        }

        /* Product section heading */
        .section-heading {
            margin-bottom: 21px;
        }

        .section-heading h2 {
            margin: 0;
            font-size: 26px;
            letter-spacing: -0.5px;
        }

        .section-heading p {
            color: var(--muted);
            margin: 8px 0 0;
            font-size: 14px;
            line-height: 1.6;
        }

        /* GridView product cards */
        .products {
            width: 100%;
            border: none;
            background: transparent;
            border-collapse: separate;
        }

        .products tbody {
            width: 100%;
        }

        .products tr {
            display: inline-block;
            vertical-align: top;
            width: 31.5%;
            margin: 0 1.5% 24px 0;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(15, 23, 42, 0.035);
            transition: transform 0.22s ease,
                        box-shadow 0.22s ease,
                        border-color 0.22s ease;
        }

        .products tr:hover {
            transform: translateY(-4px);
            border-color: #d5e2f7;
            box-shadow: 0 12px 28px rgba(15, 23, 42, 0.09);
        }

        .products td {
            display: block;
            padding: 0;
            border: none;
        }

        .product-card {
            width: 100%;
        }

        .product-image-area {
            height: 235px;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(180deg, #fbfcff, #f4f7fc);
            border-bottom: 1px solid #edf1f7;
        }

        .product-image {
            width: 100%;
            height: 190px;
            object-fit: contain;
            display: block;
            transition: transform 0.25s ease;
        }

        .products tr:hover .product-image {
            transform: scale(1.035);
        }

        .product-info {
            padding: 21px;
        }

        .product-label {
            display: inline-block;
            color: #2563eb;
            background: #eff5ff;
            padding: 6px 9px;
            border-radius: 5px;
            font-size: 10px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 12px;
        }

        .product-name {
            font-size: 18px;
            line-height: 1.45;
            min-height: 52px;
            margin: 0 0 10px;
            color: #172b4d;
            overflow-wrap: anywhere;
        }

        .product-price {
            color: #0f766e;
            font-size: 25px;
            font-weight: bold;
            letter-spacing: -0.5px;
            margin: 0 0 20px;
        }

        .product-actions .btn {
            display: block;
            width: 100%;
            margin: 8px 0 0;
            padding: 12px 8px;
        }

        .product-actions .btn:first-child {
            margin-top: 0;
        }

        .empty-message {
            display: block !important;
            width: 100% !important;
            margin: 0 !important;
            padding: 28px !important;
            background: white;
            color: #64748b;
            border: 1px dashed #cbd5e1 !important;
            border-radius: 12px;
            text-align: center;
        }

        /* Tablet */
        @media screen and (max-width: 950px) {
            .filter-fields {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .products tr {
                width: 48%;
                margin-right: 1.5%;
            }

            .hero h1 {
                font-size: 34px;
            }

            .nav {
                padding-left: 4%;
                padding-right: 4%;
            }

            .nav-links {
                gap: 17px;
            }
        }

        /* Mobile */
        @media screen and (max-width: 600px) {
            .nav {
                padding: 17px 5%;
                gap: 15px;
            }

            .brand {
                font-size: 25px;
            }

            .nav-links {
                width: 100%;
                gap: 12px 19px;
            }

            .nav-links a {
                font-size: 12px;
            }

            .container {
                width: 92%;
                margin: 22px auto 38px;
            }

            .hero {
                padding: 30px 23px;
                border-radius: 15px;
            }

            .hero h1 {
                font-size: 29px;
            }

            .hero p {
                font-size: 14px;
            }

            .panel {
                padding: 21px 17px;
                border-radius: 13px;
            }

            .filter-fields {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .filter-actions {
                display: block;
            }

            .filter-actions .btn {
                display: block;
                width: 100%;
                margin: 8px 0;
            }

            .section-heading h2 {
                font-size: 23px;
            }

            .products tr {
                display: block;
                width: 100%;
                margin: 0 0 20px;
            }

            .product-image-area {
                height: 225px;
            }

            .product-image {
                height: 185px;
            }

            .product-name {
                min-height: 0;
            }
        }

        /* Reduce motion for users who prefer it */
        @media (prefers-reduced-motion: reduce) {
            *,
            *:before,
            *:after {
                transition: none !important;
                scroll-behavior: auto !important;
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

        <div class="hero">
            <span class="hero-tag">THE MOBILE COLLECTION</span>
            <h1>Discover your next upgrade.</h1>
            <p>
                Explore our mobile collection, compare prices, discover
                your next phone, and save your favourite devices.
            </p>
        </div>

        <div class="panel">
            <h2>Find your mobile</h2>
            <p class="panel-description">
                Search by name, set your price range, or sort by price.
            </p>

            <div class="filter-fields">
                <div class="field">
                    <label for="<%= txtSearch.ClientID %>">Mobile name</label>
                    <asp:TextBox ID="txtSearch" runat="server"
                        ToolTip="Enter a mobile name" />
                </div>

                <div class="field">
                    <label for="<%= txtMinPrice.ClientID %>">Minimum price (₹)</label>
                    <asp:TextBox ID="txtMinPrice" runat="server"
                        TextMode="Number"
                        ToolTip="Enter minimum price" />
                </div>

                <div class="field">
                    <label for="<%= txtMaxPrice.ClientID %>">Maximum price (₹)</label>
                    <asp:TextBox ID="txtMaxPrice" runat="server"
                        TextMode="Number"
                        ToolTip="Enter maximum price" />
                </div>

                <div class="field">
                    <label for="<%= ddlSort.ClientID %>">Sort mobiles</label>
                    <asp:DropDownList ID="ddlSort" runat="server">
                        <asp:ListItem Value="default">Default order</asp:ListItem>
                        <asp:ListItem Value="low">Price: Low to High</asp:ListItem>
                        <asp:ListItem Value="high">Price: High to Low</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="filter-actions">
                <asp:Button ID="btnBrowse" runat="server"
                    Text="Browse All Mobiles"
                    CssClass="btn secondary"
                    OnClick="btnBrowse_Click" />

                <asp:Button ID="btnSearchFilter" runat="server"
                    Text="Search / Filter"
                    CssClass="btn"
                    OnClick="btnSearchFilter_Click" />

                <asp:Button ID="btnClear" runat="server"
                    Text="Clear Filters"
                    CssClass="btn muted"
                    OnClick="btnClear_Click" />
            </div>

            <asp:Label ID="lblMessage" runat="server"
                CssClass="message" />
        </div>

        <div class="section-heading">
            <h2>Explore Mobiles</h2>
            <p>Find your next favourite device.</p>
        </div>

        <asp:GridView ID="gvMobiles" runat="server"
            AutoGenerateColumns="False"
            ShowHeader="False"
            CssClass="products"
            DataKeyNames="Id"
            GridLines="None"
            EmptyDataText="No mobiles to display. Click Browse All Mobiles."
            OnRowCommand="gvMobiles_RowCommand">

            <EmptyDataRowStyle CssClass="empty-message" />

            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <div class="product-card">

                            <div class="product-image-area">
                                <asp:Image ID="imgMobile" runat="server"
                                    CssClass="product-image"
                                    ImageUrl='<%# ResolveUrl("~/Images/") + Eval("image") %>'
                                    AlternateText='<%# Eval("name") %>' />
                            </div>

                            <div class="product-info">
                                <div class="product-label">Mobile phone</div>

                                <h3 class="product-name">
                                    <%#: Eval("name") %>
                                </h3>

                                <p class="product-price">
                                    ₹<%#: Eval("price", "{0:N0}") %>
                                </p>

                                <div class="product-actions">
                                    <asp:Button ID="btnDetails" runat="server"
                                        Text="View Details"
                                        CssClass="btn secondary"
                                        CommandName="ShowDetails"
                                        CommandArgument='<%# Eval("Id") %>' />

                                    <asp:Button ID="btnAdd" runat="server"
                                        Text="Add to Cart"
                                        CssClass="btn"
                                        CommandName="AddCart"
                                        CommandArgument='<%# Eval("Id") %>' />

                                    <asp:Button ID="btnWishlist" runat="server"
                                        Text="Save to Wishlist"
                                        CssClass="btn muted"
                                        CommandName="AddWishlist"
                                        CommandArgument='<%# Eval("Id") %>' />
                                </div>
                            </div>

                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

    </div>

</form>
</body>
</html>
