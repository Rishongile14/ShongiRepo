<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Passenger_DASH.aspx.cs" Inherits="TYP_TEAM_13_PROTOTYPE.Passenger_DASH" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap v3.3.6 CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
   
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <!-- Chart.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
    <style>
        .My-content {
            background-color: white;
            width: 100%;
            height: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--service start -->
    <section id="service" class="service">
        <div class="container">
            <div class="service-content">
                <div class="My-content">
                    <div class="row">
                        <div class="col-xs-12" style="justify-content:center;">
                            <h1 class="page-header" style="font-size:50px; color:#337ab7;margin-left:350px">Passenger Dashboard</h1>
                        </div>
                    </div>
                    <div class="row">
                        <form id="form1" runat="server"></form>
                        <div class="col-xs-12">
                            <h1 class="page-header" style="font-size:60px; color:#337ab7;margin-left:350px">Trip History</h1>
                            <div class="table-responsive">
                                <table id="tripHistoryTable" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>Trip ID</th>
                                            <th>Driver</th>
                                            <th>Fare (Rands)</th>
                                            <th>Start Location</th>
                                            <th>Destination Location</th>
                                            <th>Date</th>
                                            <th>Time</th>
                                            <th>Seats</th>
                                            <th>Actions</th> 
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Table body will be populated dynamically -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--/.service-->
    <!--service end-->

    <!-- Bootstrap v3.3.6 JavaScript -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap.min.js"></script>
  <script>
      $(document).ready(function () {
          // Retrieve user information from cookie
          var userType = getCookie('UserType');
          var userID = getCookie('UserID');
          console.log('UserType cookie:', userType);
          console.log('UserID cookie:', userID);

          if (userID) {
              // Fetch trip history data
              $.ajax({
                  url: 'http://localhost:5001/getPassengerTripHistory',
                  method: 'POST',
                  data: JSON.stringify({ passenger_id: userID }),
                  contentType: 'application/json',
                  success: function (response) {
                      console.log('Received response:', response);
                      if (response.success) {
                          if (response.info && response.info.length > 0) {
                              populateTripHistory(response.info);
                          } else {
                              showError('No trip history found for this passenger.');
                          }
                      } else {
                          showError('Failed to fetch trip history: ' + response.message);
                      }
                  },
                  error: function (xhr, status, error) {
                      console.error('Error details:', {
                          status: status,
                          error: error,
                          responseText: xhr.responseText
                      });
                      showError('Error fetching trip history');
                  }
              });
          } else {
              showError('User not logged in or user information not available.');
          }

          function getCookie(name) {
              var nameEQ = name + "=";
              var ca = document.cookie.split(';');
              for (var i = 0; i < ca.length; i++) {
                  var c = ca[i];
                  while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                  if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
              }
              return null;
          }

          function populateTripHistory(trips) {
              console.log('Populating trip history with:', trips);
              var tableBody = $('#tripHistoryTable tbody');
              tableBody.empty();

              trips.forEach(function (trip) {
                  var row = $('<tr>');
                  row.append($('<td>').text(trip.trip_id));
                  row.append($('<td>').text(trip.drivername));
                  row.append($('<td>').text('R' + trip.price.toFixed(2)));
                  row.append($('<td>').text(trip.start_location));
                  row.append($('<td>').text(trip.end_location));

                  // Handle null outbound_time
                  var date = trip.outbound_time ? new Date(trip.outbound_time) : new Date();
                  row.append($('<td>').text(date.toLocaleDateString()));
                  row.append($('<td>').text(date.toLocaleTimeString()));

                  row.append($('<td>').text(trip.bookedseats));

                  var actions = $('<td>');
                  actions.append($('<a>').attr('href', 'Complaints.aspx?tripID=' + trip.trip_id).addClass('btn btn-danger').text('Complaint'));
                  actions.append(' ');
                  actions.append($('<a>').attr('href', 'Review.aspx?tripID=' + trip.trip_id).addClass('btn btn-warning').text('Review'));
                  row.append(actions);

                  tableBody.append(row);
              });

              // Initialize DataTable
              $('#tripHistoryTable').DataTable();
          }

          function showError(message) {
              var tableBody = $('#tripHistoryTable tbody');
              tableBody.empty();
              tableBody.append($('<tr>').append($('<td colspan="9" class="text-center">').text(message)));
          }
      });


  </script>

</asp:Content>