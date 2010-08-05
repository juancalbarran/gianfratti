using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Catalogo
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //TRanscao http://stackoverflow.com/questions/815586/entity-framework-using-transactions-or-savechangesfalse-and-acceptallchanges
            //Crud legal http://diariodafonte.wordpress.com/2009/01/13/crud-com-adonet-entity-framework/
            if (!Page.IsPostBack)
            {
                //Insert02();
                //Select02();
            }

        }

        private void Insert()
        {
            CatalogoLivros categoriaLivros = new CatalogoLivros();

            categoriaLivros.Titulo = "Teste de Livro";
            categoriaLivros.Sinopse = "Bla Bla Bla";
            categoriaLivros.ISBN = "12334343";
            categoriaLivros.Edicao = "2009";
            categoriaLivros.Autor = "Fabrizio Manes";
            categoriaLivros.Paginas = "1000";
            categoriaLivros.Img = "capa.jpg";
            categoriaLivros.Tags = "a b c d e";
            categoriaLivros.Observacao = "nana nana nana nana";

            CatalogoEntities entidades = new CatalogoEntities();
            entidades.AddToCatalogoLivros(categoriaLivros);

            entidades.SaveChanges();

            //Pega o ultimo registro inserido
            int ID = categoriaLivros.ID;
            Response.Write(ID.ToString());
        }

        private void Insert02()
        {
            List<CatalogoLivros> cat = new List<CatalogoLivros>();
            CatalogoLivros categoriaLivros = new CatalogoLivros();
            //CatalogoEntities entidades = new CatalogoEntities();

            categoriaLivros.Titulo = "Teste de Livro";
            categoriaLivros.Sinopse = "Bla Bla Bla";
            categoriaLivros.ISBN = "12334343";
            categoriaLivros.Edicao = "2009";
            categoriaLivros.Autor = "Fabrizio Manes";
            categoriaLivros.Paginas = "1000";
            categoriaLivros.Img = "capa.jpg";
            categoriaLivros.Tags = "a b c d e";
            categoriaLivros.Observacao = "nana nana nana nana";
            cat.Add(categoriaLivros);

            categoriaLivros.Titulo = "Teste de Livro";
            categoriaLivros.Sinopse = "Bla Bla Bla";
            categoriaLivros.ISBN = "12334343";
            categoriaLivros.Edicao = "2009";
            categoriaLivros.Autor = "Fabrizio Manes";
            categoriaLivros.Paginas = "1000";
            categoriaLivros.Img = "capa.jpg";
            categoriaLivros.Tags = "a b c d e";
            categoriaLivros.Observacao = "nana nana nana nana";
            cat.Add(categoriaLivros);

            //using (CatalogoEntities entidades = new CatalogoEntities())
            //{
            //    for (int i = 0; i < cat.Count; i++) // Loop through List with for
            //    {
            //        //Console.WriteLine(cat[i]);
            //        entidades.AddToCatalogoLivros(cat[i]);
            //    }
            //    entidades.SaveChanges();
            //}

            CatalogoEntities entidades = new CatalogoEntities();
            
            var query = from p in cat
                        select p;

            foreach (var item in query)
            {
                entidades.AddToCatalogoLivros(item);
                entidades.SaveChanges();
            }
            
        }

        //Select para carregar os dados na tela
        private void Select01()
        {
            CatalogoEntities entidades = new CatalogoEntities();
            CatalogoLivros categoriaLivros = entidades.CatalogoLivros.First(p => p.ID == 9);
            
            Response.Write(categoriaLivros.Autor);
        }

        //Select que pode ser usado para carregar um gridView
        private void Select02()
        {
            var entidades = new CatalogoEntities();
            var consulta = from p in entidades.CatalogoLivros
                           select p;

            GridView1.DataSource = consulta;
            GridView1.DataBind();
        }

        private void Update()
        {
            CatalogoLivros categoriaLivros = new CatalogoLivros();
            categoriaLivros.ID = 9;
            categoriaLivros.Autor = "Michelle Fagundes";
            categoriaLivros.Edicao = "2000";

            CatalogoEntities entidades = new CatalogoEntities();
            CatalogoLivros original = entidades.CatalogoLivros.First(p => p.ID == categoriaLivros.ID);
            entidades.ApplyPropertyChanges("CatalogoLivros", categoriaLivros);
            entidades.SaveChanges();
        }

        private void Delete()
        {
            CatalogoEntities entidades = new CatalogoEntities();
            entidades.DeleteObject(entidades.CatalogoLivros.First(p => p.ID == 9));
            entidades.SaveChanges();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                Response.Write(e.CommandArgument);
            }
        }
    }
}
