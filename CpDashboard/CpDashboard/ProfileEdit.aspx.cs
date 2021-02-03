using CpDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CpDashboard
{
    public partial class ProfileEdit : System.Web.UI.Page
    {
        private CpDashboardContext _db = new CpDashboardContext();
        int eid;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                EditUser();
            }
        }

        protected void Edit_Click(object sender, EventArgs e)
        {
            string edit_id = Request.QueryString["edit_id"];

            if (!string.IsNullOrEmpty(edit_id) && int.TryParse(edit_id, out eid))
            {
                var user = _db.Users.SingleOrDefault(u => u.UserId == eid);

                user.Name = EditFn.Text;
                user.LastName = EditLn.Text;
                user.UserName = EditEm.Text;
                user.Password = EditPass.Text;
                user.Password = EditRepass.Text;

                Session["Username"] = EditEm.Text;
                Session["Password"] = EditPass.Text;
                Session["Name"] = EditFn.Text;
                Session["Lastname"] = EditLn.Text;

                _db.SaveChanges();
            }
        }

        private void EditUser()
        {
            string edit_id = Request.QueryString["edit_id"];

            if (!string.IsNullOrEmpty(edit_id) && int.TryParse(edit_id, out eid))
            {
                var user = _db.Users.SingleOrDefault(u => u.UserId == eid);

                EditFn.Text = user.Name;
                EditLn.Text = user.LastName;
                EditEm.Text = user.UserName;
                EditPass.Text = user.Password;
                EditRepass.Text = user.Password;

            }
        }
    }
}