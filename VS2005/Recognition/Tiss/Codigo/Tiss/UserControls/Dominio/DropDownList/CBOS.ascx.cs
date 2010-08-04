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

public partial class UserControls_Dominio_DropDownList_CBOS : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DominioCBOSDAL ObjDominioCBOSDAL = new DominioCBOSDAL();
            ddlCBOS.DataSource = ObjDominioCBOSDAL.DropDownList();
            ddlCBOS.DataTextField = "Descricao";
            ddlCBOS.DataValueField = "ID";
            ddlCBOS.DataBind();
            ddlCBOS.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }
    public string TextoInformado
    {
        get
        {
            return ddlCBOS.SelectedItem.Text;
        }
        set
        {
            ddlCBOS.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlCBOS.SelectedItem.Value;
        }
        set
        {
            ddlCBOS.SelectedValue = value;
        }
    }
}
