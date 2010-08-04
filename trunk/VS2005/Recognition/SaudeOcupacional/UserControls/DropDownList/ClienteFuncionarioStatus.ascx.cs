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

public partial class UserControls_DropDownList_ClienteFuncionarioStatus : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ClienteFuncionarioStatusBO ObjClienteFuncionarioStatusBO = new ClienteFuncionarioStatusBO();
            ddlClienteFuncionarioStatus.DataSource = ObjClienteFuncionarioStatusBO.DropDownList();
            ddlClienteFuncionarioStatus.DataTextField = "Status";
            ddlClienteFuncionarioStatus.DataValueField = "ID";
            ddlClienteFuncionarioStatus.DataBind();
            ddlClienteFuncionarioStatus.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }

    public string TextoInformado
    {
        get
        {
            return ddlClienteFuncionarioStatus.SelectedItem.Text;
        }
        set
        {
            ddlClienteFuncionarioStatus.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlClienteFuncionarioStatus.SelectedItem.Value;
        }
        set
        {
            ddlClienteFuncionarioStatus.SelectedValue = value;
        }
    }
}
