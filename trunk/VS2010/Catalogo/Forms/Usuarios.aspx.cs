using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/*
 *Data: 01/08/2010
 *Analista: Fabrizio Gianfratti Manes 
 *Descrição: Página responsavel por visualizar todos os usuários
*/
namespace Catalogo
{
    public partial class Usuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //Chamo o metodo que carrega o GridView
                CarregaGrid();
            }
        }

        /// <summary>
        /// Carrega o GridView
        /// </summary>
        private void CarregaGrid()
        {
            //Instancio a lista de entidades
            var entidades = new CatalogoEntities();

            //Executo a consulta
            var consulta =  from usuario in entidades.Usuario
                            select new { usuario.ID,usuario.nome,usuario.Email,usuario.UsuarioPerfil.Perfil };

            //Carrego o GridView
            GridView1.DataSource = consulta;
            GridView1.DataBind();
        }

        /// <summary>
        /// Evento do GridView que percorre linha a linha
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //Percorre o GridView somente se a linha for do tipo DataRow
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //Controle ImageButton responsavel por mudar de pagina
                ImageButton BtnVisualizar = (ImageButton)e.Row.FindControl("BtnVisualizar");
                //Insiro no botão a URL que visualiza os dados da proposta e concateno o Id da proposta selecionada
                BtnVisualizar.PostBackUrl = "UsuariosEditar.aspx?id=" + DataBinder.Eval(e.Row.DataItem, "ID");

                //Confirmação de Exclusão
                ImageButton ImageButton = (ImageButton)e.Row.FindControl("ImgBtnApagar");
                ImageButton.CommandArgument = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ID"));
                ImageButton.Attributes.Add("onclick", "javascript:return confirm('O seguinte registro será apagado:\\n\\n" + DataBinder.Eval(e.Row.DataItem, "Nome") + "\\n\\nTem Certeza?');");

                //Insere atributo JavaScript ao passar o mouse sobre o Grid
                e.Row.Attributes["onmouseover"] = "javascript:setMouseOverColor(this);";
                e.Row.Attributes["onmouseout"] = "javascript:setMouseOutColor(this);";
            }
        }

        /// <summary>
        /// Evento de paginação do GridView
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            CarregaGrid();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Apagar")
            {
                CatalogoEntities entidades = new CatalogoEntities();
                int ID = Convert.ToInt32(e.CommandArgument);
                entidades.DeleteObject(entidades.Usuario.First(p => p.ID == ID));
                entidades.SaveChanges();
                CarregaGrid();
            }
        }
    }
}
