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
using System.IO;

public partial class Admin_Autores_Cadastro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Editar(Convert.ToInt32(Request.QueryString["id"]));
        }
    }

    private void Upload()
    {
        try
        {
            //Informações do arquivo
            FileInfo vNomeArquivo = new FileInfo(arquivo.PostedFile.FileName);
            //Processo de upload
            arquivo.PostedFile.SaveAs(Server.MapPath("") + "\\Fotos" + "\\" + vNomeArquivo.Name);
            //lblMensagem.Text = "Arquivo enviado com sucesso.";
        }
        catch (Exception ex)
        {
            Response.Write("Erro ao enviar a foto" + ex.Message);
            Response.End();
        }
    }

    protected void btnSalvar_Click(object sender, EventArgs e)
    {
        try
        {
            Autores ObjAutores = new Autores();
            ObjAutores.id = Convert.ToInt32(Request.QueryString["id"]);
            ObjAutores.Nome = txtNome.Text;
            ObjAutores.Descricao = txtDescricao.Text;
            AutoresBO ObjAutoresBO = new AutoresBO();
            ObjAutoresBO.InsertUpdate(ObjAutores);
            //Upload();
            Response.Redirect("default.aspx");
        }
        catch (Exception ex)
        {
            Response.Write("Erro na gravação do registro " + ex);
            Response.End();
        }
    }

    private void Editar(int id)
    {
        try
        {
            Autores ObjAutores = new Autores();
            AutoresBO ObjAutoresBO = new AutoresBO();
            ObjAutores = ObjAutoresBO.SelectByID(id);
            txtNome.Text = ObjAutores.Nome;
            txtDescricao.Text = ObjAutores.Descricao;
        }
        catch (Exception ex)
        {
            Response.Write("Erro na edição do registro " + ex);
            Response.End();
        }
    }
}
