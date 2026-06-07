using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace GameVault
{
    public class Manager
    {
        private string cs = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\GameVault.mdf;Integrated Security=True;Connect Timeout=30";
        private decimal GetTotalUserSpending(int userId)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                string query = "SELECT ISNULL(SUM(Price), 0) FROM PURCHASES WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                return (decimal)cmd.ExecuteScalar();
            }
        }
        private object GetSingleValueFromTable(string tableName, string columnName, string idColumnName, object idValue)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                string query = $"SELECT {columnName} FROM {tableName} WHERE {idColumnName} = @Id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", idValue);

                return cmd.ExecuteScalar();
            }
        }

        private decimal GetDiscountPercentage(decimal totalSpent)
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






    }
}