<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="AlertReport.aspx.cs" Inherits="CpDashboard.AlertReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainCssContent" runat="server">

    <%--<script src="Scripts/jquery-3.4.1.min.js"></script>--%>
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">
    <script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function () {
            //in json object using dataType instead!
            $.ajax({
                url: 'SensorService.asmx/getAlertJSValue',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    $('#table_id').dataTable({
                        data: data,
                        columns: [
                            { 'data': 'AlertID' },
                            { 'data': 'SensorName' },
                            { 'data': 'AlertThresholdVal' },
                            { 'data': 'AlertVal' },
                            { 'data': 'AlertDateTime' },
                        ]
                    })
                },
                error: function (err) {
                    alert("Error");
                }

            })
        })
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageContent" runat="server">
    <form runat="server">
        <table id="table_id" class="display">
            <thead>
                <tr>
                    <th>Alert ID</th>
                    <th>Sensor Name</th>
                    <th>Threshold Value</th>
                    <th>Alert Value</th>
                    <th>Time Operate</th>
                </tr>
            </thead>
        </table>
    </form>
</asp:Content>
