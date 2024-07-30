<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TYP_TEAM_13_PROTOTYPE.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
    .btn {
        background-color: #337ab7;
        color: white;
        border: none;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 2px;
        cursor: pointer;
        border-radius: 4px;
    }
    .btn .fa-search {
        margin-right: 8px;
    }
</style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
         <div class="container">				  
				<div class="welcome-hero-txt" id="welcome" runat="server" style="background-color:white">
					<h2 style="color:black">Your Price, Your Ride - TripTogether</h2>
					<p style="color:black">
						Liftsearch connects you with nearby drivers or passengers heading your way, ensuring a comfortable ride at a price that fits your budget. Say goodbye to expensive solo trips and hello to affordable and eco-friendly travel options. Join the carpooling revolution with TripTogether today! 

					</p>
                    <p style="margin-top:15px; color:deepskyblue">To get started please install our Driver or Passenger app from the AppStore and Register as a User</p>
						<a href="#"  style="text-decoration:none; color:white; " class="text-white"><button class="welcome-btn"  style="background-color:#337ab7">Get Started</button></a>
				  
				</div>
                
         
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

</asp:Content>
