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

public partial class Profissionais_ProfissionalCadastro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "OnLoad", "AlternarAbas('td_FichaPessoal','div_FichaPessoal')", true);
            CarregaDadosProfissionais();
        }
    }
    protected void ddlOrgaoExpeditor_PreRender(object sender, EventArgs e)
    {
        ddlOrgaoExpeditor.Items.Insert(0, new ListItem("<--Selecione-->", "")); //Texto Inicial do combo
    }
    protected void BtnSalvar_Click(object sender, EventArgs e)
    {
        try
        {
            Profissional ObjProfissional = new Profissional();
            Validacoes Valida = new Validacoes();

            ObjProfissional.id = Convert.ToInt32(Request.QueryString["idProfissional"]);
            ObjProfissional.idTipoProfissional = Valida.TextoNull(ddlTipoProfissional.ValorInformado);
            ObjProfissional.CPF = Valida.TextoNull(txtCPF.Text);
            ObjProfissional.RG =  Valida.TextoNull(txtRG.Text);
            ObjProfissional.DtExpedicao = Valida.TextoNull(txtDtExpedicao.Text);
            ObjProfissional.RgUFemissao = Valida.TextoNull(ddlRgUFemissao.ValorInformado);
            ObjProfissional.idOrgaoExpeditor = Valida.TextoNull(ddlOrgaoExpeditor.Text);
            ObjProfissional.Nome = Valida.TextoNull(txtNome.Text);
            ObjProfissional.DtNascimento = Valida.TextoNull(txtDtNascimento.Text);
            ObjProfissional.Sexo = Valida.TextoNull(ddlSexo.Text);
            ObjProfissional.EstadoCivil = Valida.TextoNull(ddlEstadoCivil.Text);
            ObjProfissional.EndResidencia = Valida.TextoNull(txtEndResidencia.Text);
            ObjProfissional.Numero = Valida.TextoNull(txtNumero.Text);
            ObjProfissional.Complemento = Valida.TextoNull(txtComplemento.Text);
            ObjProfissional.Cidade = Valida.TextoNull(txtCidade.Text);
            ObjProfissional.Bairro = Valida.TextoNull(txtBairro.Text);
            ObjProfissional.UF = Valida.TextoNull(ddlEstados.ValorInformado);
            ObjProfissional.CEP = Valida.TextoNull(txtCEP.Text);
            ObjProfissional.DDDtel = Valida.TextoNull(txtDDDtel.Text);
            ObjProfissional.Telefone = Valida.TextoNull(txtTelefone.Text);
            ObjProfissional.DDDcel = Valida.TextoNull(txtDDDcel.Text);
            ObjProfissional.Celular = Valida.TextoNull(txtCelular.Text);
            ObjProfissional.Email = Valida.TextoNull(txtEmail.Text);
            ObjProfissional.ConselhoProfissional = Valida.TextoNull(ddlConselhoProfissional.ValorInformado);
            ObjProfissional.ConselhoNumero = Valida.TextoNull(txtConselhoNumero.Text);
            ObjProfissional.ConselhoUF = Valida.TextoNull(ddlConselhoUF.ValorInformado);
            ObjProfissional.CBOS_1 = Valida.TextoNull(ddlCBOS_1.ValorInformado);
            ObjProfissional.CBOS_2 = Valida.TextoNull(ddlCBOS_2.ValorInformado);
            ObjProfissional.CBOS_3 = Valida.TextoNull(ddlCBOS_3.ValorInformado);
            ObjProfissional.CBOS_4 = Valida.TextoNull(ddlCBOS_4.ValorInformado);
            ObjProfissional.CBOS_5 = Valida.TextoNull(ddlCBOS_5.ValorInformado);
            ObjProfissional.CBOS_6 = Valida.TextoNull(ddlCBOS_6.ValorInformado);

            ProfissionalBO ObjProfissionalBO = new ProfissionalBO();
            ObjProfissionalBO.SalvaDados(ObjProfissional);

        }
        catch (Exception erro)
        {
            Response.Write(erro);
            Response.End();
        }
        Response.Redirect("ProfissionalPrincipal.aspx");
    }
    //CARREGA OS REGISTROS PARA EDIÇÃO
    public void CarregaDadosProfissionais()
    {
        try
        {
            Profissional ObjProfissional = new Profissional();
            ProfissionalBO ObjProfissionalBO = new ProfissionalBO();
            Validacoes Valida = new Validacoes();
            ObjProfissional = ObjProfissionalBO.CarregaProfissional(Convert.ToInt32(Request.QueryString["idProfissional"])) as Profissional;

            ddlTipoProfissional.ValorInformado = Valida.TextoNull(Convert.ToString(ObjProfissional.idTipoProfissional));
            txtCPF.Text = ObjProfissional.CPF;
            txtRG.Text = ObjProfissional.RG;
            txtDtExpedicao.Text = ObjProfissional.DtExpedicao;
            ddlRgUFemissao.ValorInformado = ObjProfissional.RgUFemissao;
            ddlOrgaoExpeditor.Text = Valida.TextoNull(ObjProfissional.idOrgaoExpeditor);
            txtNome.Text = ObjProfissional.Nome;
            txtDtNascimento.Text = ObjProfissional.DtNascimento;
            ddlSexo.Text = ObjProfissional.Sexo;
            ddlEstadoCivil.Text = ObjProfissional.EstadoCivil;
            txtEndResidencia.Text = ObjProfissional.EndResidencia;
            txtNumero.Text = ObjProfissional.Numero;
            txtComplemento.Text = ObjProfissional.Complemento;
            txtCidade.Text = ObjProfissional.Cidade;
            txtBairro.Text = ObjProfissional.Bairro;
            ddlEstados.ValorInformado = ObjProfissional.UF;
            txtCEP.Text = ObjProfissional.CEP;
            txtDDDtel.Text = ObjProfissional.DDDtel;
            txtTelefone.Text = ObjProfissional.Telefone;
            txtDDDcel.Text = ObjProfissional.DDDcel;
            txtCelular.Text = ObjProfissional.Celular;
            txtEmail.Text = ObjProfissional.Email;
            ddlConselhoProfissional.ValorInformado = ObjProfissional.ConselhoProfissional;
            txtConselhoNumero.Text = ObjProfissional.ConselhoNumero;
            ddlConselhoUF.ValorInformado = ObjProfissional.ConselhoUF;
            ddlCBOS_1.ValorInformado = ObjProfissional.CBOS_1;
            ddlCBOS_2.ValorInformado = ObjProfissional.CBOS_2;
            ddlCBOS_3.ValorInformado = ObjProfissional.CBOS_3;
            ddlCBOS_4.ValorInformado = ObjProfissional.CBOS_4;
            ddlCBOS_5.ValorInformado = ObjProfissional.CBOS_5;
            ddlCBOS_6.ValorInformado = ObjProfissional.CBOS_6;
        }
        catch (Exception erro)
        {
            Response.Write(erro);
            Response.End();
        }
    }
    
}
