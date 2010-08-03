using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PortalMTL.Forms
{
    public partial class Empresa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                MontaGridView();
            }
        }

        //Monta o GridView
        public void MontaGridView()
        {
            var entidades = new PortalMTLEntities();

            var Empresa = from p in entidades.empresa
                          select p;

            GridView1.DataSource = Empresa;
            GridView1.DataBind();
        }
    }
}
