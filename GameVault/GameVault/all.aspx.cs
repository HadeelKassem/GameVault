using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GameVault
{
    public partial class all : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGenres();
                LoadConsoles();
                LoadAllGames("", "", "", "none");
            }
        }

        protected void FilterChanged(object sender, EventArgs e)
        {
            string selectedConsole = ddlConsole.SelectedItem.Text;
            string selectedGenre = ddlGenre.SelectedItem.Text;
            LoadAllGames(selectedGenre, selectedConsole, "", "filter");
        }


        private void LoadGenres()
        {
            List<string> genres = GamesManager.GetDistinctValues("Genre", "GAMES_INFO");
            ddlGenre.Items.Clear();
            ddlGenre.Items.Add(new ListItem("All Genres", "All Genres"));

            foreach (string genre in genres)
            {  
                ddlGenre.Items.Add(new ListItem(genre, genre));

            }
        }

        private void LoadConsoles()
        {
            List<string> consoles = GamesManager.GetDistinctValues("Console", "GAMES_INFO");
            ddlConsole.Items.Clear();
            ddlConsole.Items.Add(new ListItem("All Consoles", "All consoles"));

            foreach (string console in consoles)
            {
                ddlConsole.Items.Add(new ListItem(console, console));

            }
        }

        protected void btnSearchAllGames_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim();
            LoadAllGames("", "", keyword, "searchbt");
        }

        private void LoadAllGames(string genre, string console, string searchKeyword, string searchtype)
        {
            List<string> columns = new List<string> { "Title", "ImgUrl" };
            List<string> conditions = new List<string>();
            List<string> paramKeys = new List<string>();
            List<object> paramValues = new List<object>();
           
            if (searchtype == "searchbt" && !string.IsNullOrWhiteSpace(searchKeyword))
            {
                conditions.Add("Title LIKE @SearchKeyword");
                paramKeys.Add("@SearchKeyword");
                paramValues.Add("%" + searchKeyword + "%");
            }

            if (!string.IsNullOrWhiteSpace(genre) && genre != "All Genres")
            {
                conditions.Add("Genre = @Genre");
                paramKeys.Add("@Genre");
                paramValues.Add(genre);
            }

            if (!string.IsNullOrWhiteSpace(console) && console != "All Consoles")
            {
                conditions.Add("Console = @Console");
                paramKeys.Add("@Console");
                paramValues.Add(console);
            }
            DataTable dt = GamesManager.GetDistinctDatatable(columns,"GAMES_INFO", conditions, paramKeys, paramValues);
            DataListAll.DataSource = dt;
            DataListAll.DataBind();

        }
    }
}
