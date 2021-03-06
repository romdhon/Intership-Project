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
    public partial class RegisterPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Register_Click(object sender, EventArgs e)
        {
            CpDashboardContext context = new CpDashboardContext();

            string reg_pass = new Encryptions().EncryptPassword(RegisterPass.Text);
            string reg_repass = new Encryptions().EncryptPassword(RegisterRepass.Text);

            if(reg_pass == reg_repass)
            {
                //singleordefault can only return to var
                var query = context.Users.SingleOrDefault(q => q.UserName == RegisterEm.Text);

                if(query == null)
                {
                    context.Users.Add(InsertUser(RegisterFn.Text, RegisterLn.Text, RegisterEm.Text, reg_repass));
                    context.SaveChanges();

                    query = context.Users.SingleOrDefault(u => u.UserName == RegisterEm.Text);

                    Session["Id"] = query.UserId;
                    Session["Username"] = query.UserName;
                    Session["Password"] = query.Password;
                    Session["Name"] = query.Name;
                    Session["Lastname"] = query.LastName;
                    Session["Position"] = context.Positions.SingleOrDefault(p => p.PositionID == query.PositionID).PositionName;
                    Session["Login"] = "Active";
                    Response.Redirect("~/Default.aspx");
                }
                else
                {
                    LabelEm.Text = "Email already Exist!!";
                }

            }
            else
            {
                LabelPass.Text = "Your password is not match!!";
            }
        }

        private User InsertUser(string fn, string ln, string em, string pass)
        {
            var user = new User
            {
                Name=fn,
                LastName=ln,
                UserName=em,
                Password=pass,
                PositionID=3

            };
            return user;
        }
    }
}