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

public partial class UserControls_DropDownList_ClienteCargo : System.Web.UI.UserControl
{
    int midClienteSetor = 0;

    protected void Page_Load(object sender, EventArgs e)
    {


    }

    private void Carrega(int midClienteSetor)
    {
        if (idClienteSetor != 0)
        {
            ClienteCargoDAL ObjClienteCargoDAL = new ClienteCargoDAL();
            ddlClienteCargo.DataSource = ObjClienteCargoDAL.DropDownList(midClienteSetor);
            ddlClienteCargo.DataTextField = "Nome";
            ddlClienteCargo.DataValueField = "ID";
            ddlClienteCargo.DataBind();
            ddlClienteCargo.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }

    public int idClienteSetor
    {
        get
        {
            return midClienteSetor;
        }
        set
        {
            midClienteSetor = value;
            Carrega(midClienteSetor);
        }
    }

    public string TextoInformado
    {
        get
        {
            return ddlClienteCargo.SelectedItem.Text;
        }
        set
        {
            ddlClienteCargo.SelectedValue = value;
        }
    }

    public string ValorInformado
    {
        get
        {
            return ddlClienteCargo.SelectedItem.Value;
        }
        set
        {
            ddlClienteCargo.SelectedValue = value;
        }
    }

    //Declaração do envento SelectedIndexChanged
    public event EventHandler SelectedIndexChanged;
    //Evento do combo. Nao esquecer de setar a propriedade AutoPostBack="True"
    //Na pagina onde sera usado o usercontrol vc deve criar o evento abaixo no page_load fora do IsPostBack
    //ddlUsuarioPerfil.SelectedIndexChanged += new EventHandler(ddlUsuarioPerfil_SelectedIndexChanged);
    //Logo apos criar o evento na pagina
    //private void NomeCombo_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //Codigo da pagina
    //}
    protected void ddlClienteCargo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (SelectedIndexChanged != null)
            SelectedIndexChanged(this, e);
    }
}

