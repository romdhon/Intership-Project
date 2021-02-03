using CpDashboard.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CpDashboard.ContentPage
{
    public partial class AdminSetting : System.Web.UI.Page
    {

        private CpDashboardContext database = new CpDashboardContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Something();
            }
        }

        public IQueryable<User> GetUsers([QueryString("admin_id")] int? adminId)
        {
            IQueryable<User> user = database.Users;
            //problem occurs when using session
            if (adminId.HasValue && adminId > 0)
            {
                user = user.Where(u => u.UserId != adminId);
            }
            return user;
        }

        protected void AdminSubmit_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CpDashboard"].ConnectionString);
            con.Open();

            string con_str = "UPDATE Users SET PositionID=@user_pos WHERE UserId=@user_em";

            SqlCommand com = new SqlCommand(con_str, con);

            com.Parameters.AddWithValue("user_pos", user_position.SelectedItem.Value);
            com.Parameters.AddWithValue("user_em", user_email.SelectedItem.Value);

            SqlDataReader reader = com.ExecuteReader();

            u_e.Text = user_email.SelectedItem.Text;
            u_p.Text = user_position.SelectedItem.Text;

            con.Close();
        }

        public void Something()
        {
            string rawId = Request.QueryString["admin_id"];

            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["CpDashboard"].ConnectionString);
            connection.Open();

            string user_constr = "SELECT * FROM Users WHERE UserId!=" + rawId;
            string position_constr = "SELECT * FROM Positions";

            //use this when dealing with datatable
            SqlDataAdapter user_adapter = new SqlDataAdapter(user_constr, connection);
            SqlDataAdapter position_adapter = new SqlDataAdapter(position_constr, connection);

            DataTable user_dt = new DataTable();
            DataTable position_dt = new DataTable();

            user_adapter.Fill(user_dt);
            position_adapter.Fill(position_dt);

            user_email.DataSource = user_dt;
            //user_email.DataBind();
            user_email.DataTextField = "Name";
            user_email.DataValueField = "UserId";
            user_email.DataBind();

            user_position.DataSource = position_dt;
            //user_position.DataBind();
            user_position.DataValueField = "PositionID";
            user_position.DataTextField = "PositionName";
            user_position.DataBind();

            
        }
    }
}