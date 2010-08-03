using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PortalMTL.UserControl.DropDownList
{
    public partial class Empresa : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                PortalMTLEntities entidades = new PortalMTLEntities();

                //Executo a query
                var Empresa = (
                    from emp in entidades.empresa
                    where emp.del == false
                    select new { emp.idEmpresa,emp.nome }
                               );

                //Preencho o controle
                ddlEmpresa.DataSource = Empresa;
                ddlEmpresa.DataTextField = "Nome";
                ddlEmpresa.DataValueField = "idEmpresa";
                ddlEmpresa.DataBind();
                ddlEmpresa.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
            }

        }

        public string TextoInformado
        {
            get
            {
                return ddlEmpresa.SelectedItem.Text;
            }
            set
            {
                ddlEmpresa.SelectedValue = value;
            }
        }
        public string ValorInformado
        {
            get
            {
                return ddlEmpresa.SelectedItem.Value;
            }
            set
            {
                ddlEmpresa.SelectedValue = value;
            }
        }
    }
}