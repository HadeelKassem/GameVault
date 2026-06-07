using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Microsoft.Ajax.Utilities;
using System.Drawing;
using GameVault;
using System.Threading;
namespace GameVault
   
{
    public partial class GameDetails : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            string gameTitle = Request.QueryString["title"];
            if (!string.IsNullOrEmpty(gameTitle))
            {
               
                LoadSimilarGames(gameTitle);
            }
        }
        private void LoadSimilarGames(string title)
        {
           var  genre = GamesManager.GetSingleValueFromTable(
                "GAMES_INFO",
                "Genre",
                new List<string> { "Title = @Title" },
                new List<string> { "@Title" },
                new List<object> { title });

            if (!string.IsNullOrEmpty(genre.ToString()))
            {
                DataTable dt = GamesManager.GetSimilarGames(genre.ToString(), title);
                DataListSimilarGames.DataSource = dt;
                DataListSimilarGames.DataBind();
            }
        }

        protected int checkUser()
        {
            string username = User.Identity.Name;
            int userId = GamesManager.getUserId(username);
            if (userId < 0)
            {
                statusLabel.Text = "Login First";
                statusLabel.CssClass = "label-error";
                statusLabel.Visible = true;

                return -1;
            }
            else return userId;
            
                }
            
        

        public void clickedbtn(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            if (btn.ID == "btnAddToLibrary" || btn.Text == "Add to My Library")
            {
                btnAddToLibrary_Click(sender, e);
            }
            else if (btn.ID == "btnBuy" || btn.Text == "Buy")
            {
                btnBuy_Click(sender, e);
            }
        }
        protected void btnBuy_Click(object sender, EventArgs e)
        {
            int userId = checkUser();
            if (userId > 0)
            {
                int gameId = Convert.ToInt32(((Button)sender).CommandArgument);

                

                    int count = GamesManager.HasUserPurchasedGame(userId, gameId);

                    if (count > 0)
                    {
                        statusLabel.Text = "You have already purchased this game.";
                        statusLabel.CssClass = "label-warning";
                        statusLabel.Visible = true;
                    }
                    else
                    {
                    var conditions = new List<string> { "Id = @Id" };
                    var paramToBind = new List<string> { "@Id" };
                    var paramValue = new List<object> { gameId.ToString() };

                    decimal originalPrice = (decimal)GamesManager.GetSingleValueFromTable("GAMES_INFO","Price",conditions,paramToBind,paramValue);
                        decimal totalSpent = GamesManager.GetTotalUserSpending(userId);
                        decimal discount = GamesManager.GetDiscountPercentage(totalSpent);
                        decimal discountedPrice = originalPrice * (1 - discount);
                        Response.Redirect($"buyform.aspx?id={gameId}&price={discountedPrice}");
                    }
                }
            }
        


        protected void btnAddToLibrary_Click(object sender, EventArgs e)
        {

            int gameId = Convert.ToInt32(((Button)sender).CommandArgument);
            int userId = checkUser();
            DateTime addedAt = DateTime.Now;


            if (userId > 0)
            {

              if (GamesManager.HaInLibrary(userId ,  gameId)==0)
                    {
                    List<object> values = new List<object> { userId, gameId, addedAt };
                    List<String> columns = new List<string> { "UserId", "GameId", "AddedAt" };
                    GamesManager.AddToTable("LIBRARY",columns, values);
                        statusLabel.Text = "Game added to your libray";
                        statusLabel.CssClass = "label-success";
                        statusLabel.Visible = true;

                    }
                    else
                    {
                        statusLabel.Text = "Gane already in your library";
                        statusLabel.CssClass = "label-warning";
                        statusLabel.Visible = true;
                    }
                }
            }
        }

           



    }
