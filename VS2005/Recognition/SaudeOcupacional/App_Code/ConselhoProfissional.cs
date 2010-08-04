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
/// Summary description for ConselhoProfissional
/// </summary>
public class ConselhoProfissional
{
    private int mId;
    private string mCodigo;
    private string mDescricao;

	public ConselhoProfissional()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public int id
    {
        get { return mId; }
        set { mId = value; }
    }

    public string Codigo
    {
        get { return mCodigo; }
        set { mCodigo = value; }
    }

    public string Descricao
    {
        get { return mDescricao; }
        set { mDescricao = value; }
    }
}
