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
/// Summary description for ClienteDepartamentoBO
/// </summary>
public class ClienteDepartamentoBO
{
	public ClienteDepartamentoBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    /// <summary>
    /// Insert ou Update
    /// </summary>
    /// <param name="ObjClienteDepartamento"></param>
    public void InsertUpdate(ClienteDepartamento ObjClienteDepartamento)
    {
        ClienteDepartamentoDAL ObjClienteDepartamentoDAL = new ClienteDepartamentoDAL();
        ObjClienteDepartamentoDAL.InsertUpdate(ObjClienteDepartamento);
    }   
    //CARREGA REGISTRO
    public object CarregaClienteDepartamento(int id)
    {
        ClienteDepartamentoDAL ObjClienteDepartamentoDAL = new ClienteDepartamentoDAL();
        return ObjClienteDepartamentoDAL.SelectDepartamentoByID(id);
    }
}
