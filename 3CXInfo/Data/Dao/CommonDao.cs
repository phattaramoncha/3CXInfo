using Npgsql;
using _3CXInfo.App_Helpers;
using _3CXInfo.Data.Model;
using System;
using System.Collections.Generic;
using System.Data;

namespace _3CXInfo.Data.Dao
{
    public class CommonDao : BaseDao
    {
        public List<Zone> GetZones()
        {
            try
            {
                using (var conn = new NpgsqlConnection(DB_CONNECTION))
                {
                    conn.Open();
                    using (var cmd = new NpgsqlCommand("spl_get_zone", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("in_search", NpgsqlTypes.NpgsqlDbType.Text, string.IsNullOrEmpty("") ? (object)DBNull.Value : "");

                        using (var reader = cmd.ExecuteReader())
                        {
                            return SQLDataMapper.MapToCollection<Zone>(reader);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public List<User> GetCreateContract()
        {
            try
            {
                using (var conn = new NpgsqlConnection(DB_CONNECTION))
                {
                    conn.Open();
                    using (var cmd = new NpgsqlCommand("spl_get_user_create_contract", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        //cmd.Parameters.AddWithValue("in_search", NpgsqlTypes.NpgsqlDbType.Text, string.IsNullOrEmpty("") ? (object)DBNull.Value : "");

                        using (var reader = cmd.ExecuteReader())
                        {
                            return SQLDataMapper.MapToCollection<User>(reader);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public List<Project> GetProjectByZone(string ZoneId)
        {
            try
            {
                using (var conn = new NpgsqlConnection(DB_CONNECTION))
                {
                    conn.Open();
                    using (var cmd = new NpgsqlCommand("spl_get_project_by_zone", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("in_zone", NpgsqlTypes.NpgsqlDbType.Uuid, string.IsNullOrEmpty(ZoneId) || Guid.Parse(ZoneId).Equals(Guid.Empty) ? (object)DBNull.Value : Guid.Parse(ZoneId));

                        using (var reader = cmd.ExecuteReader())
                        {
                            return SQLDataMapper.MapToCollection<Project>(reader);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public List<Project> GetProjectByUser(string UserName)
        {
            try
            {
                using (var conn = new NpgsqlConnection(DB_CONNECTION))
                {
                    conn.Open();
                    using (var cmd = new NpgsqlCommand("spl_get_project", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("in_search", NpgsqlTypes.NpgsqlDbType.Text, string.IsNullOrEmpty(UserName) ? (object)DBNull.Value : UserName);

                        using (var reader = cmd.ExecuteReader())
                        {
                            return SQLDataMapper.MapToCollection<Project>(reader);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public List<Menu> GetMenu()
        {
            try
            {
                using (var conn = new NpgsqlConnection(DB_CONNECTION))
                {
                    conn.Open();
                    using (var cmd = new NpgsqlCommand("spl_get_menu", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("in_search", NpgsqlTypes.NpgsqlDbType.Text, (object)DBNull.Value);

                        using (var reader = cmd.ExecuteReader())
                        {
                            return SQLDataMapper.MapToCollection<Menu>(reader);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public List<Dept_SMC> GetDeptSMC()
        {
            try
            {
                using (var conn = new NpgsqlConnection(DB_CONNECTION))
                {
                    conn.Open();
                    using (var cmd = new NpgsqlCommand("spl_dept_smc", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("in_search", NpgsqlTypes.NpgsqlDbType.Text, (object)DBNull.Value);

                        using (var reader = cmd.ExecuteReader())
                        {
                            return SQLDataMapper.MapToCollection<Dept_SMC>(reader);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        } 
        public List<Line_Of_Business> GetLineOfBusiness(string in_type)
        {
            try
            {
                using (var conn = new NpgsqlConnection(DB_CONNECTION))
                {
                    conn.Open();
                    using (var cmd = new NpgsqlCommand("spl_get_line_of_business", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("in_type", NpgsqlTypes.NpgsqlDbType.Integer, string.IsNullOrEmpty(in_type) ? (object)DBNull.Value :Convert.ToInt64( in_type));

                        using (var reader = cmd.ExecuteReader())
                        {
                            return SQLDataMapper.MapToCollection<Line_Of_Business>(reader);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        } 
        public List<Internal_order> GetIOByProject(string in_proj_id)
        {
            try
            {
                using (var conn = new NpgsqlConnection(DB_CONNECTION))
                {
                    conn.Open();
                    using (var cmd = new NpgsqlCommand("spl_get_io_by_project", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("in_proj_id", NpgsqlTypes.NpgsqlDbType.Text, string.IsNullOrEmpty(in_proj_id) ? (object)DBNull.Value : in_proj_id);

                        using (var reader = cmd.ExecuteReader())
                        {
                            return SQLDataMapper.MapToCollection<Internal_order>(reader);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        } 
        public List<Project> GetProjectByLob(string in_lob, string in_zone)
        {
            try
            {
                using (var conn = new NpgsqlConnection(DB_CONNECTION))
                {
                    conn.Open();
                    using (var cmd = new NpgsqlCommand("spl_get_project_by_lob", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("in_lob", NpgsqlTypes.NpgsqlDbType.Text, string.IsNullOrEmpty(in_lob) ? (object)DBNull.Value : in_lob);
                        cmd.Parameters.AddWithValue("in_zone", NpgsqlTypes.NpgsqlDbType.Text, string.IsNullOrEmpty(in_zone) ? (object)DBNull.Value : in_zone); 

                        using (var reader = cmd.ExecuteReader())
                        {
                            return SQLDataMapper.MapToCollection<Project>(reader);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public List<Zone> GetZonesByLob(string in_lob)
        {
            try
            {
                using (var conn = new NpgsqlConnection(DB_CONNECTION))
                {
                    conn.Open();
                    using (var cmd = new NpgsqlCommand("spl_get_zone_by_lob", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("in_lob", NpgsqlTypes.NpgsqlDbType.Text, string.IsNullOrEmpty(in_lob) ? (object)DBNull.Value : in_lob);

                        using (var reader = cmd.ExecuteReader())
                        {
                            return SQLDataMapper.MapToCollection<Zone>(reader);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        } 
        public List<contractor> GetMasterContractor()
        {
            try
            {
                using (var conn = new NpgsqlConnection(DB_CONNECTION))
                {
                    conn.Open();
                    using (var cmd = new NpgsqlCommand("spl_get_master_contractor", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        //cmd.Parameters.AddWithValue("in_sap_pur_org", NpgsqlTypes.NpgsqlDbType.Text, string.IsNullOrEmpty(in_sap_pur_org) ? (object)DBNull.Value : in_sap_pur_org);
                        //cmd.Parameters.AddWithValue("in_sap_vendor", NpgsqlTypes.NpgsqlDbType.Text, string.IsNullOrEmpty(in_sap_vendor) ? (object)DBNull.Value : in_sap_vendor);
                        //cmd.Parameters.AddWithValue("in_avg_score", NpgsqlTypes.NpgsqlDbType.Numeric, string.IsNullOrEmpty(in_avg_score) ? (object)DBNull.Value : Convert.ToDecimal(in_avg_score));

                        using (var reader = cmd.ExecuteReader())
                        {
                            return SQLDataMapper.MapToCollection<contractor>(reader);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}