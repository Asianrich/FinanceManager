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
    public partial class Compare : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected async void BT_ADD_Click(object sender, EventArgs e)
        {
            try
            {
                char[] delimiter = { ' ', ';' ,','};
                string[] symbols = TB_Symbol.Text.Split(delimiter);

                foreach (string symbol in symbols)
                {
                    await insert(symbol);
                }

            }
            catch(Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Fehler", "alert('" + ex.Message + "');", true);
            }
            Response.Redirect(Request.RawUrl);




        }

        protected async Task<bool> insert (string symbols)
        {
            try
            {
                var securities = await Yahoo.Symbols(symbols).Fields(Field.Symbol, Field.RegularMarketPrice, Field.FiftyTwoWeekHigh, Field.RegularMarketDayLow, Field.RegularMarketVolume).QueryAsync();
                
                var aapl = securities[symbols];
                var price = aapl[Field.RegularMarketPrice]; // or, you could use aapl.RegularMarketPrice directly for typed-value


                decimal marketprice = Convert.ToDecimal(price);



                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["StockConnection"].ConnectionString);
                con.Open();

                string read = "SELECT symbols from Compare Where symbols = @symbols";
                SqlCommand reading = new SqlCommand(read, con);
                reading.Parameters.AddWithValue("@symbols", symbols);
                SqlDataReader reader = reading.ExecuteReader();
                if (reader.Read())
                {
                    return false;
                }
                else
                {
                    reader.Close();
                    string insert = "insert into Compare (symbols, openstock, High, Low, Volume) values(@symbols, @openstock, @High, @Low, @Volume)";
                    SqlCommand cmd = new SqlCommand(insert, con);
                    cmd.Parameters.AddWithValue("@symbols", symbols);
                    cmd.Parameters.AddWithValue("@openstock", aapl.RegularMarketPrice);
                    cmd.Parameters.AddWithValue("@High", aapl.RegularMarketDayHigh);
                    cmd.Parameters.AddWithValue("@Low", aapl.RegularMarketDayLow);
                    cmd.Parameters.AddWithValue("@Volume", aapl.RegularMarketVolume);
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                return true;
            }
            catch(Exception ex)
            {
                return false;
            }
        }

        protected void BT_DeleteStocks_Click(object sender, EventArgs e)
        {
            delete();
            Response.Redirect(Request.RawUrl);
        }

        protected void delete(string symbols = null)
        {
            string delete = "DELETE FROM Compare";
            SqlCommand del;
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["StockConnection"].ConnectionString);
            con.Open();

            if (symbols != null)
            {
                delete = delete + " Where symbols = @symbols";
                del = new SqlCommand(delete, con);
                del.Parameters.AddWithValue("@symbols", symbols);
            }
            else
            {
                del = new SqlCommand(delete, con);
            }

            del.ExecuteNonQuery();
            con.Close();


        }

        protected void BT_DeleteStock_Click(object sender, EventArgs e)
        {
            try
            {
                int index = GV_Compare.SelectedIndex;
                string symbol = GV_Compare.Rows[index].Cells[1].Text;

                delete(symbol);
                Response.Redirect(Request.RawUrl);
            }
            catch(Exception ex)
            {
                Response.Write("<script>alert('Hoppala, da hat jemand kein Reihe ausgewaehlt. :(');</script>");
            }
        }
    }
}