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

        public string thermoValStr1 = "";
        public string thermoValStr2 = "";

        public List<DateTime> dtList1 = new List<DateTime>();
        public List<DateTime> dtList2 = new List<DateTime>();

        public List<string> timeList = new List<string>();


        public string dtStr1 = "No Data";

        //using array
        public string valStr1 = "";


        protected void Page_Load(object sender, EventArgs e)
        {
            GetThermoValStr(1, ref thermoValList1, ref thermoValStr1, ref dtList1, ref dtStr1);
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


    }
}