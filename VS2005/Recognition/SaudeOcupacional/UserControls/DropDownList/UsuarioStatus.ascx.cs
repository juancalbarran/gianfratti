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

public partial class UserControls_DropDownList_UsuarioStatus : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            UsuarioStatusBO ObjUsuarioStatusBO = new UsuarioStatusBO();
            ddlUsuarioStatus.DataSource = ObjUsuarioStatusBO.SelectUsuarioStatusALL();
            ddlUsuarioStatus.DataTextField = "Nome";
            ddlUsuarioStatus.DataValueField = "ID";
            ddlUsuarioStatus.DataBind();
            ddlUsuarioStatus.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }

    public string TextoInformado
    {
        get
        {
            return ddlUsuarioStatus.SelectedItem.Text;
        }
        set
        {
            ddlUsuarioStatus.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlUsuarioStatus.SelectedItem.Value;
        }
        set
        {
            ddlUsuarioStatus.SelectedValue = value;
        }
    }
}
