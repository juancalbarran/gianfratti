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
/// Summary description for Empresa
/// </summary>
public class Empresa
{
    private int mid;
    private string mCNPJ;
    private string mInscEstadual;
    private string mRazaoSocial;
    private string mEndereco;
    private string mBairro;
    private string mCEP;
    private string mCidade;
    private string mUF;
    private string mDDDtel;
    private string mTel;
    private string mDDDfax;
    private string mFax;
    private string mContato;
    private string mEmail;

	public Empresa()
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

    public string CNPJ
    {
        get { return mCNPJ; }
        set { mCNPJ = value; }
    }

    public string InscEstadual
    {
        get { return mInscEstadual; }
        set { mInscEstadual = value; }
    }

    public string RazaoSocial
    {
        get { return mRazaoSocial; }
        set { mRazaoSocial = value; }
    }

    public string Endereco
    {
        get { return mEndereco; }
        set { mEndereco = value; }
    }

    public string Bairro
    {
        get { return mBairro; }
        set { mBairro = value; }
    }

    public string CEP
    {
        get { return mCEP; }
        set { mCEP = value; }
    }

    public string Cidade
    {
        get { return mCidade; }
        set { mCidade = value; }
    }

    public string UF
    {
        get { return mUF; }
        set { mUF = value; }
    }

    public string DDDtel
    {
        get { return mDDDtel; }
        set { mDDDtel = value; }
    }

    public string Tel
    {
        get { return mTel; }
        set { mTel = value; }
    }

    public string DDDfax
    {
        get { return mDDDfax; }
        set { mDDDfax = value; }
    }

    public string Fax
    {
        get { return mFax; }
        set { mFax = value; }
    }

    public string Contato
    {
        get { return mContato; }
        set { mContato = value; }
    }

    public string Email
    {
        get { return mEmail; }
        set { mEmail = value; }
    }
}
