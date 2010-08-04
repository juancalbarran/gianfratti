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

public partial class UserControls_DropDownList_RiscosOcupacionaisascx : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            RiscosOcupacionaisDAL ObjRiscosOcupacionaisDAL = new RiscosOcupacionaisDAL();
            ddlRiscosOcupacionais.DataSource = ObjRiscosOcupacionaisDAL.DropDownList();
            ddlRiscosOcupacionais.DataTextField = "Descricao";
            ddlRiscosOcupacionais.DataValueField = "ID";
            ddlRiscosOcupacionais.DataBind();
            ddlRiscosOcupacionais.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }


    public string TextoInformado
    {
        get
        {
            return ddlRiscosOcupacionais.SelectedItem.Text;
        }
        set
        {
            ddlRiscosOcupacionais.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlRiscosOcupacionais.SelectedItem.Value;
        }
        set
        {
            ddlRiscosOcupacionais.SelectedValue = value;
        }
    }

    //Declaração do envento SelectedIndexChanged
    public event EventHandler SelectedIndexChanged;
    //Evento do combo. Nao esquecer de setar a propriedade AutoPostBack="True"
    //Na pagina onde sera usado o usercontrol vc deve criar o evento abaixo no page_load fora do IsPostBack
    //ddlUsuarioPerfil.SelectedIndexChanged += new EventHandler(ddlUsuarioPerfil_SelectedIndexChanged);
    //Logo apos criar o evento na pagina
    //private void NomeCombo_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //Codigo da pagina
    //}
    protected void ddlRiscosOcupacionais_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (SelectedIndexChanged != null)
            SelectedIndexChanged(this, e);
    }
}
