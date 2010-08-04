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
using System.ComponentModel;

public partial class UserControls_DropDownList_UsuariosPerfil : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            UsuarioPerfilBO ObjUsuarioPerfilBO = new UsuarioPerfilBO();
            ddlUsuarioPerfil.DataSource = ObjUsuarioPerfilBO.SelectUsuarioPerfilALL();
            ddlUsuarioPerfil.DataTextField = "Nome";
            ddlUsuarioPerfil.DataValueField = "ID";
            ddlUsuarioPerfil.DataBind();
            ddlUsuarioPerfil.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }

    public string TextoInformado
    {
        get
        {
            return ddlUsuarioPerfil.SelectedItem.Text;
        }
        set
        {
            ddlUsuarioPerfil.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlUsuarioPerfil.SelectedItem.Value;
        }
        set
        {
            ddlUsuarioPerfil.SelectedValue = value;
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
    protected void ddlUsuarioPerfil_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (SelectedIndexChanged != null)
            SelectedIndexChanged(this, e);
    }
}
