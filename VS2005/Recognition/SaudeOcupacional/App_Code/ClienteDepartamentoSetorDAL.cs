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
/// Summary description for ClienteDepartamentoSetorDAL
/// </summary>
public class ClienteDepartamentoSetorDAL
{
    ClienteDepartamentoSetor ObjClienteDepartamentoSetor;

	public ClienteDepartamentoSetorDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public void InsertClienteDepartamento(object ObjPacote)
    {
        ObjClienteDepartamentoSetor = ObjPacote as ClienteDepartamentoSetor;       
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ClienteDepartamentoInsert");
        
        db.AddInParameter(command, "@idCliente", DbType.Int32, ObjClienteDepartamentoSetor.idCliente);
        db.AddInParameter(command, "@Nome", DbType.String, ObjClienteDepartamentoSetor.Depto);

        db.ExecuteNonQuery(command);
    }


    public void InsertClienteSetor(object ObjPacote)
    {
        ObjClienteDepartamentoSetor = ObjPacote as ClienteDepartamentoSetor;
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ClienteSetorInsert");

        db.AddInParameter(command, "@idClienteDepartamento", DbType.Int32, ObjClienteDepartamentoSetor.IdDepto);
        db.AddInParameter(command, "@Nome", DbType.String, ObjClienteDepartamentoSetor.Setor);

        db.ExecuteNonQuery(command);
    }

    public DataTable SelectDepartamentoAll(int idCliente)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ClienteDepartamentoByID");
        db.AddInParameter(command, "@idCliente", DbType.Int32, idCliente);
        
        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }

    public DataTable SelectSetorAll(int idClienteDepartamento)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ClienteSetorByID");
        db.AddInParameter(command, "@idClienteDepartamento", DbType.Int32, idClienteDepartamento);

        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }

    public void ClienteDepartamentoDelete(int Id)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ClienteDepartamentoDeleteById");
        db.AddInParameter(command, "@Id", DbType.Int32, Id);
        db.ExecuteNonQuery(command);
    }


    public void ClienteSetorDelete(int Id)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ClienteSetorDeleteById");
        db.AddInParameter(command, "@Id", DbType.Int32, Id);
        db.ExecuteNonQuery(command);
    }
    
}
