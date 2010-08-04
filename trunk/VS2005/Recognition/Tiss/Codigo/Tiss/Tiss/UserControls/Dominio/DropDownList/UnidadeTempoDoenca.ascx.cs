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
using TissObjetos;

public partial class UserControls_Dominio_DropDownList_UnidadeTempoDoenca : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DominioUnidadeTempoDoencaDAL ObjDominioUnidadeTempoDoencaDAL = new DominioUnidadeTempoDoencaDAL();
            ddlTempoDoencaUnidade.DataSource = ObjDominioUnidadeTempoDoencaDAL.DropDownList();
            ddlTempoDoencaUnidade.DataTextField = "Descricao";
            ddlTempoDoencaUnidade.DataValueField = "ID";
            ddlTempoDoencaUnidade.DataBind();
            ddlTempoDoencaUnidade.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }
    public string TextoInformado
    {
        get
        {
            return ddlTempoDoencaUnidade.SelectedItem.Text;
        }
        set
        {
            ddlTempoDoencaUnidade.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlTempoDoencaUnidade.SelectedItem.Value;
        }
        set
        {
            ddlTempoDoencaUnidade.SelectedValue = value;
        }
    }
}
