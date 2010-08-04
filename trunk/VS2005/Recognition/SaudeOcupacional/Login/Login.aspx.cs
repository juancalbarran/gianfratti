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
    //Na pagina Default.asp da raiz do site é a responsavel por criar a session do perfil do usuario
    //Session["Perfil"] = HttpContext.Current.User.Identity.Name;
    protected void BtnLogar_Click(object sender, EventArgs e)
    {
        try
        {
            Usuario ObjUsuario = new Usuario();
            ObjUsuario.Usuarios = txtLogin.Text;
            ObjUsuario.Senha = txtSenha.Text;
            UsuarioBO ObjUsuarioBO = new UsuarioBO();
            ObjUsuario = ObjUsuarioBO.ValidaUsuario(ObjUsuario);
            if (Convert.ToInt32(ObjUsuario.id) == 0)
            {
                MsgErro.InnerHtml = "Login ou Senha inválidos";
            }
            else
            {
                //Caso queira pegar o perfil logado use HttpContext.Current.User.Identity.Name;
                Session["IdUsuario"] = ObjUsuario.id;
                Session["idPerfil"] = ObjUsuario.idPerfil;
                Session["UsuarioNome"] = ObjUsuario.Nome;
                Session["UsuarioPerfil"] = ObjUsuario.RefUsuarioPerfil.Nome;
            }
        }
        catch (Exception ex)
        {
            MsgErro.InnerHtml = "Ocorreu um erro inesperado <span onclick='ErroDetalhe()' style='cursor:pointer;' id='imgDetalhe'><img src=../Template/Img/icoMais.gif /></span><div id='erroDetalhe' style='display:none; padding:7px; font-size:9px; text-align:left; color:#000000'>" + Convert.ToString(ex) + "</div>";
        }
    }

    //protected void BtnLogar_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        EmpresaUsuario EmpresaUsuario = new EmpresaUsuario();
    //        EmpresaUsuario.Usuario = txtLogin.Text;
    //        EmpresaUsuario.Senha = txtSenha.Text;
    //        EmpresaUsuarioBO EmpresaUsuarioBO = new EmpresaUsuarioBO();
    //        if (!EmpresaUsuarioBO.ValidaEmpresaUsuario(EmpresaUsuario))
    //        {
    //            MsgErro.InnerHtml = "Login ou Senha inválidos";
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        MsgErro.InnerHtml = "Ocorreu um erro inesperado <span onclick='ErroDetalhe()' style='cursor:pointer;' id='imgDetalhe'><img src=../Template/Img/icoMais.gif /></span><div id='erroDetalhe' style='display:none; padding:7px; font-size:9px; text-align:left; color:#000000'>" + Convert.ToString(ex) + "</div>";
    //    }
        
    //}

}
