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
/// Summary description for ConselhoProfissionalDAL
/// </summary>
public class ConselhoProfissionalDAL
{
	public ConselhoProfissionalDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    //USADO PARA POPULAR UM DROPDOWNLIST
    public DataTable ConselhoProfissionalDropDownList()
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select id,Codigo,(Descricao + ' ' + '(' + Codigo + ')' ) As Descricao From ConselhoProfissional");

        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }
}
