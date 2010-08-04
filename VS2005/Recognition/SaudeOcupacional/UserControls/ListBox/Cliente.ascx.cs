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

public partial class UserControls_ListBox_Cliente : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ClienteDAL ObjClienteDAL = new ClienteDAL();
            ListBoxCliente.DataSource = ObjClienteDAL.DropDownList(Convert.ToInt32(Session["idUsuario"]), Convert.ToInt32(Session["idPerfil"]));
            ListBoxCliente.DataTextField = "RazaoSocial";
            ListBoxCliente.DataValueField = "ID";
            ListBoxCliente.DataBind();
        }
    }

    public string TextoInformado
    {
        get
        {
            return ListBoxCliente.SelectedItem.Text;
        }
        set
        {
            ListBoxCliente.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ListBoxCliente.SelectedItem.Value;
        }
        set
        {
            ListBoxCliente.SelectedValue = value;
        }
    }
}
