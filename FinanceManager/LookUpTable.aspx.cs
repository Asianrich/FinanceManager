using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinanceManager
{
    public partial class LookUpTable : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BT_back_Click(object sender, EventArgs e)
        {
            Response.Redirect("Chart.aspx");
        }
    }
}