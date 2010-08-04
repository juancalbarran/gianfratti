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
/// Summary description for CID10
/// </summary>
public class CID10
{
    public int mid;
    public string mCID;
    public string mOPC;
    public string mCAT;
    public string mSubCat;
    public string mDescricao;
    public string mRestrSexo;

	public CID10()
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

    public string CID
    {
        get { return mCID; }
        set { mCID = value; }
    }

    public string OPC
    {
        get { return mOPC; }
        set { mOPC = value; }
    }

    public string CAT
    {
        get { return mCAT; }
        set { mCAT = value; }
    }

    public string Descricao
    {
        get { return mDescricao; }
        set { mDescricao = value; }
    }

    public string RestrSexo
    {
        get { return mRestrSexo; }
        set { mRestrSexo = value; }
    }

}
