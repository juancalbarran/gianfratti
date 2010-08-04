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

public partial class UserControls_DropDownList_CBOS : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            CBOSDAL ObjCBOSDAL = new CBOSDAL();
            ddlCBOS.DataSource = ObjCBOSDAL.CBOSDropDownList();
            ddlCBOS.DataTextField = "Descricao";
            ddlCBOS.DataValueField = "Codigo";
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
