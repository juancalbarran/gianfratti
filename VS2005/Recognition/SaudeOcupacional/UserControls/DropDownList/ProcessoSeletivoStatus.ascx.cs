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

public partial class UserControls_DropDownList_ProcessoSeletivoStatus : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ProcessoSeletivoStatusDAL ObjProcessoSeletivoStatusDAL = new ProcessoSeletivoStatusDAL();
            ddlProcessoSeletivoStatus.DataSource = ObjProcessoSeletivoStatusDAL.DropDownList();
            ddlProcessoSeletivoStatus.DataTextField = "Nome";
            ddlProcessoSeletivoStatus.DataValueField = "ID";
            ddlProcessoSeletivoStatus.DataBind();
            ddlProcessoSeletivoStatus.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }
    public string TextoInformado
    {
        get
        {
            return ddlProcessoSeletivoStatus.SelectedItem.Text;
        }
        set
        {
            ddlProcessoSeletivoStatus.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlProcessoSeletivoStatus.SelectedItem.Value;
        }
        set
        {
            ddlProcessoSeletivoStatus.SelectedValue = value;
        }
    }
}
