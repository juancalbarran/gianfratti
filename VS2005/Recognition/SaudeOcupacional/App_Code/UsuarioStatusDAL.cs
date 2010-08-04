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
/// Summary description for UsuarioStatusDAL
/// </summary>
public class UsuarioStatusDAL
{
	public UsuarioStatusDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    /// <summary>
    /// Retorna um DataTable com todos os registros
    /// </summary>
    /// <returns></returns>
    public DataTable SelectUsuarioStatusALL()
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("SELECT id, Nome FROM UsuarioStatus");
        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;

    }
}
