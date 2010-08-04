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

public partial class UserControls_Dominio_DropDownList_Tabelas : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DominioTabelasDAL ObjDominioTabelasDAL = new DominioTabelasDAL();
            ddlTabelas.DataSource = ObjDominioTabelasDAL.DropDownList();
            ddlTabelas.DataTextField = "Descricao";
            ddlTabelas.DataValueField = "ID";
            ddlTabelas.DataBind();
            ddlTabelas.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }
    public string TextoInformado
    {
        get
        {
            return ddlTabelas.SelectedItem.Text;
        }
        set
        {
            ddlTabelas.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlTabelas.SelectedItem.Value;
        }
        set
        {
            ddlTabelas.SelectedValue = value;
        }
    }
}
