<%@ Page Language="C#" AutoEventWireup="true" CodeFile="all.aspx.cs" Inherits="GameVault.all" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
    body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .filters {
            margin: 40px 20px 20px 20px;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: center;
        }

        .filters select,
        .filters input[type="text"],
        .filters button {
            padding: 10px 15px;
            border-radius: 8px;
            border: 1px solid #888;
            background-color: #1a1a1a;
            color: white;
        }

        .filters button {
            background-color: palevioletred;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .filters button:hover {
            background-color: #d87093;
        }

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
            width: 100%;
            height: 400px;
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
            font-size: 32px;
            color: white;
            margin: 40px 20px 10px;
            text-shadow: 0 0 4px palevioletred;
        }

        .back-btn {
            margin: 20px;
            padding: 8px 18px;
            background-color: cadetblue;
            border: none;
            border-radius: 25px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .back-btn:hover {
            background-color: #2f7c88;
        }

        .search-message {
            color: red;
            margin-left: 20px;
        }
    </style>    

    <button type="button" class="back-btn" onclick="history.back()">Go Back</button>
 <div class="filters">
    <asp:DropDownList ID="ddlConsole" runat="server" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged">
    <asp:ListItem Text="All Consoles" />
   
</asp:DropDownList>

<asp:DropDownList ID="ddlGenre" runat="server" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged">
    <asp:ListItem Text="All Genres" />
   
</asp:DropDownList>

<asp:TextBox ID="txtSearch" runat="server" />
<asp:Button ID="btnSearchAllGames" runat="server" Text="Search" OnClick="btnSearchAllGames_Click" CssClass="back-btn" />
<asp:Label ID="lblSearchMessage" runat="server" ForeColor="Red" Visible="false" />
   </div>
     <h2>ALL games</h2>
    <div class="scroll-container">
        <asp:DataList ID="DataListAll" runat="server" RepeatDirection="Horizontal"  RepeatColumns="4">
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
</asp:Content>