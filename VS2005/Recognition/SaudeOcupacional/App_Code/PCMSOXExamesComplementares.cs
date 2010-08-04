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
/// Summary description for PCMSOXExamesComplementares
/// </summary>
public class PCMSOXExamesComplementares
{

    private int mid;
    private int midPCMSO;
    private int midCargo;
    private int midTipoAtestado;
    private int midExamesComplementares;
    private string midPeriodicidade;

    //Construtor da Classe
    public PCMSOXExamesComplementares(int idPCMSO, int idCargo, int idTipoAtestado, int idExamesComplementares, string idPeriodicidade)
    {
        midPCMSO = idPCMSO;
        midCargo = idCargo;
        midTipoAtestado = idTipoAtestado;
        midExamesComplementares = idExamesComplementares;
        midPeriodicidade = idPeriodicidade;
    }

    public int id
    {
        get { return mid; }
        set { mid = value; }
    }

    public int idPCMSO
    {
        get { return midPCMSO; }
        set { midPCMSO = value; }
    }

    public int idCargo
    {
        get { return midCargo; }
        set { midCargo = value; }
    }

    public int idTipoAtestado
    {
        get { return midTipoAtestado; }
        set { midTipoAtestado = value; }
    }

    public int idExamesComplementares
    {
        get { return midExamesComplementares; }
        set { midExamesComplementares = value; }
    }

    public string idPeriodicidade
    {
        get { return midPeriodicidade; }
        set { midPeriodicidade = value; }
    }

}
