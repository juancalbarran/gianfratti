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
/// Summary description for ClienteFuncionarioProfissional
/// </summary>
public class ClienteFuncionarioProfissional
{
    //Referencias a outras classes
    private Cliente ObjCliente = new Cliente();
    private CBO ObjCBO = new CBO();
    //Fim das referencias

    private int mid;
    private int midFuncionario;
    private string midSetor;
    private string midCargo;
    private string midDepartamento;
    private int midFuncionarioStatus;
    private string mNumMatricula;
    private string mDtAdmissao;
    private string mDtDemissao;
    private string mUnidade;
    private string mSalario;
    private string mAposentado;
    private string mCBO;
    private string mDtPeriodoInicial;
    private string mDtPeriodoFinal;
    private string mDescricaoAtividades;
    private string mCBO_Funcao;
    private string mNumCTPS;
    private string mSerieCTPS;
    private string mUFCTPS;
    private string mFiliacaoPrevidencia;
    private string mPIS;
    private string mDepartamento;
    private string mSetor;

	public ClienteFuncionarioProfissional()
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
    public CBO RefCBO
    {
        get { return ObjCBO; }
        set { ObjCBO = value; }
    }
    //Final das referencias as outras classes

    public int id
    {
        get { return mid; }
        set { mid = value; }
    }
    public int idFuncionario
    {
        get { return midFuncionario; }
        set { midFuncionario = value; }
    }
    public string idDepartamento
    {
        get { return midDepartamento; }
        set { midDepartamento = value; }
    }
    public string idSetor
    {
        get { return midSetor; }
        set { midSetor = value; }
    }
    public string idCargo
    {
        get { return midCargo; }
        set { midCargo = value; }
    }
    public int idFuncionarioStatus
    {
        get { return midFuncionarioStatus; }
        set { midFuncionarioStatus = value; }
    }
    public string NumMatricula
    {
        get { return mNumMatricula; }
        set { mNumMatricula = value; }
    }
    public string DtAdmissao
    {
        get { return mDtAdmissao; }
        set { mDtAdmissao = value; }
    }
    public string DtDemissao
    {
        get { return mDtDemissao; }
        set { mDtDemissao = value; }
    }
    public string Unidade
    {
        get { return mUnidade; }
        set { mUnidade = value; }
    }
    public string Salario
    {
        get { return mSalario; }
        set { mSalario = value; }
    }
    public string Aposentado
    {
        get { return mAposentado; }
        set { mAposentado = value; }
    }
    public string CBO
    {
        get { return mCBO; }
        set { mCBO = value; }
    }
    public string CBO_Funcao
    {
        get { return mCBO_Funcao; }
        set { mCBO_Funcao = value; }
    }
    public string DtPeriodoInicial
    {
        get { return mDtPeriodoInicial; }
        set { mDtPeriodoInicial = value; }
    }
    public string DtPeriodoFinal
    {
        get { return mDtPeriodoFinal; }
        set { mDtPeriodoFinal = value; }
    }
    public string DescricaoAtividades
    {
        get { return mDescricaoAtividades; }
        set { mDescricaoAtividades = value; }
    }
    public string NumCTPS
    {
        get { return mNumCTPS; }
        set { mNumCTPS = value; }
    }
    public string SerieCTPS
    {
        get { return mSerieCTPS; }
        set { mSerieCTPS = value; }
    }
    public string UFCTPS
    {
        get { return mUFCTPS; }
        set { mUFCTPS = value; }
    }
    public string FiliacaoPrevidencia
    {
        get { return mFiliacaoPrevidencia; }
        set { mFiliacaoPrevidencia = value; }
    }
    public string PIS
    {
        get { return mPIS; }
        set { mPIS = value; }
    }
    public string Departamento
    {
        get { return mDepartamento; }
        set { mDepartamento = value; }
    }
    public string Setor
    {
        get { return mSetor; }
        set { mSetor = value; }
    }
}
