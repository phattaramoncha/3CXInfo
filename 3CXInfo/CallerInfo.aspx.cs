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

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string getCallerInfo(string numberPhone, string dateStart, string dateEnd, bool type)
        {
            //DateTime dtSrt = DateTime.ParseExact(dateStart, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            //DateTime dtEnd = DateTime.ParseExact(dateEnd, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            string result = string.Empty;

            CallerInfoDao info = new CallerInfoDao();
            //SEARCH
            if (type)
            {
                result = info.getCallerInfo(numberPhone, dateStart, dateEnd);
                return result;
            }
            else
            {
                result = info.getCallerInfoTODAY();
                return result;
            }
        }


    }

}