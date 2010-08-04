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
        //Pega o perfil do usuario logado no sistema
        String Perfil = HttpContext.Current.User.Identity.Name;

        TreeView1.DataSource = GetMenuDataSource(Perfil, Server.MapPath("~"));
        TreeView1.DataBind();
    }

    XmlDataSource GetMenuDataSource(string menu, string serverMapPath)
    {
        XmlDataSource objData = new XmlDataSource();
        objData.XPath = "siteMap/siteMapNode";
        switch (menu)
        {
            case "Empresa":
                objData.DataFile = serverMapPath + @"\App_Data\Empresa.sitemap";
                break;
            case "Atendimento":
                objData.DataFile = serverMapPath + @"\App_Data\Atendimento.sitemap";
                break;
            case "Medico":
                objData.DataFile = serverMapPath + @"\App_Data\Medico.sitemap";
                break;
            case "Ambulatorio":
                objData.DataFile = serverMapPath + @"\App_Data\Ambulatorio.sitemap";
                break;
            case "Administrativo":
                objData.DataFile = serverMapPath + @"\App_Data\Administrativo.sitemap";
                break;
            case "Multidisciplinar":
                objData.DataFile = serverMapPath + @"\App_Data\Multidisciplinar.sitemap";
                break;

            default:
                break;
        }
        objData.DataBind();
        return objData;
    }

}
