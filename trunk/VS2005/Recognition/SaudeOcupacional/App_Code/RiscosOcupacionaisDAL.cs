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
using System.Data.Common;
using System.Collections.Generic;

/// <summary>
/// Summary description for RiscosOcupacionaisDAL
/// </summary>
public class RiscosOcupacionaisDAL
{
	public RiscosOcupacionaisDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    /// <summary>
    /// Retorna um DataTable com todos os usuarios.
    /// Pode-se fazer um filtro conforme parametros.
    /// </summary>
    /// <returns></returns>

    //USADO PARA POPULAR UM DROPDOWNLIST
    public DataTable DropDownList()
    {
        try
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT id, Descricao FROM dbo.RiscosOcupacionais ");

            DataTable dt = new DataTable();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                dt.Load(dr);
            }
            return dt;

        }

        catch (Exception ex)
        {
            throw (ex);
        }
    }
}
