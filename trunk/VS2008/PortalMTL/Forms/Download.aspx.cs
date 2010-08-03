using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.IO;

namespace PortalMTL.Forms
{
    public partial class Download : System.Web.UI.Page
    {
        string PathDocumentos = ConfigurationManager.AppSettings["PathDocumentos"];

        protected void Page_Load(object sender, EventArgs e)
        {
            FileInfo arquivo = new FileInfo(PathDocumentos + "\\" + Request.QueryString["NumEmpresa"] + "\\" + Request.QueryString["NumProcesso"] + "\\" + Request.QueryString["Data"] + "\\" + Request.QueryString["ArquivoPDF"]);

            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + arquivo.Name);
            Response.AddHeader("content-length", arquivo.Length.ToString());
            Response.ContentType = ContentType;
            Response.WriteFile(arquivo.FullName);
            Response.End();

        }
    }
}
