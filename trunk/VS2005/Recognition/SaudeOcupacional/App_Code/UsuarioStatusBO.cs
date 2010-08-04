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
/// Summary description for UsuarioStatusBO
/// </summary>
public class UsuarioStatusBO
{
	public UsuarioStatusBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    /// <summary>
    /// Retorna um DataTable com todos os registros
    /// </summary>
    /// <returns></returns>
    public DataTable SelectUsuarioStatusALL()
    {
        UsuarioStatusDAL ObjUsuarioStatusDAL = new UsuarioStatusDAL();
        return ObjUsuarioStatusDAL.SelectUsuarioStatusALL();
    }
}
