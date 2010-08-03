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

public partial class Admin_Autores_Upload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnEnviar_Click(object sender, EventArgs e)
    {
        try
        {
            //Informações do arquivo
            FileInfo vNomeArquivo = new FileInfo(arquivo.PostedFile.FileName);
            //Processo de upload
            arquivo.PostedFile.SaveAs(Server.MapPath("") + "\\Fotos" + "\\" + vNomeArquivo.Name);
            lblMensagem.Text = "Arquivo enviado com sucesso.";
        }
        catch (Exception ex)
        {
            Response.Write("Erro ao enviar a foto" + ex.Message);
            Response.End();
        }
    }
}
