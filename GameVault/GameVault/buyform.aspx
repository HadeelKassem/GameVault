<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="buyform.aspx.cs" Inherits="GameVault.buyform" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .buy-form-container {
            max-width: 800px;
            margin: 30px auto;
            padding: 30px;
            background: #1a1a1a;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,255,255,0.1);
            color: #fff;
        }
        
        .game-info-section {
            display: flex;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #333;
        }
        
        .game-poster {
            width: 200px;
            height: 250px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 30px;
        }
        
        .payment-form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }
        
        .form-control {
            width: 100%;
            padding: 12px;
            background: #2a2a2a;
            border: 1px solid #444;
            border-radius: 5px;
            color: #fff;
            font-size: 16px;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #00ffff;
            box-shadow: 0 0 0 2px rgba(0,255,255,0.2);
        }
        
        .btn-submit {
            grid-column: span 2;
            background: limegreen;
            color: white;
            padding: 15px;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-submit:hover {
            background: #32cd32;
            transform: translateY(-2px);
        }
        
        .price-display {
            font-size: 24px;
            color: limegreen;
            margin: 20px 0;
            text-align: right;
        }
        
        .full-width {
            grid-column: span 2;
        }
    </style>

    <div class="buy-form-container">
        <asp:Label ID="lblError" runat="server" CssClass="error-message" Visible="false"></asp:Label>
            <div class="scroll-container">
 
    <asp:SqlDataSource ID="SqlDataSourceitem" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Title], [Price],[Developer],  [Console], [ImgUrl] FROM [GAMES_INFO] WHERE ([Id] = @Id)">
        <SelectParameters>
            <asp:QueryStringParameter Name="Id" QueryStringField="id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
              <asp:DataList ID="DataListitem" runat="server" DataSourceID="SqlDataSourceitem">
    <ItemTemplate>
        <div class="game-info-section">
            <img src='<%# Eval("ImgUrl") %>' alt="Game Poster" class="game-poster" />
            <div>
                <h1 style="font-size: 32px; margin-bottom: 10px;"><%# Eval("Title") %></h1>
                <h3 style="font-weight: normal; color: #aaa; margin-bottom: 40px;">By <%# Eval("Developer") %></h3>
                                <h3 style="font-weight: normal; color: #aaa; margin-bottom: 40px;"> <%# Eval("Console") %></h3>
                                <h4 style="font-weight: normal; color: #aaa; margin-bottom: 40px;"> <%# Eval("Price") %></h4>
        <asp:Label ID="lblDiscountedPrice" runat="server" 
      CssClass="discounted-price"
      Visible="false"/>
              <asp:Label ID="Label2" runat="server" 
CssClass="discounted-price"
Visible="false">
  </asp:Label>

            </div>
        </div>
    </ItemTemplate>
</asp:DataList>
<asp:Label ID="Label1" runat="server" Visible="false" />          

</div>
        
        <asp:Panel ID="pnlPaymentForm" runat="server" CssClass="payment-form">
            <div class="form-group full-width">
                <label for="ddlPaymentMethod">Payment Method</label>
                <asp:DropDownList ID="ddlPaymentMethod" runat="server" CssClass="form-control">
                    <asp:ListItem Value="Credit Card" Text="Credit Card" Selected="True" />
                    <asp:ListItem Value="Debit Card" Text="Debit Card" />
                    <asp:ListItem Value="PayPal" Text="PayPal" />
                </asp:DropDownList>
            </div>
            
            <div class="form-group">
                <label for="txtCardNumber">Card Number</label>
                <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control" 
                    placeholder="1234 5678 9012 3456" MaxLength="19"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <label for="txtCardHolder">Cardholder Name</label>
                <asp:TextBox ID="txtCardHolder" runat="server" CssClass="form-control" 
                    placeholder="John Doe"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <label for="txtExpiryDate">Expiry Date</label>
                <asp:TextBox ID="txtExpiryDate" runat="server" CssClass="form-control" 
                    placeholder="MM/YY" MaxLength="5"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <label for="txtCVV">CVV</label>
                <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control" 
                    placeholder="123" MaxLength="4" TextMode="Password"></asp:TextBox>
            </div>
            
            <div class="form-group full-width">
                <label for="txtBillingAddress">Billing Address</label>
                <asp:TextBox ID="txtBillingAddress" runat="server" CssClass="form-control" 
                    TextMode="MultiLine" Rows="3"></asp:TextBox>
            </div>
            
            <asp:Button ID="btnSubmit" runat="server" Text="Complete Purchase" 
                CssClass="btn-submit" onClick="btnSubmit_Click" />
        </asp:Panel>
        
        <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
            <div style="text-align: center; padding: 40px;">
                <h2 style="color: limegreen;">Purchase Complete!</h2>
                <p>Thank you for your purchase. The game has been added to your library.</p>
              <asp:Button ID="btnBack" runat="server" Text="Back to Game" 
    CssClass="btn-submit" 
   PostBackUrl="Default.aspx"
/>

            </div>
        </asp:Panel>
    </div>
</asp:Content>