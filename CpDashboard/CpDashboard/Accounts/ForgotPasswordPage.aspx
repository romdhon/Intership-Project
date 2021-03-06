<%@ Page Title="" Language="C#" MasterPageFile="~/Blank.Master" AutoEventWireup="true" 
    CodeBehind="ForgotPasswordPage.aspx.cs" Inherits="CpDashboard.Accounts.ForgotPasswordPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="BlankJSContent" runat="server">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="/img/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/css/util.css">
	<link rel="stylesheet" type="text/css" href="/css/main.css">
<!--===============================================================================================-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BlankContent" runat="server">
    <div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-pic js-tilt" data-tilt>
					<img src="/img/icons/img-01.png" alt="IMG">
				</div>

				<form class="login100-form validate-form" runat="server">
					<span class="login100-form-title">
						Create New Password
					</span>

					<div class="wrap-input100 validate-input" data-validate = "Valid email is required: ex@abc.xyz">
						<%--<input class="input100" type="text" name="email" placeholder="Email">--%>
						<asp:TextBox TextMode="Email" CssClass="input100"
							ID="forgotEmail" placeholder="Enter Email Address..." runat="server" />
						<span class="focus-input100"></span>

						<span class="symbol-input100">
							<i class="fa fa-envelope" aria-hidden="true"></i>
						</span>
					</div>

					<div class="wrap-input100 validate-input" data-validate = "Password is required">
						<%--<input class="input100" type="password" name="pass" placeholder="Password">--%>
						<asp:TextBox TextMode="Password" CssClass="input100"
							ID="forgotPass" placeholder="Enter New Password..." runat="server" />
						
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="fa fa-lock" aria-hidden="true"></i>
						</span>
					</div>
					<%--<asp:TextBox TextMode="Password" CssClass="input100"
							ID="TextBox1" placeholder="Enter Password..." runat="server" />--%>
					<div class="wrap-input100 validate-input" data-validate = "Password is required">
						<%--<input class="input100" type="password" name="pass" placeholder="Password">--%>
						<asp:TextBox TextMode="Password" CssClass="input100"
							ID="forgotRepass" placeholder="Reenter Password..." runat="server" />
						<asp:Label runat="server" ID="forgotRepasstxt" style="color:red;"></asp:Label>
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="fa fa-lock" aria-hidden="true"></i>
						</span>
					</div>
					
					<div class="container-login100-form-btn">
						<%--<button class="login100-form-btn">
							Login
						</button>--%>
						<asp:Button ID="EnterNewPass" Text="Reset Password" CssClass="login100-form-btn" 
                                                OnClick="EnterNewPass_Click" runat="server"/>
					</div>

					<%--<div class="text-center p-t-12">
						<span class="txt1">
							Forgot
						</span>
						<a class="txt2" href="#">
							Username / Password?
						</a>
					</div>--%>

					<div class="text-center p-t-116">
						<a class="txt2" href="/Accounts/RegisterPage.aspx">
							Create your Account
							<i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>

<!--===============================================================================================-->	
	<script src="/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="/vendor/bootstrap/js/popper.js"></script>
	<script src="/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="/vendor/tilt/tilt.jquery.min.js"></script>
	<script >
		$('.js-tilt').tilt({
			scale: 1.1
		})
    </script>
<!--===============================================================================================-->
	<script src="/js/main.js"></script>
</asp:Content>
