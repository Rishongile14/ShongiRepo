using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TYP_TEAM_13_PROTOTYPE
{
	public partial class Home : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if(Session["Admin"] != null)
			{
			//	search_bar.Visible = false;
			}
		}

		protected void WelcomeBtn_Click(object sender, EventArgs e)
		{

			
		}
		protected void Search_Trip_Click(object sender, EventArgs e)
		{
			// Add your button click logic here
			// For example, you can perform a search operation or redirect to another page
			Session["Searched"] = "results";
			Response.Redirect("FeaturedTrips.aspx");
		}

	}
}