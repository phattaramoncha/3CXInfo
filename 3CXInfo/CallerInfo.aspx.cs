using _3CXInfo.App_Helpers;
using _3CXInfo.Data.Dao;
using System;
using System.Web.Services;

namespace _3CXInfo
{
    [AuthorizeUser]
    public partial class CallerInfo : System.Web.UI.Page
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
        }

        [WebMethod]
        public static string getCallerInfo(string numberPhone, string dateStart, string dateEnd, bool type, bool toDN)
        {
            //DateTime dtSrt = DateTime.ParseExact(dateStart, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            //DateTime dtEnd = DateTime.ParseExact(dateEnd, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            string result = string.Empty;

            CallerInfoDao info = new CallerInfoDao();
            //SEARCH
            if (type)
            {
                result = info.getCallerInfo(numberPhone, dateStart, dateEnd, toDN);
                return result;
            }
            else
            {
                result = info.getCallerInfoTODAY();
                return result;
            }
        }
        [WebMethod]
        public static string ExportReport(string numberPhone, string dateStart, string dateEnd, bool type, bool toDN)
        {
            return "CreateRpt.aspx?in_numbp=" + numberPhone + "&in_datest=" + dateStart + "&in_dateed=" + dateEnd + "&in_todn=" + toDN + "";
        }


    }

}