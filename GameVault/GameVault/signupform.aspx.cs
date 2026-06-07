using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace GameVault
{
    public partial class signupform : System.Web.UI.Page
    {


        private string cs = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\GameVault.mdf;Integrated Security=True;Connect Timeout=30";
        private string username = null , password = null , email = null ; 
        private SqlConnection GetConnection()
        {
            return new SqlConnection(cs);
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        

        protected void btnsignup_click(object sender, EventArgs e)
        {

            string testUsername = usernametxt.Text;
            string testPassword = passtxt.Text;
            string testEmail = emailtxt.Text;

            if (!verifyUsername(testUsername)) return;
            if (!verifypass(testPassword)) return;
            if (!verifyemail(testEmail))
            {
                ShowMessage("Invalid email format");
                return;
            }

            adduser(testUsername, testEmail, testPassword);
            ShowMessage("User registered successfully!", false);



        }



        private void adduser(string username, string email , string password)
        {
            using (SqlConnection conn = GetConnection())
            {
                conn.Open();
                DateTime date = DateTime.Now;

                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO USERS (Username, Email,PasswordHash,CreatedAt) VALUES (@Username, @Email, @Password, @Date)", conn);

                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.Parameters.AddWithValue("@Date", date);

                cmd.ExecuteNonQuery();
            }
            Response.Redirect("~/library.aspx?username='" + username + "'");


        }
        private void ShowMessage(string message, bool isError = true)
        {
            error_mess.Text = message;

            error_mess.Visible = true;
        }
         
        private Boolean verifyUsername(string username)
        {
            using (SqlConnection conn = GetConnection())
            {
                conn.Open();
                
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM USERS WHERE Username = @Username", conn);
                cmd.Parameters.AddWithValue("@Username", username);
                int count = (int)cmd.ExecuteScalar();
                if (count > 0)
                {
                    ShowMessage("Username already exists");
                    return false; 
                }
                
                    return true;
                    
                
                

            }
              
        }
        private Boolean verifypass(string password)
        {
          if(password.Length <4)
            {
                ShowMessage("password musdt be longer than 4 character");
                return false;

            }
            return true; 

            

        }
        private Boolean verifyemail(string email )
        {
            string pattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
            return Regex.IsMatch(email, pattern);



        }






    }
}
