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
/// Summary description for CBOSDAL
/// </summary>
public class CBOSDAL
{
	public CBOSDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    //USADO PARA POPULAR UM DROPDOWNLIST
    public DataTable CBOSDropDownList()
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select id,Codigo,Descricao From CBOS");

        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }
}
