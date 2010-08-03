using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Gianfratti.DataManager teste = new Gianfratti.DataManager();
        teste.DBManager(Gianfratti.DataProviderType.SqlServer, @"data source=DESENVOLVIMENTO\SQL2005EXPRESS;persist security info=False;initial catalog=Credito;user=mdiCredito;password=rcbab");
        try
        {
            teste.GravaDataSetXML(teste.GetDataSet("Select * From operador"), @"C:\");
        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
        
        //GridView1.DataSource = teste.GetDataSet("Select * From operador");
        //GridView1.DataBind();

    }
}
