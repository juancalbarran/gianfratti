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

public partial class Cliente_ClientePrincipal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Deletar")
        {
            Deletar(Convert.ToInt32(e.CommandArgument));
        }
    }
    private void DataGrid()
    {
        Validacoes ObjValidacoes = new Validacoes();
        ClienteBO ObjClienteBO = new ClienteBO();
        GridView1.DataSource = ObjClienteBO.SelectAll(TxtCNPJ.Text, TxtRazaoSocial.Text, TxtContato.Text);
        GridView1.DataBind();
    }
    private void Deletar(int id)
    {
        try
        {
            ClienteBO ObjClienteBO = new ClienteBO();
            ObjClienteBO.DeleteByID(id);
            GridView1.DataBind();
        }
        catch (Exception)
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Antes de apagar um cliente deve-se apagar todos os registros pertinentes ao mesmo.')", true);
        }
    }
    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        DataGrid();
    }
    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        DataGrid();
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        DataGrid();
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //Confirmação de Exclusão
            ImageButton ImageButton = (ImageButton)e.Row.FindControl("ImgDelete");
            ImageButton.Attributes.Add("onclick", "javascript:return confirm('Confirma a exclusão do cliente " + DataBinder.Eval(e.Row.DataItem, "RazaoSocial") + "?')");
        }
    }
}
