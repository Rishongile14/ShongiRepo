using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ADMIN_WEBSITE
{
    public partial class Datatables : System.Web.UI.Page
    {
        protected async void Page_Load(object sender, EventArgs e)
        {
            var display = "";
            using (HttpClient client = new HttpClient())
            {
                try
                {
                    client.BaseAddress = new Uri("http://localhost:5001");
                    HttpResponseMessage response = await client.GetAsync("/getalldriverdetails");
                    
                    if (response.IsSuccessStatusCode)
                    {
                        string responseBody = await response.Content.ReadAsStringAsync();
                        var result = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(responseBody);


                        if (result.success == true)
                        {

                            for (int i = 0; i < result.info.Count; i++)
                            {
                                display += "<tr>";
                                display += "<td>" + result.info[i].drivername + "</td>";
                                display += "<td>" +result.info[i].lastname + "</td>";
                                display += "<td>" + result.info[i].name + "</td>";
                                display += "<td>"+ result.info[i].registration +"</td>";
                                display += "<td>55</td>";
                                display += "<td>" + result.info[i].activestatus + "</td>";
                                display += "<td><asp:Button ID='btnBlock' runat='server' Text='Block' style='background-color:#337ab7; color:white' CssClass='btn btn-block' /></td>";
                                display += "</tr>";
                            }
                            Driver_table_data.InnerHtml = display;

                        }
                        else
                        {

                        }
                    }
                    else
                    {

                    }
                }
                catch (HttpRequestException ex)
                {
                    // Handle request exception
                    throw ex;
                }
            }
        }
        protected void btnBlock_Click(object sender, EventArgs e)
        {
            // Your button click handling code here
            // For demonstration, we'll simply change the button text
            btnBlock.Text = "Clicked!";
        }
    }
}