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
/// Summary description for EmpresaDAL
/// </summary>
public class EmpresaDAL
{
	public EmpresaDAL()
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
    public void InsertUpdate(Empresa ObjEmpresa)
    {
        try
        {
            string NomeProc;
            Database db = DatabaseFactory.CreateDatabase();
            Validacoes ObjValidacoes = new Validacoes();
            if (ObjEmpresa.id != 0) { NomeProc = "EmpresaUpdate"; } else { NomeProc = "EmpresaInsert"; }
            DbCommand command = db.GetStoredProcCommand(NomeProc);
            //Caso id(chave primaria for diferente de zero(0) então é passado o parametro para fazer o update
            if (ObjEmpresa.id != 0) { db.AddInParameter(command, "@ID", DbType.Int32, ObjEmpresa.id); }
            //Dados
            db.AddInParameter(command, "@CNPJ", DbType.String, ObjEmpresa.CNPJ);
            db.AddInParameter(command, "@InscEstadual", DbType.String, ObjEmpresa.InscEstadual);
            db.AddInParameter(command, "@RazaoSocial", DbType.String, ObjEmpresa.RazaoSocial);
            db.AddInParameter(command, "@Endereco", DbType.String, ObjEmpresa.Endereco);
            db.AddInParameter(command, "@Bairro", DbType.String, ObjEmpresa.Bairro);
            db.AddInParameter(command, "@CEP", DbType.String, ObjEmpresa.CEP);
            db.AddInParameter(command, "@Cidade", DbType.String, ObjEmpresa.Cidade);
            db.AddInParameter(command, "@UF", DbType.String, ObjEmpresa.UF);
            db.AddInParameter(command, "@DDDtel", DbType.String, ObjEmpresa.DDDtel);
            db.AddInParameter(command, "@Tel", DbType.String, ObjEmpresa.Tel.Replace(".", String.Empty).Replace("-", String.Empty).Replace(" ", String.Empty));
            db.AddInParameter(command, "@DDDfax", DbType.String, ObjEmpresa.DDDfax);
            db.AddInParameter(command, "@Fax", DbType.String, ObjEmpresa.Fax.Replace(".", String.Empty).Replace("-", String.Empty).Replace(" ", String.Empty));
            db.AddInParameter(command, "@Contato", DbType.String, ObjEmpresa.Contato);
            db.AddInParameter(command, "@Email", DbType.String, ObjEmpresa.Email);
            //Executa
            db.ExecuteNonQuery(command);
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    public Empresa SelectEmpresaByID(int idEmpresa)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select * From Empresa Where id = " + idEmpresa + "  ");

        using (IDataReader dr = db.ExecuteReader(command))
        {
            Empresa ObjEmpresa = new Empresa();
            if (dr.Read())
            {
                ObjEmpresa.CNPJ = Convert.ToString(dr["CNPJ"]);
                ObjEmpresa.InscEstadual = Convert.ToString(dr["InscEstadual"]);
                ObjEmpresa.RazaoSocial = Convert.ToString(dr["RazaoSocial"]);
                ObjEmpresa.Endereco = Convert.ToString(dr["Endereco"]);
                ObjEmpresa.Bairro = Convert.ToString(dr["Bairro"]);
                ObjEmpresa.CEP = Convert.ToString(dr["CEP"]);
                ObjEmpresa.Cidade = Convert.ToString(dr["Cidade"]);
                ObjEmpresa.UF = Convert.ToString(dr["UF"]);
                ObjEmpresa.Tel = Convert.ToString(dr["Tel"]);
                ObjEmpresa.DDDtel = Convert.ToString(dr["DDDTel"]);
                ObjEmpresa.DDDfax = Convert.ToString(dr["DDDFax"]);
                ObjEmpresa.Fax = Convert.ToString(dr["Fax"]);
                ObjEmpresa.Contato = Convert.ToString(dr["Contato"]);
                ObjEmpresa.Email = Convert.ToString(dr["Email"]);
            }
            return ObjEmpresa;
        }
    }
}
