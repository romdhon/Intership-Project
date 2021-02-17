using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CpDashboard.Models
{
    public class ServiceAllSensor
    {
        public string SensorNames { get; set; }
        public string SensorValArr { get; set; }
        public string TimeOperateArr { get; set; }
        public string LastVal { get; set; }
        public string LastDt { get; set; }

    }
}