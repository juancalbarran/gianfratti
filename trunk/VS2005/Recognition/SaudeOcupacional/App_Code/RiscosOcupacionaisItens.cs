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
/// Summary description for RiscosOcupacionaisItens
/// </summary>
public class RiscosOcupacionaisItens
{
    //Referencias a outras classes
    private RiscosOcupacionais ObjRiscosOcupacionais = new RiscosOcupacionais();
    //Fim das referencias

    private int mid;
    private string mDescricao;

	public RiscosOcupacionaisItens()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    //Faz referencia a outras classes
    public RiscosOcupacionais RefRiscosOcupacionais
    {
        get { return ObjRiscosOcupacionais; }
        set { ObjRiscosOcupacionais = value; }
    }
    //Final das referencias as outras classes

    public int id
    {
        get { return mid; }
        set { mid = value; }
    }

    public string Descricao
    {
        get { return mDescricao; }
        set { mDescricao = value; }
    }
}
