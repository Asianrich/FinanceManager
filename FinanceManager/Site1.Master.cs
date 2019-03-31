using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinanceManager
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void HomeButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void ChartButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Chart.aspx");
        }

        protected void CompareButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Compare.aspx");
        }

        protected void AboutButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("About.aspx");
        }
    }
}