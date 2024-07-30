using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TYP_TEAM_13_PROTOTYPE
{
    public partial class Complaints : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string tripID = Request.QueryString["tripID"];
                if (!string.IsNullOrEmpty(tripID))
                {
                    tripIDTextbox.Text = tripID;
                }
            }
        }
    }
}