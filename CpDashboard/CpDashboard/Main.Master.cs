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
    public partial class Main : System.Web.UI.MasterPage
    {
        private CpDashboardContext _db = new CpDashboardContext();
        public List<Sensor> sensors;
        public List<SensorGroup> sensorgroup;
        protected void Page_Load(object sender, EventArgs e)
        {
            //sensors = _db.Sensors.ToList();
            sensorgroup = _db.SensorGroups.ToList();
            //sensortype = _db.SensorTypes.ToList();
        }

        //protected void alertTimer_Tick(object sender, EventArgs e)
        //{
        //    ScriptManager.RegisterStartupScript(this, GetType(), "detectAlert", "detectAlert()", true);
        //}

        //public List<SensorType> GetSensorTypes()
        //{
        //    return _db.SensorTypes.ToList();
        //}

        //public List<SensorGroup> GetSensorGroups()
        //{
        //    var sensorGroup = _db.SensorGroups.ToList();
        //    return sensorGroup;
        //}
    }
}