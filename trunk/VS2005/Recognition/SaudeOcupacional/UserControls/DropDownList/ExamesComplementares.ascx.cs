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

public partial class UserControls_DropDownList_ExamesComplementares : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ExamesComplementaresDAL ObjExamesComplementaresDAL = new ExamesComplementaresDAL();
            ddlExamesComplementares.DataSource = ObjExamesComplementaresDAL.DropDownlist();
            ddlExamesComplementares.DataTextField = "Descricao";
            ddlExamesComplementares.DataValueField = "Id";
            ddlExamesComplementares.DataBind();
            ddlExamesComplementares.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
    }
    public string TextoInformado
    {
        get
        {
            return ddlExamesComplementares.SelectedItem.Text;
        }
        set
        {
            ddlExamesComplementares.SelectedValue = value;
        }
    }
    public string ValorInformado
    {
        get
        {
            return ddlExamesComplementares.SelectedItem.Value;
        }
        set
        {
            ddlExamesComplementares.SelectedValue = value;
        }
    }
}
