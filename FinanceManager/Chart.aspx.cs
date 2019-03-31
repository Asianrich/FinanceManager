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

            if ((Session["Symbol"] != null) && (Session["Begin"] != null) && (Session["Ende"] != null))
            {
                string symbol = Session["Symbol"].ToString();
                DateTime begin = Convert.ToDateTime(Session["Begin"].ToString());
                DateTime end = Convert.ToDateTime(Session["Ende"].ToString());

                char[] delimiter = { ' ' };
                string[] split = symbol.Split(delimiter);



                insert(split[0], begin, end);
                Session["Symbol"] = null;
                Session["Begin"] = null;
                Session["Ende"] = null;

            }

            

        }

        protected async void SearchButton_Click(object sender, EventArgs e)
        {
            try
            {
                if (TB_Symbol.Text is null)
                {
                    throw new Exception("Bitte geben sie einen Symbol");
                }
                string symbol = TB_Symbol.Text;
                DateTime begin = getDate(TB_Begin.Text);
                DateTime end = getDate(TB_End.Text);

                insert(symbol, begin, end);

                if (Session["username"] != null)
                {
                    writeHistory(symbol, begin, end);
                }

            }
            catch (Exception ex)
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
            if (split.Count() == 3)
            {
                for (int i = 0; i < 3; i++)
                {
                    if (Int32.TryParse(split[i], out int result))
                    {
                        if (i == 0)
                        {
                            if(result > 0 && result < 31)
                            day = result;
                        }

                        if (i == 1)
                            if (result > 0 && result < 31)
                                month = result;
                        if (i == 2)
                            if (result > 0)
                                year = result;
                    }
                    else
                    {
                        throw new Exception("Überprüfe deine Eingaben am Datum");
                    }
                }
            }
            else
            {
                throw new Exception("Eines der Datum hat den falschen Format");
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
                clearDatabase();

                foreach (var candle in history)
                {
                    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["StockConnectionDB"].ConnectionString);
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
            catch (Exception ex)
            {
                //Response.Redirect("Error.aspx");
                //ClientScript.RegisterStartupScript(this.GetType(), "Fehler", "alert('" + ex.Message + "');", true);
                Response.Write("<script>alert('Symbol konnte nicht gefunden werden');</script>");
            }
        }

        protected void clearDatabase()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["StockConnectionDB"].ConnectionString);
            con.Open();
            string delete = "DELETE FROM stock";
            SqlCommand del = new SqlCommand(delete, con);
            del.ExecuteNonQuery();
            con.Close();
        }


        protected void writeHistory(string symbol, DateTime beginn, DateTime end)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["StockConnectionDB"].ConnectionString);
            con.Open();
            string insert = "insert into history (username, modus,symbol, beginDate, endDate) values(@username, @modus, @symbol, @beginDate, @endDate)";
            SqlCommand inserter = new SqlCommand(insert, con);
            inserter.Parameters.AddWithValue("@username", Session["username"].ToString());
            inserter.Parameters.AddWithValue("@modus", 0);
            inserter.Parameters.AddWithValue("@symbol", symbol);
            inserter.Parameters.AddWithValue("@beginDate", beginn);
            inserter.Parameters.AddWithValue("@endDate", end);
            inserter.ExecuteNonQuery();
            con.Close();
        }

        protected void BT_Table_Click(object sender, EventArgs e)
        {
            Response.Redirect("LookUpTable.aspx");
        }

        protected void BT_verlauf_Click(object sender, EventArgs e)
        {
            Response.Redirect("History.aspx");
        }

        protected void BT_verlauf_Load(object sender, EventArgs e)
        {

            if (Session["username"] != null)
            {
                BT_verlauf.Enabled = true;
                BT_verlauf.Visible = true;
            }
            else
            {
                BT_verlauf.Enabled = true;
                BT_verlauf.Visible = true;
            }

        }
    }
}