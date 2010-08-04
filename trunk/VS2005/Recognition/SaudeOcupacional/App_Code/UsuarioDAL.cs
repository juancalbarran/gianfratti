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
using System.Collections.Generic;

/// <summary>
/// Summary description for UsuarioDAL
/// </summary>
public class UsuarioDAL
{
    public UsuarioDAL()
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
    public void InsertUpdate(Usuario ObjUsuario)
    {
        try
        {
            string NomeProc;
            Database db = DatabaseFactory.CreateDatabase();
            Validacoes ObjValidacoes = new Validacoes();
            if (ObjUsuario.id != 0) { NomeProc = "UsuarioUpdate"; } else { NomeProc = "UsuarioInsert"; }
            DbCommand command = db.GetStoredProcCommand(NomeProc);
            //Caso id(chave primaria for diferente de zero(0) então é passado o parametro para fazer o update
            if (ObjUsuario.id != 0) { db.AddInParameter(command, "@ID", DbType.Int32, ObjUsuario.id); }
            //Dados
            db.AddInParameter(command, "@idEmpresa", DbType.String, ObjValidacoes.TextoNull(ObjUsuario.idEmpresa));
            db.AddInParameter(command, "@idProfissional", DbType.String, ObjValidacoes.TextoNull(ObjUsuario.idProfissional));
            db.AddInParameter(command, "@idPerfil", DbType.Int32, ObjUsuario.idPerfil);
            db.AddInParameter(command, "@idStatus", DbType.Int32, ObjUsuario.idStatus);
            db.AddInParameter(command, "@Nome", DbType.String, ObjUsuario.Nome);
            db.AddInParameter(command, "@Email", DbType.String, ObjUsuario.Email);
            if (NomeProc != "UsuarioUpdate")
            {
                db.AddInParameter(command, "@usuario", DbType.String, ObjValidacoes.TextoNull(ObjUsuario.Usuarios));
                db.AddInParameter(command, "@Senha", DbType.String, FormsAuthentication.HashPasswordForStoringInConfigFile(ObjUsuario.Senha, "MD5"));
            }
            else
            {
                db.AddInParameter(command, "@usuario", DbType.String, "");
            }
            //Parametros de OutPut Identity.
            //Somente se for Insert
            if (ObjUsuario.id == 0)
            {
                db.AddOutParameter(command, "@id", DbType.Int32, 8); //Retorna o parametro Identity
            }
            //Executa
            db.ExecuteNonQuery(command);
            //Apos o Execute pegamos os parametros de retorno que foram inseridos e chamos a função InsertUsuarioXCliente
            InsertUsuarioXCliente(ObjUsuario.UsuarioXCliente, Convert.ToInt32(db.GetParameterValue(command, "@id")));
        }
        catch (Exception e)
        {
            throw e;
        }
    }
    //Faz o insert na tabela de usuarios X clientes
    public void InsertUsuarioXCliente(List<UsuarioXCliente> ObjUsuarioXCliente, int idUsuario)
    {
        try
        {
            //Na proc de Insert de usuario tem o comando DELETE, antes do insert ele deleta todos
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand commandDelete = db.GetSqlStringCommand("Delete From UsuarioXCliente Where idUsuario = " + idUsuario);
            db.ExecuteNonQuery(commandDelete);

            DbCommand command = db.GetStoredProcCommand("UsuarioXClienteInsert");
            Validacoes ObjValidacoes = new Validacoes();
            //Criando Parametros da Procedure
            db.AddInParameter(command, "@idUsuario", DbType.Int32, null);
            db.AddInParameter(command, "@idCliente", DbType.Int32, null);
            foreach (UsuarioXCliente proc in ObjUsuarioXCliente)
            {
                if (idUsuario == 0)
                    idUsuario = proc.idUsuario;

                //Dados
                db.SetParameterValue(command, "@idUsuario", idUsuario);
                db.SetParameterValue(command, "@idCliente", proc.idCliente);
                //Executa a proc que esta em transação
                db.ExecuteNonQuery(command);
            }
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    /// <summary>
    /// Retorna um DataTable com todos os usuarios
    /// </summary>
    /// <returns></returns>
    public DataTable SelectUsuarioALL(string Nome, string idPerfil, string idStatus)
    {
        Validacoes ObjValidacoes = new Validacoes();
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("UsuarioSelectAll");
        db.AddInParameter(command, "@Nome", DbType.String, ObjValidacoes.TextoNull(Nome));
        db.AddInParameter(command, "@idPerfil", DbType.String, ObjValidacoes.TextoNull(idPerfil));
        db.AddInParameter(command, "@idStatus", DbType.String, ObjValidacoes.TextoNull(idStatus));
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
    public Usuario SelectUsuarioByID(int idUsuario)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select * From Usuario Where id = " + idUsuario);

        using (IDataReader dr = db.ExecuteReader(command))
        {
            Usuario ObjUsuario = new Usuario();
            if (dr.Read())
            {
                ObjUsuario.id = Convert.ToInt32(dr["id"]);
                ObjUsuario.idEmpresa = Convert.ToString(dr["idEmpresa"]);
                ObjUsuario.idProfissional = Convert.ToString(dr["idProfissional"]);
                ObjUsuario.idStatus = Convert.ToInt32(dr["idStatus"]);
                ObjUsuario.idPerfil = Convert.ToInt32(dr["idPerfil"]);
                ObjUsuario.Nome = Convert.ToString(dr["Nome"]);
                ObjUsuario.Email = Convert.ToString(dr["Email"]);
                ObjUsuario.Usuarios = Convert.ToString(dr["Usuario"]);
            }
            return SelectUsuarioXClienteByID(ObjUsuario, Convert.ToInt32(dr["id"]));
        }
    }

    public Usuario SelectUsuarioXClienteByID(Usuario ObjUsuario, int idUsuario)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select * From UsuarioXCliente Where idUsuario = " + idUsuario);

        using (IDataReader dr = db.ExecuteReader(command))
        {
            //Usuario ObjUsuario = new Usuario();
            while (dr.Read())
            {
                ObjUsuario.UsuarioXCliente.Add(new UsuarioXCliente(Convert.ToInt32(dr["idUsuario"]), Convert.ToInt32(dr["idCliente"])));
            }
        }
        return ObjUsuario;
    }
    /// <summary>
    /// Verifica se o nome de usuario digitado já existe na base de dados
    /// </summary>
    /// <param name="Usuario"></param>
    /// <returns></returns>
    public bool SelectVerificaUsuario(string Usuario)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select id,Usuario From Usuario Where usuario = '" + Usuario + "' ");

        using (IDataReader dr = db.ExecuteReader(command))
        {
            if (dr.Read())
            {
                //Encontrou usuario ja existente
                return true;
            }
            //Não encontrou usuario, ou seja, usuario consultado pode ser usado
            return false;
        }
    }
    //FAZ UM SELECT EM TODOS OS CLIENTES NA BASE E PODE SER USADO ALGUNS CRITERIAS DE BUSCA
    public Usuario SelecValidaUsuario(Usuario ObjUsuario)
    {
        try
        {
            //ObjUsuario = new Usuario();
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetStoredProcCommand("UsuarioSelectByLoginSenha");
            db.AddInParameter(command, "@Usuario", DbType.String, ObjUsuario.Usuarios);
            db.AddInParameter(command, "@Senha", DbType.String, FormsAuthentication.HashPasswordForStoringInConfigFile(ObjUsuario.Senha, "MD5"));
            using (IDataReader dr = db.ExecuteReader(command))
            {
                if (dr.Read())
                {
                    //FormsAuthentication.RedirectFromLoginPage("Empresa", true);
                    FormsAuthentication.RedirectFromLoginPage(Convert.ToString(dr["Perfil"]), true);
                    ObjUsuario.id = Convert.ToInt32(dr["id"]);
                    ObjUsuario.idPerfil = Convert.ToInt32(dr["idPerfil"]);
                    ObjUsuario.Nome = Convert.ToString(dr["Nome"]);
                    ObjUsuario.RefUsuarioPerfil.Nome = Convert.ToString(dr["Perfil"]);
                    return ObjUsuario;
                }
                else
                {
                    return ObjUsuario;
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    /// <summary>
    /// Deletar um registro
    /// </summary>
    /// <param name="id"></param>
    public void DeleteUsuarioByID(int id)
    {
        try
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("Delete From Usuario Where id = " + id);
            db.ExecuteNonQuery(command);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}
