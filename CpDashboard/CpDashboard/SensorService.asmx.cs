using CpDashboard.Logics;
using CpDashboard.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Http;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CpDashboard
{
    /// <summary>
    /// Summary description for SensorService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class SensorService : System.Web.Services.WebService
    {
        private CpDashboardContext _db = new CpDashboardContext();

        [WebMethod]
        public ServiceGroup GetSensorVal(string groupId)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CpDashboard"].ConnectionString);
            con.Open();

            //string qStr = "SELECT * FROM SensorGroups WHERE GroupID=@g_id";

            SqlCommand sqlcmd = new SqlCommand("spGetSensorValStr", con);
            sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;

            SqlParameter param = new SqlParameter();
            param.ParameterName = "@Id";
            param.Value = Convert.ToInt32(groupId);
            sqlcmd.Parameters.Add(param);

            //sqlcmd.Parameters.AddWithValue("g_id", groupId);

            SqlDataReader reader = sqlcmd.ExecuteReader();

            ServiceGroup group = new ServiceGroup();
            while (reader.Read())
            {
                group.GroupID = Convert.ToInt32(reader["GroupID"]);
                group.GroupName = reader["GroupName"].ToString();
                group.GroupDescription = reader["GroupDescription"].ToString();
            }

            Debug.Write(group.GroupName.ToString());
            //SensorGroup group = new SensorGroup();
            //SensorGroup query = new SensorGroup();
            //if (int.TryParse(groupId, out int g_id)) {
            //    query = _db.SensorGroups.SingleOrDefault(s => s.GroupID == g_id);

            //    group.GroupID = query.GroupID;
            //    group.GroupName = query.GroupName;
            //    group.GroupDescription = query.GroupDescription;
            //}

            return group;
        }

        [WebMethod]
        public ServiceSensor GetSensorDetail(string groupId)
        {
            ServiceSensor ss = new ServiceSensor();
            List<string> sensorList = new List<string>();
            List<DateTime> sensorDtList = new List<DateTime>();
            string sensorStr = "";
            string sensorDtStr = "";

            if(!string.IsNullOrEmpty(groupId) && int.TryParse(groupId, out int g_id)){
                var group = _db.SensorGroups.SingleOrDefault(g => g.GroupID == g_id);
                var sensors = _db.Sensors.Where(s => s.GroupId == g_id);

                foreach (var sensor in sensors)
                {
                    sensorList.Add(sensor.SensorVal.ToString());
                    sensorDtList.Add(DateTime.Parse(sensor.TimeOperate.ToString()));
                }

                var sensorCount = sensorList.Count;

                for(int i = sensorCount -12; i < sensorCount; i++) { 
                    if(i > sensorCount - 12)
                    {
                        sensorStr += "~";
                        sensorDtStr += "~";
                    }
                    sensorStr += sensorList[i].ToString();
                    sensorDtStr += sensorDtList[i].TimeOfDay.ToString();
                }

                ss.SensorName = group.GroupName.ToString();
                ss.SensorVal = sensorStr;
                ss.TimeOperate = sensorDtStr;

            }
            return ss;
        }

        [WebMethod]
        public ServiceAllSensor GetAllSensors()
        {
            ServiceAllSensor allSensor = new ServiceAllSensor();
            var group = _db.SensorGroups.ToList();
            string sensorName = "";
            string sensorVal = "";
            string sensorDt = "";

            //initiate string for a dt and a sensor
            string lastVal = "";
            string lastDt = "";

            

            var groupCount = group.Count;

            for(int i=0; i<groupCount; i++)
            {
                //Sensor value
                List<string> sensorList = new List<string>();
                string sensorValStr = "";
                //sensor datetime
                List<DateTime> sensorDtList = new List<DateTime>();
                string sensorDtStr = "";

                

                var sensors = _db.Sensors.Where(s => s.GroupId == i + 1);
                foreach (var sensor in sensors)
                {
                    sensorList.Add(sensor.SensorVal.ToString());
                    sensorDtList.Add(DateTime.Parse(sensor.TimeOperate.ToString()));
                }

                var sensorCount = sensorList.Count;

                //get only 12 last values
                for(int j=sensorCount -12; j<sensorCount; j++)
                {
                    if(j > sensorCount - 12)
                    {
                        sensorValStr += "~";
                        sensorDtStr += "~";
                    }
                    sensorValStr += sensorList[j].ToString();
                    sensorDtStr += sensorDtList[j].TimeOfDay.ToString();
                }
                if(i > 0)
                {
                    sensorName += "~";
                    lastVal += "~";
                    lastDt += "~";
                    sensorVal += "<";
                    sensorDt += "<";
                }
                //add each name into array
                sensorName += group[i].GroupName.ToString();
                sensorVal += sensorValStr;
                sensorDt += sensorDtStr;

                lastVal += sensors.ToList().Last().SensorVal.ToString();
                lastDt += DateTime.Parse(sensors.ToList().Last().TimeOperate.ToString()).TimeOfDay.ToString();
            }


            allSensor.SensorNames = sensorName;
            allSensor.SensorValArr = sensorVal;
            allSensor.TimeOperateArr = sensorDt;
            allSensor.LastVal = lastVal;
            allSensor.LastDt = lastDt;

            return allSensor;
        }

        [WebMethod]
        public RealTimeSensorData GetRealTimeData(string num) {
            RealTimeSensorData realTimeData = new RealTimeSensorData();

            if (int.TryParse(num, out int sensorNum))
            {
                
                AdamRetriever adamData = new AdamRetriever(sensorNum);
                Dictionary<string, string> getDic = adamData.getAllValues();

                string status = adamData.getSensorStatus();

                if (status == "true")
                {
                    realTimeData.Sensor1 = getDic["sensor1"];
                    realTimeData.Sensor2 = getDic["sensor2"];
                    realTimeData.Sensor3 = getDic["sensor3"];
                    realTimeData.Sensor4 = getDic["sensor4"];
                    realTimeData.TimeOperate = getDic["timeOperate"];
                }
                realTimeData.Status = status;
            }


            return realTimeData;
        }

        [WebMethod]
        public AlertValue GetAlertValue(string id)
        {
            AlertValue alert = new AlertValue();
            if(int.TryParse(id, out int _id))
            {
                alert = _db.AlertValues.SingleOrDefault(a => a.AlertValueID == _id);
                alert.SensorName = _db.SensorGroups.SingleOrDefault(g => g.GroupID == alert.GroupID).GroupName.ToString();
            }
            return alert;
        }

        [WebMethod]
        public SensorAlert PostAlert(string sensorname, string threshval, string alertval)
        {
            SensorAlert alert = new SensorAlert();

            //change thai year to us year
            Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");

            alert.SensorName = sensorname;
            alert.AlertThresholdVal = threshval;
            alert.AlertVal = alertval;
            alert.AlertDateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

            _db.SensorAlerts.Add(alert);
            _db.SaveChanges();
            return alert;
        }
    }
}
