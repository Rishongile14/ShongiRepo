<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TYP_TEAM_13_PROTOTYPE.Login"  Async="true"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<!--service start -->
    <section id="service" class="service">
        <div class="container">
            <div class="service-content">
                <div class="row justify-content-center" style="margin-left:250px">
                    <div class="col-md-8">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="background-color:#337ab7">
                                <h3 class="panel-title text-center" style="color:white; font-size:50px;">LogIn</h3>
                            </div>
                            <div class="panel-body">
                                <form id="form2" runat="server">
                                    <div class="form-group">
                                        <label for="email">Username</label>
                                        <input runat="server" type="email" class="form-control" id="uemail" name="email" placeholder="e.g example@gmail.com" required>
                                    </div>
                                    <div class="form-group" runat="server">
                                        <label for="password">Password</label>
                                        <input runat="server" type="password" class="form-control" id="upassword" name="password" required>
                                    </div>
                                    <div class="form-group">
                                        <br />
                                        <a style="text-decoration:none; color:rgb(70 68 68); font-size:small" href="Register.aspx">Don't have an account? <strong>Register</strong> </a><br />
                                        <br /> <a style="text-decoration:none; color:rgb(70 68 68); font-size:small" href="#">Forgot Password? <strong>reset</strong> </a>
                                    </div>
                                    <div class="text-center">
                                        <asp:Button ID="Button1" class="btn btn-primary" runat="server" Text="Log In" OnClick="Button1_Click" />
                                   
                                    </div>
                                    
                                </form>

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
