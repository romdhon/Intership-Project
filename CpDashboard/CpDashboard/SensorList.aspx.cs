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
        protected void Page_Load(object sender, EventArgs e)
        {
            string tid = Request.QueryString["type_id"];
            if(!string.IsNullOrEmpty(tid) && int.TryParse(tid, out int t_id))
            {
                var vals = _db.Sensors.Where(s => s.TypeId == t_id);
                this.s = vals;
            }
        }

        public IQueryable<CpDashboard.Models.Sensor> GetSensors([QueryString("type_id")] int? typeid)
        {
            IQueryable<Sensor> sensor = _db.Sensors;

            if(typeid.HasValue && typeid > 0)
            {
                sensor = sensor.Where(s => s.TypeId == typeid);
            }
            return sensor;
        }
    }
}