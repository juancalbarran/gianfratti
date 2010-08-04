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
/// Summary description for ClienteFuncionarioProfissionalDAL
/// </summary>
public class ClienteFuncionarioProfissionalDAL
{
	public ClienteFuncionarioProfissionalDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    //INSERE UM NOVO REGISTRO OU ATUALIZA UM DETERMINDO REGISTRO JÁ EXISTENTE.
    public void InsertUpdate(ClienteFuncionarioProfissional ObjClienteFuncionarioProfissional)
    {
        try
        {
            string NomeProc;
            Database db = DatabaseFactory.CreateDatabase();
            Validacoes ObjValidacoes = new Validacoes();
            if (ObjClienteFuncionarioProfissional.id != 0) { NomeProc = "ClienteFuncionarioProfissionalUpdate"; } else { NomeProc = "ClienteFuncionarioProfissionalInsert"; }
            DbCommand command = db.GetStoredProcCommand(NomeProc);
            //Caso id(chave primaria for diferente de zero(0) então é passado o parametro para fazer o update
            if (ObjClienteFuncionarioProfissional.id != 0) { db.AddInParameter(command, "@ID", DbType.Int32, ObjClienteFuncionarioProfissional.id); }
            //Dados do Profissional
            db.AddInParameter(command, "@idFuncionario", DbType.Int32, ObjClienteFuncionarioProfissional.idFuncionario);
            db.AddInParameter(command, "@idDepartamento", DbType.String, ObjClienteFuncionarioProfissional.idDepartamento);
            db.AddInParameter(command, "@idCargo", DbType.String, ObjClienteFuncionarioProfissional.idCargo);
            db.AddInParameter(command, "@idSetor", DbType.String, ObjClienteFuncionarioProfissional.idSetor);
            db.AddInParameter(command, "@idFuncionarioStatus", DbType.Int32, ObjClienteFuncionarioProfissional.idFuncionarioStatus);
            db.AddInParameter(command, "@NumMatricula", DbType.String, ObjClienteFuncionarioProfissional.NumMatricula);
            db.AddInParameter(command, "@DtAdmissao", DbType.Date, ObjValidacoes.TextoNull(ObjClienteFuncionarioProfissional.DtAdmissao));
            db.AddInParameter(command, "@DtDemissao", DbType.Date, ObjValidacoes.TextoNull(ObjClienteFuncionarioProfissional.DtDemissao));
            db.AddInParameter(command, "@Unidade", DbType.String, ObjClienteFuncionarioProfissional.Unidade);
            db.AddInParameter(command, "@Salario", DbType.String, ObjClienteFuncionarioProfissional.Salario);
            db.AddInParameter(command, "@Aposentado", DbType.String, ObjClienteFuncionarioProfissional.Aposentado);
            db.AddInParameter(command, "@CBO", DbType.String, ObjClienteFuncionarioProfissional.CBO);
            db.AddInParameter(command, "@DtPeriodoInicial", DbType.Date, ObjValidacoes.TextoNull(ObjClienteFuncionarioProfissional.DtPeriodoInicial));
            db.AddInParameter(command, "@DtPeriodoFinal", DbType.Date, ObjValidacoes.TextoNull(ObjClienteFuncionarioProfissional.DtPeriodoFinal));
            db.AddInParameter(command, "@DescricaoAtividades", DbType.String, ObjValidacoes.TextoNull(ObjClienteFuncionarioProfissional.DescricaoAtividades));
            db.AddInParameter(command, "@NumCTPS", DbType.String, ObjClienteFuncionarioProfissional.NumCTPS);
            db.AddInParameter(command, "@SerieCTPS", DbType.String, ObjClienteFuncionarioProfissional.SerieCTPS);
            db.AddInParameter(command, "@UFCTPS", DbType.String, ObjClienteFuncionarioProfissional.UFCTPS);
            db.AddInParameter(command, "@FiliacaoPrevidencia", DbType.String, ObjClienteFuncionarioProfissional.FiliacaoPrevidencia);
            db.AddInParameter(command, "@PIS", DbType.String, ObjClienteFuncionarioProfissional.PIS);
            //Executa
            db.ExecuteNonQuery(command);
        }
        catch (Exception e)
        {
            throw e;
        }
    }
    //SELECIONA UM DETERMINADO REGISTRO DO HISTORICO PROFISSIONAL DO FUNCIONARIO PARA ALTERAÇÃO DE DADOS.
    public ClienteFuncionarioProfissional SelectFuncionarioProfissionalByID(int idFuncionarioProfissional)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ClienteFuncionarioProfissionalSelectByID");
        db.AddInParameter(command, "@id", DbType.Int32, idFuncionarioProfissional);

        using (IDataReader dr = db.ExecuteReader(command))
        {
            ClienteFuncionarioProfissional ObjClienteFuncionarioProfissional = new ClienteFuncionarioProfissional();
            Validacoes ObjValidacoes = new Validacoes();

            if (dr.Read())
            {
                //DADOS PROFISSIONAIS
                ObjClienteFuncionarioProfissional.idDepartamento = Convert.ToString(dr["idClienteDepartamento"]);
                ObjClienteFuncionarioProfissional.idSetor = Convert.ToString(dr["idSetor"]);
                ObjClienteFuncionarioProfissional.idCargo = Convert.ToString(dr["idCargo"]);
                ObjClienteFuncionarioProfissional.idFuncionarioStatus = Convert.ToInt32(dr["idFuncionarioStatus"]);
                ObjClienteFuncionarioProfissional.NumMatricula = Convert.ToString(dr["NumMatricula"]);
                ObjClienteFuncionarioProfissional.DtAdmissao = Convert.ToString(dr["DtAdmissao"]).Replace("00:00:00", "");
                ObjClienteFuncionarioProfissional.DtDemissao = Convert.ToString(dr["DtDemissao"]).Replace("00:00:00", "");
                ObjClienteFuncionarioProfissional.Unidade = Convert.ToString(dr["Unidade"]);
                ObjClienteFuncionarioProfissional.Salario = Convert.ToString(dr["Salario"]);
                ObjClienteFuncionarioProfissional.Aposentado = Convert.ToString(dr["Aposentado"]);
                ObjClienteFuncionarioProfissional.CBO = Convert.ToString(dr["CBO"]);
                ObjClienteFuncionarioProfissional.CBO_Funcao = Convert.ToString(dr["CBO_Funcao"]);
                ObjClienteFuncionarioProfissional.DtPeriodoInicial = Convert.ToString(dr["DtPeriodoInicial"]).Replace("00:00:00", "");
                ObjClienteFuncionarioProfissional.DtPeriodoFinal = Convert.ToString(dr["DtPeriodoFinal"]).Replace("00:00:00", "");
                ObjClienteFuncionarioProfissional.DescricaoAtividades = Convert.ToString(dr["DescricaoAtividades"]);
                ObjClienteFuncionarioProfissional.NumCTPS = Convert.ToString(dr["NumCTPS"]);
                ObjClienteFuncionarioProfissional.SerieCTPS = Convert.ToString(dr["SerieCTPS"]);
                ObjClienteFuncionarioProfissional.UFCTPS = Convert.ToString(dr["UFCTPS"]);
                ObjClienteFuncionarioProfissional.FiliacaoPrevidencia = Convert.ToString(dr["FiliacaoPrevidencia"]);
                ObjClienteFuncionarioProfissional.PIS = Convert.ToString(dr["PIS"]);
            }
            return ObjClienteFuncionarioProfissional;
        }
    }
    //FAZ UM SELECT NO HISTORICO PROFISSIONAL DE UM DETERMINADO FUNCIONARIO
    public DataTable SelectFuncionarioHistoricoProfissional(int idFuncionario)
    {
        Database db = DatabaseFactory.CreateDatabase();
        Validacoes Valida = new Validacoes();
        DbCommand command = db.GetStoredProcCommand("ClienteFuncionarioHistoricoProfissional");
        db.AddInParameter(command, "@idFuncionario", DbType.Int32, idFuncionario);
        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }
    //APAGA UM DETERMINADO REGISTRO DA BASE
    public void DeleteClienteFuncionarioProfissional(int id)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ClienteFuncionarioProfissionalDelete");
        db.AddInParameter(command, "@id", DbType.Int32, id);
        db.ExecuteNonQuery(command);
    }
}
