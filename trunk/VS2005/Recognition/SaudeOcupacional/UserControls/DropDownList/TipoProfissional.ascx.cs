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

public partial class UserControls_DropDownList_TipoProfissional : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            TipoProfissionalBO ObjTipoProfissionalBO = new TipoProfissionalBO();
            ddlTipoProfissional.DataSource = ObjTipoProfissionalBO.DropDownList();
            ddlTipoProfissional.DataTextField = "Nome";
            ddlTipoProfissional.DataValueField = "ID";
            ddlTipoProfissional.DataBind();
            ddlTipoProfissional.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }

    public string TextoInformado
    {
        get
        {
            return ddlTipoProfissional.SelectedItem.Text;
        }
        set
        {
            ddlTipoProfissional.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlTipoProfissional.SelectedItem.Value;
        }
        set
        {
            ddlTipoProfissional.SelectedValue = value;
        }
    }
}
