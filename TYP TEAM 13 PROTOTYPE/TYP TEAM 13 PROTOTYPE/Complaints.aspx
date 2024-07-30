<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Complaints.aspx.cs" Inherits="TYP_TEAM_13_PROTOTYPE.Complaints" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--service start -->
    <section id="service" class="service justify-content-center" style="background-color: white;">
        <div class="container" style="padding: 10px;">
            <div class="service-content">
                <div class="container">
                    
                    <!-- Complaint Form Section -->
                    <div class="row">
                        <div class="col-md-12">
                            <h2>Submit a Complaint</h2>
                            <form id="complaintForm" runat="server">
                                <div class="form-group">
                                    <label for="tripID">Trip ID</label>
                                    <asp:TextBox ID="tripIDTextbox" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="complaint">Complaint</label>
                                    <textarea class="form-control" id="complaint" name="complaint" rows="3" required style="resize: none;"></textarea>
                                </div>
                                <button type="submit" class="btn btn-danger">Submit Complaint</button>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- Bootstrap JS and jQuery -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
                <!-- Your custom script -->
                <script>
                    $(document).ready(function() {
                        // Example: Handle form submission with AJAX or other methods
                        $('#complaintForm').submit(function(e) {
                            e.preventDefault(); // Prevent form submission
                            // Handle form submission with AJAX or other methods
                            // Example:
                            // $.post('submit_complaint.php', $(this).serialize(), function(response) {
                            //   // Handle response from the server
                            // });
                        });
                    });
                </script>
            </div>
        </div><!--/.container-->
    </section><!--/.service-->
    <!--service end-->
</asp:Content>
