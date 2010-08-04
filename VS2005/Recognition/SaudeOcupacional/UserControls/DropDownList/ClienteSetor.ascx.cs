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

public partial class UserControls_DropDownList_ClienteSetor : System.Web.UI.UserControl
{
    int midClienteDepartamento;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private void Carrega(int midClienteDepartamento)
    {
        if (midClienteDepartamento != 0)
        {
            ClienteSetorDAL ObjClienteSetorDAL = new ClienteSetorDAL();
            ddlClienteSetor.DataSource = ObjClienteSetorDAL.DropDownList(midClienteDepartamento);
            ddlClienteSetor.DataTextField = "Nome";
            ddlClienteSetor.DataValueField = "ID";
            ddlClienteSetor.DataBind();
            ddlClienteSetor.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }

    public int idClienteDepartamento
    {
        get
        {
            return midClienteDepartamento;
        }
        set
        {
            midClienteDepartamento = value;
            Carrega(midClienteDepartamento);
        }
    }

    public string TextoInformado
    {
        get
        {
            return ddlClienteSetor.SelectedItem.Text;
        }
        set
        {
            ddlClienteSetor.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlClienteSetor.SelectedItem.Value;
        }
        set
        {
            ddlClienteSetor.SelectedValue = value;
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
    protected void ddlClienteSetor_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (SelectedIndexChanged != null)
            SelectedIndexChanged(this, e);
    }
}
