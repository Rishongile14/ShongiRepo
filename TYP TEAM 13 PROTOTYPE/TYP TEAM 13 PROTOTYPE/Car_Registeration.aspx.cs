using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net.Http;
using System.Text;

namespace TYP_TEAM_13_PROTOTYPE
{
    public partial class Car_Registeration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected async void Button3_Click(object sender, EventArgs e)
        {

            HttpPostedFile uploadedFile1 = dPic1.PostedFile;
            string fileName1 = Path.GetFileName(uploadedFile1.FileName);
            HttpPostedFile uploadedFile2 = dPic2.PostedFile;
            string fileName2 = Path.GetFileName(uploadedFile2.FileName);
            HttpPostedFile uploadedFile3 = dPic3.PostedFile;
            string fileName3 = Path.GetFileName(uploadedFile3.FileName);
            HttpPostedFile uploadedFile4 = dPic4.PostedFile;
            string fileName4 = Path.GetFileName(uploadedFile4.FileName);

            var userObject = new
            {
                Reg_Number = dReg_Number.Value,
                Manufacturer = dManufacturer.Value,
                Model = dModel.Value,
                Year = dYear.Value,
                Pic1 = "assets/images/" + fileName1,
                Pic2 = "assets/images/" + fileName2,
                Pic3 = "assets/images/" + fileName3,
                Pic4 = "assets/images/" + fileName4

            };

            string jsonData = Newtonsoft.Json.JsonConvert.SerializeObject(userObject);

            using (HttpClient client = new HttpClient())
            {
                try
                {
                    client.BaseAddress = new Uri("http://localhost:5001");
                    var content = new StringContent(jsonData, Encoding.UTF8, "application/json");
                    HttpResponseMessage response = await client.PostAsync("/registercar", content);

                    if (response.IsSuccessStatusCode)
                    {
                        string responseBody = await response.Content.ReadAsStringAsync();
                        var result = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(responseBody);

                        bool status = result.status;
                        string userType = result.type;


                        if (status)
                        {

                            Response.Redirect("Home.aspx");


                        }
                        else
                        {
                            //message.InnerHtml = "Status: " + result.status + " Usertype: " + result.type;
                            // Handle login failure
                            // Display error message to the user
                        }
                    }
                    else
                    {
                        // Handle response failure
                        // Display error message to the user
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