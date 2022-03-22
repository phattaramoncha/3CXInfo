using System;

namespace _3CXInfo.Data.Model
{
    public class Zone
    {
        public Guid ZoneId { get; set; }

        public string ZoneDesc { get; set; }

        public Int32 ZonePosition { get; set; }

        public Int64 ProjectTotal { get; set; }

        public Guid SubZoneId { get; set; }
    }

    public class SubZone
    {
        public Guid SubZoneId { get; set; }

        public string SubZoneDesc { get; set; }

        public Int32 SubZonePosition { get; set; }
    }

    public class Project
    {
        public Guid ProjectId { get; set; }
        public string ProjectName { get; set; }
        public string ProjectCode { get; set; }
        public Guid SubZoneId { get; set; }
    }

    public class Menu
    {
        public Guid ReportId { get; set; }
        public string MenuRedirectedUrl { get; set; }
    }
 
    public class User
    {
        public Guid user_id { get; set; }
        public string username { get; set; }
    }

    public class Dept_SMC
    {
        public string Dept_Desc { get; set; }
    }
    public class Line_Of_Business
    {
        public string lb_id { get; set; }
        public string lb_code { get; set; }
        public string lb_name { get; set; }
    }
    public class Internal_order
    {
        public Guid io_id { get; set; }
        public string io_code { get; set; }
        public Guid proj_id { get; set; }
        public string proj_code { get; set; }
        public string proj_name { get; set; }
    }
    public class contractor
    {
        public Guid con_id { get; set; }
        public string con_code { get; set; }
        public string con_name { get; set; }
    }
}