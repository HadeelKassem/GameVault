<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signupform.aspx.cs" 
    Inherits="GameVault.signupform
" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .prompt-text {
            color: #00ffff;
            font-size: 14px;
            margin: 12px 0 6px 0;
            font-weight: 600;
        }
        .error{
            background-color:aliceblue;
        }
        .login_container {
            width: 50%;
            margin: 80px auto;
            background-color: #121212;
            border-radius: 12px;
            box-shadow: 0 0 15px #00ffff;
            padding: 30px;
            color: #00ffff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            text-align: center;
        }
        .login_box h2 {
            margin-bottom: 10px;
            font-size: 28px;
            letter-spacing: 1.2px;
        }
        .login_box p {
            margin-bottom: 25px;
            font-size: 14px;
            color: #66ffff;
        }
        .game-button {
            color: #fff;
            font-weight: bold;
            font-size: 16px;
            padding: 12px 28px;
            margin: 10px 8px;
            background-color: cadetblue;
            border-style: none;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 0 8px #00ffff;
        }
        .login_body {
            display: flex;
            flex-direction: column;
        }
        .game-button:hover {
            background: linear-gradient(90deg, #006666, #00ffff);
            box-shadow: 0 0 20px #00ffff;
        }
        .button-container {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            color: #00ffff;
            margin-bottom: 8px;
            font-size: 14px;
        }
        .form-control:focus {
            border-color: #00ffff;
            box-shadow: 0 0 10px rgba(0, 255, 255, 0.5);
            outline: none;
        }
        
        .form-control {
            width: 50%;
            padding: 12px 15px;
            background: rgba(10, 10, 30, 0.7);
            border: 1px solid #008080;
            border-radius: 30px;
            color: #ffffff;
            font-size: 16px;
            transition: all 0.3s;
        }
        
    </style>

    <div class="login_container" DefaultButton="btnsignup">
        
        <div class="form-group"> 
            <label class="form_label" for="usernametxt">Username:</label> 
        <asp:TextBox ID="usernametxt" runat="server" CssClass="form-control" placeholder="enter your email or username"></asp:TextBox>

            </div>
         <div class="form-group"> 
     <label class="form_label" for="emailtxt">Email:</label> 
 <asp:TextBox ID="emailtxt" runat="server" CssClass="form-control" TextMode="Email" placeholder="enter your email"></asp:TextBox>

     </div>
                <div class="form-group"> 
    <label class="form_label" for="passtxt">Password:</label> 
<asp:TextBox ID="passtxt" runat="server" CssClass="form-control" TextMode="Password" placeholder="enter your password"></asp:TextBox>

    </div>
    
      
                            
      <asp:Button ID="btnsignup" runat="server" Text="sign up" OnClick=" btnsignup_click" CssClass="game-button" />

  <asp:TextBox  ID="error_mess" runat="server"   CssClass="error" Visible="false" ></asp:TextBox>
    </div>
</asp:Content>