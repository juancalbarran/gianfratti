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
/// Summary description for ProcessoSeletivo
/// </summary>
public class ProcessoSeletivo
{
    //Referencias a outras classes
    private Cliente ObjCliente = new Cliente();
    private ClienteDepartamento ObjClienteDepartamento = new ClienteDepartamento();
    private ClienteSetor ObjClienteSetor = new ClienteSetor();
    private ProcessoSeletivoStatus ObjProcessoSeletivoStatus = new ProcessoSeletivoStatus();
    //Fim das referencias

    private int mId;
    private int mIdCliente;
    private int mIdSetor;
    private int mIdDepartamento;
    private int mIdProcessoSeletivoStatus; 
    private string mNome;
    private string mCPF;
    private string mDtNascimento;
    private string mSexo;
    private string mFuncao;

	public ProcessoSeletivo()
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
    public ClienteDepartamento RefClienteDepartamento
    {
        get { return ObjClienteDepartamento; }
        set { ObjClienteDepartamento = value; }
    }
    public ClienteSetor RefClienteSetor
    {
        get { return ObjClienteSetor; }
        set { ObjClienteSetor = value; }
    }
    public ProcessoSeletivoStatus RefProcessoSeletivoStatus
    {
        get { return ObjProcessoSeletivoStatus; }
        set { ObjProcessoSeletivoStatus = value; }
    }
    //Final das referencias as outras classes

    public int id
    {
        get { return mId; }
        set { mId = value; }
    }

    public int idCliente
    {
        get { return mIdCliente; }
        set { mIdCliente = value; }
    }

    public int IdSetor
    {
        get { return mIdSetor; }
        set { mIdSetor = value; }
    }

    public int IdDepartamento
    {
        get { return mIdDepartamento; }
        set { mIdDepartamento = value; }
    }

    public int IdProcessoSeletivoStatus
    {
        get { return mIdProcessoSeletivoStatus; }
        set { mIdProcessoSeletivoStatus = value; }
    }

    public string Nome
    {
        get { return mNome; }
        set { mNome = value; }
    }

    public string CPF
    {
        get { return mCPF; }
        set { mCPF = value; }
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

    public string Funcao
    {
        get { return mFuncao; }
        set { mFuncao = value; }
    }

}
