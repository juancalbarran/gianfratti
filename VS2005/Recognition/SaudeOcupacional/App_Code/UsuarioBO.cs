using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Camada de negocio
/// </summary>
public class UsuarioBO
{
	public UsuarioBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    /// <summary>
    /// Insert ou Update
    /// </summary>
    /// <param name="ObjUsuario"></param>
    public void InsertUpdate(Usuario ObjUsuario)
    {
            UsuarioDAL ObjUsuarioDAL = new UsuarioDAL();
            ObjUsuarioDAL.InsertUpdate(ObjUsuario);
    }   
    /// <summary>
    /// Retorna um DataTable com todos os usuarios
    /// </summary>
    /// <returns></returns>
    public DataTable SelectUsuarioALL(string Nome, string idPerfil, string idStatus)
    {
        Usuario ObjUsuario = new Usuario();
        UsuarioDAL ObjUsuarioDAL = new UsuarioDAL();
        return ObjUsuarioDAL.SelectUsuarioALL(Nome,idPerfil,idStatus);
    }
    /// <summary>
    /// Carregar registro para edição
    /// </summary>
    /// <param name="id"></param>
    public Usuario SelectUsuarioByID(int id)
    {
        Usuario ObjUsuario = new Usuario();
        UsuarioDAL ObjUsuarioDAL = new UsuarioDAL();
        return ObjUsuario = ObjUsuarioDAL.SelectUsuarioByID(id);
    }
    /// <summary>
    /// Verifica se o nome de usuario digitado já existe na base de dados
    /// </summary>
    /// <param name="Usuario"></param>
    /// <returns></returns>
    public bool SelectVerificaUsuario(string Usuario)
    {
        UsuarioDAL ObjUsuarioDAL = new UsuarioDAL();
        return ObjUsuarioDAL.SelectVerificaUsuario(Usuario);

    }
    public Usuario ValidaUsuario(Usuario ObjUsuario)
    {
        try
        {
            UsuarioDAL ObjUsuarioDAL = new UsuarioDAL();
            return ObjUsuarioDAL.SelecValidaUsuario(ObjUsuario);
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }
    /// <summary>
    /// Deletar um registro
    /// </summary>
    /// <param name="id"></param>
    public void DeleteUsuarioByID(int id)
    {
        UsuarioDAL ObjUsuarioDAL = new UsuarioDAL();
        ObjUsuarioDAL.DeleteUsuarioByID(id);
    }
}
