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
/// Summary description for EncaminhamentoDAL
/// </summary>
public class EncaminhamentoDAL
{
	public EncaminhamentoDAL()
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
    public void InsertUpdate(Encaminhamento ObjEncaminhamento)
    {
        try
        {
            string NomeProc;
            Database db = DatabaseFactory.CreateDatabase();
            Validacoes ObjValidacoes = new Validacoes();
            if (ObjEncaminhamento.id != 0) { NomeProc = "EncaminhamentoUpdate"; } else { NomeProc = "EncaminhamentoInsert"; }
            DbCommand command = db.GetStoredProcCommand(NomeProc);
            //Caso id(chave primaria for diferente de zero(0) então é passado o parametro para fazer o update
            if (ObjEncaminhamento.id != 0) { db.AddInParameter(command, "@ID", DbType.Int32, ObjEncaminhamento.id); }
            //Dados
            db.AddInParameter(command, "@idCliente", DbType.Int32, ObjEncaminhamento.idCliente);
            db.AddInParameter(command, "@idProcessoSeletivo", DbType.String, ObjValidacoes.TextoNull(ObjEncaminhamento.idProcessoSeletivo));
            db.AddInParameter(command, "@idClienteFuncionario", DbType.String, ObjValidacoes.TextoNull(ObjEncaminhamento.idClienteFuncionario));
            db.AddInParameter(command, "@idTipoAtestado", DbType.Int32, ObjEncaminhamento.idTipoAtestado);
            db.AddInParameter(command, "@idProfissional", DbType.Int32, ObjEncaminhamento.idProfissional);
            db.AddInParameter(command, "@DtRealizacao", DbType.DateTime, ObjEncaminhamento.DtRealizacao);
            //Parametros de OutPut Identity.
            //Somente se for Insert
            if (ObjEncaminhamento.id == 0)
            {
                db.AddOutParameter(command, "@id", DbType.Int32, 8); //Retorna o parametro Identity
            }
            //Executa
            db.ExecuteNonQuery(command);
            //Apos o Execute pegamos os parametros de retorno que foram inseridos e chamos a função InsertUsuarioXCliente
            EncaminhamentoXExamesComplementaresDAL Obj = new EncaminhamentoXExamesComplementaresDAL();
            //InsertUsuarioXCliente(ObjUsuario.UsuarioXCliente, Convert.ToInt32(db.GetParameterValue(command, "@id")));
            Obj.InsertEncaminhamentoXExamesComplementares(ObjEncaminhamento.EncaminhamentoXExamesComplementares, Convert.ToInt32(db.GetParameterValue(command, "@id")));
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
    public DataTable SelectAll(string idCliente, string Nome, string CPF, string idTipoAtestado, string TipoEncaminhamento, string DtRealizacao)
    {
        Validacoes ObjValidacoes = new Validacoes();
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("EncaminhamentoSelectAll");
        db.AddInParameter(command, "@idCliente", DbType.String, ObjValidacoes.TextoNull(idCliente));
        db.AddInParameter(command, "@Nome", DbType.String, ObjValidacoes.TextoNull(Nome));
        db.AddInParameter(command, "@CPF", DbType.String, ObjValidacoes.TextoNull(CPF));
        db.AddInParameter(command, "@idTipoAtestado", DbType.String, ObjValidacoes.TextoNull(idTipoAtestado));
        db.AddInParameter(command, "@TipoEncaminhamento", DbType.String, ObjValidacoes.TextoNull(TipoEncaminhamento));
        db.AddInParameter(command, "@DtRealizacao", DbType.String, ObjValidacoes.TextoNull(DtRealizacao));
        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }

    public Encaminhamento SelectVisualizaEncaminhamentoFuncionario(int idEncaminhamento)
    {
        string sql;
        sql = "SELECT Encaminhamento.id, TipoAtestado.Nome AS TipoAtestado, Profissional.Nome AS Medico, Encaminhamento.DtRealizacao " +
                "FROM Encaminhamento INNER JOIN " +
                "TipoAtestado ON Encaminhamento.idTipoAtestado = TipoAtestado.id INNER JOIN " +
                "Profissional ON Encaminhamento.idProfissional = Profissional.id " +
                "WHERE Encaminhamento.id = " + idEncaminhamento;
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand(sql);
        using (IDataReader dr = db.ExecuteReader(command))
        {
            Encaminhamento ObjEcaminhamento = new Encaminhamento();
            if (dr.Read())
            {
                ObjEcaminhamento.id = Convert.ToInt32(dr["id"]);
                ObjEcaminhamento.RefTipoAtestado.Nome = Convert.ToString(dr["TipoAtestado"]);
                ObjEcaminhamento.RefProfissional.Nome = Convert.ToString(dr["Medico"]);
                ObjEcaminhamento.DtRealizacao = Convert.ToDateTime(dr["DtRealizacao"]);
            }
            return ObjEcaminhamento;
        }
    }


    public Encaminhamento SelectVisualizaEncaminhamentoProcessoSeletivo(int idEncaminhamento)
    {
        string sql;
        sql =   "SELECT dbo.Encaminhamento.id, dbo.Cliente.RazaoSocial, dbo.ProcessoSeletivo.Nome AS NomeCandidato, dbo.TipoAtestado.Nome AS TipoAtestado, "+
                "dbo.Profissional.Nome AS Medico, dbo.Encaminhamento.DtRealizacao "+
                "FROM dbo.Encaminhamento INNER JOIN "+
                "dbo.ProcessoSeletivo ON dbo.Encaminhamento.idProcessoSeletivo = dbo.ProcessoSeletivo.id INNER JOIN "+
                "dbo.TipoAtestado ON dbo.Encaminhamento.idTipoAtestado = dbo.TipoAtestado.id INNER JOIN "+
                "dbo.Profissional ON dbo.Encaminhamento.idProfissional = dbo.Profissional.id INNER JOIN "+
                "dbo.Cliente ON dbo.Encaminhamento.idCliente = dbo.Cliente.id "+
                "WHERE Encaminhamento.id = " + idEncaminhamento;
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand(sql);
        using (IDataReader dr = db.ExecuteReader(command))
        {
            Encaminhamento ObjEcaminhamento = new Encaminhamento();
            if (dr.Read())
            {
                ObjEcaminhamento.id = Convert.ToInt32(dr["id"]);
                ObjEcaminhamento.RefCliente.RazaoSocial = Convert.ToString(dr["RazaoSocial"]);
                ObjEcaminhamento.RefProcessoSeletivo.Nome = Convert.ToString(dr["NomeCandidato"]);
                ObjEcaminhamento.RefTipoAtestado.Nome = Convert.ToString(dr["TipoAtestado"]);
                ObjEcaminhamento.RefProfissional.Nome = Convert.ToString(dr["Medico"]);
                ObjEcaminhamento.DtRealizacao = Convert.ToDateTime(dr["DtRealizacao"]);
            }
            return ObjEcaminhamento;
        }

    }

}



