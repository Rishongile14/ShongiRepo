<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Driver_Dash.aspx.cs" Inherits="TYP_TEAM_13_PROTOTYPE.Driver_Dash" %>
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
        .My-content{
            background-color:white;
            width:100%;
            height:100%;

        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <!--service start -->
    <section id="service" class="service">
        <div class="container">
            <div class="service-content">
    <!-- Page Heading -->
                <div class="My-content">
    
    
    
        <!-- Add similar panels for other cards -->
        <div class="row">
        <div class="col-xs-12" style="justify-content:center;">
            <h1 class="page-header" style="font-size:50px; color:#337ab7;margin-left:350px">Driver Dashboard</h1>
           
        </div>
    </div>
     
    <div class="row" >
        <!-- Earnings (Monthly) Card Example -->
        <div class="col-md-3 col-sm-6">
            <div class="panel panel-primary" >
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-calendar fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">R15 000.00</div>
                            <div>Earnings (This Month)</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Begin Page Content -->

    <div class="row">
        <form id="form1" runat="server">
        
           
        
             <div class="container">
        <h1>Perfomance And Income Analysis</h1>
        <div class="row">
            <div class="col-md-6">
                <canvas id="performanceChart" width="400" height="200"></canvas>
            </div>
            <div class="col-md-6">
                <canvas id="incomeChart" width="400" height="200"></canvas>
            </div>
        </div>
    </div>
    </form>
        <div class="col-xs-12">
            <h1 class="page-header" style="font-size:60px; color:#337ab7;margin-left:350px">Trip History</h1>
            <p class="lead">Below is a table displaying trip history information</p>
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover">
<thead>
                <tr>
                    <th>Trip ID</th>
                    <th>Passenger</th>
                    <th>Fare (Rands)</th>
                    <th>Start Location</th>
                    <th>Destination Location</th>
                    <th>Date</th>
                    <th>Duration (minutes)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>Lerato Molefe</td>
                    <td>R150.00</td>
                    <td>Johannesburg CBD</td>
                    <td>Sandton</td>
                    <td>2023-05-15</td>
                    <td>30</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Thabo Modise</td>
                    <td>R200.00</td>
                    <td>Pretoria</td>
                    <td>Midrand</td>
                    <td>2023-06-20</td>
                    <td>45</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Thabo Modise</td>
                    <td>R200.00</td>
                    <td>Acadia</td>
                    <td>Soshanguve</td>
                    <td>2023-06-21</td>
                    <td>45</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Lerato Modise</td>
                    <td>R200.00</td>
                    <td>Centurion</td>
                    <td>Soshanguve</td>
                    <td>2023-06-21</td>
                    <td>54</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Thomas Jackson</td>
                    <td>R500.00</td>
                    <td>Midrand</td>
                    <td>Soshanguve</td>
                    <td>2023-06-21</td>
                    <td>15</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Tylon Takaidza</td>
                    <td>R85.00</td>
                    <td>Roodeport</td>
                    <td>Johannesburg</td>
                    <td>2023-06-21</td>
                    <td>25</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Rishongile TShabalala</td>
                    <td>R195.00</td>
                    <td>Brixton</td>
                    <td>Kempton park</td>
                    <td>2023-06-21</td>
                    <td>55</td>
                </tr>

                <!-- Add more trip history data rows as needed -->
            </tbody>
                </table>
            </div>
        </div>

    </div>
                      <!-- Begin Page Content -->
   
    </div>
    <!-- Add similar sections for Trips Information and Passengers Information -->
    
</div>
<!-- /.container -->
             </div>
        
    </section>
    <!--/.service-->
    <!--service end-->

<!-- Bootstrap v3.3.6 JavaScript -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<!-- Page level plugins -->
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap.min.js"></script>

<!-- Page level custom scripts -->
<script src="dashboards/js/demo/datatables-demo.js"></script>
     <script>
        // Sample data for charts
        var performanceData = {
            labels: ["Jan", "Feb", "Mar", "Apr", "May"],
            datasets: [{
                label: "Performance",
                data: [3, 4, 5, 6, 7], // Sample performance data
                backgroundColor: "rgba(75, 192, 192, 0.2)",
                borderColor: "rgba(75, 192, 192, 1)",
                borderWidth: 1
            }]
        };

        var incomeData = {
            labels: ["Jan", "Feb", "Mar", "Apr", "May"],
            datasets: [{
                label: "Income",
                data: [200, 235, 265, 300, 313], // Sample income data
                backgroundColor: "rgba(255, 159, 64, 0.2)",
                borderColor: "rgba(255, 159, 64, 1)",
                borderWidth: 1
            }]
        };

        // Initialize Performance Chart
        var performanceCtx = document.getElementById('performanceChart').getContext('2d');
        var performanceChart = new Chart(performanceCtx, {
            type: 'line',
            data: performanceData,
            options: {}
        });

        // Initialize Income Chart
        var incomeCtx = document.getElementById('incomeChart').getContext('2d');
        var incomeChart = new Chart(incomeCtx, {
            type: 'bar',
            data: incomeData,
            options: {}
        });
     </script>

</asp:Content>
