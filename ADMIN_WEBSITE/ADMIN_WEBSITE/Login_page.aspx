<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login_page.aspx.cs" Inherits="ADMIN_WEBSITE.Login_page" Async="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>TripTogether</title>
    <meta
        content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
        name="viewport" />
    <link
        rel="icon"
        href="assets/img/kaiadmin/favicon.ico"
        type="image/x-icon" />

    <!-- Fonts and icons -->
    <script src="assets/js/plugin/webfont/webfont.min.js"></script>
    <script>
        WebFont.load({
            google: { families: ["Public Sans:300,400,500,600,700"] },
            custom: {
                families: [
                    "Font Awesome 5 Solid",
                    "Font Awesome 5 Regular",
                    "Font Awesome 5 Brands",
                    "simple-line-icons",
                ],
                urls: ["assets/css/fonts.min.css"],
            },
            active: function () {
                sessionStorage.fonts = true;
            },
        });
    </script>

    <!-- CSS Files -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/plugins.min.css" />
    <link rel="stylesheet" href="assets/css/kaiadmin.min.css" />

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="assets/css/demo.css" />
</head>
<body style="background-image:url(../assets/img/bg-picture.jpg);
            background-size: cover; 
            background-repeat: no-repeat; 
            background-position: center; 
            width: 100%; 
            height: 100vh;">
    <!-- Content wrapper -->
    <div class="container">
        <!-- Content -->
        <div class="row justify-content-center align-items-center">
            <div class="col-md-8">
                <div class="card" style="margin-top:160px; ">
                    <div class="card-header" style="background-color: #337ab7">
                        <h3 class="card-title text-center" style="color: white; font-size: 50px;">Admin Login</h3>
                    </div>
                    <div class="card-body">
                        <form id="form2" runat="server">
                            <div class="mb-3">
                                <label for="email" class="form-label">Username</label>
                                <input runat="server" type="email" class="form-control" id="uemail" name="email" placeholder="e.g example@gmail.com" required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input runat="server" type="password" class="form-control" id="upassword" name="password" required>
                            </div>
                            <div class="mb-3">
                                <a style="text-decoration: none; color: rgb(70 68 68); font-size: small" href="#">Don't have an account? <strong>Register</strong></a><br />
                                <a style="text-decoration: none; color: rgb(70 68 68); font-size: small" href="#">Forgot Password? <strong>reset</strong></a>
                            </div>
                            <div class="text-center">
                                <asp:Button ID="Button1" class="btn" style="background-color: #337ab7; color:white" runat="server" Text="Login" OnClick="Button1_Click" />
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
