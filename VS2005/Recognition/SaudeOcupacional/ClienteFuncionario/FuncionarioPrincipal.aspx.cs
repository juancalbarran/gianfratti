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

public partial class ClienteFuncionario_FuncionarioPrincipal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DataGrid();
        }
    }

    private void DataGrid()
    {
        Validacoes Valida = new Validacoes();
        ClienteFuncionarioDAL ObjClienteFuncionarioDAL = new ClienteFuncionarioDAL();
        GridView1.DataSource = ObjClienteFuncionarioDAL.SelectAll(ddlCliente.ValorInformado, Valida.TextoNull(TxtCPF.Text), Valida.TextoNull(TxtRG.Text), TxtNome.Text, Valida.TextoNull(TxtMae.Text), Valida.TextoNull(ddlClienteFuncionarioStatus.ValorInformado));
        GridView1.DataBind();
    }
    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        DataGrid();
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //e.Row.Cells[0].Style.Add("visibility", "hidden"); 

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Image Img = (Image)e.Row.FindControl("Image1");
            if (e.Row.Cells[4].Text == "Ativo")
            {
                Img.ImageUrl = "~/Template/Img/Flg_verde.gif";
                Img.AlternateText = "Ativo";
            }
            else if (e.Row.Cells[4].Text == "Licen&#231;a")
            {
                Img.ImageUrl = "~/Template/Img/Flg_amerelo_Escuro.gif";
                Img.AlternateText = "Licença";
            }
            else if (e.Row.Cells[4].Text == "Afastamento")
            {
                Img.ImageUrl = "~/Template/Img/Flg_vermelho.gif";
                Img.AlternateText = "Afastamento";
            }
            else if (e.Row.Cells[4].Text == "Desligado")
            {
                Img.ImageUrl = "~/Template/Img/Flg_preto.gif";
                Img.AlternateText = "Desligado";
            }
            else if (e.Row.Cells[4].Text == "&nbsp;")
            {
                Img.ImageUrl = "~/Template/Img/Flg_cinza.gif";
                Img.AlternateText = "Sem Registro Profissional";
                e.Row.Cells[4].Text = "Sem Registro Profissional";
            }

            //Confirmação de Exclusão
            ImageButton ImageButton = (ImageButton)e.Row.FindControl("ImgDelete");
            ImageButton.Attributes.Add("onclick", "javascript:return confirm('Confirma a exclusão do funcionário " + DataBinder.Eval(e.Row.DataItem, "Nome") + "?')");
        }
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Deletar")
        {
            Deletar(Convert.ToInt32(e.CommandArgument));
        }
    }

    private void Deletar(int id)
    {
        try
        {
            ClienteFuncionarioBO ObjClienteFuncionarioBO = new ClienteFuncionarioBO();
            ObjClienteFuncionarioBO.DeleteByID(id);
            DataGrid();
        }
        catch (Exception)
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Antes de apagar este funcionário deve-se apagar todos os registros pertinentes ao mesmo.')", true);
        }
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        DataGrid();
    }
}
