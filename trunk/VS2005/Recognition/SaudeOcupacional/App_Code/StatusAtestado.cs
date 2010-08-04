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
/// Summary description for StatusAtestado
/// </summary>
public class StatusAtestado
{
    private int mid;
    private string mNome;

	public StatusAtestado()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public int id
    {
        get { return mid; }
        set { mid = value; }
    }

    public string Nome
    {
        get { return mNome; }
        set { mNome = value; }
    }
}
