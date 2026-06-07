using Microsoft.AspNet.FriendlyUrls;
using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Activities;

namespace GameVault
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
       
        protected void btnAction_Click(object sender, EventArgs e)
        {
            Button clickedButton = sender as Button;
            if (clickedButton.ID == "btnLogin")
            {
                Response.Redirect("~/loginform.aspx");
            }
            else if (clickedButton.ID == "btnSignup")
            {
                Response.Redirect("~/signupform.aspx");
            }


        }






    }
}