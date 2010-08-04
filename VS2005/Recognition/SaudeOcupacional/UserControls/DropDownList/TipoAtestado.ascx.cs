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

public partial class UserControls_DropDownList_TipoAtestado : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            TipoAtestadoBO ObjTipoAtestadoBO = new TipoAtestadoBO();
            ddlTipoAtestato.DataSource = ObjTipoAtestadoBO.DropDownList();
            ddlTipoAtestato.DataTextField = "Nome";
            ddlTipoAtestato.DataValueField = "ID";
            ddlTipoAtestato.DataBind();
            ddlTipoAtestato.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }

    public string TextoInformado
    {
        get
        {
            return ddlTipoAtestato.SelectedItem.Text;
        }
        set
        {
            ddlTipoAtestato.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlTipoAtestato.SelectedItem.Value;
        }
        set
        {
            ddlTipoAtestato.SelectedValue = value;
        }
    }
}
