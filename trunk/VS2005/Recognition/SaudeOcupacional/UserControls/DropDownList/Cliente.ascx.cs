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

public partial class UserControls_DropDownList_Cliente : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ClienteDAL ObjClienteDAL = new ClienteDAL();
            ddlCliente.DataSource = ObjClienteDAL.DropDownList(Convert.ToInt32(Session["idUsuario"]), Convert.ToInt32(Session["idPerfil"]));
            ddlCliente.DataTextField = "RazaoSocial";
            ddlCliente.DataValueField = "ID";
            ddlCliente.DataBind();
            ddlCliente.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }
    public string TextoInformado
    {
        get
        {
            return ddlCliente.SelectedItem.Text;
        }
        set
        {
            ddlCliente.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlCliente.SelectedItem.Value;
        }
        set
        {
            ddlCliente.SelectedValue = value;
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
    protected void ddlCliente_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (SelectedIndexChanged != null)
            SelectedIndexChanged(this, e);
    }
}
