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

public partial class ProcessoSeletivo_ProcessosSeletivoPrincipal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private void DataGrid()
    {
        ClienteBO ObjClienteBO = new ClienteBO();
        ProcessoSeletivoBO ObjProcessoSeletivoBO = new ProcessoSeletivoBO();
        GridView1.DataSource = ObjProcessoSeletivoBO.SelectAll(ddlCliente.ValorInformado,  txtNome.Text,txtCPF.Text, ddlProcessoSeletivoStatus.ValorInformado);
        GridView1.DataBind();
    }

    private void Deletar(int id)
    {
        try
        {
            ProcessoSeletivoBO ObjProcessoSeletivoBO = new ProcessoSeletivoBO();
            ObjProcessoSeletivoBO.Delete(id);
        }
        catch (Exception)
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Antes de apagar um candidato deve-se apagar todos os registros pertinentes ao mesmo.')", true);
        }
    }

    private void Editar(int id)
    {
        Response.Redirect("ProcessosSeletivoCadastro.aspx?id="+id);
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Deletar")
        {
            Deletar(Convert.ToInt32(e.CommandArgument));
        }
        if (e.CommandName == "Editar")
        {
            Editar(Convert.ToInt32(e.CommandArgument));
        }
    }
    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        DataGrid();
    }

    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        //Response.Write();

    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
                Image Img = (Image)e.Row.FindControl("Image1");
                if (e.Row.Cells[3].Text == "Processo Seletivo")
                {
                    Img.ImageUrl = "~/Template/Img/Flg_amerelo_Escuro.gif";
                    Img.AlternateText = "Canditos em processo seletivo";
                }
                else if (e.Row.Cells[3].Text == "Admitido")
                {
                    Img.ImageUrl = "~/Template/Img/Flg_verde.gif";
                    Img.AlternateText = "Canditos admitido";
                }
                else if (e.Row.Cells[3].Text == "N&#227;o Admitido")
                {
                    Img.ImageUrl = "~/Template/Img/Flg_vermelho.gif";
                    Img.AlternateText = "Canditos não admitido";
                }
                //Confirmação de Exclusão
                ImageButton ImageButton = (ImageButton)e.Row.FindControl("ImgDelete");
                //ImageButton.Attributes.Add("onclick", "javascript:return confirm('Confirma a exclusão do candidato " + DataBinder.Eval(e.Row.DataItem, "Empresa") + "?')");
                ImageButton.Attributes.Add("onclick", "javascript:return confirm('Confirma a exclusão do candidato " + e.Row.Cells[1].Text + "?')");
            
        }

    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        DataGrid();
    }
}
