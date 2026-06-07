    <%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="GameVault.Login" MasterPageFile="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            background-color: #0d0d0d;
        }

        .login_container {
            width: 90%;
            max-width: 500px;
            margin: 80px auto;
            background-color: #121212;
            border-radius: 16px;
            box-shadow: 0 0 25px rgba(0, 255, 255, 0.3);
            padding: 40px 30px;
            color: #00ffff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            text-align: center;
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login_header h2 {
            font-size: 32px;
            margin-bottom: 10px;
            letter-spacing: 1.2px;
            text-shadow: 0 0 10px #00ffff;
        }

        .login_header p {
            font-size: 15px;
            color: #66ffff;
            margin-bottom: 30px;
        }

        .prompt-text {
            color: #99ffff;
            font-size: 14px;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .game-button {
            color: #fff;
            font-weight: bold;
            font-size: 16px;
            padding: 14px 30px;
            margin: 10px 8px;
            background: linear-gradient(135deg, #008080, #00ffff);
            border: none;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 0 12px rgba(0, 255, 255, 0.5);
        }

        .game-button:hover {
            transform: scale(1.05);
            box-shadow: 0 0 25px #00ffff;
        }

        .login_body {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
        }

        .button-container > div {
            margin: 15px 10px;
        }
    </style>

    <div class="login_container">
        <div class="login_box">
            <div class="login_header">
                <h2>Login</h2>
                <p>Unlock your gaming adventure</p>
            </div>
            <div class="login_body">
                <div class="button-container">
                    <div>
                        <p class="prompt-text">Old buddy?</p>
                        <asp:Button ID="btnLogin" runat="server" Text="Log In" OnClick="btnAction_Click" CssClass="game-button" />

                        
                    </div>
                    <div>
                        <p class="prompt-text">New user?</p>
                        <asp:Button ID="btnSignup" runat="server" Text="Sign Up" OnClick="btnAction_Click" CssClass="game-button" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
