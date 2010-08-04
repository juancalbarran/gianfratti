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

public partial class UserControls_Dominio_DropDownList_ConselhoProfissional : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DominioConselhoProfissionalDAL ObjDominioConselhoProfissionalDAL = new DominioConselhoProfissionalDAL();
            ddlConselhoProfissional.DataSource = ObjDominioConselhoProfissionalDAL.DropDownList();
            ddlConselhoProfissional.DataTextField = "Descricao";
            ddlConselhoProfissional.DataValueField = "ID";
            ddlConselhoProfissional.DataBind();
            ddlConselhoProfissional.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }
    public string TextoInformado
    {
        get
        {
            return ddlConselhoProfissional.SelectedItem.Text;
        }
        set
        {
            ddlConselhoProfissional.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlConselhoProfissional.SelectedItem.Value;
        }
        set
        {
            ddlConselhoProfissional.SelectedValue = value;
        }
    }
    public bool CampoObrigatorio
    {
        get
        {
            return ValidaConselhoProfissional.Enabled;
        }
        set
        {
            ValidaConselhoProfissional.Enabled = value;
        }
    }
}
