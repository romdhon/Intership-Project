<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SensorList.aspx.cs" Inherits="CpDashboard.SensorList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="JSMain" runat="server">
    
    <script>

        var sensorVal = '<%= sensorValStr %>'.split('~');
        var sensorDt = '<%= sensorDtStr %>'.split('~');

        //var group_id = new URL(window.location.href).searchParams.get('group_id');
        var group_id = '<%= group.GroupID %>';

        function multilineColors(sensorNum, transparent) {
            var lineColors = ["rgba(223, 115, 78, ", "rgba(78, 223, 115, ", "rgba(78, 115, 223, ", "rgba(255, 223, 78, "]
            return lineColors[sensorNum] + transparent + ")";
        }

        //alert(sensorVal.find('SensorName').text())
        var ctx = document.getElementById("myAreaChart" + group_id);
        var myLineChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: sensorDt,
                datasets: [{
                    label: '<%= group.GroupName %>',
                    lineTension: 0.3,
                    backgroundColor: multilineColors(parseInt(group_id) - 1, 0.05),
                    borderColor: multilineColors(parseInt(group_id) - 1, 1),
                    pointRadius: 3,
                    pointBackgroundColor: multilineColors(parseInt(group_id) - 1, 1),
                    pointBorderColor: multilineColors(parseInt(group_id) - 1, 1),
                    pointHoverRadius: 3,
                    pointHoverBackgroundColor: multilineColors(parseInt(group_id) - 1, 1),
                    pointHoverBorderColor: multilineColors(parseInt(group_id) - 1, 1),
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

        //for offline
        //function updateSensorVal() {
        //    var groupid = new URL(window.location.href).searchParams.get('group_id')
        //    $.ajax({
        //        url: 'SensorService.asmx/GetSensorDetail',
        //        data: { groupId: groupid },
        //        method: 'post',
        //        type: 'xml',
        //        success: function (data) {
        //            var datas = $(data);
        //            var value = datas.find('SensorVal').text().split("~")[11];
        //            var dt = datas.find('TimeOperate').text().split("~")[11];
        //            var name = datas.find('SensorName').text();

        //            myLineChart.data.datasets[0].data[12] = value;
        //            myLineChart.data.labels[12] = dt;
        //            myLineChart.data.datasets[0].data.shift();
        //            myLineChart.data.labels.shift();

        //            myLineChart.update();
        //        }
        //    })
        //}

        //for real-time data monitoring
        function updateSensorVal() {
            var sensorUrl = new URL(window.location.href).searchParams.get('group_id');
            var sensorNum = 4;
            $.ajax({
                url: 'SensorService.asmx/GetRealTimeData',
                data: { num: sensorNum },
                method: 'post',
                type: 'xml',
                success: function (data) {
                    var datas = $(data);
                    var status = datas.find('Status').text();
                    var statusOnOff = $('#iOnOff');
                    if (status == "true") {
                        statusOnOff.removeClass('fas fa-toggle-off');
                        statusOnOff.addClass('fas fa-toggle-on');

                        var selectedSensor = datas.find('Sensor' + sensorUrl).text();
                        var selectedDt = datas.find('TimeOperate').text();

                        var datasetInd = parseInt(sensorUrl) - 1;
                        //alert(datasetInd)
                        myLineChart.data.datasets[0].data[12] = selectedSensor;
                        myLineChart.data.labels[12] = selectedDt;
                        myLineChart.data.datasets[0].data.shift();
                        myLineChart.data.labels.shift();

                        myLineChart.update();


                    } else {
                        statusOnOff.remove('fas fa-toggle-on');
                        statusOnOff.AddClass('fas toggle-off');
                    }
                },
                error: function (err) {
                    alert(err);
                }
            });
        }
        

        
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageHeader" runat="server">
     <%--<h1 class="h3 mb-0 text-gray-800">
            Sensor Details
    </h1>--%>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageContent" runat="server">
            <h1 style="display: inline"><%: group.GroupName %></h1>
            <h2 class="text-gray-800" style="display: inline"><i id="iOnOff" class="fas fa-toggle-off"></i></h2>
            
        <form runat="server">
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
                        
                            <asp:ScriptManager ID="listScript" runat="server"></asp:ScriptManager>
                            <asp:Timer ID="listTimer" runat="server" OnTick="listTimer_Tick" Interval="2000">
                            </asp:Timer>
                            <asp:UpdatePanel ID="listPanel" runat="server">
                                <ContentTemplate>
                                    
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="listTimer" EventName="Tick" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <div class="card-body">
                                <div class="chart-area">
                                    <%--<canvas id="myAreaChart"></canvas>--%>
                                    <canvas id="myAreaChart<%: asensor.SensorID %>"></canvas>
                                </div>
                            </div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label>Max Value: </label>
                <%--<input type="number" id="maxValInput" class="form-control" />--%>
                <asp:TextBox runat="server" ID="alertTxt" CssClass="form-control" TextMode="Number" />
            </div>
            <div class="form-group">
                <%--<input value="Submit" type="submit" id="alertSubmit" class="btn btn-success" />--%>
                <asp:Button Text="Submit" id="alertSubmit" runat="server" OnClick="alertSubmit_Click" CssClass="btn btn-success" />
            </div>
        </form>

           
    
</asp:Content>
