using System;
using System.Web;
using System.Web.Mvc;

namespace _3CXInfo.App_Helpers
{
    public class AuthorizeUserAttribute : AuthorizeAttribute
    {
        // Custom property
        public string AccessRole { get; set; }

        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            //var isAuthorized = base.AuthorizeCore(httpContext);
            //if (!isAuthorized)
            //{
            //    return false;
            //}
            if (httpContext == null)
            {
                throw new ArgumentNullException("httpContext");
            }

            if (!AuthHelper.IsAuthenticated())
            {
                return false;
            }

            //List<string> allRole = AuthHelper.GetUserRoleCode();

            //return allRole.Contains(this.AccessRole) || String.IsNullOrEmpty(this.AccessRole);
            return true;
        }
    }
}