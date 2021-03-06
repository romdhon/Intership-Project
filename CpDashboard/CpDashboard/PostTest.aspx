<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PostTest.aspx.cs" Inherits="CpDashboard.PostTest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <script src="Scripts/XmlToJson.js"></script>
    <script>
        $(document).ready(function () {
            datas = {
                value: "21",
                sensorname: "",
                g_id: 1
            };


            $.ajax({
                url: 'SensorService.asmx/GetAlertValue',
                data: {id: 1},
                type: 'xml',
                method: 'POST',
                success: function (value) {
                    var sensor_name = $(value).find("SensorName").text();
                    var thresh_val = $(value).find("Value").text();
                    $.ajax({
                        url: 'SensorService.asmx/PostAlert',
                        data: {
                            sensorname: sensor_name,
                            threshval: thresh_val,
                            alertval: "31",
                            dt: "12:00:00"
                        },
                        method: 'POST',
                        type: 'xml',
                        success: function (succ) {
                            alert("success")
                        },
                        error: function (err) {
                            alert("error");
                        }

                    });
                },
                error: function (err) {
                    alert("Error");
                }
            })
        })
    </script>
</head>
<body>
    <div class="container">
        <form id="formTest">
            <div class="form-group">
                <label class="text-info">Alert Value</label>
                <input id="alertValue" class="form-control" />
            </div>
            <div class="form-group">
                <label class="text-info">Sensor Name</label>
                <input id="sensorName" class="form-control" />
            </div>
            <div class="form-group">
                <label class="text-info">Group ID</label>
                <input id="groupId" class="form-control" />
            </div>
        </form>
    </div>
    
</body>
</html>
