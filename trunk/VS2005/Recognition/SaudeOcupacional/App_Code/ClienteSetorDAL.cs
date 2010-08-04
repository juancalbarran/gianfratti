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
/// Summary description for ClienteSetorDAL
/// </summary>
public class ClienteSetorDAL
{
	public ClienteSetorDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    //INSERE UM NOVO REGISTRO OU ATUALIZA UM DETERMINDO REGISTRO JÁ EXISTENTE.
    public void InsertUpdate(ClienteSetor ObjClienteSetor)
    {
        try
        {
            string NomeProc;
            Database db = DatabaseFactory.CreateDatabase();
            Validacoes ObjValidacoes = new Validacoes();
            if (ObjClienteSetor.id != 0) { NomeProc = "ClienteSetorUpdate"; } else { NomeProc = "ClienteSetorInsert"; }
            DbCommand command = db.GetStoredProcCommand(NomeProc);
            //Caso id(chave primaria for diferente de zero(0) então é passado o parametro para fazer o update
            if (ObjClienteSetor.id != 0) { db.AddInParameter(command, "@ID", DbType.Int32, ObjClienteSetor.id); }
            //Dados
            db.AddInParameter(command, "@idClienteDepartamento", DbType.Int32, ObjClienteSetor.idClienteDepartamento);
            db.AddInParameter(command, "@Nome", DbType.String, ObjClienteSetor.Nome);
            //Executa
            db.ExecuteNonQuery(command);
        }
        catch (Exception e)
        {
            throw e;
        }
    }
    //SELECIONA UM DETERMINADO DEPARTAMENTO PARA ALTERAÇÃO DE DADOS.
    public ClienteSetor SelectSetorByID(int id)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select * From ClienteSetor Where id = " + id);
        db.AddInParameter(command, "@id", DbType.Int32, id);

        using (IDataReader dr = db.ExecuteReader(command))
        {
            ClienteSetor ObjClienteSetor = new ClienteSetor();
            if (dr.Read())
            {
                //DADOS
                ObjClienteSetor.id = Convert.ToInt32(dr["id"]);
                ObjClienteSetor.idClienteDepartamento = Convert.ToInt32(dr["idClienteDepartamento"]);
                ObjClienteSetor.Nome = Convert.ToString(dr["Nome"]);
            }
            return ObjClienteSetor;
        }
    }
    //FAZ UM SELECT EM TODOS OS SETORES DE UM DETERMINADO DEPARTAMENTO
    public DataTable SelectSetoresByIdDepartamento(int IdDepartamento)
    {
        try
        {
            if (IdDepartamento != 0)
            {
                Database db = DatabaseFactory.CreateDatabase();
                DbCommand command = db.GetSqlStringCommand("SELECT id, idClienteDepartamento, Nome FROM  ClienteSetor WHERE idClienteDepartamento =" + IdDepartamento);
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
            throw(ex);
        }
    }

    //USADO PARA POPULAR UM DROPDOWNLIST
    public DataTable DropDownList(int idClienteDepartamento)
    {
        try
        {
            if (idClienteDepartamento != 0)
            {
                Database db = DatabaseFactory.CreateDatabase();
                DbCommand command = db.GetSqlStringCommand("Select id,Nome From ClienteSetor Where idClienteDepartamento = " + idClienteDepartamento);

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

    //DELETA UM REGISTRO
    public void Delete(int id)
    {
        try
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("Delete From ClienteSetor WHERE id = " + id);
            db.ExecuteNonQuery(command);
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }
}
