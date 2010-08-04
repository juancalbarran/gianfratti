using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Sql;
using System.Data.Common;

/// <summary>
/// Summary description for DALcliente
/// </summary>
public class DALcliente
{
    Cliente ObjTeste;
    public DataTable getAllNews()
	{
        Database news = DatabaseFactory.CreateDatabase();
        DbCommand command = news.GetStoredProcCommand("selectNews");
        DataTable AllNews = new DataTable();
        using (IDataReader dr = news.ExecuteReader(command))
        {
            AllNews.Load(dr);
        }
        return AllNews;
	}

    public void InsertNews(object teste)
    {

        ObjTeste = teste as Cliente;
        
        Database newsInsert = DatabaseFactory.CreateDatabase();
        DbCommand command = newsInsert.GetStoredProcCommand("insert_Cliente_1");
        newsInsert.AddInParameter(command, "@RazaoSocial", DbType.String, ObjTeste.RazaoSocial);
        newsInsert.ExecuteNonQuery(command);
    }
     

}
