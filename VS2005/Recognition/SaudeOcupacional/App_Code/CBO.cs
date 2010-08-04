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
/// Summary description for CBO
/// </summary>
public class CBO
{
    private int mid;
    private string mCOD_CBO;
    private string mFUNCAO;
    private string mDescr_Familia;
    private string mCond_Exerc;
    private string mForm_Exp;
    private string mDescr_Excecao;
    private string mCod_Int_Ocup;

    public CBO()
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

    public string COD_CBO
    {
        get { return mCOD_CBO; }
        set { mCOD_CBO = value; }
    }

    public string FUNCAO
    {
        get { return mFUNCAO; }
        set { mFUNCAO = value; }
    }

    public string Descr_Familia
    {
        get { return mDescr_Familia; }
        set { mDescr_Familia = value; }
    }

    public string Cond_Exerc
    {
        get { return mCond_Exerc; }
        set { mCond_Exerc = value; }
    }

    public string Form_Exp
    {
        get { return mForm_Exp; }
        set { mForm_Exp = value; }
    }

    public string Descr_Excecao
    {
        get { return mDescr_Excecao; }
        set { mDescr_Excecao = value; }
    }

    public string Cod_Int_Ocup
    {
        get { return mCod_Int_Ocup; }
        set { mCod_Int_Ocup = value; }
    }

}

