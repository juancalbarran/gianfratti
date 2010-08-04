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
/// Summary description for PCMSOXRiscosOcupacionais
/// </summary>
public class PCMSOXRiscosOcupacionais
{

    private int mid;
    private int midPCMSO;
    private int midCargo;
    private int midRiscosOcupacionais;
    private int midRiscosOcupacionaisItens;

    public PCMSOXRiscosOcupacionais()
    {

    }

    public PCMSOXRiscosOcupacionais(int idPCMSO, int idCargo, int idRiscosOcupacionais, int idRiscosOcupacionaisItens)
    {
        midPCMSO = idPCMSO;
        midCargo = idCargo;
        midRiscosOcupacionais = idRiscosOcupacionais;
        midRiscosOcupacionaisItens = idRiscosOcupacionaisItens;
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

    public int idRiscosOcupacionais
    {
        get { return midRiscosOcupacionais; }
        set { midRiscosOcupacionais = value; }
    }

    public int idRiscosOcupacionaisItens
    {
        get { return midRiscosOcupacionaisItens; }
        set { midRiscosOcupacionaisItens = value; }
    }
}
