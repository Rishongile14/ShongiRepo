using System;
using System.Web;

namespace TYP_TEAM_13_PROTOTYPE
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear the session
            Session.Clear();

            // Optionally, you can also abandon the session
            Session.Abandon();

            // Clear any authentication cookies
            if (Request.Cookies["UserType"] != null)
            {
                var userTypeCookie = new HttpCookie("UserType");
                userTypeCookie.Expires = DateTime.Now.AddDays(-1); // Set cookie to expire in the past
                Response.Cookies.Add(userTypeCookie);
            }

            // Redirect to home page
            Response.Redirect("Home.aspx");
        }
    }
}
