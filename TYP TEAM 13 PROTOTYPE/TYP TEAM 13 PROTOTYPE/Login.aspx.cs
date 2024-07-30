using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;

namespace TYP_TEAM_13_PROTOTYPE
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_LoadAsync(object sender, EventArgs e)
        {

        }

        protected async void Button1_Click(object sender, EventArgs e)
        {


            var userObject = new
            {
                email = uemail.Value,
                password = upassword.Value
            };

            string jsonData = Newtonsoft.Json.JsonConvert.SerializeObject(userObject);

            using (HttpClient client = new HttpClient())
            {
                try
                {
                    client.BaseAddress = new Uri("http://localhost:5001");

                    var content = new StringContent(jsonData, Encoding.UTF8, "application/json");

                    HttpResponseMessage response = await client.PostAsync("/login", content);

                    if (response.IsSuccessStatusCode)
                    {
                        string responseBody = await response.Content.ReadAsStringAsync();
                        var result = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(responseBody);

                       
                        if (result.status == true)
                        {
                            Session["Logged_in"] = result;
                            // Set user type cookie or session variable
                            var userType = result.info.usertype;
                            var userID = result.info.id;

                            HttpCookie userTypeCookie = new HttpCookie("UserType", userType.ToString());
                            HttpCookie userIDCookie = new HttpCookie("UserID", userID.ToString());
                            Response.Cookies.Add(userTypeCookie);
                            Response.Cookies.Add(userIDCookie);
                            Response.Redirect("Home.aspx");
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




