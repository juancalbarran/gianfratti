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

public partial class UserControls_DropDownList_ConselhoProfissional : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ConselhoProfissionalDAL ObjConselhoProfissionalDAL = new ConselhoProfissionalDAL();
            ddlConselhoProfissional.DataSource = ObjConselhoProfissionalDAL.ConselhoProfissionalDropDownList();
            ddlConselhoProfissional.DataTextField = "Descricao";
            ddlConselhoProfissional.DataValueField = "Codigo";
            ddlConselhoProfissional.DataBind();
            ddlConselhoProfissional.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }

    public string TextoInformado
    {
        get
        {
            return ddlConselhoProfissional.SelectedItem.Text;
        }
        set
        {
            ddlConselhoProfissional.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlConselhoProfissional.SelectedItem.Value;
        }
        set
        {
            ddlConselhoProfissional.SelectedValue = value;
        }
    }
}
