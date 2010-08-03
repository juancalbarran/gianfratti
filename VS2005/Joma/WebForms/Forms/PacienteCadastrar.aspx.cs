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

public partial class Forms_PacienteCadastrar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            MontaComboConvenio();
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
            PacienteBE pacienteBe = new PacienteBE();
            pacienteBe.id = Convert.ToInt32(Request.QueryString["id"]);
            pacienteBe.idConvenio = Convert.ToString(ddlConvenio.SelectedValue);
            pacienteBe.Nome = txtNome.Text;
            pacienteBe.NumeroConvenio = txtNumeroConvenio.Text;
            pacienteBe.Sexo = ddlSexo.SelectedValue;
            pacienteBe.DtNascimento = Convert.ToDateTime(txtDtNascimento.Text);
            pacienteBe.RG = txtRG.Text;
            pacienteBe.CPF = txtCPF.Text;
            pacienteBe.Endereco = txtEndereco.Text;
            pacienteBe.Bairro = txtBairro.Text;
            pacienteBe.CEP = txtCEP.Text;
            pacienteBe.Cidade = txtCidade.Text;
            pacienteBe.UF = ddlUF.Text;
            pacienteBe.Telefone = txtTelefone.Text;
            pacienteBe.Celular = txtCelular.Text;
            pacienteBe.Email = txtEmail.Text;
            pacienteBe.Obs = txtObs.Text;
            PacienteDAL pacienteDAL = new PacienteDAL();
            if (Request.QueryString["id"] != null)
            {
                //Chamo o metodo que altera o registro
                pacienteDAL.Alterar(pacienteBe);
            }
            else
            {
                //Chamo o metodo que insere um novo registro
                pacienteDAL.Incluir(pacienteBe);

            }
            Response.Redirect("Paciente.aspx");
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
            PacienteBE pacienteBE = new PacienteBE();
            PacienteDAL pacienteDAL = new PacienteDAL();
            pacienteBE = pacienteDAL.Obter(Convert.ToInt32(Request.QueryString["id"]));

            ddlConvenio.SelectedValue = Convert.ToString(pacienteBE.idConvenio);
            txtNome.Text = pacienteBE.Nome;
            txtNumeroConvenio.Text = pacienteBE.NumeroConvenio;
            ddlSexo.SelectedValue = pacienteBE.Sexo;
            txtDtNascimento.Text = pacienteBE.DtNascimento.ToString("dd/MM/yyyy");
            txtRG.Text = pacienteBE.RG;
            txtCPF.Text = pacienteBE.CPF;
            txtEndereco.Text = pacienteBE.Endereco;
            txtBairro.Text = pacienteBE.Bairro;
            txtCEP.Text = pacienteBE.CEP;
            txtCidade.Text = pacienteBE.Cidade;
            ddlUF.SelectedValue = pacienteBE.UF;
            txtTelefone.Text = pacienteBE.Telefone;
            txtCelular.Text = pacienteBE.Celular;
            txtEmail.Text = pacienteBE.Email;
            txtObs.Text = pacienteBE.Obs;
        }
        catch (Exception ex)
        {
            Label lblErro = (Label)Master.FindControl("lblErro");
            lblErro.Text = ex.ToString();
        }
    }

    public void MontaComboConvenio()
    {
        ConvenioDAL convenioDAL = new ConvenioDAL();
        ddlConvenio.DataSource = convenioDAL.Listar(null);
        ddlConvenio.DataTextField = "Nome";
        ddlConvenio.DataValueField = "ID";
        ddlConvenio.DataBind();
        ddlConvenio.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }
}
