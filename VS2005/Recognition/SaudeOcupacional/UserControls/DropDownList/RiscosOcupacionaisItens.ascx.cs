using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class UserControls_DropDownList_RiscosOcupacionaisItens : System.Web.UI.UserControl
{
    int midRiscosOcupacionais = 0;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private void Carrega(int midRiscosOcupacionais)
    {
        if (midRiscosOcupacionais != 0)
        {
            RiscosOcupacionaisItensDAL ObjRiscosOcupacionaisItensDAL = new  RiscosOcupacionaisItensDAL();
            ddlRiscosOcupacionaisItens.DataSource = ObjRiscosOcupacionaisItensDAL.DropDownList(midRiscosOcupacionais);
            ddlRiscosOcupacionaisItens.DataTextField = "Descricao";
            ddlRiscosOcupacionaisItens.DataValueField = "ID";
            ddlRiscosOcupacionaisItens.DataBind();
            ddlRiscosOcupacionaisItens.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }


    public int idRiscosOcupacionais
    {
        get
        {
            return midRiscosOcupacionais;
        }
        set
        {
            midRiscosOcupacionais = value;
            Carrega(midRiscosOcupacionais);
        }
    }

    public string TextoInformado
    {
        get
        {
            return ddlRiscosOcupacionaisItens.SelectedItem.Text;
        }
        set
        {
            ddlRiscosOcupacionaisItens.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlRiscosOcupacionaisItens.SelectedItem.Value;
        }
        set
        {
            ddlRiscosOcupacionaisItens.SelectedValue = value;
        }
    }
}
