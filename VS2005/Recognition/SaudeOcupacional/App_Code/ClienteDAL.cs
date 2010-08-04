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
/// Summary description for ClienteDAL
/// </summary>
public class ClienteDAL
{
    //MENBROS DA CLASSE
    Cliente ObjCliente;

    /// <summary>
    /// INSERE UM NOVO REGISTRO OU ATUALIZA UM DETERMINDO REGISTRO JÁ EXISTENTE.
    /// EXEMPLO:
    /// PARA INSERT BASTA PASSAR O ID DA TEBELA COMO ZERO(0)
    /// PARA UPDATE BASTA PASSAR O ID DA TABELA DIFERENTE DE ZERO(0)
    /// </summary>
    /// <param name="ObjUsuario"></param>
    public void InsertUpdate(Cliente ObjCliente, out string idCliente)
    {
        try
        {
            string NomeProc;
            Database db = DatabaseFactory.CreateDatabase();
            Validacoes ObjValidacoes = new Validacoes();
            if (ObjCliente.id != 0) { NomeProc = "ClienteUpdate"; } else { NomeProc = "ClienteInsert"; }
            DbCommand command = db.GetStoredProcCommand(NomeProc);
            //Caso id(chave primaria for diferente de zero(0) então é passado o parametro para fazer o update
            if (ObjCliente.id != 0) { db.AddInParameter(command, "@ID", DbType.Int32, ObjCliente.id); }
            //Dados
            db.AddInParameter(command, "@idTipoIdentificacao", DbType.Int32, ObjCliente.idTipoIdentificacao);
            db.AddInParameter(command, "@idProfissional", DbType.Int32, ObjValidacoes.TextoNull(ObjCliente.idProfissional));
            db.AddInParameter(command, "@idProfissional1", DbType.Int32, ObjValidacoes.TextoNull(ObjCliente.idProfissional1));
            db.AddInParameter(command, "@idProfissional2", DbType.Int32, ObjValidacoes.TextoNull(ObjCliente.idProfissional2));
            db.AddInParameter(command, "@idProfissional3", DbType.Int32, ObjValidacoes.TextoNull(ObjCliente.idProfissional3));
            db.AddInParameter(command, "@CNPJ_INCRA_CPF", DbType.String, ObjCliente.CNPJ_INCRA_CPF.Replace(".", String.Empty).Replace("-", String.Empty).Replace("/", String.Empty));
            db.AddInParameter(command, "@InscEstadual", DbType.String, ObjCliente.InscEstadual);
            db.AddInParameter(command, "@RazaoSocial", DbType.String, ObjCliente.RazaoSocial);
            db.AddInParameter(command, "@Endereco", DbType.String, ObjCliente.Endereco);
            db.AddInParameter(command, "@Bairro", DbType.String, ObjCliente.Bairro);
            db.AddInParameter(command, "@CEP", DbType.String, ObjCliente.CEP);
            db.AddInParameter(command, "@Cidade", DbType.String, ObjCliente.Cidade);
            db.AddInParameter(command, "@UF", DbType.String, ObjCliente.UF);
            db.AddInParameter(command, "@CNAE", DbType.String, ObjCliente.CNAE);
            db.AddInParameter(command, "@GFIP", DbType.String, ObjCliente.GFIP);
            db.AddInParameter(command, "@DDDtel", DbType.String, ObjCliente.DDDtel);
            db.AddInParameter(command, "@Telefone", DbType.String, ObjCliente.Telefone.Replace(".", String.Empty).Replace("-", String.Empty).Replace(" ", String.Empty));
            db.AddInParameter(command, "@DDDfax", DbType.String, ObjCliente.DDDfax);
            db.AddInParameter(command, "@Fax", DbType.String, ObjCliente.Fax.Replace(".", String.Empty).Replace("-", String.Empty).Replace(" ", String.Empty));
            db.AddInParameter(command, "@Contato", DbType.String, ObjCliente.Contato);
            db.AddInParameter(command, "@Email", DbType.String, ObjCliente.Email);
            //Parametros de OutPut Identity.
            //Somente se for Insert
            if (ObjCliente.id == 0)
            {
                db.AddOutParameter(command, "@id", DbType.Int32, 8); //Retorna o parametro Identity
            }
            //Executa
            db.ExecuteNonQuery(command);
            //Apos o Execute pegamos os parametros de retorno que foram inseridos
            idCliente = Convert.ToString(db.GetParameterValue(command, "@id"));
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
    public DataTable SelectAll(string CNPJ, string RazaoSocial, string Contato)
    {
        Validacoes ObjValidacoes = new Validacoes();
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ClienteSelectAll");
        db.AddInParameter(command, "@CNPJ_INCRA_CPF", DbType.String, ObjValidacoes.TextoNull(CNPJ));
        db.AddInParameter(command, "@RazaoSocial", DbType.String, ObjValidacoes.TextoNull(RazaoSocial));
        db.AddInParameter(command, "@Contato", DbType.String, ObjValidacoes.TextoNull(Contato));
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
    /// <param name="idUsuario"></param>
    /// <returns></returns>
    public Cliente SelectByID(int idCliente)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ClienteSelectByID");
        db.AddInParameter(command, "@id", DbType.Int32, idCliente);

        using (IDataReader dr = db.ExecuteReader(command))
        {
            ObjCliente = new Cliente();
            if (dr.Read())
            {
                ObjCliente.idTipoIdentificacao = Convert.ToInt32(dr["idTipoIdentificacao"]);
                ObjCliente.idProfissional = Convert.ToString(dr["idProfissional"]);
                ObjCliente.idProfissional1 = Convert.ToString(dr["idProfissional1"]);
                ObjCliente.idProfissional2 = Convert.ToString(dr["idProfissional2"]);
                ObjCliente.idProfissional3 = Convert.ToString(dr["idProfissional3"]);
                ObjCliente.CNPJ_INCRA_CPF = Convert.ToString(dr["CNPJ_INCRA_CPF"]);
                ObjCliente.InscEstadual = Convert.ToString(dr["inscEstadual"]);
                ObjCliente.RazaoSocial = Convert.ToString(dr["RazaoSocial"]);
                ObjCliente.Endereco = Convert.ToString(dr["Endereco"]);
                ObjCliente.Bairro = Convert.ToString(dr["Bairro"]);
                ObjCliente.CEP = Convert.ToString(dr["CEP"]);
                ObjCliente.Cidade = Convert.ToString(dr["Cidade"]);
                ObjCliente.UF = Convert.ToString(dr["UF"]);
                ObjCliente.CNAE = Convert.ToString(dr["CNAE"]);
                ObjCliente.Denominacao = Convert.ToString(dr["Descricao"]);
                ObjCliente.Risco = Convert.ToString(dr["Grau_Risco"]);
                ObjCliente.GFIP = Convert.ToString(dr["GFIP"]);
                ObjCliente.DDDtel = Convert.ToString(dr["DDDtel"]);
                ObjCliente.Telefone = Convert.ToString(dr["Telefone"]);
                ObjCliente.DDDfax = Convert.ToString(dr["DDDfax"]);
                ObjCliente.Fax = Convert.ToString(dr["Fax"]);
                ObjCliente.Contato = Convert.ToString(dr["Contato"]);
                ObjCliente.Email = Convert.ToString(dr["Email"]);
            }
            return ObjCliente;
        }
    }

    public Cliente DadosBasicos(int idCliente)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ClienteDadosBasicosSelectById");
        db.AddInParameter(command, "@id", DbType.Int32, idCliente);

        using (IDataReader dr = db.ExecuteReader(command))
        {
            ObjCliente = new Cliente();
            if (dr.Read())
            {
                ObjCliente.RazaoSocial = Convert.ToString(dr["RazaoSocial"]);
                ObjCliente.RefProfissional.Nome = Convert.ToString(dr["Nome"]);
                ObjCliente.CNPJ_INCRA_CPF = Convert.ToString(dr["CNPJ_INCRA_CPF"]);
            }
            return ObjCliente;
        }
    }

    /// <summary>
    /// Retorna um DataTable
    /// </summary>
    /// <returns></returns>
    public DataTable DropDownList(int idUsuario, int idPerfil)
    {
        string SQL;
        string Clausula;
        //string And;

        SQL = "SELECT Distinct dbo.Cliente.id ,  dbo.Cliente.RazaoSocial FROM dbo.Cliente FULL OUTER JOIN  dbo.UsuarioXCliente ON dbo.Cliente.id = dbo.UsuarioXCliente.idCliente ";
        Clausula = "Where ";
        if (idPerfil == 2 || idPerfil == 3)
        {
            SQL = SQL + Clausula + " dbo.UsuarioXCliente.idUsuario = '" + idUsuario +"' ";
        }

        Validacoes Valida = new Validacoes();
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand(SQL);

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
        DbCommand command = db.GetStoredProcCommand("ClienteDelete");
        db.AddInParameter(command, "@id", DbType.Int32, id);
        db.ExecuteNonQuery(command);
    }
}
