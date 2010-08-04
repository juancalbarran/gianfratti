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

public partial class UserControls_Dominio_DropDownList_TipoDoenca : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DominioTipoDoencaDAL ObjDominioTipoDoencaDAL = new DominioTipoDoencaDAL();
            ddlTipoDoenca.DataSource = ObjDominioTipoDoencaDAL.DropDownList();
            ddlTipoDoenca.DataTextField = "Descricao";
            ddlTipoDoenca.DataValueField = "ID";
            ddlTipoDoenca.DataBind();
            ddlTipoDoenca.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }
    public string TextoInformado
    {
        get
        {
            return ddlTipoDoenca.SelectedItem.Text;
        }
        set
        {
            ddlTipoDoenca.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlTipoDoenca.SelectedItem.Value;
        }
        set
        {
            ddlTipoDoenca.SelectedValue = value;
        }
    }
}
