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

public partial class Tabelas_CID10_PopUp_CID10PopUp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["Tipo"] == null)
            {
                Session["Tipo"] = Request.QueryString["Tipo"];
            }
                //TRANSFERE O CBO SELECIONADO PARA A PAGINA DE BAIXO
            if (Request.QueryString["Numero"] != null && Convert.ToString(Session["Tipo"]) == "1")
                {
                    Response.Write("<script>window.opener.document.aspnetForm.ctl00$ContentPlaceHolder1$txtAnamnese_AntecedentesPessoais_Tumores_CID10.value = '" + Request.QueryString["Numero"] + "';</script>");
                    Response.Write("<script>window.close();</script>");
                    Session["Tipo"] = null;
                }
            if (Request.QueryString["Numero"] != null && Convert.ToString(Session["Tipo"]) == "2")
                {
                    Response.Write("<script>window.opener.document.aspnetForm.ctl00$ContentPlaceHolder1$txtCID10_Primario.value = '" + Request.QueryString["Numero"] + "';</script>");
                    Response.Write("<script>window.close();</script>");
                    Session["Tipo"] = null;
                }
            if (Request.QueryString["Numero"] != null && Convert.ToString(Session["Tipo"]) == "3")
                {
                    Response.Write("<script>window.opener.document.aspnetForm.ctl00$ContentPlaceHolder1$txtCID10_Secundario_1.value = '" + Request.QueryString["Numero"] + "';</script>");
                    Response.Write("<script>window.close();</script>");
                    Session["Tipo"] = null;
                }
            if (Request.QueryString["Numero"] != null && Convert.ToString(Session["Tipo"]) == "4")
            {
                    Response.Write("<script>window.opener.document.aspnetForm.ctl00$ContentPlaceHolder1$txtCID10_Secundario_2.value = '" + Request.QueryString["Numero"] + "';</script>");
                    Response.Write("<script>window.close();</script>");
                    Session["Tipo"] = null;
            }
        }
        GridView();
    }
    private void GridView()
    {
        CID10DAL ObjCID10DAL = new CID10DAL();
        GridView1.DataSource = ObjCID10DAL.SelectAll(txtCID10.Text, txtDescricao.Text);
        GridView1.DataBind();
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        GridView();
    }
}