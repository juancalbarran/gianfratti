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
/// Summary description for CID10DAL
/// </summary>
public class CID10DAL
{
	public CID10DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    //FAZ UM SELECT EM TODOS OS REGISTROS DO CID
    public DataTable SelectAll(string CID10, string Descricao)
    {
        Validacoes ObjValida = new Validacoes();
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("CID10SelectAll");
        db.AddInParameter(command, "@CID", DbType.String, ObjValida.TextoNull(CID10));
        db.AddInParameter(command, "@Descricao", DbType.String, ObjValida.TextoNull(Descricao));
        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }
}
