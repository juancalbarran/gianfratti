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
public class ClienteBO
{
	public ClienteBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    /// <summary>
    /// Insert ou Update
    /// </summary>
    /// <param name="ObjUsuario"></param>
    public void InsertUpdate(Cliente ObjCliente,out string idCliente)
    {
        //string idCliente = null;
        ClienteDAL ObjClienteDAL = new ClienteDAL();
        ObjClienteDAL.InsertUpdate(ObjCliente, out idCliente);
    }
    /// <summary>
    /// Retorna um DataTable com todos os usuarios.
    /// Pode-se fazer um filtro conforme parametros.
    /// </summary>
    /// <returns></returns>
    public DataTable SelectAll(string CNPJ, string RazaoSocial, string Contato)
    {
        ClienteDAL ObjClienteDAL = new ClienteDAL();
        return ObjClienteDAL.SelectAll(CNPJ, RazaoSocial, Contato);
    }
    /// <summary>
    /// Carregar registro para edição
    /// </summary>
    /// <param name="idCliente"></param>
    /// <returns></returns>
    public Cliente SelectByID(int idCliente)
    {
        ClienteDAL ObjClienteDAL = new ClienteDAL();
        return ObjClienteDAL.SelectByID(idCliente);
    }
    /// <summary>
    /// Usado para gerar um DropDownList
    /// </summary>
    /// <returns></returns>
    public DataTable DropDownList(int idUsuario, int idPerfil)
    {
        ClienteDAL ObjClienteDAL = new ClienteDAL();
        return ObjClienteDAL.DropDownList(idUsuario,idPerfil);
    }
    /// <summary>
    /// Deletar um registro
    /// </summary>
    /// <param name="id"></param>
    public void DeleteByID(int id)
    {
        ClienteDAL ObjClienteDAL = new ClienteDAL();
        ObjClienteDAL.Delete(id);
    }
}
