
<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Wishlist.aspx.cs"
    Inherits="MobileShoppingCatalog.Wishlist" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>My Wishlist - MobileHub</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f7fb;
            color: #172b4d;
            margin: 0;
        }

        .nav {
            background: #172b4d;
            color: white;
            padding: 18px 5%;
        }

        .nav a {
            color: white;
            text-decoration: none;
            margin-right: 20px;
        }

        .container {
            max-width: 1000px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .panel {
            background: white;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 4px 15px #00000010;
        }

        .btn {
            background: #172b4d;
            color: white;
            border: 0;
            padding: 9px 14px;
            border-radius: 6px;
            cursor: pointer;
        }

        .message {
            display: block;
            margin: 12px 0;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .grid th, .grid td {
            padding: 12px;
            border-bottom: 1px solid #e5eaf1;
            text-align: left;
        }

        .grid th {
            background: #edf2f8;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

    <div class="nav">
        <a href="WebForm1.aspx">Home</a>
        <a href="Wishlist.aspx">Wishlist</a>
        <a href="Cart.aspx">Cart</a>
        <a href="Checkout.aspx">Checkout</a>
        <a href="OrderHistory.aspx">My Orders</a>
    </div>

    <div class="container">
        <div class="panel">
            <h1>My Wishlist</h1>
            <p>Mobiles you have saved for later.</p>

            <asp:Label ID="lblMessage" runat="server"
                CssClass="message" />

            <asp:GridView ID="gvWishlist" runat="server"
                AutoGenerateColumns="False"
                DataKeyNames="MobileId"
                CssClass="grid"
                OnRowCommand="gvWishlist_RowCommand"
                EmptyDataText="Your wishlist is empty.">

                <Columns>
                    <asp:BoundField DataField="name"
                        HeaderText="Mobile" />

                    <asp:BoundField DataField="price"
                        HeaderText="Price (₹)" />

                    <asp:ButtonField Text="Remove"
                        CommandName="RemoveItem"
                        ButtonType="Button" />
                </Columns>

            </asp:GridView>

            <p>
                <a href="WebForm1.aspx">Continue shopping</a>
            </p>
        </div>
    </div>

</form>
</body>
</html>
