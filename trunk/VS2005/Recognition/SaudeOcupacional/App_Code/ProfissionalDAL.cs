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
/// Summary description for ProfissionalDAL
/// </summary>
public class ProfissionalDAL
{
	public ProfissionalDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    //INSERE UM NOVO REGISTRO OU ATUALIZA UM DETERMINDO REGISTRO JÁ EXISTENTE.
    public void InsertUpdateProfissional(Profissional ObjProfissional)
    {
        try
        {
            string NomeProc;
            Validacoes Valida = new Validacoes();
            Database db = DatabaseFactory.CreateDatabase();
            if (ObjProfissional.id != 0) { NomeProc = "ProfissionalUpdate"; } else { NomeProc = "ProfissionalInsert"; }
            DbCommand command = db.GetStoredProcCommand(NomeProc);

            if (ObjProfissional.id != 0) { db.AddInParameter(command, "@ID", DbType.Int32, ObjProfissional.id); }
            db.AddInParameter(command, "@idTipoProfissional", DbType.String, ObjProfissional.idTipoProfissional);
            db.AddInParameter(command, "@CPF", DbType.String, ObjProfissional.CPF);
            db.AddInParameter(command, "@RG", DbType.String, Valida.TextoNull(ObjProfissional.RG));
            db.AddInParameter(command, "@idOrgaoExpeditor", DbType.Int32, Valida.TextoNull(ObjProfissional.idOrgaoExpeditor));
            db.AddInParameter(command, "@DtExpedicao", DbType.Date, ObjProfissional.DtExpedicao);
            db.AddInParameter(command, "@RgUFemissao", DbType.String, Valida.TextoNull(ObjProfissional.RgUFemissao));
            db.AddInParameter(command, "@Nome", DbType.String, Valida.TextoNull(ObjProfissional.Nome));
            db.AddInParameter(command, "@DtNascimento", DbType.Date, Valida.TextoNull(ObjProfissional.DtNascimento));
            db.AddInParameter(command, "@Sexo", DbType.String, Valida.TextoNull(ObjProfissional.Sexo));
            db.AddInParameter(command, "@Email", DbType.String, Valida.TextoNull(ObjProfissional.Email));
            db.AddInParameter(command, "@EstadoCivil", DbType.String, Valida.TextoNull(ObjProfissional.EstadoCivil));
            db.AddInParameter(command, "@EndResidencia", DbType.String, Valida.TextoNull(ObjProfissional.EndResidencia));
            db.AddInParameter(command, "@Numero", DbType.String, Valida.TextoNull(ObjProfissional.Numero));
            db.AddInParameter(command, "@Complemento", DbType.String, Valida.TextoNull(ObjProfissional.Complemento));
            db.AddInParameter(command, "@Bairro", DbType.String, Valida.TextoNull(ObjProfissional.Bairro));
            db.AddInParameter(command, "@CEP", DbType.String, Valida.TextoNull(ObjProfissional.CEP));
            db.AddInParameter(command, "@Cidade", DbType.String, Valida.TextoNull(ObjProfissional.Cidade));
            db.AddInParameter(command, "@UF", DbType.String, Valida.TextoNull(ObjProfissional.UF));
            db.AddInParameter(command, "@DDDtel", DbType.String, Valida.TextoNull(ObjProfissional.DDDtel));
            db.AddInParameter(command, "@Telefone", DbType.String, Valida.TextoNull(ObjProfissional.Telefone));
            db.AddInParameter(command, "@DDDcel", DbType.String, Valida.TextoNull(ObjProfissional.DDDcel));
            db.AddInParameter(command, "@Celular", DbType.String, Valida.TextoNull(ObjProfissional.Celular));
            db.AddInParameter(command, "@ConselhoProfissional", DbType.String, Valida.TextoNull(ObjProfissional.ConselhoProfissional));
            db.AddInParameter(command, "@ConselhoNumero", DbType.String, Valida.TextoNull(ObjProfissional.ConselhoNumero));
            db.AddInParameter(command, "@ConselhoUF", DbType.String, Valida.TextoNull(ObjProfissional.ConselhoUF));
            db.AddInParameter(command, "@CBOS_1", DbType.String, Valida.TextoNull(ObjProfissional.CBOS_1));
            db.AddInParameter(command, "@CBOS_2", DbType.String, Valida.TextoNull(ObjProfissional.CBOS_2));
            db.AddInParameter(command, "@CBOS_3", DbType.String, Valida.TextoNull(ObjProfissional.CBOS_3));
            db.AddInParameter(command, "@CBOS_4", DbType.String, Valida.TextoNull(ObjProfissional.CBOS_4));
            db.AddInParameter(command, "@CBOS_5", DbType.String, Valida.TextoNull(ObjProfissional.CBOS_5));
            db.AddInParameter(command, "@CBOS_6", DbType.String, Valida.TextoNull(ObjProfissional.CBOS_6));
            db.ExecuteNonQuery(command);
        }
        catch (Exception e)
        {
            throw e;
        }
    }
    //SELECIONA UM DETERMINADO REGISTRO PARA ALTERAÇÃO DE DADOS.
    public object SelectProfissionalByID(int idProfissional)
    {
        try
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetStoredProcCommand("ProfissionalSelectByID");
            db.AddInParameter(command, "@id", DbType.Int32, idProfissional);

            using (IDataReader dr = db.ExecuteReader(command))
            {
                Profissional ObjProfissional = new Profissional();
                if (dr.Read())
                {
                    Validacoes ObjValidacoes = new Validacoes();
                    ObjProfissional.idTipoProfissional = Convert.ToString(dr["idTipoProfissional"]);
                    ObjProfissional.CPF = Convert.ToString(dr["CPF"]);
                    ObjProfissional.RG = Convert.ToString(dr["RG"]);
                    ObjProfissional.idOrgaoExpeditor = Convert.ToString(dr["idOrgaoExpeditor"]);
                    ObjProfissional.DtExpedicao = Convert.ToString(dr["DtExpedicao"]);
                    ObjProfissional.RgUFemissao = Convert.ToString(dr["RgUFemissao"]);
                    ObjProfissional.Nome = Convert.ToString(dr["Nome"]);
                    ObjProfissional.DtNascimento = Convert.ToString(dr["DtNascimento"]);
                    ObjProfissional.Sexo = Convert.ToString(dr["Sexo"]);
                    ObjProfissional.Email = Convert.ToString(dr["Email"]);
                    ObjProfissional.EstadoCivil = Convert.ToString(dr["EstadoCivil"]);
                    ObjProfissional.EndResidencia = Convert.ToString(dr["EndResidencia"]);
                    ObjProfissional.Numero = Convert.ToString(dr["Numero"]);
                    ObjProfissional.Complemento = Convert.ToString(dr["Complemento"]);
                    ObjProfissional.Bairro = Convert.ToString(dr["Bairro"]);
                    ObjProfissional.CEP = Convert.ToString(dr["CEP"]);
                    ObjProfissional.Cidade = Convert.ToString(dr["Cidade"]);
                    ObjProfissional.UF = Convert.ToString(dr["UF"]);
                    ObjProfissional.DDDtel = Convert.ToString(dr["DDDtel"]);
                    ObjProfissional.Telefone = Convert.ToString(dr["Telefone"]);
                    ObjProfissional.DDDcel = Convert.ToString(dr["DDDcel"]);
                    ObjProfissional.Celular = Convert.ToString(dr["Celular"]);
                    ObjProfissional.ConselhoProfissional = ObjValidacoes.TextoNull(Convert.ToString(dr["ConselhoProfissional"]));
                    ObjProfissional.ConselhoNumero = Convert.ToString(dr["ConselhoNumero"]);
                    ObjProfissional.ConselhoUF = Convert.ToString(dr["ConselhoUF"]);
                    ObjProfissional.CBOS_1 = ObjValidacoes.TextoNull(Convert.ToString(dr["CBOS_1"]));
                    ObjProfissional.CBOS_2 = ObjValidacoes.TextoNull(Convert.ToString(dr["CBOS_2"]));
                    ObjProfissional.CBOS_3 = ObjValidacoes.TextoNull(Convert.ToString(dr["CBOS_3"]));
                    ObjProfissional.CBOS_4 = ObjValidacoes.TextoNull(Convert.ToString(dr["CBOS_4"]));
                    ObjProfissional.CBOS_5 = ObjValidacoes.TextoNull(Convert.ToString(dr["CBOS_5"]));
                    ObjProfissional.CBOS_6 = ObjValidacoes.TextoNull(Convert.ToString(dr["CBOS_6"]));
                }
                return ObjProfissional;
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    //FAZ UM SELECT EM TODOS OS REGISTROS NA BASE
    public DataTable SelectAll(string Nome, string CPF, string RG)
    {
        try
        {
            Database db = DatabaseFactory.CreateDatabase();
            Validacoes Valida = new Validacoes();
            DbCommand command = db.GetStoredProcCommand("ProfissionalSelectAll");
            db.AddInParameter(command, "@Nome", DbType.String, Valida.TextoNull(Nome));
            db.AddInParameter(command, "@CPF", DbType.String, Valida.TextoNull(CPF));
            db.AddInParameter(command, "@RG", DbType.String, Valida.TextoNull(RG));
            DataTable dt = new DataTable();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                dt.Load(dr);
            }
            return dt;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    /// <summary>
    /// Usuado para gerar um DropDownList
    /// </summary>
    /// <returns></returns>
    public DataTable DropDownList()
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("SELECT id, Nome FROM Profissional");
        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;

    }
    //APAGA UM DETERMINADO REGISTRO
    public void DeleteProfissional(int id)
    {
        try
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetStoredProcCommand("ProfissionalDelete");
            db.AddInParameter(command, "@id", DbType.Int32, id);
            db.ExecuteNonQuery(command);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}
