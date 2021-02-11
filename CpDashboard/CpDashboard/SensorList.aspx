<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SensorList.aspx.cs" Inherits="CpDashboard.SensorList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="JSMain" runat="server">
    
    <script>
        $(document).ready(function () {
            var group_id = new URL(window.location.href).searchParams.get('group_id');
            //alert(group_id);
            $.ajax({
                url: 'SensorService.asmx/GetSensorDetail',
                data: { groupId: group_id },
                method: 'post',
                dataType: 'xml',
                success: function (data) {
                    var datas = $(data);
                    var sensorName = datas.find('SensorName').text();
                    var sensorVal = datas.find('SensorVal').text().split('~');
                    var sensorDt = datas.find('TimeOperate').text().split('~');
                    //alert(sensorDt);

                    //alert(sensorVal.find('SensorName').text())
                    var ctx = document.getElementById("myAreaChart" + group_id);
                    var myLineChart = new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: sensorDt,
                            datasets: [{
                                label: sensorName,
                                lineTension: 0.3,
                                backgroundColor: "rgba(78, 115, 223, 0.05)",
                                borderColor: "rgba(78, 115, 223, 1)",
                                pointRadius: 3,
                                pointBackgroundColor: "rgba(78, 115, 223, 1)",
                                pointBorderColor: "rgba(78, 115, 223, 1)",
                                pointHoverRadius: 3,
                                pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
                                pointHoverBorderColor: "rgba(78, 115, 223, 1)",
                                pointHitRadius: 10,
                                pointBorderWidth: 2,
                                data: sensorVal,
                            },],
                        },
                        options: {
                            maintainAspectRatio: false,
                            layout: {
                                padding: {
                                    left: 10,
                                    right: 25,
                                    top: 25,
                                    bottom: 0
                                }
                            },
                            scales: {
                                xAxes: [{
                                    time: {
                                        unit: 'date'
                                    },
                                    gridLines: {
                                        display: false,
                                        drawBorder: false
                                    },
                                    ticks: {
                                        maxTicksLimit: 7
                                    }
                                }],
                                yAxes: [{
                                    ticks: {
                                        maxTicksLimit: 5,
                                        padding: 10,
                                        // Include a dollar sign in the ticks
                                        callback: function (value, index, values) {
                                            return number_format(value) + ' C';
                                        }
                                    },
                                    gridLines: {
                                        color: "rgb(234, 236, 244)",
                                        zeroLineColor: "rgb(234, 236, 244)",
                                        drawBorder: false,
                                        borderDash: [2],
                                        zeroLineBorderDash: [2]
                                    }
                                }],
                            },
                            legend: {
                                display: false
                            },
                            tooltips: {
                                backgroundColor: "rgb(255,255,255)",
                                bodyFontColor: "#858796",
                                titleMarginBottom: 10,
                                titleFontColor: '#6e707e',
                                titleFontSize: 14,
                                borderColor: '#dddfeb',
                                borderWidth: 1,
                                xPadding: 15,
                                yPadding: 15,
                                displayColors: false,
                                intersect: false,
                                mode: 'index',
                                caretPadding: 10,
                                callbacks: {
                                    label: function (tooltipItem, chart) {
                                        var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
                                        return datasetLabel + ': ' + number_format(tooltipItem.yLabel) + ' C';
                                    }
                                }
                            }
                        }
                    });
                },
                error: function (err) {
                    alert(err);
                }
            })
        })
        
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageHeader" runat="server">
    Sensor Details
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageContent" runat="server">
            <h1 id="senText"></h1>
            <h1><%: group.GroupName %></h1>
            <div class="row">
                <!-- Area Chart -->
                <div class="col-xl-12 col-lg-7">
                    <div class="card shadow mb-4">
                        <!-- Card Header - Dropdown -->
                        <div
                            class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold text-primary">Earnings Overview</h6>
                            <div class="dropdown no-arrow">
                                <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                    aria-labelledby="dropdownMenuLink">
                                    <div class="dropdown-header">Dropdown Header:</div>
                                    <a class="dropdown-item" href="#">Action</a>
                                    <a class="dropdown-item" href="#">Another action</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="#">Something else here</a>
                                </div>
                            </div>
                        </div>
                        <!-- Card Body -->
                        <div class="card-body">
                            <div class="chart-area">
                                <%--<canvas id="myAreaChart"></canvas>--%>
                                <canvas id="myAreaChart<%: asensor.SensorID %>"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

           
    
</asp:Content>
