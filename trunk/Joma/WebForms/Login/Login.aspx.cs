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
using JomaBE;
using JomaDAL;

public partial class Login_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void BtnLogar_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtLogin.Text == string.Empty)
            {
                MsgErro.InnerHtml = "Login ou Senha inválidos";
            }
            else
            {
                LogaUsuario();
            }
        }
        catch (Exception ex)
        {
            MsgErro.InnerHtml = "Ocorreu um erro inesperado <span onclick='ErroDetalhe()' style='cursor:pointer;' id='imgDetalhe'><img src=../Template/Img/icoMais.gif /></span><div id='erroDetalhe' style='display:none; padding:7px; font-size:9px; text-align:left; color:#000000'>" + Convert.ToString(ex) + "</div>";
        }
    }

    //Loga o usuario na aplicação
    public void LogaUsuario()
    {
        try
        {
            ProfissionaisBE profissionaisBE = new ProfissionaisBE();
            ProfissionaisDAL profissionaisDAL = new ProfissionaisDAL();
            profissionaisBE = profissionaisDAL.Login(txtLogin.Text, txtSenha.Text);
            Session["id"] = profissionaisBE.id;
            Session["Nome"] = profissionaisBE.Nome;
            Session["idProfissionalPerfil"] = profissionaisBE.idProfissionalPerfil;
            Session["Email"] = profissionaisBE.Email;
            Session["PerfilNome"] = profissionaisBE.RefprofissionalPerfilBE.Nome;
            //Loga o usuario conforme perfil
            FormsAuthentication.RedirectFromLoginPage(Convert.ToString(profissionaisBE.RefprofissionalPerfilBE.Nome), true);
        }
        catch (Exception ex)
        {
            Label lblErro = (Label)Master.FindControl("lblErro");
            lblErro.Text = ex.ToString();
        }

    }
}
