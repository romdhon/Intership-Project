<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CpDashboard._Default" %>


<asp:Content ID="DefaultJS" ContentPlaceHolderID="JSMain" runat="server">
    <script src="js/AlertFunc.js"></script>
    <script language="javascript" type="text/javascript">
            
        var lines = [];

        function multilineColors(sensorNum, transparent) {
            var lineColors = ["rgba(223, 115, 78, ", "rgba(78, 223, 115, ", "rgba(78, 115, 223, ", "rgba(255, 223, 78, "]
            return lineColors[sensorNum] + transparent + ")";
        }
        //sensor value
        var valStr1 = '<%= thermoValStr1 %>';
        var valAr1 = valStr1.split(',');

        var valStr2 = '<%= thermoValStr2 %>';
        var valAr2 = valStr2.split(',');

        var valStr3 = '<%= thermoValStr3 %>';
        var valAr3 = valStr3.split(',');

        var valStr4 = '<%= thermoValStr4 %>';
        var valAr4 = valStr4.split(',');

        //sensor time
        var dtStr = '<%= dtStr1 %>';
        var dtArr = dtStr.split(',');

        var sensorValues = [valAr1, valAr2, valAr3, valAr4]

        //create a function for creating multiple lines
        var sensorNumCount = 0;
        function multiLine(values) {
            lines.push({
                label: "Thermocouple" + (sensorNumCount+1),
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
            labels: dtArr,
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

        

        var myLineChart = new Chart(ctx, options);
        var adder = 0;

        //using data from database uncomment this
        //function getAllData() {
        //    $.ajax({
        //        url: 'SensorService.asmx/GetAllSensors',
        //        type: 'xml',
        //        method: 'post',
        //        success: function (data) {
        //            var datas = $(data);
        //            var eachSensorVal = datas.find('LastVal').text().split('~');
        //            var eachDtVal = datas.find('LastDt').text().split('~');
        //            var dataCount = 12;
        //            for (var ind = 0; ind < eachSensorVal.length; ind++) {
        //                myLineChart.data.datasets[ind].data[dataCount] = eachSensorVal[ind];
        //                myLineChart.data.datasets[ind].data.shift();
        //            }

        //            myLineChart.data.labels[dataCount] = eachDtVal[0];
        //            myLineChart.data.labels.shift();
        //            //alert(myLineChart.data.labels);
        //            myLineChart.update();
        //            adder++;
        //        },
        //        error: function (err) {
        //            alert(err);
        //        }
        //    })
        //}

        //using real-time data uncomment this
        function getAllData() {
            $.ajax({
                url: 'SensorService.asmx/GetRealTimeData',
                data: { 'num': 4 },
                method: 'post',
                type: 'xml',
                success: function (data) {
                    //alert("success")
                    var datas = $(data);
                    var count = 12;
                    var status = datas.find('Status').text();
                    var onOffStatus = $('#onOffIcon');

                    if (status == "true") {
                        onOffStatus.removeClass('fas fa-toggle-off');
                        onOffStatus.addClass('fas fa-toggle-on');

                        for (var i = 0; i < 4; i++) {
                            myLineChart.data.datasets[i].data[count] = datas.find('Sensor' + (i + 1)).text();
                            myLineChart.data.datasets[i].data.shift();
                        }
                        myLineChart.data.labels[count] = datas.find('TimeOperate').text()
                        myLineChart.data.labels.shift();
                        myLineChart.update();
                    } else {
                        onOffStatus.removeClass('fas fa-toggle-on');
                        onOffStatus.addClass('fas fa-toggle-off');
                    }
                },
                error: function (err) {
                    alert("error")
                }
            })
        }

    </script>
</asp:Content>

<asp:Content ID="Body" ContentPlaceHolderID="PageHeader" runat="server">
    <h1 class="h3 mb-0 text-gray-800">
        <span class="text">Dashboard</span>
        <span><i id="onOffIcon" class="fas fa-toggle-off"></i></span>
    </h1>
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
