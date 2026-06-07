using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GameVault
{
    public partial class loginform : System.Web.UI.Page
    {
        private string cs = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\GameVault.mdf;Integrated Security=True;Connect Timeout=30";
        
        private SqlConnection GetConnection()
        {
            return new SqlConnection(cs);
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }



        protected void btnLogin_click(object sender , EventArgs e )
        {
           
            string username = usernametxt.Text;
            string password = passtxt.Text;
            if (username.IsNullOrWhiteSpace() || password.IsNullOrWhiteSpace())
            {
                ShowMessage("Invalid username or password");
            }
            else
            {
                using (SqlConnection conn = GetConnection())
                {   
                    conn.Open();
                    SqlCommand cmd = conn.CreateCommand();
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "SELECT PasswordHash FROM USERS WHERE Username = @Username";
                    cmd.Parameters.AddWithValue("@Username", username);

                    string  storedpass = (string)cmd.ExecuteScalar();

                    if(storedpass == password)
                    {
                        FormsAuthentication.SetAuthCookie(username, false); // false = session cookie
                        string redirectUrl = FormsAuthentication.GetRedirectUrl(username, false);
                        Response.Redirect(redirectUrl);
                    }
                    else
                    {
                        ShowMessage("incorrect password");
                    }
                  

                }

            }

        }
        private void ShowMessage(string message, bool isError = true)
        {
            error_mess.Text = message;

           error_mess.Visible = true;
        }
       
            


        }
    }





