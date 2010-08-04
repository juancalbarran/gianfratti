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

public partial class Tabelas_CNAE20_PopUp_CNAE20PopUp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //TRANSFERE O CANE SELECIONADO PARA A PAGINA DE BAIXO
        if (Request.QueryString["Numero"] != null)
        {
            Response.Write("<script>window.opener.document.form1.TxtCNAE.value = '" + Request.QueryString["Numero"] + "';</script>");
            Response.Write("<script>window.opener.document.form1.TxtDenominacao.value = '" + Request.QueryString["Denominacao"] + "';</script>");
            Response.Write("<script>window.opener.document.form1.TxtRisco.value = '" + Request.QueryString["Risco"] + "';</script>");
            Response.Write("<script>window.close();</script>");
        }

            GridView();         
    }

    private void GridView()
    {
        CnaeDAL ObjCnaeDal = new CnaeDAL();
        GridView1.DataSource = ObjCnaeDal.SelectAll(txtSubClasse.Text,txtDescricao.Text,txtRisco.Text);
        GridView1.DataBind();
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        GridView();
    }

}