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
/// Summary description for ClienteFuncionarioStatusDAL
/// </summary>
public class ClienteFuncionarioStatusDAL
{
	public ClienteFuncionarioStatusDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    /// <summary>
    /// Retorna um DataTable
    /// </summary>
    /// <returns></returns>
    public DataTable DropDownList()
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select id,Status From ClienteFuncionarioStatus");

        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }
}
