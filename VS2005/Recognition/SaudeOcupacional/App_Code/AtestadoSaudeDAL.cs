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
/// Summary description for AtestadoSaudeDAL
/// </summary>
public class AtestadoSaudeDAL
{
	public AtestadoSaudeDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    //INSERE UM NOVO REGISTRO
    public void InsertAtestado(AtestadoSaude ObjAtestadoSaude)
    {
        try
        {
            Validacoes Valida = new Validacoes();
            //ObjAtestadoSaude = new AtestadoSaude();
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetStoredProcCommand("AtestadoSaudeInsert");
            db.AddInParameter(command, "@idProfissional_MedicoCoordenador", DbType.Int32, ObjAtestadoSaude.idProfissional_MedicoCoordenador);
            db.AddInParameter(command, "@idProfissional_MedicoExaminador", DbType.Int32, ObjAtestadoSaude.idProfissional_MedicoExaminador);
            db.AddInParameter(command, "@idTipoAtestado", DbType.Int32, ObjAtestadoSaude.idTipoAtestado);
            db.AddInParameter(command, "@idClienteFuncionario", DbType.Int32, ObjAtestadoSaude.idClienteFuncionario);
            db.AddInParameter(command, "@idStatusAtestado", DbType.Int32, ObjAtestadoSaude.idStatusAtestado);
            db.AddInParameter(command, "@DataConsulta", DbType.Date, ObjAtestadoSaude.DataConsulta);
            db.AddInParameter(command, "@Observacoes", DbType.String, ObjAtestadoSaude.Observacoes);
            db.AddInParameter(command, "@Pendencia", DbType.String, ObjAtestadoSaude.Pendencia);
            db.ExecuteNonQuery(command);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    //FAZ UM SELECT EM TODOS OS REGISTROS NA BASE
    public DataTable SelectAll(string idCliente, string Nome, string CPF, string RG)
    {
        Database db = DatabaseFactory.CreateDatabase();
        Validacoes Valida = new Validacoes();
        DbCommand command = db.GetStoredProcCommand("AtestadoSaudeSelectAll");
        db.AddInParameter(command, "@idCliente", DbType.String, idCliente);
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
    //FAZ UM SELECT EM TODOS OS ATESTADOS DE UM DETERMINADO FUNCIONARIO
    public DataTable SelectHistoricoAtestadoSaude(Int32 idFuncionario)
    {
        string SQL;
        SQL = "SELECT dbo.AtestadoSaude.id, dbo.ClienteFuncionario.Nome, dbo.TipoAtestado.Nome AS TipoAtestado, dbo.StatusAtestado.Nome AS StatusAtestado,dbo.AtestadoSaude.DataConsulta " +
                "FROM dbo.ClienteFuncionario RIGHT OUTER JOIN " +
                "dbo.AtestadoSaude LEFT OUTER JOIN " +
                "dbo.StatusAtestado ON dbo.AtestadoSaude.idStatusAtestado = dbo.StatusAtestado.id ON " +
                "dbo.ClienteFuncionario.id = dbo.AtestadoSaude.idClienteFuncionario LEFT OUTER JOIN " +
                "dbo.TipoAtestado ON dbo.AtestadoSaude.idTipoAtestado = dbo.TipoAtestado.id " +
                "WHERE dbo.AtestadoSaude.idClienteFuncionario = " + idFuncionario;
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand(SQL);
        db.AddInParameter(command, "@idFuncionario", DbType.Int32, Convert.ToInt32(idFuncionario));
        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }
    //CARREGA OS DADOS DE UM DETERMINADO FUNCIONARIO
    public ClienteFuncionario CarregaDadosFuncionario(int idFuncionario)
    {
        Database db = DatabaseFactory.CreateDatabase();
        String SQL;
        SQL =   "SELECT ClienteFuncionario.RG, ClienteFuncionario.Nome, Cliente.RazaoSocial, ClienteFuncionarioProfissional.CBO, CBO_Ocupacao.FUNCAO, " +
                "Profissional.Nome AS MedicoCoordenador, Profissional.ConselhoNumero, Profissional.ConselhoUF, Profissional.id AS idProfissional, " +
                "CNAE.Grau_Risco " +
                "FROM Profissional RIGHT OUTER JOIN " +
                "ClienteFuncionario INNER JOIN " +
                "Cliente ON ClienteFuncionario.idCliente = Cliente.id LEFT OUTER JOIN " +
                "CNAE ON Cliente.CNAE = CNAE.SubClasse ON Profissional.id = Cliente.idProfissional LEFT OUTER JOIN " +
                "ClienteFuncionarioProfissional LEFT OUTER JOIN " +
                "CBO_Ocupacao ON ClienteFuncionarioProfissional.CBO = CBO_Ocupacao.Cod_Familia + CBO_Ocupacao.Cod_Ocup ON  " +
                "ClienteFuncionario.id = ClienteFuncionarioProfissional.idFuncionario " +
                "Where ClienteFuncionario.id = " + idFuncionario;
        DbCommand command = db.GetSqlStringCommand(SQL);
        using (IDataReader dr = db.ExecuteReader(command))
        {
            ClienteFuncionario ObjClienteFuncionario = new ClienteFuncionario();
            if (dr.Read())
            {
                ObjClienteFuncionario.RefClienteFuncionarioProfissional.id = Convert.ToInt32(dr["idProfissional"]);
                ObjClienteFuncionario.Nome = Convert.ToString(dr["Nome"]);
                ObjClienteFuncionario.RG = Convert.ToString(dr["RG"]);
                ObjClienteFuncionario.RefClienteFuncionarioProfissional.CBO = Convert.ToString(dr["CBO"]);
                ObjClienteFuncionario.RefCliente.RazaoSocial = Convert.ToString(dr["RazaoSocial"]);
                ObjClienteFuncionario.RefCliente.Risco = Convert.ToString(dr["Grau_Risco"]);
                ObjClienteFuncionario.RefClienteFuncionarioProfissional.RefCBO.FUNCAO = Convert.ToString(dr["Funcao"]);
                ObjClienteFuncionario.RefCliente.RefProfissional.Nome = Convert.ToString(dr["MedicoCoordenador"]);
                ObjClienteFuncionario.RefCliente.RefProfissional.ConselhoNumero = Convert.ToString(dr["ConselhoNumero"]);
                ObjClienteFuncionario.RefCliente.RefProfissional.ConselhoUF = Convert.ToString(dr["ConselhoUF"]);
            }
            return ObjClienteFuncionario;
        }
    }
    //CARREGA OS DADOS COMPLETOS DO ATESTADO DE SAUDE
    public AtestadoSaude VisualizaAtestadoSaude(int AtestadoSaude)
    {
        Database db = DatabaseFactory.CreateDatabase();
        String SQL;
        SQL =   "SELECT ClienteFuncionario.Nome, ClienteFuncionario.RG, Cliente.RazaoSocial, CNAE.SubClasse, CNAE.Grau_Risco, " +
                "Profissional.Nome AS MedicoCoordenador, Profissional.ConselhoNumero, Profissional.ConselhoUF, TipoAtestado.Nome AS TipoAtestado, " +
                "AtestadoSaude.Observacoes, StatusAtestado.Nome AS StatusAtestado, AtestadoSaude.Pendencia, AtestadoSaude.DataConsulta, " +
                "ClienteFuncionarioProfissional.CBO, CBO_Ocupacao.FUNCAO " +
                "FROM  ClienteFuncionarioProfissional LEFT OUTER JOIN " +
                "CBO_Ocupacao ON ClienteFuncionarioProfissional.CBO = CBO_Ocupacao.Cod_Familia + CBO_Ocupacao.Cod_Ocup RIGHT OUTER JOIN " +
                "CNAE RIGHT OUTER JOIN " +
                "Cliente INNER JOIN " +
                "ClienteFuncionario ON Cliente.id = ClienteFuncionario.idCliente ON CNAE.SubClasse = Cliente.CNAE ON " +
                "ClienteFuncionarioProfissional.idFuncionario = ClienteFuncionario.id RIGHT OUTER JOIN " +
                "AtestadoSaude LEFT OUTER JOIN " +
                "StatusAtestado ON AtestadoSaude.idStatusAtestado = StatusAtestado.id ON " +
                "ClienteFuncionario.id = AtestadoSaude.idClienteFuncionario LEFT OUTER JOIN " +
                "Profissional ON AtestadoSaude.idProfissional_MedicoCoordenador = Profissional.id LEFT OUTER JOIN " +
                "TipoAtestado ON AtestadoSaude.idTipoAtestado = TipoAtestado.id " +
                "WHERE dbo.AtestadoSaude.id = " + AtestadoSaude;
        DbCommand command = db.GetSqlStringCommand(SQL);
        using (IDataReader dr = db.ExecuteReader(command))
        {
            AtestadoSaude ObjAtestadoSaude = new AtestadoSaude();
            if (dr.Read())
            {
                ObjAtestadoSaude.RefClienteFuncionario.Nome = Convert.ToString(dr["Nome"]);
                ObjAtestadoSaude.RefClienteFuncionario.RG = Convert.ToString(dr["RG"]);
                ObjAtestadoSaude.RefClienteFuncionario.RefClienteFuncionarioProfissional.RefCBO.COD_CBO = Convert.ToString(dr["CBO"]);
                ObjAtestadoSaude.RefClienteFuncionario.RefClienteFuncionarioProfissional.RefCBO.FUNCAO = Convert.ToString(dr["Funcao"]);
                ObjAtestadoSaude.RefClienteFuncionario.RefCliente.RazaoSocial = Convert.ToString(dr["RazaoSocial"]);
                ObjAtestadoSaude.RefClienteFuncionario.RefCliente.RefCNAE.Risco = Convert.ToString(dr["Grau_Risco"]);
                ObjAtestadoSaude.RefClienteFuncionario.RefCliente.RefProfissional.Nome = Convert.ToString(dr["MedicoCoordenador"]);
                ObjAtestadoSaude.RefClienteFuncionario.RefCliente.RefProfissional.ConselhoNumero = Convert.ToString(dr["ConselhoNumero"]);
                ObjAtestadoSaude.RefClienteFuncionario.RefCliente.RefProfissional.ConselhoUF = Convert.ToString(dr["ConselhoUF"]);
                ObjAtestadoSaude.RefTipoAtestado.Nome = Convert.ToString(dr["TipoAtestado"]);
                ObjAtestadoSaude.Observacoes = Convert.ToString(dr["Observacoes"]);
                ObjAtestadoSaude.RefStatusAtestado.Nome = Convert.ToString(dr["StatusAtestado"]);
                ObjAtestadoSaude.Pendencia = Convert.ToString(dr["Pendencia"]);
                ObjAtestadoSaude.DataConsulta = Convert.ToString(dr["DataConsulta"]).Replace("00:00:00","");
            }
            return ObjAtestadoSaude;
        }
    }
    //USADO PARA POPULAR UM DROPDOWNLIST
    public DataTable TipoAtestatoDropDownList()
    {
        Validacoes Valida = new Validacoes();
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select id,Nome From TipoAtestado");

        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }
    //USADO PARA POPULAR UM DROPDOWNLIST
    public DataTable StatusAtestatoDropDownList()
    {
        Validacoes Valida = new Validacoes();
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select id,Nome From StatusAtestado");

        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }
}
