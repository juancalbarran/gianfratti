using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.Sql;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using System.Collections.Generic;

/// <summary>
/// Summary description for ProcessoSeletivoDAL
/// </summary>
public class ProcessoSeletivoDAL
{
	public ProcessoSeletivoDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    /// <summary>
    /// INSERE UM NOVO REGISTRO OU ATUALIZA UM DETERMINDO REGISTRO JÁ EXISTENTE.
    /// EXEMPLO:
    /// PARA INSERT BASTA PASSAR O ID DA TEBELA COMO ZERO(0)
    /// PARA UPDATE BASTA PASSAR O ID DA TABELA DIFERENTE DE ZERO(0)
    /// </summary>
    /// <param name="ObjUsuario"></param>
    public void InsertUpdate(ProcessoSeletivo ObjProcessoSeletivo)
    {
        try
        {
            string NomeProc;
            Database db = DatabaseFactory.CreateDatabase();
            Validacoes ObjValidacoes = new Validacoes();
            if (ObjProcessoSeletivo.id != 0) { NomeProc = "ProcessoSeletivoUpdate"; } else { NomeProc = "ProcessoSeletivoInsert"; }
            DbCommand command = db.GetStoredProcCommand(NomeProc);
            //Caso id(chave primaria for diferente de zero(0) então é passado o parametro para fazer o update
            if (ObjProcessoSeletivo.id != 0) { db.AddInParameter(command, "@ID", DbType.Int32, ObjProcessoSeletivo.id); }
            //Dados
            db.AddInParameter(command, "@idCliente", DbType.Int32, ObjProcessoSeletivo.idCliente);
            db.AddInParameter(command, "@idSetor", DbType.Int32, ObjProcessoSeletivo.IdSetor);
            db.AddInParameter(command, "@idDepartamento", DbType.Int32, ObjProcessoSeletivo.IdDepartamento);
            db.AddInParameter(command, "@idProcessoSeletivoStatus", DbType.Int32, ObjProcessoSeletivo.IdProcessoSeletivoStatus);
            db.AddInParameter(command, "@Nome", DbType.String, ObjValidacoes.TextoNull(ObjProcessoSeletivo.Nome));
            db.AddInParameter(command, "@CPF", DbType.String, ObjValidacoes.TextoNull(ObjProcessoSeletivo.CPF));
            db.AddInParameter(command, "@DtNascimento", DbType.DateTime, ObjValidacoes.TextoNull(ObjProcessoSeletivo.DtNascimento));
            db.AddInParameter(command, "@Sexo", DbType.String, ObjValidacoes.TextoNull(ObjProcessoSeletivo.Sexo));
            db.AddInParameter(command, "@Funcao", DbType.String, ObjValidacoes.TextoNull(ObjProcessoSeletivo.Funcao));
            //Executa
            db.ExecuteNonQuery(command);
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    /// <summary>
    /// Retorna um DataTable com todos os usuarios.
    /// Pode-se fazer um filtro conforme parametros.
    /// </summary>
    /// <returns></returns>
    public DataTable SelectAll(string idCliente, string Nome,string CPF, string idProcessoSeletivoStatus)
    {
        Validacoes ObjValidacoes = new Validacoes();
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ProcessoSeletivoSelectAll");
        db.AddInParameter(command, "@idCliente", DbType.String, ObjValidacoes.TextoNull(idCliente));
        db.AddInParameter(command, "@Nome", DbType.String, ObjValidacoes.TextoNull(Nome));
        db.AddInParameter(command, "@CPF", DbType.String, ObjValidacoes.TextoNull(CPF));
        db.AddInParameter(command, "@idProcessoSeletivoStatus", DbType.String, ObjValidacoes.TextoNull(idProcessoSeletivoStatus));
        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }

    /// <summary>
    /// Seleciona um determinado registro conformo o ID
    /// </summary>
    /// <param name="idProcessoSeletivo"></param>
    /// <returns></returns>
    public ProcessoSeletivo SelectByID(int idProcessoSeletivo)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ProcessoSeletivoSelectByID");
        db.AddInParameter(command, "@id", DbType.Int32, idProcessoSeletivo);

        using (IDataReader dr = db.ExecuteReader(command))
        {
            ProcessoSeletivo ObjProcessoSeletivo = new ProcessoSeletivo();
            if (dr.Read())
            {
                ObjProcessoSeletivo.id = Convert.ToInt32(dr["id"]);
                ObjProcessoSeletivo.idCliente = Convert.ToInt32(dr["idCliente"]);
                ObjProcessoSeletivo.IdSetor = Convert.ToInt32(dr["IdSetor"]);
                ObjProcessoSeletivo.IdDepartamento = Convert.ToInt32(dr["IdDepartamento"]);
                ObjProcessoSeletivo.IdProcessoSeletivoStatus = Convert.ToInt32(dr["IdProcessoSeletivoStatus"]);
                ObjProcessoSeletivo.Nome = Convert.ToString(dr["Nome"]);
                ObjProcessoSeletivo.CPF = Convert.ToString(dr["CPF"]);
                ObjProcessoSeletivo.DtNascimento = Convert.ToString(dr["DtNascimento"]).Replace("00:00:00", "");
                ObjProcessoSeletivo.Sexo = Convert.ToString(dr["Sexo"]);
                ObjProcessoSeletivo.Funcao = Convert.ToString(dr["Funcao"]);
            }
            return ObjProcessoSeletivo;
        }
    }
    /// <summary>
    /// Retorna um DataTable
    /// </summary>
    /// <returns></returns>
    public DataTable DropDownList(int idCliente)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("SELECT id, idCliente, Nome FROM ProcessoSeletivo Where idProcessoSeletivoStatus = 1 and  idCliente= " + idCliente);

        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }
    /// <summary>
    /// Deletar um registro
    /// </summary>
    /// <param name="id"></param>
    public void Delete(int id)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Delete From ProcessoSeletivo Where id = " + id);
        db.ExecuteNonQuery(command);
    }
}
