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
/// Summary description for ClienteFuncionarioStatus
/// </summary>
public class ClienteFuncionarioStatus
{

	public ClienteFuncionarioStatus()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    private int mid;

    public int id
    {
        get { return mid; }
        set { mid = value; }
    }

    private string mStatus;

    public string Status
    {
        get { return mStatus; }
        set { mStatus = value; }
    }


}
