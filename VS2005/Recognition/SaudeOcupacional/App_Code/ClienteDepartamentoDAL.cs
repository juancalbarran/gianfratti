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
/// Summary description for ClienteDepartamentoDAL
/// </summary>
public class ClienteDepartamentoDAL
{
    /// <summary>
    /// INSERE UM NOVO REGISTRO OU ATUALIZA UM DETERMINDO REGISTRO JÁ EXISTENTE.
    /// EXEMPLO:
    /// PARA INSERT BASTA PASSAR O ID DA TEBELA COMO ZERO(0)
    /// PARA UPDATE BASTA PASSAR O ID DA TABELA DIFERENTE DE ZERO(0)
    /// </summary>
    /// <param name="ObjClienteDepartamento"></param>
    public void InsertUpdate(ClienteDepartamento ObjClienteDepartamento)
    {
        try
        {
            string NomeProc;
            Database db = DatabaseFactory.CreateDatabase();
            Validacoes ObjValidacoes = new Validacoes();
            if (ObjClienteDepartamento.id != 0) { NomeProc = "ClienteDepartamentoUpdate"; } else { NomeProc = "ClienteDepartamentoInsert"; }
            DbCommand command = db.GetStoredProcCommand(NomeProc);
            //Caso id(chave primaria for diferente de zero(0) então é passado o parametro para fazer o update
            if (ObjClienteDepartamento.id != 0) { db.AddInParameter(command, "@ID", DbType.Int32, ObjClienteDepartamento.id); }
            //Dados
            db.AddInParameter(command, "@idCliente", DbType.Int32, ObjClienteDepartamento.IdCliente);
            db.AddInParameter(command, "@Nome", DbType.String, ObjClienteDepartamento.Nome);
            //Executa
            db.ExecuteNonQuery(command);
        }
        catch (Exception e)
        {
            throw e;
        }
    }
    /// <summary>
    /// Seleciona um determinado registro conformo o ID
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    public ClienteDepartamento SelectDepartamentoByID(int id)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select * From ClienteDepartamento Where id = " + id);
        db.AddInParameter(command, "@id", DbType.Int32, id);

        using (IDataReader dr = db.ExecuteReader(command))
        {
            ClienteDepartamento ObjClienteDepartamento = new ClienteDepartamento();
            if (dr.Read())
            {
                //DADOS
                ObjClienteDepartamento.id = Convert.ToInt32(dr["id"]);
                ObjClienteDepartamento.IdCliente = Convert.ToInt32(dr["IdCliente"]);
                ObjClienteDepartamento.Nome = Convert.ToString(dr["Nome"]);
            }
            return ObjClienteDepartamento;
        }
    }
    /// <summary>
    /// Seleciona um determinado registro conformo o ID do Cliente
    /// </summary>
    /// <param name="idCliente"></param>
    /// <returns></returns>
    public DataTable SelectDepartamentosByIdCliente(int idCliente)
    {
        try
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT id, idCliente, Nome FROM  ClienteDepartamento WHERE idCliente =" + idCliente);
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
    /// <summary>
    /// Usado para gerar um DropDownList
    /// </summary>
    /// <param name="idCliente"></param>
    /// <returns></returns>
    public DataTable DropDownList(int idCliente)
    {
        try
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("Select id,Nome From ClienteDepartamento Where idCliente = " + idCliente);

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
    /// <summary>
    /// Deletar um registro
    /// </summary>
    /// <param name="id"></param>
    public void Delete(int id)
    {
        try
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("Delete From ClienteDepartamento WHERE id = " + id);
            db.ExecuteNonQuery(command);
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }

}
