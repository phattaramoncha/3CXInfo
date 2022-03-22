using _3CXInfo.App_Helpers;
using System;
using System.Web.Services;

namespace _3CXInfo
{
    public partial class Login : System.Web.UI.Page
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string AuthLogin(string usn, string psw)
        {
            try
            {
                ///IsSkipAuthen
                if (AppSettingsInfo.IsSkipAuthen())
                {
                    #region MyRegion
                    //UserDao uDao = new UserDao();
                    //var userInfo = uDao.GetUserInfo(usn);

                    //if (userInfo.Count != 0)
                    //{
                    //    var txt = "Success";
                    //    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    //    return serializer.Serialize(txt);
                    //}

                    //else
                    //{
                    //    var txt = "The user name or password is incorrect.";
                    //    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    //    return serializer.Serialize(txt);
                    //}
                    #endregion

                    var txt = "Success";
                    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    return serializer.Serialize(txt);

                    //return RedirectToAction("Index", "Home", new { ReturnUrl, Type = Constant.Walk_In });
                }
                else
                {
                    if (AuthHelper.SignIn(usn.Trim(), psw.Trim()))
                    {
                        #region MyRegion
                        //UserDao uDao = new UserDao();
                        //var userInfo = uDao.GetUserInfo(usn);

                        //if (userInfo.Count != 0)
                        //{
                        //    var txt = "Success";
                        //    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                        //    return serializer.Serialize(txt);
                        //}

                        //else
                        //{
                        //    var txt = "The user name or password is incorrect.";
                        //    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                        //    return serializer.Serialize(txt);
                        //}
                        #endregion

                        var txt = "Success";
                        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                        return serializer.Serialize(txt);
                        //return RedirectToAction("Index", "Home", new { ReturnUrl, Type = Constant.Walk_In });
                    }
                    else
                    {
                        var txt = "The user name or password is incorrect.";
                        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                        return serializer.Serialize(txt);
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Login Error : " + ex.StackTrace + "-" + ex.Message);
                //return "Login Error : " + ex.StackTrace + "-" + ex.Message;
                //return "The user name or password is incorrect.\r\n";
                var txt = "The user name or password is incorrect.";
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                return serializer.Serialize(txt);
            }
        }
    }
}