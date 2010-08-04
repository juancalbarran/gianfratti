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
/// Summary description for TipoProfissionalBO
/// </summary>
public class TipoProfissionalBO
{
	public TipoProfissionalBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    /// <summary>
    /// Retorna um DropDownList
    /// </summary>
    /// <returns></returns>
    public DataTable DropDownList()
    {
        TipoProfissionalDAL ObjTipoProfissionalDAL = new TipoProfissionalDAL();
        return ObjTipoProfissionalDAL.DropDownList();
    }
}
