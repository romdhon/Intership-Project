using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace CpDashboard.Models
{
    public class CpDashboardDatabaseInitializer : DropCreateDatabaseIfModelChanges<CpDashboardContext>
    {
        protected override void Seed(CpDashboardContext context)
        {
            GetPositions().ForEach(p => context.Positions.Add(p));
            context.SaveChanges();
            GetUsers().ForEach(u => context.Users.Add(u));
            context.SaveChanges();
            base.Seed(context);
        }

        private static List<Position> GetPositions()
        {
            var positions = new List<Position>
            {
                new Position
                {
                    PositionID = 1,
                    PositionName = "Admin"
                },
                new Position
                {
                    PositionID = 2,
                    PositionName = "Normal User"
                },
                new Position
                {
                    PositionID = 3,
                    PositionName = "Guest"
                }
            };
            return positions;
        }

        private static List<User> GetUsers()
        {
            var users = new List<User>
            {
                new User
                {
                    UserId=1,
                    Name="Romdon",
                    LastName="Uma",
                    UserName="romdon_uma@gmail.com",
                    Password="12345",
                    PositionID=1
                },
                new User
                {
                    UserId=2,
                    Name="Hazal",
                    LastName="Uma",
                    UserName="hazal_uma@gmail.com",
                    Password="12345",
                    PositionID=2
                },
            };
            return users;
        }
    }

}