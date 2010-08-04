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

public partial class UserControls_DropDownList_PCMSOPeriodicidadel : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            PCMSOPeriodicidadeDAL ObjPCMSOPeriodicidadeDAL = new PCMSOPeriodicidadeDAL();
            ddlPCMSOPeriodicidade.DataSource = ObjPCMSOPeriodicidadeDAL.SelectAll();
            ddlPCMSOPeriodicidade.DataTextField = "Descricao";
            ddlPCMSOPeriodicidade.DataValueField = "id";
            ddlPCMSOPeriodicidade.DataBind();
            ddlPCMSOPeriodicidade.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty));
        }
    }

    public string TextoInformado
    {
        get
        {
            return ddlPCMSOPeriodicidade.SelectedItem.Text;
        }
        set
        {
            ddlPCMSOPeriodicidade.SelectedValue = value;
        }
    }

    public string ValorInformado
    {
        get
        {
            return ddlPCMSOPeriodicidade.SelectedItem.Value;
        }
        set
        {
            ddlPCMSOPeriodicidade.SelectedValue = value;
        }
    }
  
    
}
