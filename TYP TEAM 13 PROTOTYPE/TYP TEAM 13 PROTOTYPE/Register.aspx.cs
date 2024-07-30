using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;


namespace TYP_TEAM_13_PROTOTYPE
{
	public partial class Register : System.Web.UI.Page
	{
        protected void Page_Load(object sender, EventArgs e)
        {




        }
        // protected void Button2_Click(object sender, EventArgs e)
        // {

        //  }
        protected async void Button2_Click(object sender, EventArgs e)
        {
            var userObject = new
            {
                name = uname.Value,
                lastname = ulastname.Value,
                phonenumber = uphonenumber.Value,
                email = uemail.Value,
                password = upassword.Value,
                gender = ugender.Value,
                usertype = uusertype.Value,

            };

            string jsonData = Newtonsoft.Json.JsonConvert.SerializeObject(userObject);

            using (HttpClient client = new HttpClient())
            {
                try
                {
                    client.BaseAddress = new Uri("http://localhost:5001");
                    var content = new StringContent(jsonData, Encoding.UTF8, "application/json");
                    HttpResponseMessage response = await client.PostAsync("/registration", content);

                    if (response.IsSuccessStatusCode)
                    {
                        string responseBody = await response.Content.ReadAsStringAsync();
                        var result = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(responseBody);


                        if (result.status == true)
                        {

                            Response.Redirect("Home.aspx");


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


    }
}