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
/// Summary description for EmpresaBO
/// </summary>
public class EmpresaBO
{
	public EmpresaBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    /// <summary>
    /// Insert ou Update
    /// </summary>
    /// <param name="ObjEmpresa"></param>
    public void InsertUpdate(Empresa ObjEmpresa)
    {
        EmpresaDAL ObjEmpresaDAL = new EmpresaDAL();
        ObjEmpresaDAL.InsertUpdate(ObjEmpresa);
    }
}
