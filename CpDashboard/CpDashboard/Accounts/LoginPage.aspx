<%@ Page Language="C#" MasterPageFile="~/Blank.Master" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="CpDashboard.Accounts.LoginPage" %>

<asp:Content ContentPlaceHolderID="BlankJSContent" runat="server">
</asp:Content>

<asp:Content ID="LoginContent" ContentPlaceHolderID="BlankContent" runat="server">
    <body class="bg-gradient-primary">
        <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
                                    </div>
                                    <form class="user" runat="server">
                                        <div class="form-group">
                                            <asp:TextBox TextMode="Email" ID="UserEmail" placeholder="Enter Email Address..." 
                                                runat="server" CssClass="form-control form-control-user"
                                                aria-describedby="emailHelp"/>
                                        </div>
                                        <div class="form-group">

                                            <asp:TextBox TextMode="Password" CssClass="form-control form-control-user"
                                                id="UserPassword" placeholder="Password" runat="server"/>
                                        </div>
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" class="custom-control-input" id="customCheck">
                                                <label class="custom-control-label" for="customCheck">Remember
                                                    Me</label>
                                            </div>
                                        </div>
                                        <asp:Button CssClass="btn btn-primary btn-user btn-block" ID="SubmitLogin" 
                                            OnClick="SubmitLogin_Click" runat="server" Text="Login"/>
                                            
                                        <hr>
                                        <a href="index.html" class="btn btn-google btn-user btn-block">
                                            <i class="fab fa-google fa-fw"></i> Login with Google
                                        </a>
                                        <a href="index.html" class="btn btn-facebook btn-user btn-block">
                                            <i class="fab fa-facebook-f fa-fw"></i> Login with Facebook
                                        </a>
                                    </form>
                                    <hr>
                                    <div class="text-center">
                                        <a class="small" href="/Accounts/ForgotPasswordPage.aspx">Forgot Password?</a>
                                    </div>
                                    <div class="text-center">
                                        <a class="small" href="/Accounts/RegisterPage.aspx">Create an Account!</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>
    </body>
    
</asp:Content>
    
