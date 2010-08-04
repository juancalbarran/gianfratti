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
/// Summary description for EncaminhamentoXExamesComplementares
/// </summary>
public class EncaminhamentoXExamesComplementares
{
    //Referencias a outras classes
    private ExamesComplementares ObjExamesComplementares = new ExamesComplementares();
    //Fim das Referencias
    private int mId;
    private int mIdEncaminhamento;
    private int mIdExamesComplementares;

    //Faz referencia a Classe de Exames Complementares
    public ExamesComplementares RefExamesComplementares
    {
        get { return ObjExamesComplementares; }
        set { ObjExamesComplementares = value; }
    }
    //Final da Referencia à Classe de Exames Complementares

    public EncaminhamentoXExamesComplementares(int IdEncaminhamento, int IdExamesComplementares)
	{
        mIdEncaminhamento = IdEncaminhamento;
        mIdExamesComplementares = IdExamesComplementares;
	}

    public EncaminhamentoXExamesComplementares()
    {

    }

    public int id
    {
        get { return mId; }
        set { mId = value; }
    }

    public int IdEncaminhamento
    {
        get { return mIdEncaminhamento; }
        set { mIdEncaminhamento = value; }
    }

    public int IdExamesComplementares
    {
        get { return mIdExamesComplementares; }
        set { mIdExamesComplementares = value; }
    }
}
