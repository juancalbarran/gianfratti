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
/// Summary description for UsuarioPerfilBO
/// </summary>
public class UsuarioPerfilBO
{
	public UsuarioPerfilBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public DataTable SelectUsuarioPerfilALL()
    {
        UsuarioPerfilDAL ObjUsuarioPerfilDAL = new UsuarioPerfilDAL();
        return ObjUsuarioPerfilDAL.SelectUsuarioPerfilALL();
    }
}
