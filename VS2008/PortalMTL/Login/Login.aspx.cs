using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace PortalMTL.Login
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnLogar_Click(object sender, EventArgs e)
        {
            try
            {
                //Verifico se os campos foram preenchidos
                if (txtLogin.Text == string.Empty || txtSenha.Text == string.Empty)
                {
                    MsgErro.InnerHtml = "Login ou Senha inválidos";
                    return;
                }

                PortalMTLEntities entidades = new PortalMTLEntities();

                //Executo a query
                var Usuario = (
                    from usu in entidades.usuario
                    from per in entidades.perfil_usuario
                    where usu.idPerfil == per.idPerfil && //Relacionamento com perfil do usuario
                    (usu.login.Equals(txtLogin.Text) && usu.senha.Equals(txtSenha.Text))
                    select new { usu.login, usu.senha, per.nome,usu.empresa.razaosocial }
                               ).FirstOrDefault();

                //Caso a query nao retorno nada
                if (Usuario == null)
                    return;

                //Verifico se o usuario digitado é igual o usuario cadastrodo no banco de dados
                if (Usuario.login.Trim() == txtLogin.Text.Trim() && Usuario.senha.Trim() == txtSenha.Text.Trim())
                {
                    //Atribuo o perfil do usuario
                    perfil_usuario perfil = new perfil_usuario();
                    perfil.nome = Usuario.nome;
                    //Logo o usuario
                    LogaUsuario(perfil);
                }
            }
            catch (Exception ex)
            {
                MsgErro.InnerHtml = "Ocorreu um erro inesperado <span onclick='ErroDetalhe()' style='cursor:pointer;' id='imgDetalhe'><img src=../Template/Img/icoMais.gif /></span><div id='erroDetalhe' style='display:none; padding:7px; font-size:9px; text-align:left; color:#000000'>" + Convert.ToString(ex) + "</div>";
            }
        }

        //Loga o usuario na aplicação
        public void LogaUsuario(perfil_usuario perfil)
        {
            try
            {
                //Loga o usuario conforme perfil
                //Por enquanto esta chapado "Administrador", se quiser dinamico basta discomentar a linha de baixo e comentar esta
                FormsAuthentication.RedirectFromLoginPage("Administrador", true);
                //FormsAuthentication.RedirectFromLoginPage(perfil.nome, true);
            }
            catch (Exception ex)
            {
                Label lblErro = (Label)Master.FindControl("lblErro");
                lblErro.Text = ex.ToString();
            }

        }
    }
}
