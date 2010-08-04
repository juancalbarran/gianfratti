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

public partial class ClienteDepartamentoSetor_ClienteDepartamentoPrincipal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnCadastrarDepto_Click(object sender, EventArgs e)
    {
        
        ClienteDepartamentoSetor ClienteDepartamentoSetor = new ClienteDepartamentoSetor();

        //preencheu a classe
        ClienteDepartamentoSetor.idCliente = Convert.ToInt32(Request.QueryString["IdCliente"]);
        ClienteDepartamentoSetor.Depto = txtDepto.Text;

        //passando obj preenchido para o BO
        ClienteDepartamentoSetorBO ClienteDepartamentoSetorBO = new ClienteDepartamentoSetorBO();
        ClienteDepartamentoSetorBO.SalvaDadosDepartamento(ClienteDepartamentoSetor);

        Response.Redirect("ClienteDepartamentoPrincipal.aspx?IdCliente=" + ClienteDepartamentoSetor.idCliente);
    }


    protected void btnCadastarSetor_Click(object sender, EventArgs e)
    {
        ClienteDepartamentoSetor ClienteDepartamentoSetor = new ClienteDepartamentoSetor();

        //preencheu a classe
        ClienteDepartamentoSetor.idCliente = Convert.ToInt32(Request.QueryString["IdCliente"]);
        ClienteDepartamentoSetor.IdDepto = Convert.ToInt32(ddlDepto.Text);
        ClienteDepartamentoSetor.Setor = txtSetor.Text;

       
        //passando obj preenchido para o BO
        ClienteDepartamentoSetorBO ClienteDepartamentoSetorBO = new ClienteDepartamentoSetorBO();
        ClienteDepartamentoSetorBO.SalvaDadosSetor(ClienteDepartamentoSetor);

        Response.Redirect("ClienteDepartamentoPrincipal.aspx?IdCliente=" + ClienteDepartamentoSetor.idCliente);
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("ClienteDepartamentoExcluir.aspx?idCliente="+Request.QueryString["idCliente"]);
    }
}
