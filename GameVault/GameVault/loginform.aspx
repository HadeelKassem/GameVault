<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="loginform.aspx.cs" 
    Inherits="GameVault.loginform" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
    body {
        background-color: #0d0d0d;
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .login_container {
        width: 50%;
          
        margin: 100px auto;
        background: linear-gradient(145deg, #101010, #1a1a1a);
        border-radius: 20px;
        box-shadow: 0 0 30px rgba(0, 255, 255, 0.4);
        padding: 40px 60px;
        text-align: center;
        animation: fadeIn 0.6s ease-in-out;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .login_box h2 {
        font-size: 30px;
        color: #00ffff;
        margin-bottom: 10px;
        letter-spacing: 1px;
        text-shadow: 0 0 10px #00ffff;
    }

    .login_box p {
        font-size: 14px;
        color: #66ffff;
        margin-bottom: 25px;
    }

    .prompt-text {
        color: #99ffff;
        font-size: 14px;
        margin: 10px 10px;
        font-weight: 600;
    }

    .form-group {
        text-align: left;
        margin-bottom: 25px;
    }

    .form-label {
        display: block;
        color: #00ffff;
        margin-bottom: 6px;
        font-size: 14px;
        font-weight: bold;
    }

    .form-control {
        width: 75%;
        padding: 12px 18px;
        background-color: rgba(0, 30, 30, 0.8);
        border: 1px solid #00bdbd;
        border-radius: 30px;
        color: #ffffff;
        font-size: 15px;
        transition: box-shadow 0.3s, border-color 0.3s;
    }

    .form-control:focus {
        border-color: #00ffff;
        box-shadow: 0 0 12px rgba(0, 255, 255, 0.6);
        outline: none;
    }

    .game-button {
        color: #ffffff;
        font-weight: bold;
        font-size: 16px;
        padding: 12px 30px;
        margin-top: 10px;
        background: linear-gradient(135deg, #008080, #00ffff);
        border: none;
        border-radius: 30px;
        cursor: pointer;
        transition: transform 0.3s, box-shadow 0.3s;
        box-shadow: 0 0 15px rgba(0, 255, 255, 0.5);
    }

    .game-button:hover {
        transform: scale(1.05);
        box-shadow: 0 0 25px #00ffff;
    }

    .error {
        width: 50%;
        margin-top: 30px;
        margin-left:170px;
        padding: 12px;
        background-color: #ffcccc;
        color: #990000;
        font-weight: bold;
        border: 1px solid #ff0000;
        border-radius: 10px;
        text-align: center;
        display: block;
    }
</style>


    <div class="login_container" DefaultButton="btnLogin">
        
        <div class="form-group"> 
            <label class="form_label" for="usernametxt">Username:</label> 
        <asp:TextBox ID="usernametxt" runat="server" CssClass="form-control" placeholder="enter your email or username"></asp:TextBox>

            </div>
         <div class="form-group"> 
     <label class="form_label" for="passtxt">Password:</label> 
 <asp:TextBox ID="passtxt" runat="server" CssClass="form-control" TextMode="Password" placeholder="enter yourpassword"></asp:TextBox>

     </div>
      
                            
      <asp:Button ID="btnlogin" runat="server" Text="Log in" OnClick="btnLogin_click" CssClass="game-button" />

  <asp:TextBox  ID="error_mess" runat="server"   CssClass="error" Visible="false" ></asp:TextBox>
    </div>
</asp:Content>