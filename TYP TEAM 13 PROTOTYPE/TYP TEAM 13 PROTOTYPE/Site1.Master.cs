using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TYP_TEAM_13_PROTOTYPE
{
	public partial class Site1 : System.Web.UI.MasterPage
	{
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (Session["Logged_in"] == null)
                {
                    login_logout.InnerHtml = "<a class='nav-link' href='Login.aspx'>Login</a>";
                }
                else
                {
                    login_logout.InnerHtml = "<a class='nav-link' href='Login.aspx'>Login</a>";
                }

                HttpCookie userTypeCookie = Request.Cookies["UserType"];
                if (userTypeCookie != null)
                {
                    string userType = userTypeCookie.Value;
                    string dashboardLink = string.Empty;

                    if (userType == "Passenger")
                    {
                        dashboardLink = "<li class='nav-item'><a class='nav-link' href='Passenger_DASH.aspx'>Dashboard</a></li>";
                        login_logout.InnerHtml = "<a class='nav-link' href='Logout.aspx'>Logout</a>";
                    }
                    else if (userType == "Driver")
                    {
                        dashboardLink = "<li class='nav-item'><a class='nav-link' href='Driver_DASH.aspx'>Dashboard</a></li>";
                        login_logout.InnerHtml = "<a class='nav-link' href='Logout.aspx'>Logout</a>";
                    }

                    dash.InnerHtml = dashboardLink;
                }
            }
        }

        private void Logout()
		{
			// Clear the session
			Session.Clear();
			// Optionally, you can also abandon the session
			// Session.Abandon();
			// Redirect to home page
			Response.Redirect("Home.aspx");
		}
	}
}