<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CpDashboard._Default" %>


<asp:Content ID="DefaultJS" ContentPlaceHolderID="JSMain" runat="server">
    <script language="javascript" type="text/javascript">

        function GetStr() {
            var valStr = '/******************/';
            var valArr = valStr.split(',');
            alert(valArr);
        }

        function getCurrentSec() {
            $('#chartLabel').text(new Date().getSeconds())
        }

        function getAllData() {
            $.ajax({
                url: 'SensorService.asmx/GetAllSensors',
                method: 'post',
                dataType: 'xml',
                success: function (data) {
                    //get sensor val
                    var valStr = '<%= thermoValStr1 %>';
                    var valArr = valStr.split(',');
                    //alert(valArr);
                    //get sensor date
                    var dtStr = '<%= dtStr1 %>';
                    var dtArr = dtStr.split(',');


                    var datas = $(data);
                    //get sensor's name
                    var sensorNames = datas.find('SensorNames').text().split("~");
                    //alert(sensorNames);
                    //get arrays of sensors with '~'
                    var sensorArrays = datas.find('SensorValArr').text().split('<');
                    var sensorValues = []

                    //get arrays of dt with '~'
                    var dtArrays = datas.find('TimeOperateArr').text().split('<');
                    var dtValues = [];

                    //getting sensorvals
                    function getSensorVal(value) {
                        sensorValues.push(value.split('~'));
                    }

                    //getting sensor date
                    function getSensorDate(dt) {
                        dtValues.push(dt.split('~'))
                    }

                    //retrieving both dt and values
                    dtArrays.forEach(getSensorDate);
                    sensorArrays.forEach(getSensorVal);

                    //array for lines
                    var lines = [];

                    function multilineColors(sensorNum, transparent) {
                        var lineColors = ["rgba(223, 115, 78, ", "rgba(78, 223, 115, ", "rgba(78, 115, 223, ", "rgba(255, 223, 78, "]
                        return lineColors[sensorNum] + transparent + ")";
                    }

                    //create a function for creating multiple lines
                    var sensorNumCount = 0;
                    function multiLine(values) {
                        lines.push({
                            label: sensorNames[sensorNumCount],
                            lineTension: 0.3,
                            backgroundColor: multilineColors(sensorNumCount, 0),
                            borderColor: multilineColors(sensorNumCount, 1),
                            pointRadius: 3,
                            pointBackgroundColor: multilineColors(sensorNumCount, 1),
                            pointBorderColor: multilineColors(sensorNumCount, 1),
                            pointHoverRadius: 3,
                            pointHoverBackgroundColor: multilineColors(sensorNumCount, 1),
                            pointHoverBorderColor: multilineColors(sensorNumCount, 1),
                            pointHitRadius: 10,
                            pointBorderWidth: 2,
                            data: values,
                        });
                        if (sensorNumCount < 3) {
                            sensorNumCount++;
                        }
                    }
                    sensorValues.forEach(multiLine);
                    //alert(sensorNumCount);
                    var ctx = document.getElementById("myAreaChart");
                    var chartData = {
                        labels: dtValues[0],
                        datasets: lines,
                    }

                    var options = {
                        type: 'line',
                        data: chartData,
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
                                display: true
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
                    }
                    //var onOffBtn = $('#onOff');
                    //alert(onOffBtn.val())
                    //onOffBtn.click(function () {
                    //    if (onOffBtn.val() == "OFFLINE") {
                    //        onOffBtn.val("ONLINE");
                    //        onOffBtn.toggleClass('btn btn-primary ')
                    //    } else {
                    //        onOffBtn.val("OFFLINE");
                    //    }
                    //})

                    var myLineChart = new Chart(ctx, options);
                    //var myLineChart = new Chart(ctx);
                    //myLineChart.Line(chartData, options);

                    //$('#addButton').click(function () {
                    //    myLineChart.data.datasets[0].data[12] = 30;
                    //    myLineChart.data.labels[12] = "Now";
                    //    myLineChart.update();
                    //});
                    //var adder = 20;
                    //var add = 0;
                    //setInterval(function () {
                    //    //add new data
                    //    var dataCount = myLineChart.data.datasets[0].data.length;

                    //    var lastVal = datas.find('LastVal').text().split('~');
                    //    var lastDt = datas.find('LastDt').text().split('~');
                    //    //alert(lastVal[0]);
                    //    //var dataCount = chart.data.datasets[i].data.length;
                    //    for (var i = 0; i < 4; i++) {
                    //        //adding new datas
                    //        myLineChart.data.datasets[i].data[dataCount+add] = lastVal[i];

                    //        //removing last first data
                    //        //myLineChart.data.datasets[i].data.shift();
                    //    }
                    //    //myLineChart.data.labels.shift();
                    //    myLineChart.data.labels[dataCount + add] = lastDt;
                    //    //myLineChart.data.datasets[0].data[12 + add] = adder;
                    //    //myLineChart.data.labels[12 + add] = adder;
                    //    //remove first data

                    //    myLineChart.update();
                    //    adder++;
                    //    add++;
                    //}, 2000)



                },
                error: function (err) {
                    alert(err);
                }
            })
        }
        

    </script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="PageHeader" runat="server">
    <span class="text">Dashboard</span>
    <%--<form runat="server">
        <asp:ScriptManager runat="server" ID="script1"></asp:ScriptManager>
    <asp:Timer ID="timer1" OnTick="timer1_Tick" runat="server" Interval="2000">
    </asp:Timer>
    <asp:UpdatePanel runat="server" ID="updatePanel">
        <ContentTemplate>
            <asp:Label runat="server" ID="label1"></asp:Label>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="timer1" EventName="Tick" />
        </Triggers>
    </asp:UpdatePanel>
    </form>--%>
    
    <%--<input type="button" id="onOff" class="btn btn-success" value="OFFLINE"/>--%>
</asp:Content>

<asp:Content ID="ChartContent" ContentPlaceHolderID="PageContent" runat="server">
    <%--<input type="button" id="addButton" value="Press"/>--%>
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
                <form runat="server">
                    <asp:ScriptManager ID="chartScript" runat="server"></asp:ScriptManager>
                    <asp:Timer ID="chartTimer" OnTick="chartTimer_Tick" runat="server" Interval="2000"></asp:Timer>
                    <asp:UpdatePanel ID="chartUpdatePanel" runat="server">
                        <ContentTemplate>
                            <label id="chartLabel"></label>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="chartTimer" EventName="Tick" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <div class="card-body">
                        <div class="chart-area">
                            <canvas id="myAreaChart"></canvas>
                        </div>
                    </div>
                </form>
                
            </div>
        </div>
    </div>
</asp:Content>
