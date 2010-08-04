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

public partial class Template_TemplateEmpresa : System.Web.UI.MasterPage
{
    //Variavel sera usada para armazenar o caminho onde esta o site
    public string Caminho; 

    protected void Page_Load(object sender, EventArgs e)
    {
        Caminho = Page.Request.ApplicationPath;

        if (Session["UsuarioNome"] != null)
        {
            lblUsuarioNome.Text = Session["UsuarioNome"].ToString() + " - " + Session["UsuarioPerfil"].ToString();
        }
        else
        {
            lblUsuarioNome.Text = "Usuário não identificado";
        }
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
        Response.Redirect(Caminho);
    }
}
