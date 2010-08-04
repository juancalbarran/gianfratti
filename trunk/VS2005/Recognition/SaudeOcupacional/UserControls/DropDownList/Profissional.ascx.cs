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

public partial class UserControls_DropDownList_Profissional : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ProfissionalBO ObjProfissionalBO = new ProfissionalBO();
            ddlProfissional.DataSource = ObjProfissionalBO.DropDownList();
            ddlProfissional.DataTextField = "Nome";
            ddlProfissional.DataValueField = "ID";
            ddlProfissional.DataBind();
            ddlProfissional.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }

    public string TextoInformado
    {
        get
        {
            return ddlProfissional.SelectedItem.Text;
        }
        set
        {
            ddlProfissional.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlProfissional.SelectedItem.Value;
        }
        set
        {
            ddlProfissional.SelectedValue = value;
        }
    }
}
