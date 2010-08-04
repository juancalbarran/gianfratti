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
/// Summary description for ClienteFuncionarioDAL
/// </summary>
public class ClienteFuncionarioDAL
{
    //MENBROS DA CLASSE
    ClienteFuncionario ObjClienteFuncionario;

    public ClienteFuncionarioDAL()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    //INSERE UM NOVO REGISTRO OU ATUALIZA UM DETERMINDO REGISTRO JÁ EXISTENTE.
    public void InsertUpdate(ClienteFuncionario ObjClienteFuncionario, out string idFuncionario, out string idCliente)
    {
        try
        {
            string NomeProc;
            Database db = DatabaseFactory.CreateDatabase();
            Validacoes ObjValidacoes = new Validacoes();
            if (ObjClienteFuncionario.id != 0) { NomeProc = "ClienteFuncionarioUpdate"; } else { NomeProc = "ClienteFuncionarioInsert"; }
            DbCommand command = db.GetStoredProcCommand(NomeProc);
            //Caso id(chave primaria for diferente de zero(0) então é passado o parametro para fazer o update
            if (ObjClienteFuncionario.id != 0) { db.AddInParameter(command, "@ID", DbType.Int32, ObjClienteFuncionario.id); }
            //Dados do Profissional
            db.AddInParameter(command, "@idCliente", DbType.Int32, ObjClienteFuncionario.idCliente);
            db.AddInParameter(command, "@CPF", DbType.String, ObjClienteFuncionario.CPF);
            db.AddInParameter(command, "@RG", DbType.String, ObjClienteFuncionario.RG);
            db.AddInParameter(command, "@idOrgaoExpeditor", DbType.String, ObjClienteFuncionario.idOrgaoExpeditor);
            db.AddInParameter(command, "@DtExpedicao", DbType.Date, ObjValidacoes.TextoNull(ObjClienteFuncionario.DtExpedicao));
            db.AddInParameter(command, "@RgUFemissao", DbType.String, ObjValidacoes.TextoNull(ObjClienteFuncionario.RgUFemissao));
            db.AddInParameter(command, "@Nome", DbType.String, ObjClienteFuncionario.Nome);
            db.AddInParameter(command, "@DtNascimento", DbType.Date, ObjValidacoes.TextoNull(ObjClienteFuncionario.DtNascimento));
            db.AddInParameter(command, "@DtObito", DbType.Date, ObjValidacoes.TextoNull(ObjClienteFuncionario.DtObito));
            db.AddInParameter(command, "@Sexo", DbType.String, ObjClienteFuncionario.Sexo);
            db.AddInParameter(command, "@EstadoCivil", DbType.String, ObjClienteFuncionario.EstadoCivil);
            db.AddInParameter(command, "@Mae", DbType.String, ObjClienteFuncionario.Mae);
            db.AddInParameter(command, "@EndResidencia", DbType.String, ObjClienteFuncionario.EndResidencia);
            db.AddInParameter(command, "@Numero", DbType.String, ObjClienteFuncionario.Numero);
            db.AddInParameter(command, "@Complemento", DbType.String, ObjClienteFuncionario.Complemento);
            db.AddInParameter(command, "@Bairro", DbType.String, ObjClienteFuncionario.Bairro);
            db.AddInParameter(command, "@CEP", DbType.String, ObjClienteFuncionario.CEP);
            db.AddInParameter(command, "@Cidade", DbType.String, ObjClienteFuncionario.Cidade);
            db.AddInParameter(command, "@UF", DbType.String, ObjClienteFuncionario.UF);
            db.AddInParameter(command, "@DDDtel", DbType.String, ObjClienteFuncionario.DDDtel);
            db.AddInParameter(command, "@Telefone", DbType.String, ObjClienteFuncionario.Telefone);
            db.AddInParameter(command, "@DDDcel", DbType.String, ObjClienteFuncionario.DDDcel);
            db.AddInParameter(command, "@Celular", DbType.String, ObjClienteFuncionario.Celular);
            db.AddInParameter(command, "@DDDcontato", DbType.String, ObjClienteFuncionario.DDDcontato);
            db.AddInParameter(command, "@TelefoneContato", DbType.String, ObjClienteFuncionario.TelefoneContato);
            db.AddInParameter(command, "@ContatoNome", DbType.String, ObjClienteFuncionario.ContatoNome);
            //Parametros de OutPut Identity.
            //Somente se for Insert
            if (ObjClienteFuncionario.id == 0)
            {
                db.AddOutParameter(command, "@id", DbType.Int32, 8); //Retorna o parametro Identity
            }
            //Executa
            db.ExecuteNonQuery(command);
            //Apos o Execute pegamos os parametros de retorno que foram inseridos
            idFuncionario = Convert.ToString(db.GetParameterValue(command, "@id"));
            idCliente = Convert.ToString(db.GetParameterValue(command, "@idCliente"));
        }
        catch (Exception e)
        {
            throw e;
        }
    }
    //FAZ UM SELECT EM TODOS OS REGISTROS NA BASE
    public DataTable SelectAll(string idCliente, string CPF, string RG, string Nome, string Mae, string idFuncionarioStatus)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ClienteFuncionarioSelectAll");
        db.AddInParameter(command, "@idCliente", DbType.String, idCliente);
        db.AddInParameter(command, "@CPF", DbType.String, CPF);
        db.AddInParameter(command, "@RG", DbType.String, RG);
        db.AddInParameter(command, "@Nome", DbType.String, Nome);
        db.AddInParameter(command, "@Mae", DbType.String, Mae);
        db.AddInParameter(command, "@idFuncionarioStatus", DbType.Int32, idFuncionarioStatus);
        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }
    //SELECIONA UM DETERMINADO FUNCIONARIO PARA ALTERAÇÃO DE DADOS.
    public object SelectFuncionarioByID(int idFuncionario)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ClienteFuncionarioSelectByID");
        db.AddInParameter(command, "@id", DbType.Int32, idFuncionario);

        using (IDataReader dr = db.ExecuteReader(command))
        {
            ObjClienteFuncionario = new ClienteFuncionario();
            if (dr.Read())
            {
                //DADOS PESSOAIS
                ObjClienteFuncionario.idCliente = Convert.ToInt32(dr["idCliente"]);
                ObjClienteFuncionario.CPF = Convert.ToString(dr["CPF"]);
                ObjClienteFuncionario.RG = Convert.ToString(dr["RG"]);
                ObjClienteFuncionario.idOrgaoExpeditor = Convert.ToString(dr["idOrgaoExpeditor"]);
                ObjClienteFuncionario.DtExpedicao = Convert.ToString(dr["DtExpedicao"]);
                ObjClienteFuncionario.RgUFemissao = Convert.ToString(dr["RgUFemissao"]);
                ObjClienteFuncionario.Nome = Convert.ToString(dr["Nome"]);
                ObjClienteFuncionario.DtNascimento = Convert.ToString(dr["DtNascimento"]);
                ObjClienteFuncionario.DtObito = Convert.ToString(dr["DtObito"]);
                ObjClienteFuncionario.Sexo = Convert.ToString(dr["Sexo"]);
                ObjClienteFuncionario.EstadoCivil = Convert.ToString(dr["EstadoCivil"]);
                ObjClienteFuncionario.Mae = Convert.ToString(dr["Mae"]);
                ObjClienteFuncionario.EndResidencia = Convert.ToString(dr["EndResidencia"]);
                ObjClienteFuncionario.Numero = Convert.ToString(dr["Numero"]);
                ObjClienteFuncionario.Complemento = Convert.ToString(dr["Complemento"]);
                ObjClienteFuncionario.CEP = Convert.ToString(dr["CEP"]);
                ObjClienteFuncionario.Cidade = Convert.ToString(dr["Cidade"]);
                ObjClienteFuncionario.UF = Convert.ToString(dr["UF"]);
                ObjClienteFuncionario.Bairro = Convert.ToString(dr["Bairro"]);
                ObjClienteFuncionario.UF = Convert.ToString(dr["UF"]);
                ObjClienteFuncionario.DDDtel = Convert.ToString(dr["DDDtel"]);
                ObjClienteFuncionario.Telefone = Convert.ToString(dr["Telefone"]);
                ObjClienteFuncionario.DDDcel = Convert.ToString(dr["Celular"]);
                ObjClienteFuncionario.Celular = Convert.ToString(dr["Celular"]);
                ObjClienteFuncionario.DDDcontato = Convert.ToString(dr["DDDcontato"]);
                ObjClienteFuncionario.TelefoneContato = Convert.ToString(dr["TelefoneContato"]);
                ObjClienteFuncionario.ContatoNome = Convert.ToString(dr["ContatoNome"]);
            }
            return ObjClienteFuncionario;
        }
    }

    public ClienteFuncionario SelectRetonarIdFuncionarioByCpf(string CPF)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select id,idCliente From ClienteFuncionario Where CPF = '" + CPF + "' ");

        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            ObjClienteFuncionario = new ClienteFuncionario();
            if (dr.Read())
            {
                ObjClienteFuncionario.id = Convert.ToInt32(dr["ID"]);
                ObjClienteFuncionario.idCliente = Convert.ToInt32(dr["idCliente"]);
            }
            return ObjClienteFuncionario;
        }
    }

    /// <summary>
    /// Verifica se o CPF preenchido já esta cadastrado para um determinado cliente
    /// </summary>
    /// <param name="idCliente"></param>
    /// <param name="CPF"></param>
    /// <returns></returns>
    public bool VerificaDuplicidadeCPF(int idCliente, string CPF)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select idCliente, CPF From ClienteFuncionario Where idCliente = '" + idCliente + "' and CPF = '" + CPF + "' ");

        using (IDataReader dr = db.ExecuteReader(command))
        {
            if (dr.Read())
            {
                return false;
            }
            return true;
        }
    }

    //USADO PARA POPULAR UM DROPDOWNLIST
    public DataTable FuncionarioStatusDropDownList()
    {
        Validacoes Valida = new Validacoes();
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select id,Status From ClienteFuncionarioStatus");

        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }
    //USADO PARA POPULAR UM DROPDOWNLIST
    public DataTable TipoOrgaoExpeditorDropDownList()
    {
        Validacoes Valida = new Validacoes();
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select id,Sigla + ' ' + Descricao as Descricao  From TipoOrgaoExpeditor");

        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }
    //APAGA UM DETERMINADO REGISTRO DA BASE
    public void DeleteClienteFuncionario(int id)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ClienteFuncionarioDelete");
        db.AddInParameter(command, "@id", DbType.Int32, id);
        db.ExecuteNonQuery(command);
    }
}
