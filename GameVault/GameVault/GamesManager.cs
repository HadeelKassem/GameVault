using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Reflection.Emit;

namespace GameVault

{
    public static class GamesManager
    {
        private static readonly string cs = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\GameVault.mdf;Integrated Security=True;Connect Timeout=30";

        public static SqlConnection GetConnection()
        {
            return new SqlConnection(cs);
        }

   
            
        public static decimal GetTotalUserSpending(int userId)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                string query = "SELECT ISNULL(SUM(SpentAmount), 0) FROM PURCHASES WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                return (decimal)cmd.ExecuteScalar();
            }
        }


        public static decimal GetDiscountPercentage(decimal totalSpent)
        {
            if (totalSpent >= 500)
                return 0.25m; // 25% discount
            else if (totalSpent >= 200)
                return 0.15m; // 15% discount
            else if (totalSpent >= 100)
                return 0.10m; // 10% discount
            else
                return 0.0m;  // No discount
        }

            public static object GetSingleValueFromTable( 
            string tableName,
           string columnName,
           List<string> conditions,
           List<string> paramToBind,        
           List<object> paramValue
            )
        {
                  string query = $"SELECT {columnName} FROM {tableName}";
                  SqlCommand cmd = CommandMaker(query, conditions, paramToBind, paramValue);

                 using (cmd.Connection)
               {
                cmd.Connection.Open();
                return cmd.ExecuteScalar();
                }
        }



        public static List<string> GetDistinctValues(string columnName, string tableName)
        {
            List<string> values = new List<string>();
            string query = $"SELECT DISTINCT {columnName} FROM {tableName}";

            using (SqlConnection conn = GetConnection())
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        values.Add(reader[columnName].ToString());
                    }
                }
            }

            return values;
        }
        private static SqlCommand  CommandMaker(string query ,List<string> conditions , List<string>paramToBind , List<object>paramValue  )
        {
            SqlConnection conn = new SqlConnection(cs);
            if (conditions != null && conditions.Count > 0)
            {
                query += " WHERE " + string.Join(" AND ", conditions);
            }
            SqlCommand cmd = new SqlCommand(query, conn);

            if (paramToBind != null && paramValue != null && paramToBind.Count == paramValue.Count)
            {
                for (int i = 0; i < paramToBind.Count; i++)
                {
                    cmd.Parameters.AddWithValue(paramToBind[i], paramValue[i]);
                }
            }
            return cmd; 

        }
        public static int getUserId(string username  )
        {
            List<string> conditions = new List<string> { "Username = @username" };
            List<string> paramToBind = new List<string> { "@username" };
            List<object> paramValue = new List<object> { username };

            object result = GetSingleValueFromTable("USERS", "UserId", conditions, paramToBind, paramValue);

            if (result != null && int.TryParse(result.ToString(), out int userId))
            {
                return userId;
            }

            return -1; // User not found

        }

        public  static  DataTable GetDistinctDatatable(List<string> columns, string tableName  ,List<string> conditions , List<string> paramToBind, List<object> paramValue)
        {
            DataTable dt = new DataTable();
            string columnString = string.Join(", ", columns);
            string query = $"SELECT DISTINCT {columnString} FROM {tableName}";
            SqlCommand cmd = CommandMaker(query, conditions, paramToBind, paramValue);
            


          using (cmd.Connection)
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(dt);
                }
            }

            return dt;



        }

        public static DataTable GetSimilarGames(string genre, string excludeTitle, int top = 10)
        {
            string query = $@"
        SELECT TOP {top} Id, Title, ImgUrl 
        FROM GAMES_INFO
        WHERE Genre = @Genre AND Title <> @Title
        ORDER BY NEWID()";

            using (SqlConnection conn = GetConnection())
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Genre", genre);
                cmd.Parameters.AddWithValue("@Title", excludeTitle);

                DataTable dt = new DataTable();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
                return dt;
            }
        }

        public static int  HasUserPurchasedGame(int userId, int gameId)
        {
            List<string> cond = new List<string> { "UserID = @UserID", "GameID = @GameID" };
            List<string> bind = new List<string> { "@UserID", "@GameID" };
            List<object> val = new List<object> { userId, gameId };

            object result = GetSingleValueFromTable("PURCHASES", "COUNT(*)", cond, bind, val);
            return  Convert.ToInt32(result) ;
        }
        public static int HaInLibrary(int userId, int gameId)
        {
            List<string> cond = new List<string> { "UserID = @UserID", "GameID = @GameID" };
            List<string> bind = new List<string> { "@UserID", "@GameID" };
            List<object> val = new List<object> { userId, gameId};

            object result = GetSingleValueFromTable("LIBRARY", "COUNT(*)", cond, bind, val);
            return Convert.ToInt32(result);
        }



   
        public static int AddToTable(string tableName, List<string> columns, List<object> values)
        {
            if (columns == null || columns.Count == 0)
                throw new ArgumentException("Columns cannot be null or empty", nameof(columns));

            if (values == null || values.Count == 0)
                throw new ArgumentException("Values cannot be null or empty", nameof(values));

            if (columns.Count != values.Count)
                throw new ArgumentException("Columns and values counts must match");

            // Create parameterized query
            var parameters = new List<string>();
            for (int i = 0; i < columns.Count; i++)
            {
                parameters.Add($"@param{i}");
            }

            string query = $@"
        INSERT INTO {tableName} ({string.Join(", ", columns)})
        VALUES ({string.Join(", ", parameters)})";

            using (var conn = GetConnection())
            using (var cmd = new SqlCommand(query, conn))
            {
                // Add parameters
                for (int i = 0; i < columns.Count; i++)
                {
                    cmd.Parameters.AddWithValue($"@param{i}", values[i] ?? DBNull.Value);
                }

                conn.Open();
                return cmd.ExecuteNonQuery();
            }
        }

        public static int RemoveFromTable(
            string tableName,
            List<string> conditions,
            List<string> paramToBind,
            List<object> paramValue)
        {
            if (conditions == null || conditions.Count == 0)
                throw new ArgumentException("Conditions cannot be null or empty for delete operations", nameof(conditions));

            if (paramToBind == null || paramValue == null || paramToBind.Count != paramValue.Count)
                throw new ArgumentException("Parameter bindings and values must match in count");

            string query = $"DELETE FROM {tableName} WHERE {string.Join(" AND ", conditions)}";

            using (var conn = GetConnection())
            using (var cmd = new SqlCommand(query, conn))
            {
                // Add parameters
                for (int i = 0; i < paramToBind.Count; i++)
                {
                    cmd.Parameters.AddWithValue(paramToBind[i], paramValue[i] ?? DBNull.Value);
                }

                conn.Open();
                return cmd.ExecuteNonQuery();
            }
        }
        public static DataTable GetUserGameData(string type, string username)
        {
            string table;
            string dateColumn;
            string alias;
            string joinOn;
            string userJoin;

            if (type  == "library")
            {
                table = "LIBRARY";
                dateColumn = "ul.AddedAt";
                alias = "ul";
                joinOn = "ul.GameID";
                userJoin = "ul.UserID";
            }
            else
            {
                table = "PURCHASES";
                dateColumn = "p.PurchaseDate AS BoughtAt";
                alias = "p";
                joinOn = "p.GameID";
                userJoin = "p.UserID";
            }

            string query = $@"
        SELECT g.ImgUrl, g.Title, {dateColumn}
        FROM GAMES_INFO g
        INNER JOIN {table} {alias} ON g.Id = {joinOn}
        INNER JOIN USERS u ON {userJoin} = u.UserId
        WHERE u.Username = @Username";

            using (SqlConnection conn = GetConnection())
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
        }


    }
}
