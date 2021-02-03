<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ProfileEdit.aspx.cs" Inherits="CpDashboard.ProfileEdit" %>
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
                                <h1 class="h4 text-gray-900 mb-4">Edit an Account!</h1>
                            </div>
                            <form class="user" runat="server">
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <asp:TextBox CssClass="form-control form-control-user" id="EditFn"
                                            placeholder="First Name" runat="server"/>
                                    </div>
                                    <div class="col-sm-6">
                                        <asp:TextBox CssClass="form-control form-control-user" id="EditLn"
                                            placeholder="Last Name" runat="server"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:TextBox TextMode="Email" class="form-control form-control-user" id="EditEm"
                                        placeholder="Email Address" runat="server"/>
                                </div>
                                <p><asp:Label runat="server" ID="LabelEm"></asp:Label></p>
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <asp:TextBox class="form-control form-control-user"
                                            id="EditPass" placeholder="Password" runat="server"/>
                                    </div>
                                    <div class="col-sm-6">
                                        <asp:TextBox class="form-control form-control-user"
                                            id="EditRepass" placeholder="Repeat Password" runat="server"/>
                                    </div>
                                </div>
                                <p><asp:Label runat="server" ID="LabelPass"></asp:Label></p>
                                <asp:Button Text="Edit Account" ID="Edit" OnClick="Edit_Click" class="btn btn-primary btn-user btn-block" runat="server"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
