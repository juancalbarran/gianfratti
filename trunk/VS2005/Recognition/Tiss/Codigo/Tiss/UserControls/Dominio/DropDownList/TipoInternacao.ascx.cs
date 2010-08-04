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

public partial class UserControls_Dominio_DropDownList_TipoInternacao : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DominioTipoInternacaoDAL ObjDominioTipoInternacaoDAL = new DominioTipoInternacaoDAL();
            ddlTipoInternacao.DataSource = ObjDominioTipoInternacaoDAL.DropDownList();
            ddlTipoInternacao.DataTextField = "Descricao";
            ddlTipoInternacao.DataValueField = "ID";
            ddlTipoInternacao.DataBind();
            ddlTipoInternacao.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }
    public string TextoInformado
    {
        get
        {
            return ddlTipoInternacao.SelectedItem.Text;
        }
        set
        {
            ddlTipoInternacao.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlTipoInternacao.SelectedItem.Value;
        }
        set
        {
            ddlTipoInternacao.SelectedValue = value;
        }
    }
    public bool CampoObrigatorio
    {
        get
        {
            return ValidaTipoInternacao.Enabled;
        }
        set
        {
            ValidaTipoInternacao.Enabled = value;
        }
    }
}
