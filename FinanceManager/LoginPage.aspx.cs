using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YahooFinanceApi;
using System.Data.SqlClient;
using System.Configuration;

namespace FinanceManager
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BT_Log_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["StockConnection"].ConnectionString);
            con.Open();

            string read = "SELECT * from userlist Where username = @username AND passwort = @passwort";
            SqlCommand reading = new SqlCommand(read, con);
            reading.Parameters.AddWithValue("@username", TB_LogUser.Text);
            reading.Parameters.AddWithValue("@passwort", TB_LogPw.Text);
            SqlDataReader reader = reading.ExecuteReader();
            if (reader.Read())
            {
                Session["username"] = TB_LogUser.Text;
            }
            Response.Redirect(Request.RawUrl);

        }

        protected void BT_registry_Click(object sender, EventArgs e)
        {
            try
            {
                if (TB_RegPw.Text == TB_RegConf.Text)
                {
                    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["StockConnection"].ConnectionString);
                    con.Open();

                    string read = "SELECT * From userlist Where username = @username";
                    SqlCommand reading = new SqlCommand(read, con);
                    reading.Parameters.AddWithValue("@username", Convert.ToString(TB_RegUser.Text));
                    SqlDataReader reader = reading.ExecuteReader();
                    if (reader.Read())
                    {
                        throw new Exception();
                    }

                    reader.Close();

                    string insert = "insert into userlist (username, passwort) values(@username, @passwort);";
                    SqlCommand cmd = new SqlCommand(insert, con);
                    cmd.Parameters.AddWithValue("@username", TB_RegUser.Text);
                    cmd.Parameters.AddWithValue("@passwort", TB_RegPw.Text);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Session["username"] = TB_RegUser.Text;
                    Response.Redirect(Request.RawUrl);

                }
            }
            catch(Exception ex)
            {
                Response.Write("<script>alert('Sry Nutzername schon vergeben');</script>");
            }
        }

        protected void TB_LogUser_TextChanged(object sender, EventArgs e)
        {
            
        }
    }
}