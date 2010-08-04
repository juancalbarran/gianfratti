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
/// Summary description for PCMSOPeriodicidadeDAL
/// </summary>
public class PCMSOPeriodicidadeDAL
{
	public PCMSOPeriodicidadeDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public DataTable SelectAll()
    {
        string sql;
        sql = "SELECT * FROM PCMSOPeriodicidade ";

        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand(sql);
        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }


}
