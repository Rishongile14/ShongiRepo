using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ADMIN_WEBSITE
{
    public partial class Login_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected async void Button1_Click(object sender, EventArgs e)
        {
            var useremailobj = new
            {
                email = uemail.Value
            };
            var mydata = "";
            var userObject = new
            {
                email = uemail.Value,
                password = upassword.Value
            };

            string jsonData = Newtonsoft.Json.JsonConvert.SerializeObject(userObject);
            String jsonData1 = Newtonsoft.Json.JsonConvert.SerializeObject(useremailobj);

            using (HttpClient client = new HttpClient())
            {
                try
                {
                    client.BaseAddress = new Uri("http://localhost:5001");

                    var content = new StringContent(jsonData, Encoding.UTF8, "application/json");
                    var content1 = new StringContent(jsonData1, Encoding.UTF8, "application/json");

                    HttpResponseMessage response = await client.PostAsync("/loginadmin", content);
                    HttpResponseMessage response1 = await client.PostAsync("/getusername",content1);

                    if (response.IsSuccessStatusCode)
                    {
                        string responseBody = await response.Content.ReadAsStringAsync();
                        string responseBody1 = await response1.Content.ReadAsStringAsync();
                        var result = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(responseBody);
                        var result1 = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(responseBody1);


                        if (result1.success == true && result.status == true)
                        {
                            Session["Logged_in"] = " ";
                            Session["Logged_in"] = result1.info.name;
                                if (Session["Logged_in"] == result1.info.name)
                            {

                           
                                Response.Redirect("Home.aspx? user_name = " + Session["Logged_in"]);
                            }


                        }

                    }

                }
                catch (HttpRequestException ex)
                {
                    throw ex;
                    // Handle the exception
                }
            }
        }
        }
}