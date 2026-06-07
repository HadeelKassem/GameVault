    <%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="GameVault.Default" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
   .scroll-container {
       margin: 20px auto 10px;
       padding: 10px;
       background: #0d0d0d;
       border-radius: 12px;
       border: 2px solid #1a1a1a;
       display: flex;
       flex-wrap: wrap;
     
       justify-content: center;
      
      
   }
   .box2{
       margin-bottom:50px;
       margin-top:50px;
   }

   .signup-message {
    font-size: 20px;
    color: #fff;
    background: linear-gradient(90deg, #ff6600, #ff9900);
    padding: 14px 70px;
    margin-left:37% ;
    border-radius: 8px;
    text-align: center;
    font-weight: 600;
    box-shadow: 0 0 15px rgba(255, 102, 0, 0.6);
   
   
   
}




   .scroll-item {
       width: 230px;
       background-color: #1a1a1a;
       border-radius: 10px;
       overflow: hidden;
       box-shadow: 0 0 12px rgba(0, 255, 255, 0.3);
       transition: transform 0.3s, box-shadow 0.3s;
       text-align: center;
       margin:30px;
   }

   .scroll-item:hover {
       transform: translateY(-5px);
       box-shadow: 0 0 25px #00ffff;
   }

   .scroll-item img {
       width: 100%;
       height: 300px;
       object-fit: cover;
   }

   .scroll-item strong {
       display: block;
       padding: 10px 0;
       color: black;
       font-size: 16px;
       text-shadow: 0 0 4px palevioletred;
       background-color:lightgray;
   }

h2 {
            color: #00ffff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 40px 0 25px 20px;
            text-shadow: 0 0 8px #00ffff;
            font-size: 28px;
        }
strong{
    text-decoration:none;

}

</style>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT   [Title], [ImgUrl] FROM [GAMES_INFO] WHERE ([ReleaseDate] &gt; @ReleaseDate)">
        <SelectParameters>
           <asp:Parameter DefaultValue="12/31/2019" Name="ReleaseDate" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
    <h2>New Releases</h2>
    <div class="scroll-container">
 <asp:DataList ID="DataList1" runat="server" 
    DataSourceID="SqlDataSource1" 
   
    RepeatDirection="Horizontal">
    <ItemTemplate>
        <div class="scroll-item">
            <asp:LinkButton ID="linkbutton1" runat="server" 
               
                CommandArgument='<%# Eval("Title") %>'
                PostBackUrl='<%# "~/GameDetails.aspx?title=" + Server.UrlEncode(Eval("Title").ToString()) %>'>
                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("ImgUrl") %>' />
                <br />
                <strong><%# Eval("Title") %></strong>
            </asp:LinkButton>
        </div>
    </ItemTemplate>
</asp:DataList>
</div>
       
    
    
    
    
    
    
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT TOP 5 [Title], [ImgUrl] FROM [GAMES_INFO] WHERE ([Console] = @Console)">
        <SelectParameters>
           <asp:Parameter DefaultValue="PS" Name="Console" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <h2>PS games</h2>
    <div class="scroll-container">
  <asp:DataList ID="DataList2" runat="server" DataSourceID="SqlDataSource2" RepeatColumns="0" RepeatDirection="Horizontal" CellSpacing="0" Width="100%">
    <ItemTemplate>
      <div class="scroll-item">
          <asp:LinkButton ID="linkbutton2" runat="server" 
    
     CommandArgument='<%# Eval("Title") %>'
     PostBackUrl='<%# "~/GameDetails.aspx?title=" + Server.UrlEncode(Eval("Title").ToString()) %>'>
               
        <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("ImgUrl") %>' Width="240px" />
        <br />
        <strong><%# Eval("Title") %></strong>
       </asp:LinkButton>
              </div>
    </ItemTemplate>
  </asp:DataList>
</div>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT  TOP 5 [Title], [ImgUrl] FROM [GAMES_INFO] WHERE ([Price] = @Price)">
        <SelectParameters>
           <asp:Parameter DefaultValue="0" Name="Price" Type="decimal" />
        </SelectParameters>
    </asp:SqlDataSource>
    <h2>Free games</h2>
    <div class="scroll-container">
 <asp:DataList ID="DataList3" runat="server" 
    DataSourceID="SqlDataSource3" 
   
    RepeatDirection="Horizontal">
    <ItemTemplate>
        <div class="scroll-item">
            <asp:LinkButton ID="linkbutton3" runat="server" 
               
                CommandArgument='<%# Eval("Title") %>'
                PostBackUrl='<%# "~/GameDetails.aspx?title=" + Server.UrlEncode(Eval("Title").ToString()) %>'>
                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("ImgUrl") %>' />
                <br />
                <strong><%# Eval("Title") %></strong>
            </asp:LinkButton>
        </div>
    </ItemTemplate>
</asp:DataList>
</div>
       
  




   <div class="box2">
    <asp:Label ID="lblSignupMessage" runat="server" Visible="false" CssClass="signup-message" />
</div>

    </asp:Content>
