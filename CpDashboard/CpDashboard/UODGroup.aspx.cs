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
    public partial class UODGroup : System.Web.UI.Page
    {
        private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CpDashboard"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SensorShow();
            }
            else
            {
                ShowData();
            }

        }

        protected void Delete_Click(object sender, EventArgs e)
        {

        }

        protected void Update_Click(object sender, EventArgs e)
        {

        }

        private void SensorShow()
        {
            con.Open();

            string constr_group = "SELECT * FROM SensorGroups";
            string constr_type = "SELECT * FROM SensorTypes";

            SqlDataAdapter adapter_group = new SqlDataAdapter(constr_group, con);
            SqlDataAdapter adapter_type = new SqlDataAdapter(constr_type, con);

            DataTable dt_group = new DataTable();
            DataTable dt_type = new DataTable();

            adapter_group.Fill(dt_group);

            sensorGroup.DataSource = dt_group;
            sensorGroup.DataTextField = "GroupName";
            sensorGroup.DataValueField = "GroupID";
            sensorGroup.DataBind();


            DataRow row = dt_group.Rows[0];
            groupId.Text = row["GroupID"].ToString();
            groupName.Text = row["GroupName"].ToString();
            GroupDes.Text = row["GroupDescription"].ToString();


        }

        private void ShowData()
        {
            con.Open();
            string constr_display_group = "SELECT * FROM SensorGroups WHERE GroupID=@gid";
            SqlCommand cmd = new SqlCommand(constr_display_group, con);
            cmd.Parameters.AddWithValue("gid", sensorGroup.SelectedItem.Value);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                groupId.Text = reader["GroupID"].ToString();
                groupName.Text = reader["GroupName"].ToString();
                GroupDes.Text = reader["GroupDescription"].ToString();
            }

        }
    }
}