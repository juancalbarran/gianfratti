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
/// Summary description for ClienteCargo
/// </summary>
public class ClienteCargo
{
    private int mid;
    private int midClienteSetor;
    private string mNome;

	public ClienteCargo()
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

    public int idClienteSetor
    {
        get { return midClienteSetor; }
        set { midClienteSetor = value; }
    }

    public string Nome
    {
        get { return mNome; }
        set { mNome = value; }
    }
}
