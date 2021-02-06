using CpDashboard.Models;
using System;
using System.Collections.Generic;
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

        public List<string> dtList1 = new List<string>();
        public List<DateTime> dtList2 = new List<DateTime>();

        public string dtStr1;


        protected void Page_Load(object sender, EventArgs e)
        {
            GetThermoValStr(1, ref thermoValList1, ref thermoValStr1, ref dtList1, ref dtStr1);
            //GetThermoValStr(2, ref thermoValList2, ref thermoValStr2, ref dtList2);
        }

        private void GetThermoValStr(int groupID, ref List<string> valList, ref string valStr, ref List<string> dtList, ref string dtstr)
        {
            var thermo = _db.Sensors.Where(s => s.GroupId == groupID);
            dtList.Clear();
            valList.Clear();
            valStr = "";

            foreach (var ther in thermo)
            {
                valList.Add(ther.SensorVal.ToString());
                dtList.Add(ther.TimeOperate.ToString());
            }

            int sensorTotal = valList.Count;


            for (int th = sensorTotal - 12; th < sensorTotal; th++)
            {
                valStr += valList[th].ToString() + ", ";
                dtstr += dtList[th].ToString() + ", ";
            }
        }
    }
}