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

public partial class UserControls_Menu_Menu : System.Web.UI.UserControl
{

    protected void Page_Load(object sender, EventArgs e)
    {
        //Caso queira pegar o perfil do usuario logado no sistema
        String Perfil = HttpContext.Current.User.Identity.Name;
        TreeView1.DataSource = GetMenuDataSource("Administrador", Server.MapPath("~"));
        TreeView1.DataBind();
    }
    /// <summary>
    /// Carrega os itens do menu conforme perfil logado
    /// </summary>
    /// <param name="menu"></param>
    /// <param name="serverMapPath"></param>
    /// <returns></returns>
    XmlDataSource GetMenuDataSource(string menu, string serverMapPath)
    {
        XmlDataSource objData = new XmlDataSource();
        objData.XPath = "siteMap/siteMapNode";
        switch (menu)
        {
            case "Administrador": //Caso seja o analista de credito carrega o perfil setado no xml
                objData.DataFile = serverMapPath + @"\App_Data\Administrador.sitemap";
                break;
            default:
                break;
        }
        objData.DataBind();
        return objData;
    }

}
