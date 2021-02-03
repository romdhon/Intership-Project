<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="AdminSetting.aspx.cs" Inherits="CpDashboard.ContentPage.AdminSetting" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageHeader" runat="server">
    Admin Page
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageContent" runat="server">
    <form class="user" runat="server">
        <label>Account Name: </label>
        <asp:Label ID="u_e" runat="server" Text=""></asp:Label>
        <div class="form-group row">
            <div class="col-sm-6">
                <asp:DropDownList ID="user_email" runat="server" CssClass="form-control">
                </asp:DropDownList>
            </div>
        </div>
        
        <label>User Type: </label>
        <asp:Label ID="u_p" runat="server" Text=""></asp:Label>
        <div class="form-group row">
            <div class="col-sm-6">
                <asp:DropDownList ID="user_position" runat="server" CssClass="form-control">
                </asp:DropDownList>
            </div>
        </div>

        <div class="form-group row">
            <div class="col-sm-2">
                <asp:Button ID="AdminSubmit" CssClass="btn btn-primary btn-user btn-block" OnClick="AdminSubmit_Click"
                    runat="server" Text="Submit" />
            </div>
        </div>
            
    </form>
</asp:Content>

