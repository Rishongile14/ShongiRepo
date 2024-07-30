<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Car_Registeration.aspx.cs" Inherits="TYP_TEAM_13_PROTOTYPE.Car_Registeration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	  <!--service start -->
		<section id="service" class="service">
			<div class="container">
				<div class="service-content">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="panel panel-default">
                <div class="panel-heading" style="background-color:#337ab7">
                    <h3 class="panel-title text-center" style="color:white; font-size:50px">Register Vehicle</h3>
                </div>
                <div class="panel-body">
                   <form id="form1" runat="server">
                        <div class="form-group" runat="server">
                            <label for="Reg_Number">License Plate:</label>
                            <input type="text" class="form-control" runat="server" id="dReg_Number" name="Reg_Number" required >
                        </div>
                        <div class="form-group" runat="server">
                            <label for="Manufacturer">Vehicle Manufacturer</label>
                            <input type="text" class="form-control" id="dManufacturer" runat="server" name="Manufacturer" required>
                        </div>
                        <div class="form-group" runat="server">
                            <label for="Model">Vehicle Model</label>
                            <input type="text" class="form-control" id="dModel" runat="server" name="Model" required >
                        </div>
                        <div class="form-group" runat="server">
                            <label for="Year">Vehicle Year</label>
                            <input type="text" class="form-control" id="dYear" name="Year" runat="server" required >
                        </div>
                        <div class="form-group" runat="server" >
                            <label for="uploading pictures">Upload 4 pictures of your vehicle</label>
                            <input type="file" class="form-control" runat="server" id="dPic1" name="Pic1" required >
                        </div>
                        <div class="form-group" runat="server">
                           <input type="file" class="form-control" id="dPic2" name="Pic2" runat="server" required >
                        </div>
                        <div class="form-group" runat="server">
                         <input type="file" class="form-control" id="dPic3" name="Pic3" runat="server" required>
                        </div>
                         <div class="form-group" runat="server">
                         <input type="file" class="form-control" id="dPic4" name="Pic4" runat="server"  required >
                        </div>
                        <div class="text-center">
                           <div class="text-center">
                         <asp:Button ID="Button3" CssClass="btn btn-primary" runat="server" Text="Register Car" OnClick="Button3_Click" />
                                   
                             </div>
                         </div>
                 </form>
                    <div id="submissionMessage" class="text-center mt-3" style="display: none;">
                        <p>Registration was unsuccessful. Please enter valid details</p>
                     </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</section><!--/.service-->
		<!--service end-->


   

</asp:Content>
