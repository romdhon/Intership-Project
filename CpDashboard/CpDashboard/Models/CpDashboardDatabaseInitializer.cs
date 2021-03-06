﻿using CpDashboard.Logics;
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
            getAlertValues().ForEach(a => context.AlertValues.Add(a));
            context.SaveChanges();
            GetPositions().ForEach(p => context.Positions.Add(p));
            context.SaveChanges();
            GetUsers().ForEach(u => context.Users.Add(u));
            context.SaveChanges();
            getSensorGroups().ForEach(g => context.SensorGroups.Add(g));
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

        private static List<SensorGroup> getSensorGroups()
        {
            var sensorGroup = new List<SensorGroup>{
                new SensorGroup
                {
                    GroupID=1,
                    GroupName="Thermocouple1",
                    GroupDescription="First Thermo"
                },
                new SensorGroup
                {
                    GroupID=2,
                    GroupName="Thermocouple2",
                    GroupDescription="Second Thermo"
                },
                new SensorGroup
                {
                    GroupID=3,
                    GroupName="Thermocouple3",
                    GroupDescription="Third Thermo"
                },
                new SensorGroup
                {
                    GroupID=4,
                    GroupName="Thermocouple4",
                    GroupDescription="Fourth Thermo"
                }


            };
            return sensorGroup;
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
                    Password=new Encryptions().EncryptPassword("12345"),
                    PositionID=1
                },
                new User
                {
                    UserId=2,
                    Name="Hazal",
                    LastName="Uma",
                    UserName="hazal_uma@gmail.com",
                    Password=new Encryptions().EncryptPassword("12345"),
                    PositionID=2
                },
                new User
                {
                    UserId=2,
                    Name="Warakorn",
                    LastName="Klaharn",
                    UserName="warakorn9597@gmail.com",
                    Password=new Encryptions().EncryptPassword("12345"),
                    PositionID=1
                },
            };
            return users;
        }

        private static List<AlertValue> getAlertValues()
        {
            var alert = new List<AlertValue>
            {
                new AlertValue
                {
                    Value="30",
                    GroupID=1
                },
                new AlertValue
                {
                    Value="30",
                    GroupID=2
                },
                new AlertValue
                {
                    Value="30",
                    GroupID=3
                },
                new AlertValue
                {
                    Value="30",
                    GroupID=4
                }
            };
            return alert;
        }
    }

}