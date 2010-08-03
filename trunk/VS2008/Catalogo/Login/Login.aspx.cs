using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
/*
 *Data: 31/07/2010
 *Analista: Fabrizio Gianfratti Manes 
 *Descrição: Página de login para acesso ao sistema administrativo
*/
namespace Catalogo
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Evento do botao logar
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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

                //Instancio o Catalogo com os objetos das entidades
                CatalogoEntities entidades = new CatalogoEntities();

                //Crio objeto Usuario e Executo a query
                var Usuario = (
                    from usu in entidades.Usuario
                    from per in entidades.UsuarioPerfil
                    where usu.UsuarioPerfil.ID == per.ID && //Relacionamento com perfil do usuario
                    (usu.Email.Equals(txtLogin.Text) && usu.Senha.Equals(txtSenha.Text))
                    select new { usu.Email, usu.Senha, per.Perfil }
                               ).FirstOrDefault();

                //Caso a query nao retorno nada
                if (Usuario == null)
                {
                    MsgErro.InnerHtml = "Login ou Senha inválidos";
                    return;
                }

                //Instancio o perfil do usuário
                UsuarioPerfil perfil = new UsuarioPerfil();
                //Atribuo o perfil do usuario ao objeto perfil
                perfil.Perfil = Usuario.Perfil;
                //Logo o perfil do usuario
                LogaUsuario(perfil);
            }
            catch (Exception ex)
            {
                MsgErro.InnerHtml = "Ocorreu um erro inesperado <span onclick='ErroDetalhe()' style='cursor:pointer;' id='imgDetalhe'><img src=../Template/Img/icoMais.gif /></span><div id='erroDetalhe' style='display:none; padding:7px; font-size:9px; text-align:left; color:#000000'>" + Convert.ToString(ex) + "</div>";
            }
        }

        //Loga o usuario na aplicação
        public void LogaUsuario(UsuarioPerfil perfil)
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
