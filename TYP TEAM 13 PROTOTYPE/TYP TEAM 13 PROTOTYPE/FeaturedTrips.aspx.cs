using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TYP_TEAM_13_PROTOTYPE
{
	public partial class FeaturedTrips : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            
            if (!IsPostBack)
            {
                string fromLocation = Request.Form["from"];
                string toLocation = Request.Form["to"];
                string date = Request.Form["date"];
                int seats = Convert.ToInt32(Request.Form["seats"]);

                // Use the form data to populate the searched trips
                if(fromLocation != null) {
                PopulateSearchedTrips(fromLocation, toLocation, date, seats);
                }
            }
            
        }
        private void PopulateSearchedTrips(string fromLocation, string toLocation, string date, int seats)
        {
            // Your logic to populate the searched trips based on the form data
            // This could involve querying a database or calling an API
            // Once you have the search results, display them on the page
            var counter = 1;
            var display = "";
            var display1 ="";
            if (counter == 1) { 
            
            display += "<div class='col-lg-3 col-md-4 col-sm-6 m-3'>";
                display += "<div class='single-featured-cars'>";
                display += "<div class='featured-img-box'>";
                display += "<div class='featured-cars-img'>";
                display += "<a href='Subscription.aspx'><img src='assets/images/featured-cars/fc1.png' alt='cars'></a>";
                display += "</div>";
                display += "<div class='featured-model-info text-white' style='background-color:#337ab7'>";
                display += "<p class='text-white' style='color:white'><solid style='color:white'>";
                display += fromLocation+"-"+ toLocation;
                display += "<span class='featured-mi-span' style='color:white'> 07:30</span> <br/>";
                display += "<span class='featured-hp-span' style='color:white'> BMW X1</span>";
                display += " BY 02 GP  BLACK<br />"+seats+" Seats Available";
                display += "<br />"+date;
                display += "</solid></p>";
                display += "</div>";
                display += "</div>";
                display += "</div>";
                display += "</div>";
               // counter+=1;
			}
			else if (counter < 5)
			{
                display += "<div class='col-lg-3 col-md-4 col-sm-6'>";
                display += "<div class='single-featured-cars'>";
                display += "<div class='featured-img-box'>";
                display += "<div class='featured-cars-img'>";
                display += "<a href='Navigator.aspx'><img src='assets/images/featured-cars/corolla.png' alt='cars'></a>";
                display += "</div>";
                display += "<div class='featured-model-info text-white' style='background-color:#337ab7'>";
                display += "<p style='color:white'><solid>";
                display += fromLocation + "-" + toLocation; 
                display += "<span style='color:white' class='featured-mi-span'> 06:30</span> <br />";
                display += "<span style='color:white' class='featured-hp-span'> TOYOTA COROLLA</span>";
                display += " TR 55 TZ GP  WHITE<br /> 2 Seats Available";
                display += "<br />" + date;
                display += "</solid></p>";
                display += "</div>";
                display += "</div>";
                display += "</div>";
                display += "</div>";
            }
			
               

			
            trips1.InnerHtml = display;
            trips2.InnerHtml = display1;
        }
    }
}