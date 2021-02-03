﻿using CpDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CpDashboard.Accounts
{
    public partial class LoginPage : System.Web.UI.Page
    {
        private CpDashboardContext _db = new CpDashboardContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();
            Session["Login"] = "Offline";
        }

        protected void SubmitLogin_Click(object sender, EventArgs e)
        {
            var new_user = _db.Users.SingleOrDefault(u => u.UserName == UserEmail.Text
                                                      && u.Password == UserPassword.Text);
            if(new_user != null)
            {
                Session["Id"] = new_user.UserId;
                Session["Username"] = new_user.UserName;
                Session["Password"] = new_user.Password;
                Session["Name"] = new_user.Name;
                Session["Lastname"] = new_user.LastName;
                Session["Position"] = _db.Positions.SingleOrDefault(p => p.PositionID == new_user.PositionID).PositionName;
                Session["Login"] = "Active";
                Page.Response.Redirect("~/Default.aspx");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "LoginFail", "LoginFail()", true);
            }

        }
    }
}