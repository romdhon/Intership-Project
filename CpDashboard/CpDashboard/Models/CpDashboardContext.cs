using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace CpDashboard.Models
{
    public class CpDashboardContext : DbContext
    {
        public CpDashboardContext() : base("CpDashboard")
        {
        }

        public DbSet<Position> Positions { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Sensor> Sensors { get; set; }
        public DbSet<SensorGroup> SensorGroups { get; set; }


    }
}