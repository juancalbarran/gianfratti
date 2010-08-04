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

public partial class UserControls_Cliente_ClienteDadosBasicos : System.Web.UI.UserControl
{
    private int mIdCliente = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DadosBasicos(mIdCliente);
        }
    }

    public void DadosBasicos(int midCliente)
    {
        if (midCliente != 0)
        {
            Cliente ObjCliente = new Cliente();
            ClienteDAL ObjClienteDAL = new ClienteDAL();
            Validacoes ObjValidacoes = new Validacoes();
            ObjCliente = ObjClienteDAL.DadosBasicos(midCliente);
            lblCNPJ.Text = ObjValidacoes.InsereMascaraCNPJ(ObjCliente.CNPJ_INCRA_CPF);
            lblMedicoCoordenador.Text = ObjCliente.RefProfissional.Nome;
            lblRazaoSocial.Text = ObjCliente.RazaoSocial;
        }
    }

    public int IdCliente
    {
        get
        {
            return mIdCliente;
        }
        set
        {
            mIdCliente = value;
            DadosBasicos(mIdCliente);
        }
    }
}



