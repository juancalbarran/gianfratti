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
/// Summary description for AtestadoSaude
/// </summary>
public class AtestadoSaude
{
    //Referencias a outras classes
    private ClienteFuncionario ObjClienteFuncionario = new ClienteFuncionario();
    private TipoAtestado ObjTipoAtestado = new TipoAtestado();
    private StatusAtestado ObjStatusAtestado = new StatusAtestado();
    //Fim das referencias

    private int mId;
    private string midProfissional_MedicoCoordenador;
    private string midProfissional_MedicoExaminador;
    private string midTipoAtestado;
    private string midClienteFuncionario;
    private string midStatusAtestado;
    private string mDataConsulta;
    private string mDataCadastro;
    private string mObservacoes;
    private string mPendencia;
    private string mCRM;

    //Faz referencia a Classe de Cliente
    public ClienteFuncionario RefClienteFuncionario
    {
        get { return ObjClienteFuncionario; }
        set { ObjClienteFuncionario = value; }
    }
    public TipoAtestado RefTipoAtestado
    {
        get { return ObjTipoAtestado; }
        set { ObjTipoAtestado = value; }
    }
    public StatusAtestado RefStatusAtestado
    {
        get { return ObjStatusAtestado; }
        set { ObjStatusAtestado = value; }
    }
    //Final das referencias as outras classes

	public AtestadoSaude()
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
    public string idProfissional_MedicoCoordenador
    {
        get { return midProfissional_MedicoCoordenador; }
        set { midProfissional_MedicoCoordenador = value; }
    }
    public string idProfissional_MedicoExaminador
    {
        get { return midProfissional_MedicoExaminador; }
        set { midProfissional_MedicoExaminador = value; }
    }
    public string idTipoAtestado
    {
        get { return midTipoAtestado; }
        set { midTipoAtestado = value; }
    }
    public string idClienteFuncionario
    {
        get { return midClienteFuncionario; }
        set { midClienteFuncionario = value; }
    }
    public string idStatusAtestado
    {
        get { return midStatusAtestado; }
        set { midStatusAtestado = value; }
    }
    public string DataConsulta
    {
        get { return mDataConsulta; }
        set { mDataConsulta = value; }
    }
    public string DataCadastro
    {
        get { return mDataCadastro; }
        set { mDataCadastro = value; }
    }
    public string Observacoes
    {
        get { return mObservacoes; }
        set { mObservacoes = value; }
    }
    public string Pendencia
    {
        get { return mPendencia; }
        set { mPendencia = value; }
    }
    public string CRM
    {
        get { return mCRM; }
        set { mCRM = value; }
    }
}
