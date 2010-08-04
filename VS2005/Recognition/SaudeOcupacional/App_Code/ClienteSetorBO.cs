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
/// Summary description for ClienteSetorBO
/// </summary>
public class ClienteSetorBO
{
	public ClienteSetorBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    //CARREGA REGISTRO
    public object CarregaClienteSetor(int id)
    {
        ClienteSetorDAL ObjClienteSetorDAL = new ClienteSetorDAL();
        return ObjClienteSetorDAL.SelectSetorByID(id);
    }
}
