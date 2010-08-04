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

public partial class Tabelas_ExamesComplementares_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GridView();
        }
    }

    private void GridView()
    {
        ExamesComplementaresDAL ObjExamesComplementaresDAL = new ExamesComplementaresDAL();
        GridView1.DataSource = ObjExamesComplementaresDAL.SelectAll(txtExame.Text);
        GridView1.DataBind();
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Editar")
        {
            Response.Redirect("ExamesComplementaresCadastro.aspx?id=" + Convert.ToInt32(e.CommandArgument));
        }
        if (e.CommandName == "Deletar")
        {
            Deletar(Convert.ToInt32(e.CommandArgument));
        }
    }

    private void Deletar(int id)
    {
        try
        {
            ExamesComplementaresDAL ObjExamesComplementaresDAL = new ExamesComplementaresDAL();
            ObjExamesComplementaresDAL.Delete(id);
            GridView();
        }
        catch (Exception)
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Este exame não pode ser apagado')", true);
        }
    }

    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        GridView();
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //Confirmação de Exclusão
            ImageButton ImageButton = (ImageButton)e.Row.FindControl("ImgDelete");
            ImageButton.Attributes.Add("onclick", "javascript:return confirm('Confirma a exclusão do Exame " + DataBinder.Eval(e.Row.DataItem, "Descricao") + "?')");
        }
    }
}