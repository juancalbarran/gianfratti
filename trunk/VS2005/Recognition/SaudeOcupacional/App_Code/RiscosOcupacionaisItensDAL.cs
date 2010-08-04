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
/// Summary description for RiscosOcupacionaisItensDAL
/// </summary>
public class RiscosOcupacionaisItensDAL
{
	public RiscosOcupacionaisItensDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    //USADO PARA POPULAR UM DROPDOWNLIST
    public DataTable DropDownList(int idRiscosOcupacionais)
    {
        try
        {
            if (idRiscosOcupacionais != 0)
            {
                Database db = DatabaseFactory.CreateDatabase();
                DbCommand command = db.GetSqlStringCommand("SELECT id, idRiscosOcupacionais, Descricao FROM RiscosOcupacionaisItens  Where idRiscosOcupacionais = '" + idRiscosOcupacionais + "' ");

                DataTable dt = new DataTable();
                using (IDataReader dr = db.ExecuteReader(command))
                {
                    dt.Load(dr);
                }
                return dt;
            }
            else
            {
                return null;
            }
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }
}
