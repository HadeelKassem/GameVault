<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="GameVault.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
  
main {
    max-width: 900px;
    margin: 50px auto;
    padding: 40px;
    background: linear-gradient(135deg, #0f0f1a, #1a1a2e);
    border: 2px solid #00ffc3;
    border-radius: 16px;
    box-shadow: 0 0 25px #00ffc3;
    color: #e0e0f8;
    font-family: 'Orbitron', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

main h2#title {
    font-size: 3em;
    text-align: center;
    color: #00ffc3;
    text-shadow: 0 0 10px #00ffc3;
    margin-bottom: 10px;
}

main h3 {
    display: none;
}

main p {
    font-size: 1.15em;
    line-height: 1.8;
    text-align: justify;
    color: #ccccff;
}

main p::first-line {
    font-weight: bold;
    color: #ffffff;
}

main p a {
    color: #ff4081;
    text-decoration: none;
    border-bottom: 1px dotted #ff4081;
}

main p a:hover {
    color: #ffffff;
    border-color: #ffffff;
}

    </style>
    
    <main aria-labelledby="title">
        <h2 id="title">GameVault</h2>
        <h3>Unleash the Gamer in You with GameVault!</h3>
        <p>
            
            GameVault is more than just a game store — it’s your gateway to a universe of digital adventures.<br />
            Whether you're into action-packed shooters, immersive RPGs, or indie gems, GameVault brings you the best titles all in one place.<br /> 
            With a sleek interface, detailed game insights, and a growing library, we’re here to make discovering and collecting games exciting,<br />
            easy, and secure. Dive in, explore, and unlock your next favorite game — only at GameVault.

</p>
    </main>
</asp:Content>
