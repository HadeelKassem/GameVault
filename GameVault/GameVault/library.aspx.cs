using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GameVault
{
    public partial class library : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                string username = User.Identity.Name;
                BindGameDataToGrid("library", GridViewgames, "You have no saved games in your library.");
                BindGameDataToGrid("purchases", GridViewBought, "You haven't bought any games yet.");


            }
        }
        private void BindGameDataToGrid(string type, GridView gridView, string noDataMessage)
        {
            DataTable dt = GamesManager.GetUserGameData(type, User.Identity.Name);
            gridView.DataSource = dt;
            gridView.DataBind();

            lblMessage.Visible = dt.Rows.Count == 0;
            lblMessage.Text = dt.Rows.Count == 0 ? noDataMessage : "";
        }


        protected void GridViewgames_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "RemoveFromLibrary")
            {
                string gameTitle = e.CommandArgument.ToString();
                RemoveGameFromLibrary(User.Identity.Name, gameTitle);

                             BindGameDataToGrid("library", GridViewgames, "You have no saved games in your library.");
                BindGameDataToGrid("purchases", GridViewBought, "You haven't bought any games yet.");

            }
        }

        public static void RemoveGameFromLibrary(string username, string gameTitle)
        {
            int userId = GamesManager.getUserId(username);
            if (userId == -1) return;

            List<string> gameCond = new List<string> { "Title = @title" };
            List<string> gameBind = new List<string> { "@title" };
            List<object> gameVal = new List<object> { gameTitle };

            object gameIdObj = GamesManager.GetSingleValueFromTable("GAMES_INFO", "Id", gameCond, gameBind, gameVal);
            if (gameIdObj == null || !int.TryParse(gameIdObj.ToString(), out int gameId)) return;

            if (GamesManager.HaInLibrary(userId, gameId) == 0) return;

            
            List<string> conditions = new List<string> { "UserID = @userId", "GameID = @gameId" };
            List<string> bind = new List<string> { "@userId", "@gameId" };
            List<object> paramVal = new List<object> { userId, gameId};

            GamesManager.RemoveFromTable("LIBRARY", conditions, bind, paramVal);
        }


    }
}
