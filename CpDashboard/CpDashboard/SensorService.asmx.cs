using CpDashboard.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
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
    }
}
