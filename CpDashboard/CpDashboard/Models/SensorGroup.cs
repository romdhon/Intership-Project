using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CpDashboard.Models
{
    public class SensorGroup
    {
        [Key]
        public int GroupID { get; set; }
        public string GroupName { get; set; }

        [StringLength(1000), Display(Name ="Group Description")]
        public string GroupDescription { get; set; }
        public virtual ICollection<Sensor> Sensors { get; set; }
        //public virtual ICollection<SensorType> SensorTypes { get; set; }
    }
}