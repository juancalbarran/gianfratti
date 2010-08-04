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

public partial class UserControls_DropDownList_Ano : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ddlAno.Items.Insert(0, new ListItem("--", string.Empty)); //Texto Inicial do combo
    }

    public string TextoInformado
    {
        get
        {
            return ddlAno.SelectedItem.Text;
        }
        set
        {
            ddlAno.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlAno.SelectedItem.Value;
        }
        set
        {
            ddlAno.SelectedValue = value;
        }
    }
}
