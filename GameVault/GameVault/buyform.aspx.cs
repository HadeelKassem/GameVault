using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Ajax.Utilities;
using System.Reflection.Emit;

namespace GameVault
{
    public partial class buyform : System.Web.UI.Page
    {
        private string cs = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\GameVault.mdf;Integrated Security=True;Connect Timeout=30";
        decimal totalSpent;
        decimal discount;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int userId = ChecUser();

                if (userId != -1)
                {
                     totalSpent = GamesManager.GetTotalUserSpending(userId);
                     discount = GamesManager.GetDiscountPercentage(totalSpent);

                    if (discount > 0)
                    {
                        int gameId = 0;
                        int.TryParse(Request.QueryString["id"], out gameId);
                        Label1.Visible = true;
                        Label1.Text = "New Price :"+GetGamePrice(gameId,discount)+"$";
                    }
                    else
                    {
                        Label1.Visible = false;
                    }
                }

                pnlPaymentForm.Visible = true;
                pnlSuccess.Visible = false;
            }
        }

        protected int ChecUser()
        {

            string username = User.Identity.Name;
            if (username.IsNullOrWhiteSpace())
            {

                return -1;
            }
            else
            {
                // Get userId from session or authentication system (example: 1)
                return GamesManager.getUserId(username);

            }

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (ValidateForm())
            {
                int gameId = 0;
                int.TryParse(Request.QueryString["id"], out gameId);

                int userId = ChecUser();
                bool inserted = InsertPurchase(
                    userId,
                    gameId,
                    ddlPaymentMethod.SelectedValue,
                    txtCardHolder.Text.Trim()
                );

                if (inserted)
                {
                    pnlPaymentForm.Visible = false;
                    pnlSuccess.Visible = true;
                    lblError.Visible = false;
                }
                else
                {
                    ShowError("Failed to complete purchase. Please try again later.");
                }
            }
        }





        private bool InsertPurchase(int userId, int gameId, string paymentMethod, string cardHolder)
        {
            decimal spentAmount = GetGamePrice(gameId);
            List<string> columns = new List<string> { "UserID","GameID","SpentAmount","PurchaseDate" };
            List<object> values = new List<object> {userId , gameId, spentAmount, DateTime.Now };

            GamesManager.AddToTable("PURCHASES",columns ,  values);

            return true;
        }


     
        public void goback()
        {

            Response.Redirect("~/GameDetails.apsx");



        }
        decimal GetGamePrice(int gameId, decimal discount = 0)
        {
            decimal price = 0;

            List<string> conditions = new List<string> { "Id = @GameId" };
            List<string> paramToBind = new List<string> { "@GameId" };
            List<object> paramValue = new List<object> { gameId };
            object result = GamesManager.GetSingleValueFromTable("GAMES_INFO", "Price", conditions, paramToBind, paramValue);

            if (result != null && result != DBNull.Value)
            {
                price = Convert.ToDecimal(result);
            }

            return price - (price * discount);
        }

        private bool ValidateForm()
        {
            lblError.Visible = false;

            // Trim inputs
            string cardNumber = txtCardNumber.Text.Trim();
            string cardHolder = txtCardHolder.Text.Trim();
            string expiryDate = txtExpiryDate.Text.Trim();
            string cvv = txtCVV.Text.Trim();
            string billingAddress = txtBillingAddress.Text.Trim();

            // Card number basic check (16 digits)
            if (string.IsNullOrEmpty(cardNumber) || !Regex.IsMatch(cardNumber.Replace(" ", ""), @"^\d{16}$"))
            {
                ShowError("Please enter a valid 16-digit card number.");
                return false;
            }

            // Card holder name check
            if (string.IsNullOrEmpty(cardHolder))
            {
                ShowError("Cardholder name cannot be empty.");
                return false;
            }

            // Expiry date format MM/YY
            if (!Regex.IsMatch(expiryDate, @"^(0[1-9]|1[0-2])\/\d{2}$"))
            {
                ShowError("Expiry date must be in MM/YY format.");
                return false;
            }

            // CVV 3 or 4 digits
            if (string.IsNullOrEmpty(cvv) || !Regex.IsMatch(cvv, @"^\d{3,4}$"))
            {
                ShowError("Please enter a valid 3 or 4 digit CVV.");
                return false;
            }

            // Billing address required
            if (string.IsNullOrEmpty(billingAddress))
            {
                ShowError("Billing address cannot be empty.");
                return false;
            }

            return true;
        }

        private void ShowError(string message)
        {
            lblError.Visible = true;
            lblError.Text = message;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            // Redirect back to game or store page
            Response.Redirect("~/GameDetails.aspx"); // change this to your actual page
        }
    }
}







