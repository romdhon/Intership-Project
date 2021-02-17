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

            if (!string.IsNullOrEmpty(forgotEmail.Text) && forgotPass.Text == forgotRepass.Text)
            {
                var new_user = user.Where(u => u.UserName == forgotEmail.Text).First();
                AddUser(ref new_user);
                _db.SaveChanges();
                new_user = _db.Users.SingleOrDefault(u => u.UserName == forgotEmail.Text
                                                      && u.Password == forgotPass.Text);
                Session["Id"] = new_user.UserId;
                Session["Username"] = new_user.UserName;
                Session["Password"] = new_user.Password;
                Session["Name"] = new_user.Name;
                Session["Lastname"] = new_user.LastName;
                Session["Position"] = _db.Positions.SingleOrDefault(p => p.PositionID == new_user.PositionID).PositionName;
                Session["Login"] = "Active";
                Response.Redirect("/Default.aspx");
            }
        }

        private void AddUser(ref User auser)
        {
            auser.Password = forgotRepass.Text;
        }
    }
}