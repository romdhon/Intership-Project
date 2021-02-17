<%@ Page Title="" Language="C#" MasterPageFile="~/Blank.Master" AutoEventWireup="true" 
    CodeBehind="ForgotPasswordPage.aspx.cs" Inherits="CpDashboard.Accounts.ForgotPasswordPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="BlankJSContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BlankContent" runat="server">
    <body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-password-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-2">Forgot Your Password?</h1>
                                        <p class="mb-4">We get it, stuff happens. Just enter your email address and
                                            password below and we'll reset your password!</p>
                                    </div>
                                    <form class="user" runat="server">
                                        <div class="form-group">
                                            <asp:TextBox TextMode="Email" CssClass="form-control form-control-user"
                                                ID="forgotEmail" placeholder="Enter Email Address..."
                                                runat="server" />
                                        </div>
                                        <div class="form-group">
                                            <asp:TextBox TextMode="Password" CssClass="form-control form-control-user"
                                                ID="forgotPass" placeholder="Enter Password..."
                                                runat="server" />
                                        </div>
                                        <div class="form-group">
                                            <asp:TextBox TextMode="Password" CssClass="form-control form-control-user"
                                                ID="forgotRepass" placeholder="Reenter Password..."
                                                runat="server" />
                                        </div>
                                        <div class="text-center">
                                            <asp:Button ID="EnterNewPass" Text="Reset Password" CssClass="btn btn-primary btn-user btn-block" 
                                                OnClick="EnterNewPass_Click" runat="server"/>
                                        </div>
                                        <hr>
                                        <div class="text-center">
                                            <a class="small" href="/Accounts/RegisterPage.aspx">Create an Account!</a>
                                        </div>
                                        <div class="text-center">
                                            <a class="small" href="/Accounts/LoginPage.aspx">Already have an account?</a>
                                        </div>
                                    </form>
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
