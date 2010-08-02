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
using JomaBE;
using JomaDAL;

public partial class Forms_ConvenioCadastrar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //Verifico se existe o ID na URL, caso existe é uma edição
            if (Request.QueryString["id"] != null)
            {
                BtnCadastrar.Text = "Alterar"; //Alteto o texto do botao
                ObtemDados(); //chamo o metodo que carrega os dados
            }
        }
    }

    //Evento responsavel por cadastrar um novo registro ou atualizar o registro já existente
    protected void BtnCadastrar_Click(object sender, EventArgs e)
    {
        try
        {
            ConvenioBE convenioBE = new ConvenioBE();
            convenioBE.id = Convert.ToInt32(Request.QueryString["id"]);
            convenioBE.Nome = Convert.ToString(txtNome.Text);
            convenioBE.Valor = Convert.ToDouble(txtValor.Text);

            ConvenioDAL convenioDAL = new ConvenioDAL();
            if (Request.QueryString["id"] != null)
            {
                //Chamo o metodo que altera o registro
                convenioDAL.Alterar(convenioBE);
            }
            else
            {
                //Chamo o metodo que insere um novo registro
                convenioDAL.Incluir(convenioBE);

            }
            Response.Redirect("Convenio.aspx");
        }
        catch (Exception ex)
        {
            Label lblErro = (Label)Master.FindControl("lblErro");
            lblErro.Text = ex.ToString();
        }
    }

    //Metodo responsavel por carregar um determinado registro para edição
    public void ObtemDados()
    {
        try
        {
            ConvenioBE convenioBE = new ConvenioBE();
            ConvenioDAL convenioDAL = new ConvenioDAL();
            convenioBE = convenioDAL.Obter(Convert.ToInt32(Request.QueryString["id"]));

            txtNome.Text = convenioBE.Nome;
            txtValor.Text = Convert.ToString(convenioBE.Valor.ToString("00.00"));
        }
        catch (Exception ex)
        {
            Label lblErro = (Label)Master.FindControl("lblErro");
            lblErro.Text = ex.ToString();
        }
    }
}
