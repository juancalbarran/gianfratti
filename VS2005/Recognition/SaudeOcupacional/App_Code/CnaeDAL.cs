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
/// Summary description for CnaeDAL
/// </summary>
public class CnaeDAL
{
	public CnaeDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    //FAZ UM SELECT EM TODOS OS REGISTROS DO CNAE
    public DataTable SelectAll(string SubClasse, string Descricao, string Risco)
    {
        Validacoes ObjValida = new Validacoes();
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("CNAESelectAll");
        db.AddInParameter(command, "@SubClasse", DbType.String, ObjValida.TextoNull(SubClasse));
        db.AddInParameter(command, "@Descricao", DbType.String, ObjValida.TextoNull(Descricao));
        db.AddInParameter(command, "@Risco", DbType.String, ObjValida.TextoNull(Risco));
        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }

}
