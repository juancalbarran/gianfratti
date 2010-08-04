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
/// Summary description for PCMSOXSetor
/// </summary>
public class PCMSOXSetor
{
	public PCMSOXSetor()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    private int mid;
    private int midPCMSO;
    private int midSetor;
    private int midCargo;

    public int id
    {
        get { return mid; }
        set { mid = value; }
    }

    public int idPCMSO
    {
        get { return midPCMSO; }
        set { midPCMSO = value; }
    }


    public int idSetor
    {
        get { return midSetor; }
        set { midSetor = value; }
    }

    public int idCargo
    {
        get { return midCargo; }
        set { midCargo = value; }
    }
}
