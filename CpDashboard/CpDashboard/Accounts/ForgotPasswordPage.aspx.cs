using CpDashboard.Logics;
using CpDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CpDashboard.Accounts
{
    public partial class ForgotPasswordPage : System.Web.UI.Page
    {
        private CpDashboardContext _db = new CpDashboardContext();
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        // The id parameter should match the DataKeyNames value set on the control
        // or be decorated with a value provider attribute, e.g. [QueryString]int id

        protected void EnterNewPass_Click(object sender, EventArgs e)
        {
            IQueryable<User> user = _db.Users;
            var new_user = user.SingleOrDefault(u => u.UserName == forgotEmail.Text);

            if (!string.IsNullOrEmpty(forgotEmail.Text) && new_user != null)
            {
                string pass = new Encryptions().EncryptPassword(forgotPass.Text);
                string repass = new Encryptions().EncryptPassword(forgotRepass.Text);
                if (pass == repass)
                {
                    AddUser(ref new_user, ref repass);
                    _db.SaveChanges();
                    new_user = _db.Users.SingleOrDefault(u => u.UserName == forgotEmail.Text
                                                      && u.Password == repass);
                    Session["Id"] = new_user.UserId;
                    Session["Username"] = new_user.UserName;
                    Session["Password"] = new_user.Password;
                    Session["Name"] = new_user.Name;
                    Session["Lastname"] = new_user.LastName;
                    Session["Position"] = _db.Positions.SingleOrDefault(p => p.PositionID == new_user.PositionID).PositionName;
                    Session["Login"] = "Active";
                    Response.Redirect("/Default.aspx");
                }
                else
                {
                    forgotRepasstxt.Text = "Password does not match!";
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "emailNotExist", "emailNotExist()", true);
            }
        }

        private void AddUser(ref User auser, ref string new_pass)
        {
            auser.Password = new_pass;
        }
    }
}