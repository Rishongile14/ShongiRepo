<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Review.aspx.cs" Inherits="TYP_TEAM_13_PROTOTYPE.Review" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <!--service start -->
		<section id="service" class="service justify-content-center" style="background-color: white;>
			<div class="container">
				<div class="service-content ">
					  <div class="container">
    <!-- Trip Details Section -->
    <div class="row">
      <div class="col-md-12">
        <h2>Trip Details</h2>
        <!-- Include trip details here -->
      </div>
    </div>
    <!-- Driver Details Section -->
    <div class="row text-white">
      <div class="col-md-12">
        <h2>Driver Details</h2>
        <!-- Include driver details here -->
      </div>
    </div>
    <!-- Review Form Section -->
    <div class="row">
      <div class="col-md-12">
        <h2>Review</h2>
        <form id="reviewForm">
          <div class="form-group">
            <label for="rating">Rating (1-5)</label>
            <input type="number" class="form-control" id="rating" name="rating" min="1" max="5" required>
          </div>
          <div class="form-group">
            <label for="comment">Comment</label>
            <textarea class="form-control" id="comment" name="comment" rows="3" required></textarea>
          </div>
          <button type="submit" class="btn btn-primary">Submit Review</button>
        </form>
      </div>
    </div>
  </div>
  <!-- Bootstrap JS and jQuery -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
  <!-- Your custom script -->
  <script>
    // Add your custom JavaScript here, such as form submission handling
    $(document).ready(function() {
      $('#reviewForm').submit(function(e) {
        e.preventDefault(); // Prevent form submission
        // Handle form submission with AJAX or other methods
        // Example:
        // $.post('review.php', $(this).serialize(), function(response) {
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
