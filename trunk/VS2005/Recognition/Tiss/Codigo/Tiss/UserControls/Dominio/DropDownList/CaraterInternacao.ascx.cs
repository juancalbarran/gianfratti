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

public partial class UserControls_Dominio_DropDownList_CaraterInternacao : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DominioCaraterInternacaoDAL ObjDominioCaraterInternacaoDAL = new DominioCaraterInternacaoDAL();
            ddlCaraterInternacao.DataSource = ObjDominioCaraterInternacaoDAL.DropDownList();
            ddlCaraterInternacao.DataTextField = "Descricao";
            ddlCaraterInternacao.DataValueField = "ID";
            ddlCaraterInternacao.DataBind();
            ddlCaraterInternacao.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }
    public string TextoInformado
    {
        get
        {
            return ddlCaraterInternacao.SelectedItem.Text;
        }
        set
        {
            ddlCaraterInternacao.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlCaraterInternacao.SelectedItem.Value;
        }
        set
        {
            ddlCaraterInternacao.SelectedValue = value;
        }
    }
    public bool CampoObrigatorio
    {
        get
        {
            return ValidaCaraterInternacao.Enabled;
        }
        set
        {
            ValidaCaraterInternacao.Enabled = value;
        }
    }
}
