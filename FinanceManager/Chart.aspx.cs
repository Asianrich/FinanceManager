using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YahooFinanceApi;
using System.Data.SqlClient;
using System.Configuration;
using System.Threading.Tasks;

namespace FinanceManager
{
    public partial class test1 : System.Web.UI.Page
    {
        
        protected async void Page_Load(object sender, EventArgs e)
        {
            //HttpCookie cookie = Request.Cookies["StockHistory"];
            //if (cookie != null)
            //{

            //    string symbol = cookie["Symbol"];
            //    DateTime begin = Convert.ToDateTime(cookie["Beginn"]);
            //    DateTime end = Convert.ToDateTime(cookie["Ende"]);
            //    await Task.Run(() =>insert(symbol, begin, end));
            //}
        }

        protected async void SearchButton_Click(object sender, EventArgs e)
        {
            try
            {
                if(TB_Symbol.Text is null)
                {
                    throw new Exception("Bitte geben sie einen Symbol");
                }
                string symbol = TB_Symbol.Text;
                DateTime begin = getDate(TB_Begin.Text);
                DateTime end = getDate(TB_End.Text);

                insert(symbol, begin, end);
                //HttpCookie cookie = new HttpCookie("StockHistory");
                //cookie["Symbol"] = symbol;
                //cookie["Beginn"] = begin.ToString();
                //cookie["Ende"] = end.ToString();
                //cookie.Expires = DateTime.Now.AddDays(2);
                //Response.Cookies.Add(cookie);

                if(Session["username"] != null)
                {
                    writeHistory(symbol, begin, end);
                }

                Response.Redirect(Request.RawUrl);
            }
            catch(Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Fehler", "alert('" + ex.Message + "');", true);
            }
        }

        protected DateTime getDate(string text)
        {
            char[] delimiter = { '-' };
            int day = 1;
            int month = 1;
            int year = 1990;
            string[] split = text.Split(delimiter);
            for(int i = 0; i < 3; i++)
            {
                if(Int32.TryParse(split[i], out int result))
                {
                    if (i == 0)
                        day = result;
                    if (i == 1)
                        month = result;
                    if (i == 2)
                        year = result;
                }
            }


            
            return new DateTime(year, month, day);


        }

        protected async void insert(string symbol, DateTime begin, DateTime end)
        {
            try
            {
                string symbols = symbol;
              



                var history = await Yahoo.GetHistoricalAsync(symbols, begin, end, Period.Daily);
                LB_Symbol.Text = symbols;
                StockChart.Titles[0].Text = symbol;
                clearDatabase();

                foreach (var candle in history)
                {
                    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["StockConnection"].ConnectionString);
                    con.Open();
                    string insert = "insert into stock (symbols, openstock, High, Low, Closestock, Volume, AdjustedClose, DateTime) values(@symbols, @openstock, @High, @Low, @Closestock, @Volume, @AdjustedClose, @DateTime)";
                    SqlCommand cmd = new SqlCommand(insert, con);
                    cmd.Parameters.AddWithValue("@symbols", symbols);
                    cmd.Parameters.AddWithValue("@openstock", candle.Open);
                    cmd.Parameters.AddWithValue("@High", candle.High);
                    cmd.Parameters.AddWithValue("@Low", candle.Low);
                    cmd.Parameters.AddWithValue("@Closestock", candle.Close);
                    cmd.Parameters.AddWithValue("@Volume", candle.Volume);
                    cmd.Parameters.AddWithValue("@AdjustedClose", candle.AdjustedClose);
                    cmd.Parameters.AddWithValue("@DateTime", candle.DateTime);
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            catch(Exception ex)
            {
                //Response.Redirect("Error.aspx");
                ClientScript.RegisterStartupScript(this.GetType(), "Fehler", "alert('" + ex.Message + "');", true);
            }
        }

        protected void clearDatabase()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["StockConnection"].ConnectionString);
            con.Open();
            string delete = "DELETE FROM stock";
            SqlCommand del = new SqlCommand(delete, con);
            del.ExecuteNonQuery();
            con.Close();
        }


        protected void writeHistory(string symbol, DateTime beginn, DateTime end)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["StockConnection"].ConnectionString);
            con.Open();
            string insert = "insert into history (username, modus,symbol, begin, end) values(@username, @modus,@symbol, @begin, @end)";
            SqlCommand inserter = new SqlCommand(insert, con);
            inserter.Parameters.AddWithValue("@username", Session["username"].ToString());
            inserter.Parameters.AddWithValue("@modus", 0);
            inserter.Parameters.AddWithValue("@symbol", symbol);
            inserter.Parameters.AddWithValue("@begin", beginn.ToString());
            inserter.Parameters.AddWithValue("@ende", end.ToString());
            inserter.ExecuteNonQuery();
            con.Close();
        }

        protected void BT_Table_Click(object sender, EventArgs e)
        {
            Response.Redirect("LookUpTable.aspx");
        }
    }
}