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
/// Summary description for Profissional
/// </summary>
public class Profissional
{
    private int mId;
    private string midTipoProfissional;
    private string mCPF;
    private string mRG;
    private string midOrgaoExpeditor;
	private string mDtExpedicao;
	private string mRgUFemissao;
	private string mNome;
	private string mDtNascimento;
    private string mSexo;
	private string mEmail;
	private string mEstadoCivil;
	private string mEndResidencia;
    private string mNumero;
    private string mComplemento;
	private string mBairro;
	private string mCEP;
	private string mCidade;
	private string mUF;
	private string mDDDtel;
	private string mTelefone;
	private string mDDDcel;
    private string mCelular;
    private string mConselhoProfissional;
    private string mConselhoNumero;
    private string mConselhoUF;
    private string mCBOS_1;
    private string mCBOS_2;
    private string mCBOS_3;
    private string mCBOS_4;
    private string mCBOS_5;
    private string mCBOS_6;
    
	public Profissional()
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
    public string idTipoProfissional
    {
        get { return midTipoProfissional; }
        set { midTipoProfissional = value; }
    }
    public string CPF
    {
        get { return mCPF; }
        set { mCPF = value; }
    }
    public string RG
    {
        get { return mRG; }
        set { mRG = value; }
    }
    public string idOrgaoExpeditor
    {
        get { return midOrgaoExpeditor; }
        set { midOrgaoExpeditor = value; }
    }
    public string DtExpedicao
    {
        get { return mDtExpedicao; }
        set { mDtExpedicao = value; }
    }
    public string RgUFemissao
    {
        get { return mRgUFemissao; }
        set { mRgUFemissao = value; }
    }
    public string Nome
    {
        get { return mNome; }
        set { mNome = value; }
    }
    public string DtNascimento
    {
        get { return mDtNascimento; }
        set { mDtNascimento = value; }
    }
    public string Sexo
    {
        get { return mSexo; }
        set { mSexo = value; }
    }
    public string Email
    {
        get { return mEmail; }
        set { mEmail = value; }
    }
    public string EstadoCivil
    {
        get { return mEstadoCivil; }
        set { mEstadoCivil = value; }
    }
    public string EndResidencia
    {
        get { return mEndResidencia; }
        set { mEndResidencia = value; }
    }
    public string Numero
    {
        get { return mNumero; }
        set { mNumero = value; }
    }
    public string Complemento
    {
        get { return mComplemento; }
        set { mComplemento = value; }
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
    public string Telefone
    {
        get { return mTelefone; }
        set { mTelefone = value; }
    }
    public string DDDcel
    {
        get { return mDDDcel; }
        set { mDDDcel = value; }
    }
    public string Celular
    {
        get { return mCelular; }
        set { mCelular = value; }
    }
    public string ConselhoProfissional
    {
        get { return mConselhoProfissional; }
        set { mConselhoProfissional = value; }
    }
    public string ConselhoNumero
    {
        get { return mConselhoNumero; }
        set { mConselhoNumero = value; }
    }
    public string ConselhoUF
    {
        get { return mConselhoUF; }
        set { mConselhoUF = value; }
    }
    public string CBOS_1
    {
        get { return mCBOS_1; }
        set { mCBOS_1 = value; }
    }
    public string CBOS_2
    {
        get { return mCBOS_2; }
        set { mCBOS_2 = value; }
    }
    public string CBOS_3
    {
        get { return mCBOS_3; }
        set { mCBOS_3 = value; }
    }
    public string CBOS_4
    {
        get { return mCBOS_4; }
        set { mCBOS_4 = value; }
    }
    public string CBOS_5
    {
        get { return mCBOS_5; }
        set { mCBOS_5 = value; }
    }
    public string CBOS_6
    {
        get { return mCBOS_6; }
        set { mCBOS_6 = value; }
    }
}
