using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using stiperModel;


public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        var _context = new Entidades();
        var result = from a in _context.evento select a;

        foreach (var item in result)
        {
            Response.Write(item.Nome);
        }

        //var entidades = new stiperEntities();
        //var consulta = from p in entidades.evento
        //               select p;

        //stiperEntities entidades = new stiperEntities();
        //evento evento = entidades.evento.First(p => p.Id == 1);
        //Response.Write(evento.Nome);

        

        //CatalogoEntities entidades = new CatalogoEntities();
        //CatalogoLivros categoriaLivros = entidades.CatalogoLivros.First(p => p.ID == 9);

        //Response.Write(categoriaLivros.Autor);
        

        //var entidades = new stiperMo CatalogoEntities();
        //var consulta = from p in entidades.CatalogoLivros
        //               select p;

        //GridView1.DataSource = consulta;
        //GridView1.DataBind();
        
    }
}
