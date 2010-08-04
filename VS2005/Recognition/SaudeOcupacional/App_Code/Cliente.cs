using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;

/// <summary>
/// Classe Cliente
/// </summary>
public class Cliente
{
    //Referencias a outras classes
    private Profissional ObjProfissional = new Profissional();
    private CNAE ObjCNAE = new CNAE();
    //Fim das referencias

    private int mId;
    private int midTipoIdentificacao;
    private string midProfissional;
    private string midProfissional1;
    private string midProfissional2;
    private string midProfissional3;
    private string mCNPJ_INCRA_CPF;
    private string mInscEstadual;
    private string mRazaoSocial;
    private string mEndereco;
    private string mBairro;
    private string mCEP;
    private string mCidade;
    private string mUF;
    private string mCNAE;
    private string mDenominacao;
    private string mRisco;
    private string mGFIP;
    private string mDDDtel;
    private string mTelefone;
    private string mDDDfax;
    private string mFax;
    private string mContato;
    private string mEmail;
    
    private List<ClienteDepartamento> mDepartamentos = new List<ClienteDepartamento>(); //Vai armazenar uma lista
    private List<string> mSetores = new List<string>(); //Vai armazenar uma lista

    //Faz referencia a Classe de Cliente
    public Profissional RefProfissional
    {
        get { return ObjProfissional; }
        set { ObjProfissional = value; }
    }
    public CNAE RefCNAE
    {
        get { return ObjCNAE; }
        set { ObjCNAE = value; }
    }
    //Final das referencias as outras classes

    public int id
    {
        get { return mId; }
        set { mId = value; }
    }
    public int idTipoIdentificacao
    {
        get { return midTipoIdentificacao; }
        set { midTipoIdentificacao = value; }
    }
    public string idProfissional
    {
        get { return midProfissional; }
        set { midProfissional = value; }
    }
    public string idProfissional1
    {
        get { return midProfissional1; }
        set { midProfissional1 = value; }
    }
    public string idProfissional2
    {
        get { return midProfissional2; }
        set { midProfissional2 = value; }
    }
    public string idProfissional3
    {
        get { return midProfissional3; }
        set { midProfissional3 = value; }
    }
    public string CNPJ_INCRA_CPF
    {
        get { return mCNPJ_INCRA_CPF; }
        set { mCNPJ_INCRA_CPF = value; }
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
    public string CNAE
    {
        get { return mCNAE; }
        set { mCNAE = value; }
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
    public string GFIP
    {
        get { return mGFIP; }
        set { mGFIP = value; }
    }
    public string DDDtel
    {
        get { return mDDDtel; }
        set { mDDDtel = value; }
    }
    public string Telefone
    {
        get { return mTelefone; }
        set { mTelefone = value; }
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
    public List<ClienteDepartamento> Departamentos //Vai armazenar uma lista
    {
        get { return mDepartamentos; }
        set { mDepartamentos = value; }
    }
    public List<String> Setores //Vai armazenar uma lista
    {
        get { return mSetores; }
        set { mSetores = value; }
    }

    //public List<String> Usuarios //Vai armazenar uma lista
    //{
    //    get { return mUsuarios; }
    //    set { mUsuarios = value; }
    //}
}