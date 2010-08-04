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

public partial class UserControls_DropDownList_Estados : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ddlEstados.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }

    public string TextoInformado
    {
        get
        {
            return ddlEstados.SelectedItem.Text;
        }
        set
        {
            ddlEstados.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlEstados.SelectedItem.Value;
        }
        set
        {
            ddlEstados.SelectedValue = value;
        }
    }
}
