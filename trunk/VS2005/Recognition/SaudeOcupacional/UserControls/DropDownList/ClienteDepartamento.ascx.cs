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

public partial class UserControls_DropDownList_ClienteDepartamento : System.Web.UI.UserControl
{
    int midCliente = 0;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private void Carrega(int midCliente)
    {
        if (midCliente != 0)
        {
            ClienteDepartamentoDAL ObjClienteDepartamentoDAL = new ClienteDepartamentoDAL();
            ddlClienteDepartamento.DataSource = ObjClienteDepartamentoDAL.DropDownList(midCliente);
            ddlClienteDepartamento.DataTextField = "Nome";
            ddlClienteDepartamento.DataValueField = "ID";
            ddlClienteDepartamento.DataBind();
            ddlClienteDepartamento.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }


    public int idCliente
    {
        get
        {
            return midCliente;
        }
        set
        {
            midCliente = value;
            Carrega(midCliente);
        }
    }

    public string TextoInformado
    {
        get
        {
            return ddlClienteDepartamento.SelectedItem.Text;
        }
        set
        {
            ddlClienteDepartamento.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlClienteDepartamento.SelectedItem.Value;
        }
        set
        {
            ddlClienteDepartamento.SelectedValue = value;
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
    protected void ddlClienteDepartamento_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (SelectedIndexChanged != null)
            SelectedIndexChanged(this, e);
    }
}
