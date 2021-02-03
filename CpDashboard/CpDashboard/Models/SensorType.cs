using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CpDashboard.Models
{
    public class SensorType
    {
        [Key]
        public int TypeID { get; set; }
        public string TypeName { get; set; }
        [StringLength(1000), Display(Name = "Type Description")]
        public string TypeDescription { get; set; }
        public virtual ICollection<Sensor> Sensors { get; set; }
        public int? GroupId { get; set; }
        public virtual SensorGroup SensorGroup { get; set; }
    }
}