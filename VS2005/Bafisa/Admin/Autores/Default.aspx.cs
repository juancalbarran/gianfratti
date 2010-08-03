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

public partial class Admin_Autores_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            MontaGriView();
        }
    }

    private void MontaGriView()
    {
        try
        {
            AutoresBO ObjAutoresBO = new AutoresBO();
            GridView.DataSource = ObjAutoresBO.SelectAll();
            GridView.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write("Erro ao carregar registros " + ex);
            Response.End();
        }
    }

    private void Deletar(int id)
    {
        AutoresBO ObjAutoresBO = new AutoresBO();
        ObjAutoresBO.DeleteByID(id);
        MontaGriView();
    }

    protected void GridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Alterar")
        {
            Response.Redirect("Cadastro.aspx?id=" + Convert.ToInt32(e.CommandArgument));         
        }
        if (e.CommandName == "Deletar")
        {
            Deletar(Convert.ToInt32(e.CommandArgument));
        }
    }
}
