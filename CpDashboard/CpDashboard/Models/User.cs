using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CpDashboard.Models
{
    public class User
    {
        public int UserId { get; set; }

        [Required, StringLength(100)]
        public string Name { get; set; }

        [Required, StringLength(100), Display(Name = "Lastname")]
        public string LastName { get; set; }

        [Required, StringLength(100), Display(Name = "Lastname")]
        public string UserName { get; set; }

        public string Password { get; set; }
        public int? PositionID { get; set; }
        public virtual Position Position { get; set; }
    }
}