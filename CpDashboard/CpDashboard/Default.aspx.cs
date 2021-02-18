using CpDashboard.Logics;
using CpDashboard.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CpDashboard
{
    public partial class _Default : Page
    {
        private CpDashboardContext _db = new CpDashboardContext();
        //public Sensor thermo1;
        public List<string> thermoValList1 = new List<string>();
        public List<string> thermoValList2 = new List<string>();
        public List<string> thermoValList3 = new List<string>();
        public List<string> thermoValList4 = new List<string>();

        public string thermoValStr1 = "";
        public string thermoValStr2 = "";
        public string thermoValStr3 = "";
        public string thermoValStr4 = "";

        public List<DateTime> dtList1 = new List<DateTime>();
        public List<DateTime> dtList2 = new List<DateTime>();
        public List<DateTime> dtList3 = new List<DateTime>();
        public List<DateTime> dtList4 = new List<DateTime>();

        public List<string> timeList = new List<string>();


        public string dtStr1 = "No Data";
        public string dtStr2 = "No Data";
        public string dtStr3 = "No Data";
        public string dtStr4 = "No Data";

        //using array
        public string valStr1 = "";


        protected void Page_Load(object sender, EventArgs e)
        {
            GetThermoValStr(1, ref thermoValList1, ref thermoValStr1, ref dtList1, ref dtStr1);
            GetThermoValStr(2, ref thermoValList2, ref thermoValStr2, ref dtList2, ref dtStr2);
            GetThermoValStr(3, ref thermoValList3, ref thermoValStr3, ref dtList3, ref dtStr3);
            GetThermoValStr(4, ref thermoValList4, ref thermoValStr4, ref dtList4, ref dtStr4);
        }

        private void GetThermoValStr(int groupID, ref List<string> valList, ref string valStr, ref List<DateTime> dtList, ref string dtstr)
        {
            var thermo = _db.Sensors.Where(s => s.GroupId == groupID);
            dtList.Clear();
            valList.Clear();
            timeList.Clear();
            valStr = "";
            dtstr = "";

            foreach (var ther in thermo)
            {
                valList.Add(ther.SensorVal.ToString());
                dtList.Add(DateTime.Parse(ther.TimeOperate.ToString()));
            }

            int sensorTotal = valList.Count;


            for (int th = sensorTotal - 12; th < sensorTotal; th++)
            {
                if(th > sensorTotal - 12)
                {
                    valStr += ",";
                    dtstr += ",";
                }
                    
                valStr += valList[th].ToString();
                dtstr += dtList[th].TimeOfDay.ToString();
            }
            //Debug.Write(dtstr);
        }

        protected void chartTimer_Tick(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "getAllData", "getAllData()", true);
            //chartLabel.Text = DateTime.Now.ToString();
        }
    }
}