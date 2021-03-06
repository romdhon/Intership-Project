using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CpDashboard.Models
{
    public class AlertValue
    {
        public int AlertValueID { get; set; }
        public string Value { get; set; }
        public string SensorName { get; set; }
        public int? GroupID { get; set; }
    }
}