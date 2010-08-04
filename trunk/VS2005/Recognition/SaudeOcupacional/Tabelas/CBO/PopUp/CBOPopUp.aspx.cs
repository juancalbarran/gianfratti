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

public partial class Tabelas_CBO_PopUp_CBOPopUp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //TRANSFERE O CBO SELECIONADO PARA A PAGINA DE BAIXO
        if (Request.QueryString["Numero"] != null)
        {
            Response.Write("<script>window.opener.document.form1.TxtCBO.value = '" + Request.QueryString["Numero"] + "';</script>");
            Response.Write("<script>window.opener.document.form1.TxtCBOFuncao.value = '" + Request.QueryString["Funcao"] + "';</script>");
            Response.Write("<script>window.close();</script>");
        }
        if (!Page.IsPostBack)
        {
            GridView();
        }
    }
    private void GridView()
    {
        CBODAL ObjCBODAL = new CBODAL();
        GridView1.DataSource = ObjCBODAL.SelectAll(txtCBO.Text, txtFuncao.Text);
        GridView1.DataBind();
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        GridView();
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Detalhes")
        {
            Response.Redirect("Detalhes.aspx?CBO=" + Convert.ToInt32(e.CommandArgument));
        }
    }
    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        GridView();
    }
}
