<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GameDetails.aspx.cs" Inherits="GameVault.GameDetails" MasterPageFile="~/Site.Master" %>

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
  .label-error {
    color: #ff4d4d;
    background-color: rgba(255, 60, 60, 0.1);
    padding: 10px 16px;
    border-radius: 10px;
    display: inline-block;
    margin-top: 10px;
    font-weight: bold;
}

.label-success {
    color: limegreen;
    background-color: rgba(0, 204, 136, 0.1);
    padding: 10px 16px;
    border-radius: 10px;
    display: inline-block;
    margin-top: 10px;
    font-weight: bold;
}

.label-warning {
    color: #ffa500;
    background-color: rgba(255, 165, 0, 0.1);
    padding: 10px 16px;
    border-radius: 10px;
    display: inline-block;
    margin-top: 10px;
    font-weight: bold;
}


        .scroll-item {
            width: 300px;
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
width:100%;
height:300px;
       object-fit: cover;
   }
scroll-item strong {
     display: block;
     padding: 10px 0;
     color: black;
     font-size: 16px;
     text-shadow: 0 0 4px palevioletred;
     background-color:lightgray;
 }
        .game-details-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            color: #fff;
        }
        .game-header {
            display: flex;
            gap: 30px;
            margin-bottom: 30px;
        }
        .game-poster {
            flex: 0 0 300px;
        }
        .game-poster img {
            width: 100%;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 255, 255, 0.3);
        }
        .game-info {
            flex: 1;
        }
        .game-title {
            color: #00ffff;
            margin-bottom: 15px;
            text-shadow: 0 0 5px #00ffff;
        }
        .game-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 20px;
        }
        .meta-item {
            background: #1a1a1a;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 14px;
        }
        .game-description {
            line-height: 1.6;
            margin-bottom: 25px;
        }
      .btn {
    padding: 15px 25px;
    border: none;
    border-radius: 30px;
    font-size: 15px;
    font-weight: bold;
    color: white;
    cursor: pointer;
    margin: 5px;
    transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
    box-shadow: 0 0 10px rgba(0,255,255,0.2);
}

.btn:hover {
    transform: scale(1.05);
    box-shadow: 0 0 20px rgba(0,255,255,0.4);
}

.btn-add {
    background-color: #00bcd4; /* Light Blue */
}

.btn-add:hover {
    background-color: #0097a7;
}

.btn-buy {
    background-color: limegreen; /* Lawn Green */
    color: white;
}

.btn-buy:hover {
    background-color: #32cd32; /* Lime Green */
}

.back-btn {
    padding: 12px 20px;
    font-size: 14px;
    background-color: #00bcd4;
    color: white;
    border: none;
    border-radius: 25px;
    margin: 20px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
    box-shadow: 0 0 10px rgba(0,255,255,0.2);
}

.back-btn:hover {
    background-color: #008ba3;
    transform: scale(1.03);
    box-shadow: 0 0 20px rgba(0,255,255,0.3);
}


}

    </style>
            <button type="button" class=" back-btn " onclick="history.back()">Go Back</button>
<asp:Label ID="statusLabel" runat="server" CssClass="" Visible="false"></asp:Label>

    <div class="game-details-container">
        <asp:SqlDataSource ID="SqlDataSource2" runat="server"
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT * FROM [GAMES_INFO] WHERE ([Title] = @Title)">
            <SelectParameters>
                <asp:QueryStringParameter Name="Title" QueryStringField="title" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource2" RepeatColumns="1" Width="100%">
            <ItemTemplate>
                <div class="game-header">
                    <div class="game-poster">
                        <asp:Image ID="Image1" runat="server" 
                            ImageUrl='<%# Eval("ImgUrl") %>' 
                            AlternateText='<%# Eval("Title") %>'
                            CssClass="game-poster-img" />
                    </div>
                    <div class="game-info">
                        <h1 class="game-title"><%# Eval("Title") %></h1>
                        
                        <div class="game-meta">
                            <span class="meta-item"><strong>Platform:</strong> <%# Eval("Console") %></span>
                            <span class="meta-item"><strong>Release Date:</strong> <%# Convert.ToDateTime(Eval("ReleaseDate")).ToString("MMMM dd, yyyy") %></span>
                            <span class="meta-item"><strong>Genre:</strong> <%# Eval("Genre") %></span>
                         <span class="meta-item"><strong>Price:</strong> <%# Eval("Price") %>$</span>

                        </div>
                        
                         <asp:Button ID="btnAddToLibrary" runat="server" Text="Add to My Library" CssClass="btn btn-add" OnClick="clickedbtn" CommandArgument='<%# Eval("Id") %> '/>
                         <asp:Button ID="btnBuy" runat="server" Text="Buy" CssClass="btn  btn-buy" OnClick="clickedbtn" CommandArgument='<%# Eval("Id") %>'/>
                       
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>

        <asp:Label ID="lblErrorMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>
    </div>
       <h3 style="color:white; margin-left:20px;">Other Games You Might Like</h3>
<div class="scroll-container">
    <asp:DataList ID="DataListSimilarGames" runat="server" RepeatDirection="Horizontal">
        <ItemTemplate>
            <div class="scroll-item">
                <asp:LinkButton ID="linkSimilar" runat="server"
                    PostBackUrl='<%# "~/GameDetails.aspx?title=" + Server.UrlEncode(Eval("Title").ToString()) %>'>
                    <asp:Image ID="imgSimilar" runat="server" ImageUrl='<%# Eval("ImgUrl") %>' />
                    <br />
                    <strong><%# Eval("Title") %></strong>
                </asp:LinkButton>
            </div>
        </ItemTemplate>
    </asp:DataList>
</div>

   
       
    
</asp:Content>