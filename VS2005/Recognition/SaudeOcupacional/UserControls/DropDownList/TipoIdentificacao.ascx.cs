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

public partial class UserControls_DropDownList_TipoIdentificacao : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            TipoIdentificacaoBO ObjTipoIdentificacaoBO = new TipoIdentificacaoBO();
            ddlTipoIdentificacao.DataSource = ObjTipoIdentificacaoBO.DropDownList();
            ddlTipoIdentificacao.DataTextField = "Nome";
            ddlTipoIdentificacao.DataValueField = "ID";
            ddlTipoIdentificacao.DataBind();
            ddlTipoIdentificacao.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }

    public string TextoInformado
    {
        get
        {
            return ddlTipoIdentificacao.SelectedItem.Text;
        }
        set
        {
            ddlTipoIdentificacao.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlTipoIdentificacao.SelectedItem.Value;
        }
        set
        {
            ddlTipoIdentificacao.SelectedValue = value;
        }
    }
}
