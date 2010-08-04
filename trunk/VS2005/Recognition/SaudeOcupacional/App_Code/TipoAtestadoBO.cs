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
/// Summary description for TipoAtestadoBO
/// </summary>
public class TipoAtestadoBO
{
	public TipoAtestadoBO()
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
        TipoAtestadoDAL ObjTipoAtestadoDAL = new TipoAtestadoDAL();
        return ObjTipoAtestadoDAL.DropDownList();
    }
}
