using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ADMIN_WEBSITE
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var display = "";
            var session = Session["Logged_in"];

                            //if (Session["Logged_in"] != " ")
                            //{
                                
                              //  display += " <span class='op-7'>"+ session+ "</span>";
                              //  display += "< span class='fw-bold'>/ Sign-in</span>";
                            //}

           // if(session != " ")
            //{
              //  var sess = session.ToString();
               // display += " <span class='op-7'>" + sess +" Mr Twari"+ "</span>";
            //}

                             logged_in_user.InnerHtml = display;

                      
            
        }
    }
}