using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Gianfratti;
using System.Data;

public partial class _Default : System.Web.UI.Page 
{
    //PAGINA COM OS EXEMPLOS
    //http://aspalliance.com/837
    //http://www.dotnetjohn.com/articles.aspx?articleid=244

    protected void Page_Load(object sender, EventArgs e)
    {
        ExecutarDataReader();
    }

    public void ExecutarDataReader()
    {
        IDBManager dbManager = new DBManager(DataProvider.SqlServer);

        dbManager.ConnectionString = "data source=desenv03;persist security info=False;initial catalog=Credito;user=mdiCredito;password=rcbab";

        try
        {
            dbManager.Open();
            dbManager.ExecuteReader(CommandType.Text, "select * from operador");

            while (dbManager.DataReader.Read())
            {
                Response.Write(dbManager.DataReader["vcNomeOper"].ToString() + "<br>");
            }

            //Pode-se preencher um GridView assimmm...
            //GridView1.DataSource = dbManager.ExecuteReader(CommandType.Text, "select * from operador");
            //GridView1.DataBind();
        }

        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }

        finally
        {
            dbManager.Dispose();
        }
    }

}
