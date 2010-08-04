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

public partial class Usuarios_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DataGridUsuarios();
        }
    }

    //Função que preenche o data grid
    private void DataGridUsuarios()
    {
        try
        {
            UsuarioBO ObjUsuarioBO = new UsuarioBO();
            GridUsuario.DataSource = ObjUsuarioBO.SelectUsuarioALL(txtNome.Text, ddlUsuariosPerfil.ValorInformado, ddlUsuarioStatus.ValorInformado);
            GridUsuario.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }

    //Evento responsavel por chamar as funções
    protected void GridUsuario_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
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
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }

    private void Editar(int id)
    {
        Response.Redirect("UsuarioCadastro.aspx?id=" + id);
    }

    //Função para deletar um registro
    public void Deletar(int id)
    {
        try
        {
            UsuarioBO ObjUsuarioBO = new UsuarioBO();
            ObjUsuarioBO.DeleteUsuarioByID(id);
            DataGridUsuarios();
        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }
    //Evento Data Grid
    protected void GridUsuario_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Image Img = (Image)e.Row.FindControl("Image1");
            if (e.Row.Cells[1].Text == "Ativo")
            {
                Img.ImageUrl = "~/Template/Img/Flg_verde.gif";
                Img.AlternateText = "Usuário Ativo";
            }
            else if (e.Row.Cells[1].Text == "Inativo")
            {
                Img.ImageUrl = "~/Template/Img/Flg_preto.gif";
                Img.AlternateText = "Usuário Inativo";
            }

            //Confirmação de Exclusão
            ImageButton ImageButton = (ImageButton)e.Row.FindControl("ImgDelete");
            ImageButton.Attributes.Add("onclick", "javascript:return confirm('Confirma a exclusão do usuário " + DataBinder.Eval(e.Row.DataItem, "Nome") + "?')");
        }
    }
    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        DataGridUsuarios();
    }
}