using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CpDashboard.Models
{
    public class Sensor
    {
        [Key]
        public int SensorID { get; set; }
        public  DateTime TimeOperate { get; set; }
        public string SensorName { get; set; }
        public string SensorVal { get; set; }
        public int? TypeId { get; set; }
        public virtual SensorType SensorType { get; set; }
    }
}