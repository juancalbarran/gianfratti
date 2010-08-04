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
/// Summary description for ClienteFuncionarioUserControlDAL
/// </summary>
public class ClienteFuncionarioUserControlDAL
{
    public ClienteFuncionarioUserControlDAL()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    //SELECIONA UM DETERMINADO FUNCIONARIO.
    public ClienteFuncionario SelectFuncionarioByID(int idFuncionario)
    {
        try
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetStoredProcCommand("ClienteFuncionarioDadosBasicosSelectByID");
            db.AddInParameter(command, "@ID", DbType.Int32, idFuncionario);

            using (IDataReader dr = db.ExecuteReader(command))
            {
                ClienteFuncionario ObjClienteFuncionario = new ClienteFuncionario();
                if (dr.Read())
                {
                    //DADOS PESSOAIS
                    ObjClienteFuncionario.CPF = Convert.ToString(dr["CPF"]);
                    ObjClienteFuncionario.RG = Convert.ToString(dr["RG"]);
                    ObjClienteFuncionario.DtExpedicao = Convert.ToString(dr["DtExpedicao"]);
                    ObjClienteFuncionario.Nome = Convert.ToString(dr["Nome"]);
                    ObjClienteFuncionario.DtNascimento = Convert.ToString(dr["DtNascimento"]).Replace("00:00:00", "");
                    ObjClienteFuncionario.DtObito = Convert.ToString(dr["DtObito"]);
                    ObjClienteFuncionario.Sexo = Convert.ToString(dr["Sexo"]);
                    ObjClienteFuncionario.EstadoCivil = Convert.ToString(dr["EstadoCivil"]);
                    ObjClienteFuncionario.EndResidencia = Convert.ToString(dr["EndResidencia"]);
                    ObjClienteFuncionario.Numero = Convert.ToString(dr["Numero"]);
                    ObjClienteFuncionario.Complemento = Convert.ToString(dr["Complemento"]);
                    ObjClienteFuncionario.CEP = Convert.ToString(dr["CEP"]);
                    ObjClienteFuncionario.Cidade = Convert.ToString(dr["Cidade"]);
                    ObjClienteFuncionario.Bairro = Convert.ToString(dr["Bairro"]);
                    ObjClienteFuncionario.UF = Convert.ToString(dr["UF"]);
                }
                return ObjClienteFuncionario;
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    //SELECIONA UM DETERMINADO FUNCIONARIO.
    public ClienteFuncionarioProfissional SelectFuncionarioProfissionalByID(int idFuncionario)
    {
        try
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetStoredProcCommand("ClienteFuncionarioProfissionalDadosBasicosSelectByID");
            db.AddInParameter(command, "@ID", DbType.Int32, idFuncionario);

            using (IDataReader dr = db.ExecuteReader(command))
            {
                ClienteFuncionarioProfissional ObjClienteFuncionarioProfissional = new ClienteFuncionarioProfissional();
                ObjClienteFuncionarioProfissional.RefCliente = new Cliente();
                if (dr.Read())
                {
                    ObjClienteFuncionarioProfissional.Departamento = Convert.ToString(dr["Departamento"]);
                    ObjClienteFuncionarioProfissional.Setor = Convert.ToString(dr["Setor"]);
                    ObjClienteFuncionarioProfissional.RefCliente.RazaoSocial = Convert.ToString(dr["RazaoSocial"]);
                    ObjClienteFuncionarioProfissional.RefCliente.CNAE = Convert.ToString(dr["SubClasse"]);
                    ObjClienteFuncionarioProfissional.RefCliente.Denominacao = Convert.ToString(dr["Descricao"]);
                    ObjClienteFuncionarioProfissional.RefCliente.Risco = Convert.ToString(dr["Grau_Risco"]);
                    ObjClienteFuncionarioProfissional.CBO = Convert.ToString(dr["CBO"]);
                    ObjClienteFuncionarioProfissional.DescricaoAtividades = Convert.ToString(dr["DescricaoAtividades"]);
                }
                return ObjClienteFuncionarioProfissional;
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}
