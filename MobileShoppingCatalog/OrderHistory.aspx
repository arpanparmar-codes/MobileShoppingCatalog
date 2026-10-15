
<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="OrderHistory.aspx.cs"
    Inherits="MobileShoppingCatalog.OrderHistory" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>My Orders - MobileHub</title>
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
            <h1>My Orders</h1>
            <p>View your previous orders here.</p>

            <asp:Label ID="lblMessage" runat="server" />

            <asp:GridView ID="gvOrders" runat="server"
                AutoGenerateColumns="False"
                CssClass="grid"
                EmptyDataText="No orders found.">

                <Columns>
                    <asp:BoundField DataField="OrderId"
                        HeaderText="Order ID" />

                    <asp:BoundField DataField="OrderDate"
                        HeaderText="Order Date"
                        DataFormatString="{0:dd-MMM-yyyy hh:mm tt}" />

                    <asp:BoundField DataField="TotalAmount"
                        HeaderText="Total (₹)"
                        DataFormatString="{0:N2}" />
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
