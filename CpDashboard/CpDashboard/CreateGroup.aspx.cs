using CpDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CpDashboard
{
    public partial class CreateGroup : System.Web.UI.Page
    {
        private CpDashboardContext _db = new CpDashboardContext();

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Group_Click(object sender, EventArgs e)
        {
            _db.SensorGroups.Add(GetGroup(groupName.Text, groupDes.Text));
            _db.SaveChanges();
            Response.Redirect("/AddSensor.aspx");
        }

        private SensorGroup GetGroup(string name, string descr)
        {
            return new SensorGroup {
                GroupName = name,
                GroupDescription = descr
            };
        }

    }
}