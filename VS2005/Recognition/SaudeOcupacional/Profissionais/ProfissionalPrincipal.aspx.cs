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

public partial class Profissionais_ProfissionalPrincipal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GridView();
        }
    }

    private void GridView()
    {
        try
        {
            ProfissionalDAL ObjProfissionalDAL = new ProfissionalDAL();
            GridView1.DataSource = ObjProfissionalDAL.SelectAll(TxtNome.Text,TxtCPF.Text,TxtRG.Text);
            GridView1.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex);
            Response.End();
        }

    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Image Img = (Image)e.Row.FindControl("Image1");
            if (e.Row.Cells[2].Text == "M&#233;dico Coordenador")
            {
                Img.ImageUrl = "~/Template/Img/Flg_verde.gif";
                Img.AlternateText = "Funcionário Efetivo";
            }
            else if (e.Row.Cells[2].Text == "M&#233;dico Examinador")
            {
                Img.ImageUrl = "~/Template/Img/Flg_amerelo_Escuro.gif";
                Img.AlternateText = "Candito em processo seletivo";
            }

            //Confirmação de Exclusão
            ImageButton ImageButton = (ImageButton)e.Row.FindControl("ImgDelete");
            ImageButton.Attributes.Add("onclick", "javascript:return confirm('Confirma a exclusão do profissional " + DataBinder.Eval(e.Row.DataItem, "Nome") + "?')");
        }
    }
    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        GridView();
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Deletar")
            {
                ProfissionalDAL Obj = new ProfissionalDAL();
                Obj.DeleteProfissional(Convert.ToInt32(e.CommandArgument));
                GridView();
            }
        }
        catch (Exception ex)
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Este profissional não pode ser apagado pois esta vinculado a alguma empresa')", true);
            Console.Write(ex);
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        GridView();
    }
}
