using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GameVault
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string username = User.Identity.Name;
            if (string.IsNullOrEmpty(username))
            {
                lblSignupMessage.Text = "Sign up to get special sales!";
                lblSignupMessage.Visible = true;
            }
            else
            {
                lblSignupMessage.Text = "";
                lblSignupMessage.Visible = false;
            }
        }
    }
}
