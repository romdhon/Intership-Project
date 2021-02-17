<%@ Page Title="" Language="C#" MasterPageFile="~/Blank.Master" AutoEventWireup="true" CodeBehind="RegisterPage.aspx.cs" Inherits="CpDashboard.Accounts.RegisterPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="BlankJSContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BlankContent" runat="server">
    <body class="bg-gradient-primary">
    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
                            </div>
                            <form class="user" runat="server">
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <asp:TextBox CssClass="form-control form-control-user" id="RegisterFn"
                                            placeholder="First Name" runat="server"/>
                                    </div>
                                    <div class="col-sm-6">
                                        <asp:TextBox CssClass="form-control form-control-user" id="RegisterLn"
                                            placeholder="Last Name" runat="server"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:TextBox TextMode="Email" class="form-control form-control-user" id="RegisterEm"
                                        placeholder="Email Address" runat="server"/>
                                </div>
                                <p><asp:Label runat="server" ID="LabelEm"></asp:Label></p>
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <asp:TextBox TextMode="Password" class="form-control form-control-user"
                                            id="RegisterPass" placeholder="Password" runat="server"/>
                                    </div>
                                    <div class="col-sm-6">
                                        <asp:TextBox TextMode="Password" class="form-control form-control-user"
                                            id="RegisterRepass" placeholder="Repeat Password" runat="server"/>
                                    </div>
                                </div>
                                <p><asp:Label runat="server" ID="LabelPass"></asp:Label></p>
                                <asp:Button Text="Register Account" ID="Register" OnClick="Register_Click" class="btn btn-primary btn-user btn-block" runat="server"/>
                                <hr>
                                <a href="index.html" class="btn btn-google btn-user btn-block">
                                    <i class="fab fa-google fa-fw"></i> Register with Google
                                </a>
                                <a href="index.html" class="btn btn-facebook btn-user btn-block">
                                    <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook
                                </a>
                            </form>
                            <hr>
                            <div class="text-center">
                                <a class="small" href="/Accounts/ForgotPasswordPage.aspx">Forgot Password?</a>
                            </div>
                            <div class="text-center">
                                <a class="small" href="/Accounts/LoginPage.aspx">Already have an account? Login!</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    </body>
</asp:Content>
