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
/// Summary description for CNAE
/// </summary>
public class CNAE
{
    private string mClasse;
    private string mDenominacao;
    private string mRisco;

	public CNAE()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public string Classe
    {
        get { return mClasse; }
        set { mClasse = value; }
    }

    public string Denominacao
    {
        get { return mDenominacao; }
        set { mDenominacao = value; }
    }

    public string Risco
    {
        get { return mRisco; }
        set { mRisco = value; }
    }
}
