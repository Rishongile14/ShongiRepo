<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="TYP_TEAM_13_PROTOTYPE.Register"  Async="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


      	 <!--service start -->
    <section id="service" class="service justify-content-center">
        <div class="container">
            <div class="service-content">
                <div class="row justify-content-center" style="margin-left:250px">
                    <div class="col-md-8">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="background-color:#337ab7">
                                <h3 class="panel-title text-center" style="color:white; font-size:50px; ">Register</h3>
                            </div>
                            <div class="panel-body">
                                <form id="form1" runat="server">
                            <div class="form-group" runat="server">
                                <label for="name">Name</label>
                                <input type="text" class="form-control" id="uname" runat="server" name="name" required>
                            </div>
                            <div class="form-group" runat="server">
                                <label for="lastname">Last Name</label>
                                <input type="text" class="form-control" id="ulastname" runat="server" name="lastname" required>
                            </div>
                            <div class="form-group" runat="server">
                                <label for="phonenumber">Phone Number</label>
                                <input type="text" class="form-control" id="uphonenumber" runat="server" name="phonenumber" required>
                            </div>
                            <div class="form-group" runat="server">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="uemail" name="email" runat="server" required>
                            </div>
                            <div class="form-group" runat="server">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" runat="server" id="upassword" name="password" required>
                            </div>
                            <div class="form-group" runat="server">
                                <label for="gender">Gender</label>
                                <select class="form-control" id="ugender" name="gender"  runat="server" required  >
                                    <option value="" selected disabled>Select Gender</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                            <div class="form-group" runat="server">
                                <label for="usertype">User Type</label>
                                <select class="form-control" id="uusertype" name="usertype" runat="server" required>
                                    <option value="" selected disabled>Select User Type</option>
                                    <option value="Passenger">Passenger</option>
                                    <option value="Driver">Driver</option>
                                </select>
                            </div>
                                    <div class="text-center">
                                        <asp:Button ID="Button2" CssClass="btn btn-primary" runat="server" Text="Log In" OnClick="Button2_Click" />
                                   
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
    </section>
    <!--/.service-->
    <!--service end-->


</asp:Content>
