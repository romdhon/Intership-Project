using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CpDashboard
{
    public partial class AddSensor : System.Web.UI.Page
    {
        private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CpDashboard"].ConnectionString);
        private SqlDataAdapter adapter_group;
        private SqlDataAdapter adapter_type;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SensorShow();
            }
        }

        protected void Add_Click(object sender, EventArgs e)
        {
            con.Open();

            string str_sensor = @"INSERT INTO Sensors(TimeOperate, SensorName, SensorVal, TypeId) 
                                VALUES(CAST(GETDATE() AS DATETIME), @sn, @sv, @tid)";
            SqlCommand cmd = new SqlCommand(str_sensor, con);
            cmd.Parameters.AddWithValue("sn", sensorTb.Text);
            cmd.Parameters.AddWithValue("sv", "50");
            cmd.Parameters.AddWithValue("tid", sensorType.SelectedItem.Value);

            SqlDataReader reader = cmd.ExecuteReader();
            con.Close();
        }

        private void SensorShow()
        {
            con.Open();

            string constr_group = "SELECT * FROM SensorGroups";
            string constr_type = "SELECT * FROM SensorTypes";

            adapter_group = new SqlDataAdapter(constr_group, con);
            adapter_type = new SqlDataAdapter(constr_type, con);

            DataTable dt_group = new DataTable();
            DataTable dt_type = new DataTable();

            adapter_group.Fill(dt_group);
            adapter_type.Fill(dt_type);

            sensorGroup.DataSource = dt_group;
            sensorGroup.DataTextField = "GroupName";
            sensorGroup.DataValueField = "GroupID";
            sensorGroup.DataBind();

            sensorType.DataSource = dt_type;
            sensorType.DataTextField = "TypeName";
            sensorType.DataValueField = "TypeID";
            sensorType.DataBind();
            con.Close();
        }

    }
}