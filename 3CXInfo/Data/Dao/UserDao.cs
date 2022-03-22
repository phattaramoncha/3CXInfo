using _3CXInfo.App_Helpers;
using System.Collections.Generic;
using System.Data.SqlClient;
using _3CXInfo.Data.Model;
using System;
using System.Configuration;

namespace _3CXInfo.Data.Dao
{
    public class UserDao //: BaseDao
    {
        protected readonly String DB_CONNECTION = ConfigurationManager.ConnectionStrings["DB_Security"].ConnectionString;
        public List<UserInfo> GetUserInfo(string Username)
        {
            using (SqlConnection conn = new SqlConnection(DB_CONNECTION))
            {
                conn.Open();
                using (SqlCommand command = conn.CreateCommand())
                {
                    command.CommandText = "spl_GetUserInfo";
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@UserName", Username));

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        return SQLDataMapper.MapToCollection<UserInfo>(reader);
                    };
                }
            }

        } 
    }
}