using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CpDashboard.Models
{
    public class Position
    {
        [Key]
        public int PositionID { get; set; }

        [Required, StringLength(100), Display(Name = "Position Name")]
        public string PositionName { get; set; }
        public virtual ICollection<User> Users { get; set; }
    }
}