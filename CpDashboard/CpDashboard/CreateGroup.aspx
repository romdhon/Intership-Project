<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CreateGroup.aspx.cs" Inherits="CpDashboard.CreateGroup" %>
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
                                <h1 class="h4 text-gray-900 mb-4">Create a new GROUP</h1>
                            </div>
                            <form class="user" runat="server">
                                <div class="form-group row">
                                        <asp:TextBox CssClass="form-control" id="groupName"
                                            placeholder="Group Name" runat="server"/>
                                        
                                </div>
                                <div class="form-group row">
                                    <asp:TextBox TextMode="MultiLine" CssClass="form-control" id="groupDes"
                                            placeholder="Group Description" runat="server"/>
                                </div>
                                <p><asp:Label runat="server" ID="existGroup"></asp:Label></p>
                                
                                <p><asp:Label runat="server" ID="LabelPass"></asp:Label></p>
                                <asp:Button Text="Add Group" ID="Group" OnClick="Group_Click" class="btn btn-primary btn-user btn-block" runat="server"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
