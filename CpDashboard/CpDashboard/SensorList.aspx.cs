using CpDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CpDashboard
{
    public partial class SensorList : System.Web.UI.Page
    {
        private CpDashboardContext _db = new CpDashboardContext();
        public IQueryable<Sensor> s;
        public Sensor asensor;
        public SensorGroup group;
        protected void Page_Load(object sender, EventArgs e)
        {
            string tid = Request.QueryString["group_id"];
            if (!string.IsNullOrEmpty(tid) && int.TryParse(tid, out int g_id))
            {
                var vals = _db.Sensors.Where(s => s.GroupId == g_id);
                this.s = vals;
                this.asensor = _db.Sensors.SingleOrDefault(s => s.GroupId == g_id);
                this.group = _db.SensorGroups.SingleOrDefault(g => g.GroupID == g_id);
            }
        }

    }
}