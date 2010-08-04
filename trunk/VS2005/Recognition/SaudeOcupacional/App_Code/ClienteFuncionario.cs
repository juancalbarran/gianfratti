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
/// Summary description for ClienteFuncionario
/// </summary>
public class ClienteFuncionario
{
    //Referencias a outras classes
    private Cliente ObjCliente = new Cliente();
    private ClienteFuncionarioProfissional ObjClienteFuncionarioProfissional = new ClienteFuncionarioProfissional();
    
    //private ClienteFuncionarioAtribuicao ObjClienteFuncionarioAtribuicao;

    //DADOS PESSOAIS DO FUNCIONARIO
    private int mid;
    private int midCliente;
    private string midOrgaoExpeditor;
    private string mCPF;
    private string mRG;
    private string mDtExpedicao;
    private string mRgUFemissao;
    private string mNome;
    private string mDtNascimento;
    private string mDtObito;
    private string mSexo;
    private string mEstadoCivil;
    private string mMae;
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
    private string mDDDcontato;
    private string mTelefoneContato;
    private string mContatoNome;

    //DADOS PROFISSIONAIS DO FUNCIONARIO
    //private int midFuncionario;
    //private int midSetor;
    //private int midFuncionarioStatus;
    //private string mNumMatricula;
    //private string mDtAdmissao;
    //private string mDtDemissao;
    //private string mUnidade;
    //private string mSalario;
    //private string mAposentado;
    //private string mCBO;
    //private string mNumCTPS;
    //private string mSerieCTPS;
    //private string mUFCTPS;
    //private string mFiliacaoPrevidencia;
    //private string mPIS;
    //private string mDepartamento;
    //private string mSetor;
    //private string mFuncao;
    


    public ClienteFuncionario()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    //Faz referencia a Classe de Cliente
    public Cliente RefCliente
    {
        get { return ObjCliente; }
        set { ObjCliente = value; }
    }

    public ClienteFuncionarioProfissional RefClienteFuncionarioProfissional
    {
        get { return ObjClienteFuncionarioProfissional; }
        set { ObjClienteFuncionarioProfissional = value; }
    }

    //Faz referencia a Classe de Funcionario Atribuição
    //public ClienteFuncionarioAtribuicao RefClienteFuncionarioAtribuicao
    //{
    //    get { return ObjClienteFuncionarioAtribuicao; }
    //    set { ObjClienteFuncionarioAtribuicao = value; }
    //}

    //DADOS PESSOAIS
    public int id
    {
        get { return mid; }
        set { mid = value; }
    }

    public int idCliente
    {
        get { return midCliente; }
        set { midCliente = value; }
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

    public string DtObito
    {
        get { return mDtObito; }
        set { mDtObito = value; }
    }

    public string Sexo
    {
        get { return mSexo; }
        set { mSexo = value; }
    }

    public string EstadoCivil
    {
        get { return mEstadoCivil; }
        set { mEstadoCivil = value; }
    }

    public string Mae
    {
        get { return mMae; }
        set { mMae = value; }
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

    public string Telefone
    {
        get { return mTelefone; }
        set { mTelefone = value; }
    }

    public string DDDtel
    {
        get { return mDDDtel; }
        set { mDDDtel = value; }
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

    public string DDDcontato
    {
        get { return mDDDcontato; }
        set { mDDDcontato = value; }
    }

    public string TelefoneContato
    {
        get { return mTelefoneContato; }
        set { mTelefoneContato = value; }
    }

    public string ContatoNome
    {
        get { return mContatoNome; }
        set { mContatoNome = value; }
    }

    ////DADOS PROFISSIONAIS
    //public int idFuncionario
    //{
    //    get { return midFuncionario; }
    //    set { midFuncionario = value; }
    //}
    //public int idSetor
    //{
    //    get { return midSetor; }
    //    set { midSetor = value; }
    //}
    //public int idFuncionarioStatus
    //{
    //    get { return midFuncionarioStatus; }
    //    set { midFuncionarioStatus = value; }
    //}
    //public string NumMatricula
    //{
    //    get { return mNumMatricula; }
    //    set { mNumMatricula = value; }
    //}
    //public string DtAdmissao
    //{
    //    get { return mDtAdmissao; }
    //    set { mDtAdmissao = value; }
    //}
    //public string DtDemissao
    //{
    //    get { return mDtDemissao; }
    //    set { mDtDemissao = value; }
    //}
    //public string Unidade
    //{
    //    get { return mUnidade; }
    //    set { mUnidade = value; }
    //}
    //public string Salario
    //{
    //    get { return mSalario; }
    //    set { mSalario = value; }
    //}
    //public string Aposentado
    //{
    //    get { return mAposentado; }
    //    set { mAposentado = value; }
    //}
    //public string CBO
    //{
    //    get { return mCBO; }
    //    set { mCBO = value; }
    //}
    //public string NumCTPS
    //{
    //    get { return mNumCTPS; }
    //    set { mNumCTPS = value; }
    //}
    //public string SerieCTPS
    //{
    //    get { return mSerieCTPS; }
    //    set { mSerieCTPS = value; }
    //}
    //public string UFCTPS
    //{
    //    get { return mUFCTPS; }
    //    set { mUFCTPS = value; }
    //}
    //public string FiliacaoPrevidencia
    //{
    //    get { return mFiliacaoPrevidencia; }
    //    set { mFiliacaoPrevidencia = value; }
    //}
    //public string PIS
    //{
    //    get { return mPIS; }
    //    set { mPIS = value; }
    //}
    //public string Departamento
    //{
    //    get { return mDepartamento; }
    //    set { mDepartamento = value; }
    //}
    //public string Setor
    //{
    //    get { return mSetor; }
    //    set { mSetor = value; }
    //}
    //public string Funcao
    //{
    //    get { return mFuncao; }
    //    set { mFuncao = value; }
    //}

}
