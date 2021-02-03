<%@ Page Title="" Language="C#" MasterPageFile="~/Blank.Master" AutoEventWireup="true" CodeBehind="NoAdmin.aspx.cs" Inherits="CpDashboard.ContentPage.NoAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="BlankContent" runat="server">
    Congratulation!! You are Logged in as <%: Session["Username"] %>
</asp:Content>

