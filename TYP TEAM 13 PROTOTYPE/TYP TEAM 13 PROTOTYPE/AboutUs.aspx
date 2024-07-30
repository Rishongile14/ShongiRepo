<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="TYP_TEAM_13_PROTOTYPE.AboutUs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    		<!--About Us start -->
		<section id="service" class="service">
			<div class="container" style="background-color:white" >
				<div class="section-header text-primary">

					<h2 class="text-primary">About Our Company</h2>
				</div><!--/.section-header-->
				<div class="new-cars-content">
					<div class="owl-carousel owl-theme" id="new-cars-carousel">
						<div class="new-cars-item">
							<div class="single-new-cars-item">
								<div class="row text-primary">
									<div class="col-md-7 col-sm-12">
										<div class="new-cars-img">
											<img src="assets/images/new-cars-model/First.jpeg" alt="img"/>
										</div><!--/.new-cars-img-->
									</div>
									<div class="col-md-5 col-sm-12">
										<div class="new-cars-txt">
											<h2><a href="#" class="text-primary">Your Ride Your Pride </a></h2>
											<p class="text-white" style="color:black">
												embodies the essence of individuality and empowerment within our carpooling community. We believe that your choice of transportation reflects your personality and values, and we aim to elevate that experience by providing a platform where you can take pride in your journey. Whether you're a driver sharing your vehicle with others or a passenger enjoying a comfortable ride, we celebrate the uniqueness of each trip and the sense of ownership it brings.
											</p>
											<p class="new-cars-para2 text-white" style="color:black">
												This motto also speaks to our commitment to offering reliable and enjoyable rides that enhance your sense of pride in your travel choices.  
											</p>
											<button class="welcome-btn new-cars-btn" onclick="window.location.href='Home.aspx'" style="background-color:#337ab7">
												view details
											</button>
										</div><!--/.new-cars-txt-->	
									</div><!--/.col-->
								</div><!--/.row-->
							</div><!--/.single-new-cars-item-->
						</div><!--/.new-cars-item-->
						<div class="new-cars-item">
							<div class="single-new-cars-item">
								<div class="row text-primary">
									<div class="col-md-7 col-sm-12">
										<div class="new-cars-img">
											<img src="assets/images/new-cars-model/Second.jpeg" alt="img"/>
										</div><!--/.new-cars-img-->
									</div>
									<div class="col-md-5 col-sm-12">
										<div class="new-cars-txt">
											<h2><a href="#" class="text-primary">Your Happiness is our priority</a></h2>
											<p class="text-white" style="color:black">
												encapsulates our commitment to ensuring that our customers' satisfaction and well-being are at the forefront of everything we do. We believe that the key to a successful and lasting relationship with our customers lies in their happiness and contentment with our products and services. By making their happiness our top priority, we strive to exceed expectations, address their needs promptly, and create experiences that leave a positive and lasting impact.
											</p>
											<p class="new-cars-para2 text-white" style="color:black">
												This statement reflects our core values of customer-centricity and excellence. 
											</p>
											<button class="welcome-btn new-cars-btn" onclick="window.location.href='#'" style="background-color:#337ab7">
												view details
											</button>
										</div><!--/.new-cars-txt-->	
									</div><!--/.col-->
								</div><!--/.row-->	
							</div><!--/.single-new-cars-item-->
						</div><!--/.new-cars-item-->
						<div class="new-cars-item">
							<div class="single-new-cars-item">
								<div class="row">
									<div class="col-md-7 col-sm-12">
										<div class="new-cars-img">
											<img src="assets/images/new-cars-model/Third.jpeg" alt="img"/>
										</div><!--/.new-cars-img-->
									</div>
									<div class="col-md-5 col-sm-12">
										<div class="new-cars-txt text-primary">
											<h2><a href="#" class="text-primary">Sharing demonstrates care.</a></h2>
											<p class="text-white" style="color:black">
												embodies the idea that acts of sharing, whether tangible goods, knowledge, or experiences, are a powerful expression of empathy and consideration for others. By sharing, we not only meet the needs of those around us but also show that we value their well-being and happiness. Whether it's sharing resources during times of need or sharing ideas to foster growth and learning, this principle highlights the profound connection between sharing and genuine care for one another.
											</p>
											<p class="new-cars-para2 text-white" style="color:black">
												This motto encourages a culture of generosity and community support, emphasizing that our actions have the potential to make a meaningful impact on the lives of others.  
											</p>
											<button class="welcome-btn new-cars-btn" onclick="window.location.href='#'" style="background-color:#337ab7">
												view details
											</button>
										</div><!--/.new-cars-txt-->	
									</div><!--/.col-->
								</div><!--/.row-->
							</div><!--/.single-new-cars-item-->
						</div><!--/.new-cars-item-->
					</div><!--/#new-cars-carousel-->
				</div><!--/.new-cars-content-->
			</div><!--/.container-->

		</section><!--/.About Us-->
		<!--About Us end -->
	<script>
    document.getElementById('registrationForm').addEventListener('submit', async (event) => {
        event.preventDefault(); 

        const formData = new FormData(event.target);

        const jsonObject = {}; 
        formData.forEach((value, key) => {
            jsonObject[key] = value; 
        });

        try {
            const response = await fetch('http://localhost:3000/registration', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(jsonObject) 
            });

            const data = await response.json(); 
            console.log('Response from server:', data);

            if (data.status === true) {
                // Redirect to another page
                window.location.href = '/login.html'; 
            } else {
               
                document.getElementById('submissionMessage').style.display = 'block';
            }

        } catch (error) {
            console.error('Error:', error);
        }
    });
    </script>
</asp:Content>
