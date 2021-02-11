using CpDashboard.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Timers;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CpDashboard
{
    public partial class SensorList : System.Web.UI.Page
    {
        private System.Timers.Timer timer;
        private CpDashboardContext _db = new CpDashboardContext();
        public Sensor asensor;
        public SensorGroup group;
        public string groupId;

        public string sensorValStr;
        public List<String> sensorValList = new List<string>();
        protected void Page_Load(object sender, EventArgs e)
        {
            string tid = Request.QueryString["group_id"];
            groupId = tid;
            if (!string.IsNullOrEmpty(tid) && int.TryParse(tid, out int g_id))
            {
                this.asensor = _db.Sensors.Where(a => a.GroupId == g_id).First();
                this.group = _db.SensorGroups.SingleOrDefault(g => g.GroupID == g_id);

                var allSensorVal = _db.Sensors.Where(s => s.GroupId == g_id);

                // loop through all sensors and add into a list
                foreach (var sensor in allSensorVal)
                {
                    sensorValList.Add(sensor.SensorVal.ToString());
                }

                this.sensorValStr = "";
                //put the last five value into string
                for (int s = sensorValList.Count - 12; s < sensorValList.Count; s++)
                {
                    this.sensorValStr += sensorValList[s].ToString() + ", ";
                }

                //Session["SensorVal"] = "";

                //setTimer();
                //timer.Start();

                //Response.Write(this.sensorValStr.ToString());

                //refresh the page every 2 sec
                //Response.AppendHeader("Refresh", "2");
            }
        }

        private List<string> getSensorVal()
        {
            if (int.TryParse(groupId, out int g_id))
            {
                var allSensorVal = _db.Sensors.Where(s => s.GroupId == g_id);

                // loop through all sensors and add into a list
                foreach (var sensor in allSensorVal)
                {
                    sensorValList.Add(sensor.SensorVal.ToString());
                }

                this.sensorValStr = "";
                //put the last five value into string
                for (int s = sensorValList.Count - 12; s < sensorValList.Count; s++)
                {
                    this.sensorValStr += sensorValList[s].ToString() + ", ";
                    
                }
                //Debug.WriteLine(this.sensorValStr.ToString());
            }
            return sensorValList;
        }

    }

}