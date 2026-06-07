    <%@ Page Language="C#" AutoEventWireup="true" CodeFile="library.aspx.cs" Inherits="GameVault.library" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <style>  h3 {
            color: #00ffff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 40px 0 25px 20px;
            text-shadow: 0 0 8px #00ffff;
            font-size: 28px;
        }

        .game-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            justify-content: flex-start;
            padding: 0 20px 50px 20px;
        }

        .item {
            display: flex;
            align-items: center;
            width: 520px;
            height: 170px;
            background: #1a1a1a;
            border-radius: 14px;
            padding: 15px;
            box-shadow: 0 0 18px rgba(0, 255, 255, 0.5);
            color: #00ffff;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }

        .item:hover {
            transform: scale(1.03);
            box-shadow: 0 0 25px #00ffff;
        }

        .item img {
            width: 140px;
            height: 140px;
            object-fit: cover;
            border-radius: 10px;
            margin-right: 20px;
            box-shadow: 0 0 8px #00ffff;
            transition: filter 0.3s ease;
        }

        .item:hover img {
            filter: brightness(1.1);
        }

        .item-text {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
        }

        .item-text .title {
            font-weight: bold;
            font-size: 20px;
            margin-bottom: 5px;
        }

        .item-text .date {
            font-size: 14px;
            color: #66ffff;
            font-style: italic;
            margin-bottom: 12px;
        }

        .item-text .game-btn {
            align-self: flex-start;
            background-color: transparent;
            color: #ffffff;
            border: 2px solid #00ffff;
            border-radius: 25px;
            padding: 8px 20px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .item-text .game-btn:hover {
            background-color: #00ffff;
            color: #000;
            box-shadow: 0 0 12px #00ffff;
        }

        .aspNetDisabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .aspNetDisabled:hover {
            background-color: transparent;
            color: #ffffff;
            box-shadow: none;
        }

        #<%= lblMessage.ClientID %> {
            margin-left: 20px;
            font-size: 14px;
            margin-bottom: 10px;
        } </style>
    
  <h3>Your Games</h3>

<div style="display: flex; gap: 50px; padding: 0 20px; flex-wrap: wrap;">

     <div style="flex: 1; min-width: 520px;">
        <h3>Saved Games</h3>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Visible="false" />
        <asp:GridView ID="GridViewgames" runat="server" AutoGenerateColumns="False"
            CssClass="game-grid" OnRowCommand="GridViewgames_RowCommand">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <div class="item">
                            <img src='<%# Eval("ImgUrl") %>' alt="Game" />
                            <div class="item-text">
                                <span class="title"><%# Eval("Title") %></span>
                                <span class="date"><%# Eval("AddedAt", "{0:dd-MM-yyyy HH:mm}") %></span>
                                <asp:Button ID="btnRemove" runat="server" Text="Remove"
                                    CommandName="RemoveFromLibrary" CommandArgument='<%# Eval("Title") %>'
                                    CssClass="game-btn" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <div style="flex: 1; min-width: 520px;">
        <h3>Bought Games</h3>
        <asp:Label ID="lblBoughtMessage" runat="server" ForeColor="Red" Visible="false" />
        <asp:GridView ID="GridViewBought" runat="server" AutoGenerateColumns="False"
            CssClass="game-grid" >
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <div class="item">
                            <img src='<%# Eval("ImgUrl") %>' alt="Game" />
                            <div class="item-text">
                                <span class="title"><%# Eval("Title") %></span>
                                <span class="date"><%# Eval("BoughtAt", "{0:dd-MM-yyyy HH:mm}") %></span>
                                <asp:Button ID="btnDownload" runat="server" Text="Download"
                                    CommandName="DownloadGame" CommandArgument='<%# Eval("Title") %>'
                                    CssClass="game-btn" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

</div>

</asp:Content>
