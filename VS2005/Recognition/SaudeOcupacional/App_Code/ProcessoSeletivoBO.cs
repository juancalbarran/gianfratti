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
/// Summary description for ProcessoSeletivoBO
/// </summary>
public class ProcessoSeletivoBO
{
	public ProcessoSeletivoBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    /// <summary>
    /// Insert ou Update
    /// </summary>
    /// <param name="ObjProcessoSeletivo"></param>
    public void InsertUpdate(ProcessoSeletivo ObjProcessoSeletivo)
    {
        ProcessoSeletivoDAL ObjProcessoSeletivoDAL = new ProcessoSeletivoDAL();
        ObjProcessoSeletivoDAL.InsertUpdate(ObjProcessoSeletivo);
    }
    /// <summary>
    /// Retorna um DataTable com todos os usuarios.
    /// Pode-se fazer um filtro conforme parametros.
    /// </summary>
    /// <returns></returns>
    public DataTable SelectAll(string idCliente, string Nome, string CPF, string idProcessoSeletivoStatus)
    {
        ClienteDAL ObjClienteDAL = new ClienteDAL();
        ProcessoSeletivoDAL ObjProcessoSeletivoDAL = new ProcessoSeletivoDAL();
        return ObjProcessoSeletivoDAL.SelectAll(idCliente, Nome, CPF, idProcessoSeletivoStatus);
    }
    public ProcessoSeletivo SelectByID(int idProcessoSeletivo)
    {
        ProcessoSeletivoDAL ObjProcessoSeletivoDAL = new ProcessoSeletivoDAL();
        return ObjProcessoSeletivoDAL.SelectByID(idProcessoSeletivo);

    }
    /// <summary>
    /// Usado para gerar um DropDownList
    /// </summary>
    /// <returns></returns>
    public DataTable DropDownList(int idCliente)
    {
        ClienteDAL ObjClienteDAL = new ClienteDAL();
        ProcessoSeletivoDAL ObjProcessoSeletivoDAL = new ProcessoSeletivoDAL();
        return ObjProcessoSeletivoDAL.DropDownList(idCliente);
    }
    /// <summary>
    /// Deletar um registro
    /// </summary>
    /// <param name="id"></param>
    public void Delete(int id)
    {
        ProcessoSeletivoDAL ObjProcessoSeletivoDAL = new ProcessoSeletivoDAL();
        ObjProcessoSeletivoDAL.Delete(id);
    }
}
