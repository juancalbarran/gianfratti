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
/// Summary description for ClienteCargoDAL
/// </summary>
public class ClienteCargoDAL
{
    public ClienteCargoDAL()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    /// <summary>
    /// Usado para gerar um DropDownList
    /// </summary>
    /// <param name="idClienteSetor"></param>
    /// <returns></returns>
    public DataTable DropDownList(int idClienteSetor)
    {
        try
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("Select id,Nome,idClienteSetor From ClienteCargo Where idClienteSetor = " + idClienteSetor);

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

    public void Insert(ClienteCargo ObjClienteCargo)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ClienteCargoInsert");

        db.AddInParameter(command, "@Nome", DbType.String, ObjClienteCargo.Nome);
        db.AddInParameter(command, "@idClienteSetor", DbType.Int32, ObjClienteCargo.idClienteSetor);
        db.ExecuteNonQuery(command);
    }

    public DataTable SelectAll(int idCliente)
    {
        try
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetStoredProcCommand("ClienteCargoSelectAll");
            db.AddInParameter(command, "@idCliente", DbType.Int32, idCliente);

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

    public void Delete(int id)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Delete From ClienteCargo Where id = " + id);
        db.ExecuteNonQuery(command);
    }
}
