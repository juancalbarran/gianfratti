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

public partial class Template_Template01 : System.Web.UI.MasterPage
{
    public string URL;
    public string Perfil;

    protected void Page_Load(object sender, EventArgs e)
    {
        
        URL = Page.Request.ApplicationPath;
        Perfil = HttpContext.Current.User.Identity.Name;

        //Verifica se o usuario clico no link para sair do sistema
        //Foi usado este metodo pois com o se colocarmos o botao e um enveto qualquer aperto do entrer deslogava o usuario
        if (Request.QueryString["Logout"] != null)
        {
            Logout();
        }

    }

    private void Logout()
    {
        //Desloga o usuario
        FormsAuthentication.SignOut();
        Response.Redirect(URL);
    }
}
