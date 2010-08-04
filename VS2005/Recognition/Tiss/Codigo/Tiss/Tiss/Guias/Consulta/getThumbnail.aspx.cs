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

public partial class CIAB_2007_SolicitacaoProcedimento_getThumbnail : System.Web.UI.Page
{
    private void Page_Load(object sender, System.EventArgs e)
    {
        // Recebe a QueryString "file" 
        string file = Request.QueryString["file"];
        //Recebe as medidas p/ miniatura 
        int width = Convert.ToInt32(Request.QueryString["w"]);
        int height = Convert.ToInt32(Request.QueryString["h"]);

        // cria o object imagem com o nome e camimho completo do arquivo
        System.Drawing.Image image = System.Drawing.Image.FromFile(Server.MapPath("ImgCaptura/"+file));

        // cria o thumbnail do object image, definindo sua altura e largura para 64 
        System.Drawing.Image thumbnailImage = image.GetThumbnailImage(width, height, new System.Drawing.Image.GetThumbnailImageAbort(ThumbnailCallback), IntPtr.Zero);

        // cria a memory stream para trabalhar com os bytes da imagem 
        MemoryStream imageStream = new MemoryStream();

        // coloca a imagem na memory stream 
        thumbnailImage.Save(imageStream, System.Drawing.Imaging.ImageFormat.Jpeg);

        // cria um array de bytes com o tamanho da imagem 
        byte[] imageContent = new Byte[imageStream.Length];

        // rebobina a memory stream 
        imageStream.Position = 0;

        // carrega o array de bytes com a imagem 
        imageStream.Read(imageContent, 0, (int)imageStream.Length);

        // modifica o cabeçalho "content-type" da página para "image/jpeg" e imprime a imagem. 
        Response.ContentType = "image/jpeg";
        Response.BinaryWrite(imageContent);

    }
    //função complementar 
    public bool ThumbnailCallback()
    {
        return true;
    } 

}
