<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Register_Admin.aspx.cs" Inherits="ADMIN_WEBSITE.Register_Admin" Async="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <!-- Content wrapper -->
    <div class="container">
        <!-- Content -->

        <div class="container-xxl flex-grow-1 py-3">
            <div class="page-header">
                <h3 class="fw-bold mb-3">Authentications</h3>
                <ul class="breadcrumbs mb-3">
                    <li class="nav-home">
                        <a href="#">
                            <i class="fas fa-lock"></i>
                        </a>
                    </li>
                    <li class="separator">
                        <i class="icon-arrow-right"></i>
                    </li>
                    <li class="nav-item">
                        <a href="#">Authentications</a>
                    </li>
                    <li class="separator">
                        <i class="icon-arrow-right"></i>
                    </li>
                    <li class="nav-item">
                        <a href="#">Register Admin</a>
                    </li>
                </ul>
            </div>

            <!-- Basic Layout -->
            <div class="row">
                <div class="col-xl">
                    <div class="card mb-4">

                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Register Admin</h5>
                            <small class="text-muted float-end">Register Page</small>
                        </div>
                        <div class="card-body">
                            <form id="form1" runat="server">
                                <div class="mb-3">
                                    <label class="form-label" for="basic-icon-default-fullname">Full Name</label>
                                    <div class="input-group input-group-merge">
                                        <span id="basic-icon-default-fullname2" class="input-group-text"><i class="fas fa-user"></i></span>
                                        <input
                                            type="text"
                                            class="form-control"
                                            id="uname"
                                            runat="server"
                                            placeholder="John Doe"
                                            aria-label="John Doe"
                                            aria-describedby="basic-icon-default-fullname2" 
                                            required/>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label" for="basic-icon-default-company">Last Name</label>
                                    <div class="input-group input-group-merge">
                                        <span id="basic-icon-default-company2" class="input-group-text"><i class="fas fa-user-circle"></i></span>
                                        <input
                                            type="text"
                                            id="ulastname"
                                             runat="server"
                                            class="form-control"
                                            placeholder="Mathebula"
                                            aria-label="ACME Inc."
                                            aria-describedby="basic-icon-default-company2"
                                            required/>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label" for="basic-icon-default-email">Email</label>
                                    <div class="input-group input-group-merge">
                                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                        <input
                                            type="text"
                                            id="uemail"
                                             runat="server"
                                            class="form-control"
                                            placeholder="john.doe"
                                            aria-label="john.doe"
                                            aria-describedby="basic-icon-default-email2" 
                                            required/>
                                        <span id="basic-icon-default-email2" class="input-group-text">@example.com</span>
                                    </div>
                                    <div class="form-text">You can use letters, numbers & periods</div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label" for="basic-icon-default-phone">Phone No</label>
                                    <div class="input-group input-group-merge">
                                        <span id="basic-icon-default-phone2" class="input-group-text"><i class="fas fa-phone"></i></span>
                                        <input
                                            type="text"
                                            id="uphonenumber"
                                             runat="server"
                                            class="form-control phone-mask"
                                            placeholder="071 799 8941"
                                            aria-label="658 799 8941"
                                            aria-describedby="basic-icon-default-phone2" 
                                            required/>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label" for="basic-icon-default-phone">Password</label>
                                    <div class="input-group input-group-merge">
                                        <span id="basic-icon-default-pass" class="input-group-text"><i class="fas fa-lock"></i></span>
                                        <input
                                            type="password"
                                            id="upassword"
                                             runat="server"
                                            class="form-control phone-mask"
                                            placeholder=""
                                            aria-label="658 799 8941"
                                            aria-describedby="basic-icon-default-phone2" 
                                            required/>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label" for="basic-icon-default-phone">Confirm Password</label>
                                    <div class="input-group input-group-merge">
                                        <span id="basic-icon-default-passconf" class="input-group-text"><i class="fas fa-lock"></i></span>
                                        <input
                                            type="password"
                                            id="upassconfirm"
                                             runat="server"
                                            class="form-control phone-mask"
                                            placeholder=""
                                            aria-label="658 799 8941"
                                            aria-describedby="basic-icon-default-phone2"
                                            required/>
                                    </div>
                                </div>
                                 <div class="mb-3">
                                    <label class="form-label" for="basic-icon-default-phone">Select Gender</label>
                                    <div class="input-group input-group-merge">
                                        
                                        <select name="gender" class="form-control" id="ugender" runat="server" required>
                                            <option value="">Please select your Gender.</option>
                                            <option value="female">Female</option>
                                            <option value="male">Male</option>
                                            <option value="non-binary">Non-Binary</option>
                                            <option value="other">Other</option>
                                            <option value="Prefer not to answer">Prefer not to Answer</option>
                                        </select>
                                    </div>
                                </div>
                                 <div class="mb-3">
                                    <label class="form-label" for="basic-icon-default-phone">Select Admin Type</label>
                                    <div class="input-group input-group-merge">
                                        
                                        <select name="gender" class="form-control" id="uusertype" runat="server" required>
                                            <option value="">Please select admin type.</option>
                                            <option value="Super Admin">Super Admin</option>
                                            <option value="Operational Admin">Operational Admin</option>
                                            <option value="Support Admin">Support Admin</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <asp:Button ID="Button2" CssClass="btn" style="margin-left:600px" runat="server" Text="Register" OnClick="Button2_Click" />
                            </form>
                             <div id="submissionMessage" class="text-center mt-3" style="display: none;">
                                    <p>Registration was unsuccessful. Please enter valid details</p>
                                </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- / Content -->
    </div>
</asp:Content>
