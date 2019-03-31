using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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


            Response.Redirect("Chart.aspx");


        }
    }
}