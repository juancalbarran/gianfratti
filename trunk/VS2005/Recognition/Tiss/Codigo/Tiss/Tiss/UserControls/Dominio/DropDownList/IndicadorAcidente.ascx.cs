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

public partial class UserControls_Dominio_DropDownList_IndicadorAcidente : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DominioIndicadorAcidenteDAL ObjDominioIndicadorAcidenteDAL = new DominioIndicadorAcidenteDAL();
            ddlIndicacaoAcidente.DataSource = ObjDominioIndicadorAcidenteDAL.DropDownList();
            ddlIndicacaoAcidente.DataTextField = "Descricao";
            ddlIndicacaoAcidente.DataValueField = "ID";
            ddlIndicacaoAcidente.DataBind();
            ddlIndicacaoAcidente.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }
    public string TextoInformado
    {
        get
        {
            return ddlIndicacaoAcidente.SelectedItem.Text;
        }
        set
        {
            ddlIndicacaoAcidente.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlIndicacaoAcidente.SelectedItem.Value;
        }
        set
        {
            ddlIndicacaoAcidente.SelectedValue = value;
        }
    }
}
