using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Threading.Tasks;

namespace FinanceManager
{
    public partial class History : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BT_Select_Click(object sender, EventArgs e)
        {
            int index = GV_History.SelectedIndex;
            string symbol = GV_History.Rows[index].Cells[1].Text;
            DateTime begin = Convert.ToDateTime(GV_History.Rows[index].Cells[2].Text);
            DateTime end = Convert.ToDateTime(GV_History.Rows[index].Cells[3].Text);

            Session["Symbol"] = symbol;
            Session["Begin"] = begin;
            Session["Ende"] = end;

            Response.Redirect("Chart.aspx");


        }

        protected void BT_Delete_Click(object sender, EventArgs e)
        {
            try
            {
                int index = GV_History.SelectedIndex;
                string symbol = GV_History.Rows[index].Cells[1].Text;
                DateTime begin = Convert.ToDateTime(GV_History.Rows[index].Cells[2].Text);
                DateTime end = Convert.ToDateTime(GV_History.Rows[index].Cells[3].Text);

                delete(begin, end, symbol);
            }
            catch(Exception)
            {
                Response.Redirect("Error.aspx");
            }
        }

        protected void delete( DateTime begin, DateTime end, string symbols = null)
        {
            string delete = "DELETE FROM history";
            SqlCommand del;
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["StockConnectionDB"].ConnectionString);
            con.Open();

            if (symbols != null)
            {
                delete = delete + " Where symbol = @symbols AND beginDate = @begin AND endDate = @end";
                del = new SqlCommand(delete, con);
                del.Parameters.AddWithValue("@symbols", symbols);
                del.Parameters.AddWithValue("@begin", begin);
                del.Parameters.AddWithValue("@end", end);
            }
            else
            {
                del = new SqlCommand(delete, con);
            }

            del.ExecuteNonQuery();
            con.Close();


        }
        protected void BT_Delete_All_Click(object sender, EventArgs e)
        {
            delete(DateTime.Now,DateTime.Now);
        }
    }
}