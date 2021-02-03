<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="AddSensor.aspx.cs" Inherits="CpDashboard.AddSensor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainCssContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageHeader" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageContent" runat="server">
    <div class="container">
        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <%--<div class="col-lg-5 d-none d-lg-block bg-register-image"></div>--%>
                    <div class="col-lg-12">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Add New Sensor</h1>
                            </div>
                            <form class="user" runat="server">
                                <div class="form-group row">
                                    <a href="/CreateGroup.aspx" style="text-decoration:none; color:gray">
                                        <i class="fas fa-fw fa-plus-circle"></i>
                            
                                        <span>Group: </span>
                                    </a>

                                    <asp:DropDownList runat="server" ID="sensorGroup" CssClass="form-control">
                                    </asp:DropDownList>

                                </div>
                                <div class="form-group row">

                                    <a href="#" style="text-decoration:none; color:gray">
                                        <i class="fas fa-fw fa-plus-circle"></i>
                                        <span>Type: </span>
                                    </a>

                                    <asp:DropDownList runat="server" ID="sensorType" class="form-control">
                                    </asp:DropDownList>

                                </div>

                                <div class="form-group row">
                                    <label>
                                        <i class="fas fa-fw fa-plus-circle"></i>
                                        <span>Sensor Name:</span>
                                    </label>
                                    <asp:TextBox ID="sensorTb" placeholder="Enter Sensor's name" runat="server" 
                                        CssClass="form-control"/>
                                </div>
                                <p><asp:Label runat="server" ID="existGroup"></asp:Label></p>
                                
                                <p><asp:Label runat="server" ID="LabelPass"></asp:Label></p>
                                <asp:Button Text="Add Sensor" ID="Add" OnClick="Add_Click" class="btn btn-primary btn-user btn-block" runat="server"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
