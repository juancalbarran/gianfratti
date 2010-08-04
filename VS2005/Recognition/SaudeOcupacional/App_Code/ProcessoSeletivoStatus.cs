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
/// Summary description for ProcessoSeletivoStatus
/// </summary>
public class ProcessoSeletivoStatus
{
    private int mId;
    private string mNome;

	public ProcessoSeletivoStatus()
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

    public string Nome
    {
        get { return mNome; }
        set { mNome = value; }
    }
}
