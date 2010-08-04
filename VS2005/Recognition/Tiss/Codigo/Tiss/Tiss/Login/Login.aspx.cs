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

public partial class Login_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void BtnLogar_Click(object sender, EventArgs e)
    {
        try
        {
            string Login = txtLogin.Text;
            string Senha = txtSenha.Text;
            if (Login.ToUpper() == "TISS" && Senha.ToUpper() == "TISS")
            {
                FormsAuthentication.RedirectFromLoginPage("Empresa", true);
            }
            else
                if (Login.ToUpper() == "OPEX" && Senha.ToUpper() == "OPEX")
                {
                    FormsAuthentication.RedirectFromLoginPage("Cliente", true);
                }
                else
                    MsgErro.InnerHtml = "Login ou Senha inválidos";
        }
        catch (Exception ex)
        {
            MsgErro.InnerHtml = "Ocorreu um erro inesperado <span onclick='ErroDetalhe()' style='cursor:pointer;' id='imgDetalhe'><img src=../Template/Img/icoMais.gif /></span><div id='erroDetalhe' style='display:none; padding:7px; font-size:9px; text-align:left; color:#000000'>" + Convert.ToString(ex) + "</div>";
        }

    }
}
