using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CpDashboard.Models
{
    public class SensorAlert
    {   
        [Key]
        public int AlertID { get; set; }
        public string SensorName { get; set; }
        public string AlertThresholdVal { get; set; }
        public string AlertVal { get; set; }
        public string AlertDateTime { get; set; }
    }
}