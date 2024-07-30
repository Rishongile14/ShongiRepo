<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FeaturedTrips.aspx.cs" Inherits="TYP_TEAM_13_PROTOTYPE.FeaturedTrips" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<style>
    .bg-black {
        background-color: black !important; /* Use !important to override Bootstrap's default styles */
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--featured-cars start -->
		<section id="featured-cars" class="featured-cars">
			<div class="container">

				<div class="section-header">
					<p  style="color:white">Checkout <span style="color:white">Our</span> Featured Trips</p>
					<h2  style="color:white">featured Trips</h2>
				</div><!--/.section-header-->
				<div class="featured-cars-content">
					<div class="row" id="trips1" runat="server">
						<div class="col-lg-3 col-md-4 col-sm-6 m-3">
							<div class="single-featured-cars">
								<div class="featured-img-box">
									<div class="featured-cars-img">
										<a href="Subscription.aspx"><img src="assets/images/featured-cars/fc1.png" alt="cars"></a>
									</div>
									<div class="featured-model-info text-white" style="background-color:#337ab7">
										<p class="text-white" style="color:white"><solid style="color:white">
											Johannesburg-Centurion
											<span class="featured-mi-span" style="color:white"> 07:30</span> <br />
											<span class="featured-hp-span" style="color:white"> BMW X1</span>
											 BY 02 GP  BLACK<br /> 4 Seats Available
											<br /> 22/04/2024
										</solid></p>
									</div>
								</div>
								
							</div>
						</div>
						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="single-featured-cars">
								<div class="featured-img-box">
									<div class="featured-cars-img">
										<a href="Navigator.aspx"><img src="assets/images/featured-cars/corolla.png" alt="cars"></a>
									</div>
									<div class="featured-model-info text-white" style="background-color:#337ab7">
										<p style="color:white"><solid>
											Pretoria-Midrand
											<span style="color:white" class="featured-mi-span"> 06:30</span> <br />
											<span style="color:white" class="featured-hp-span"> TOYOTA COROLLA</span>
											 TR 55 TZ GP  WHITE<br /> 2 Seats Available
											<br /> 22/04/2024
										</solid></p>
									</div>
								</div>
								
							</div>
						</div>
						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="single-featured-cars">
								<div class="featured-img-box">
									<div class="featured-cars-img text-white ">
										<a href="Subscription.aspx"><img src="assets/images/featured-cars/Vw-polo.png" alt="cars"></a>
									</div>
									<div class="featured-model-info" style="background-color:#337ab7">
										<p style="color:white"><solid>
											Tembisa-Randburg
											<span style="color:white" class="featured-mi-span"> 07:00</span> <br />
											<span style="color:white" class="featured-hp-span"> Volkswagen Polo</span>
											 BMT 567 MP WHITE<br /> 4 Seats Available
											<br /> 22/04/2024
										</solid></p>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="single-featured-cars">
								<div class="featured-img-box">
									<div class="featured-cars-img">
										<a href="Subscription.aspx"><img src="assets/images/featured-cars/fc4.png" alt="cars"></a>
									</div>
									<div class="featured-model-info" style="background-color:#337ab7">
										<p style="color:white"><solid>
											Auckland Park-Sandton
											<span style="color:white" class="featured-mi-span"> 07:15</span> <br />
											<span style="color:white" class="featured-hp-span"> Audi A4 Station Wagon</span>
											 CPY 774 L RED<br /> 3 Seats Available
											<br /> 22/04/2024
										</solid></p>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row" style="margin-top:50px" runat="server" id="trips2">
						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="single-featured-cars">
								<div class="featured-img-box">
									<div class="featured-cars-img">
										<a href="Subscription.aspx"><img src="assets/images/featured-cars/Kia-Rio.png" alt="cars"></a>
									</div>
									<div class="featured-model-info" style="background-color:#337ab7">
										<p style="color:white"><solid>
											Soweto-Alexandra
											<span style="color:white" class="featured-mi-span"> 06:30</span> <br />
											<span style="color:white" class="featured-hp-span"> KIA Rio</span>
											 CP 82 PL GP  BLUE <br /> 4 Seats Available
											<br /> 22/04/2024
										</solid></p>
									</div>
								</div>
								
							</div>
						</div>
						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="single-featured-cars">
								<div class="featured-img-box">
									<div class="featured-cars-img">
										<a href="Subscription.aspx"><img src="assets/images/featured-cars/Suzuki-Baleno.jpeg" alt="cars"></a>
									</div>
									<div class="featured-model-info " style="background-color:#337ab7">
										<p style="color:white"><solid>
											Boksburg-Pretoria
											<span style="color:white" class="featured-mi-span"> 07:30</span> <br />
											<span style="color:white" class="featured-hp-span"> Suzuki Baleno</span>
											 PTY 607 L SEA-GREY <br /> 4 Seats Available
											<br /> 25/04/2024
										</solid></p>
									</div>
								</div>
								
							</div>
						</div>
						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="single-featured-cars">
								<div class="featured-img-box">
									<div class="featured-cars-img">
										<a href="Subscription.aspx"><img src="assets/images/featured-cars/haval.png" alt="cars"></a>
									</div>
									<div class="featured-model-info " style="background-color:#337ab7">
										<p style="color:white"><solid>
											Midrand-Johannesburg
											<span style="color:white" class="featured-mi-span"> 06:00</span> <br />
											<span style="color:white" class="featured-hp-span"> Haval Jolion</span>
											 TG 67 MM GP  Light Blue <br /> 4 Seats Available
											<br /> 28/04/2024
										</solid></p>
									</div>
								</div>
								
							</div>
						</div>
						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="single-featured-cars">
								<div class="featured-img-box">
									<div class="featured-cars-img">
										<a href="Subscription.aspx"><img src="assets/images/featured-cars/Omoda.png" alt="cars"></a>
									</div>
									<div class="featured-model-info bg-dark" style="background-color:#337ab7">
										<p style="color:white"><solid>
											Auckland Park-Midrand
											<span style="color:white" class="featured-mi-span"> 08:00</span> <br />
											<span style="color:white" class="featured-hp-span"> Omoda C5</span>
											 PY 88 CY GP  GRAY <br /> 4 Seats Available 
											<br /> 30/04/2024
										</solid></p>
									</div>
								</div>
								
							</div>
						</div>
					</div>
				</div>
			</div><!--/.container-->

		</section><!--/.featured-cars-->
		<!--featured-cars end -->
</asp:Content>
