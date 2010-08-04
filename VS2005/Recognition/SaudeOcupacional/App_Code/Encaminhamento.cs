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
/// Summary description for Encaminhamento
/// </summary>
public class Encaminhamento
{
    //Referencias a outras classes
    private Profissional ObjProfissional = new Profissional();
    private TipoAtestado ObjTipoAtestado = new TipoAtestado();
    private Cliente ObjCliente = new Cliente();
    private ProcessoSeletivo ObjProcessoSeletivo = new ProcessoSeletivo();
    private DateTime mDtRealizacao;
    //Fim das referencias

    private int mid;
    private int midCliente;
    private string midProcessoSeletivo;
    private string midClienteFuncionario;
    private int midTipoAtestado;
    private int midProfissional;

    private List<EncaminhamentoXExamesComplementares> mEncaminhamentoXExamesComplementares = new List<EncaminhamentoXExamesComplementares>(); //Vai armazenar uma lista

	public Encaminhamento()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    //Faz referencia a Classe de Cliente
    public TipoAtestado RefTipoAtestado
    {
        get { return ObjTipoAtestado; }
        set { ObjTipoAtestado = value; }
    }

    public Profissional RefProfissional
    {
        get { return ObjProfissional; }
        set { ObjProfissional = value; }
    }

    public Cliente RefCliente
    {
        get { return ObjCliente; }
        set { ObjCliente = value; }
    }

    public ProcessoSeletivo RefProcessoSeletivo
    {
        get { return ObjProcessoSeletivo; }
        set { ObjProcessoSeletivo = value; }
    }

    public List<EncaminhamentoXExamesComplementares> EncaminhamentoXExamesComplementares //Vai armazenar uma lista
    {
        get { return mEncaminhamentoXExamesComplementares; }
        set { mEncaminhamentoXExamesComplementares = value; }
    }
    //Final das referencias as outras classes


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

    public string idProcessoSeletivo
    {
        get { return midProcessoSeletivo; }
        set { midProcessoSeletivo = value; }
    }

    public string idClienteFuncionario
    {
        get { return midClienteFuncionario; }
        set { midClienteFuncionario = value; }
    }

    public int idTipoAtestado
    {
        get { return midTipoAtestado; }
        set { midTipoAtestado = value; }
    }

    public int idProfissional
    {
        get { return midProfissional; }
        set { midProfissional = value; }
    }

    public DateTime DtRealizacao
    {
        get { return mDtRealizacao; }
        set { mDtRealizacao = value; }
    }
}
