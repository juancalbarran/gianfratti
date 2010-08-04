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

public partial class UserControls_Dominio_DropDownList_TipoAcomodacao : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DominioTipoAcomodacaoDAL ObjDominioTipoAcomodacaoDAL = new DominioTipoAcomodacaoDAL(); ;
            ddlTipoAcomodacao.DataSource = ObjDominioTipoAcomodacaoDAL.DropDownList();
            ddlTipoAcomodacao.DataTextField = "Descricao";
            ddlTipoAcomodacao.DataValueField = "ID";
            ddlTipoAcomodacao.DataBind();
            ddlTipoAcomodacao.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }
    public string TextoInformado
    {
        get
        {
            return ddlTipoAcomodacao.SelectedItem.Text;
        }
        set
        {
            ddlTipoAcomodacao.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlTipoAcomodacao.SelectedItem.Value;
        }
        set
        {
            ddlTipoAcomodacao.SelectedValue = value;
        }
    }
}
