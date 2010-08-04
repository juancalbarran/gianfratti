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

public partial class UserControls_Dominio_DropDownList_RegimeInternacao : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DominioRegimeInternacaoDAL ObjDominioRegimeInternacaoDAL = new DominioRegimeInternacaoDAL();
            ddlRegimeInternacao.DataSource = ObjDominioRegimeInternacaoDAL.DropDownList();
            ddlRegimeInternacao.DataTextField = "Descricao";
            ddlRegimeInternacao.DataValueField = "ID";
            ddlRegimeInternacao.DataBind();
            ddlRegimeInternacao.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }
    public string TextoInformado
    {
        get
        {
            return ddlRegimeInternacao.SelectedItem.Text;
        }
        set
        {
            ddlRegimeInternacao.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlRegimeInternacao.SelectedItem.Value;
        }
        set
        {
            ddlRegimeInternacao.SelectedValue = value;
        }
    }
    public bool CampoObrigatorio
    {
        get
        {
            return ValidaRegimeInternacao.Enabled;
        }
        set
        {
            ValidaRegimeInternacao.Enabled = value;
        }
    }
}
