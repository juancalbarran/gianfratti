using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PortalMTL.UserControl.DropDownList
{
    public partial class Cliente : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                PortalMTLEntities entidades = new PortalMTLEntities();

                //Executo a query
                var Cliente = (
                    from cli in entidades.cliente_processo
                    where cli.del == false
                    select new { cli.idCliente, cli.nome }
                               );

                //Preencho o controle
                ddlCliente.DataSource = Cliente;
                ddlCliente.DataTextField = "Nome";
                ddlCliente.DataValueField = "idCliente";
                ddlCliente.DataBind();
                ddlCliente.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
            }

        }

        public string TextoInformado
        {
            get
            {
                return ddlCliente.SelectedItem.Text;
            }
            set
            {
                ddlCliente.SelectedValue = value;
            }
        }
        public string ValorInformado
        {
            get
            {
                return ddlCliente.SelectedItem.Value;
            }
            set
            {
                ddlCliente.SelectedValue = value;
            }
        }
    }
}