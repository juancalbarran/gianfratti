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
using TissObjetos;

public partial class Guias_Consulta_GuiaConsultaCadastro : System.Web.UI.Page
{
    string NomeImagem; //Variavel que vai armazenar o nome da imagem para ser usada no evendo Click da Imagem

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            CarregaRegistro();
        }
    }
    protected void BtnSalvar_Click(object sender, EventArgs e)
    {
        try
        {
            GuiaConsulta ObjGuiaConsulta = new GuiaConsulta();
            Validacoes ObjValidacoes = new Validacoes();
            //Chave primaria da tabela
            ObjGuiaConsulta.id = Convert.ToInt32(Request.QueryString["id"]);
            //Dados do Beneficiário
            ObjGuiaConsulta.RegANS = txtRegANS.Text;
            ObjGuiaConsulta.DtEmissao = txtDtEmissao.Text;
            ObjGuiaConsulta.NumCarteira = txtNumCarteira.Text;
            ObjGuiaConsulta.Plano = txtPlano.Text;
            ObjGuiaConsulta.DtValidadeCarteira = txtDtValidadeCarteira.Text;
            ObjGuiaConsulta.NomeBeneficiario = txtNomeBeneficiario.Text;
            ObjGuiaConsulta.NumCartaoNacionalSaude = txtNumCartaoNacionalSaude.Text;
            //Dados do Contratado
            ObjGuiaConsulta.CodOperadoraCnpjCpf = txtCodOperadoraCnpjCpf.Text;
            ObjGuiaConsulta.NomeContratado = txtNomeContratado.Text;
            ObjGuiaConsulta.CNES = txtCNES.Text;
            ObjGuiaConsulta.IdTipoLogradouro = ddlTipoLogradouro.Text;
            ObjGuiaConsulta.Logradouro = txtLogradouro.Text;
            ObjGuiaConsulta.Numero = txtNumero.Text;
            ObjGuiaConsulta.Complemento = txtComplemento.Text;
            ObjGuiaConsulta.Municipio = txtMunicipio.Text;
            ObjGuiaConsulta.UF = txtUF.Text;
            ObjGuiaConsulta.CodIBGE = txtCodIBGE.Text;
            ObjGuiaConsulta.CEP = txtCEP.Text;
            ObjGuiaConsulta.NomeProfissional = txtNomeProfissional.Text;
            ObjGuiaConsulta.IdConselhoProfissional = ddlConselhoProfissional.Text;
            ObjGuiaConsulta.NumeroConselho = txtNumeroConselho.Text;
            ObjGuiaConsulta.UFConselho = txtUFConselho.Text;
            ObjGuiaConsulta.IdCBOS = ddlCBOS.Text;
            //Hipótese Diagnóstica
            ObjGuiaConsulta.IdTipoDoenca = ddlTipoDoenca.Text;
            ObjGuiaConsulta.TempoDoenca = txtTempoDoenca.Text;
            ObjGuiaConsulta.IdTempoDoencaUnidade = ddlTempoDoencaUnidade.Text;
            ObjGuiaConsulta.IdIndicacaoAcidente = ddlIndicacaoAcidente.Text;
            ObjGuiaConsulta.CID10_1 = txtCID10_1.Text;
            ObjGuiaConsulta.CID10_2 = txtCID10_2.Text;
            ObjGuiaConsulta.CID10_3 = txtCID10_3.Text;
            ObjGuiaConsulta.CID10_4 = txtCID10_4.Text;
            //Dados do Atendimento / Procedimento Realizado
            ObjGuiaConsulta.DtAtendimento = txtDtAtendimento.Text;
            ObjGuiaConsulta.IdCodTabela = ddlCodTabela.Text;
            ObjGuiaConsulta.CodProcedimento = txtCodProcedimento.Text;
            ObjGuiaConsulta.IdTipoConsulta = ddlTipoConsulta.Text;
            ObjGuiaConsulta.IdTipoSaida = ddlTipoSaida.Text;
            ObjGuiaConsulta.Observacao = txtObservacao.Text;
            //Chama o BO
            GuiaConsultaBO ObjGuiaConsultaBO = new GuiaConsultaBO();
            ObjGuiaConsultaBO.SalvaDados(ObjGuiaConsulta);
            //Apos salvar faz o redirecionamento
            Response.Redirect("Default.aspx");
        }
        catch (Exception Ex)
        {
            Response.Write(Ex);
            Response.End();
        }
    }
    public void CarregaRegistro()
    {
        try
        {
            if (Convert.ToInt32(Request.QueryString["id"]) != 0)
            {
                GuiaConsulta ObjGuiaConsulta = new GuiaConsulta();
                GuiaConsultaBO ObjGuiaConsultaBO = new GuiaConsultaBO();
                Validacoes ObjValidacoes = new Validacoes();
                ObjGuiaConsulta.id = Convert.ToInt32(Request.QueryString["id"]);
                ObjGuiaConsulta = ObjGuiaConsultaBO.CarregaRegistro(ObjGuiaConsulta) as GuiaConsulta;
                //Dados do Beneficiário
                txtRegANS.Text = ObjGuiaConsulta.RegANS;
                txtDtEmissao.Text = ObjGuiaConsulta.DtEmissao;
                txtNumCarteira.Text = ObjGuiaConsulta.NumCarteira;
                txtPlano.Text = ObjGuiaConsulta.Plano;
                txtDtValidadeCarteira.Text = ObjGuiaConsulta.DtValidadeCarteira;
                txtNomeBeneficiario.Text = ObjGuiaConsulta.NomeBeneficiario;
                txtNumCartaoNacionalSaude.Text = ObjGuiaConsulta.NumCartaoNacionalSaude;
                //Dados do Contratado
                txtCodOperadoraCnpjCpf.Text = ObjGuiaConsulta.CodOperadoraCnpjCpf;
                txtNomeContratado.Text = ObjGuiaConsulta.NomeContratado;
                txtCNES.Text = ObjGuiaConsulta.CNES;
                ddlTipoLogradouro.Text = ObjGuiaConsulta.IdTipoLogradouro;
                txtLogradouro.Text = ObjGuiaConsulta.Logradouro;
                txtNumero.Text = ObjGuiaConsulta.Numero;
                txtComplemento.Text = ObjGuiaConsulta.Complemento;
                txtMunicipio.Text = ObjGuiaConsulta.Municipio;
                txtUF.Text = ObjGuiaConsulta.UF;
                txtCodIBGE.Text = ObjGuiaConsulta.CodIBGE;
                txtCEP.Text = ObjGuiaConsulta.CEP;
                txtNomeProfissional.Text = ObjGuiaConsulta.NomeProfissional;
                ddlConselhoProfissional.Text = ObjGuiaConsulta.IdConselhoProfissional;
                txtNumeroConselho.Text = ObjGuiaConsulta.NumeroConselho;
                txtUFConselho.Text = ObjGuiaConsulta.UFConselho;
                ddlCBOS.Text = ObjGuiaConsulta.IdCBOS;
                //Hipótese Diagnóstica
                ddlTipoDoenca.Text = ObjValidacoes.TextoNull(ObjGuiaConsulta.IdTipoDoenca);
                txtTempoDoenca.Text = ObjGuiaConsulta.TempoDoenca;
                ddlTempoDoencaUnidade.Text = ObjValidacoes.TextoNull(ObjGuiaConsulta.IdTempoDoencaUnidade);
                ddlIndicacaoAcidente.Text = ObjValidacoes.TextoNull(ObjGuiaConsulta.IdIndicacaoAcidente);
                txtCID10_1.Text = ObjGuiaConsulta.CID10_1;
                txtCID10_2.Text = ObjGuiaConsulta.CID10_2;
                txtCID10_3.Text = ObjGuiaConsulta.CID10_3;
                txtCID10_4.Text = ObjGuiaConsulta.CID10_4;
                //Dados do Atendimento / Procedimento Realizado
                txtDtAtendimento.Text = ObjGuiaConsulta.DtAtendimento;
                ddlCodTabela.Text = ObjGuiaConsulta.IdCodTabela;
                txtCodProcedimento.Text = ObjGuiaConsulta.CodProcedimento;
                ddlTipoConsulta.Text = ObjValidacoes.TextoNull(ObjGuiaConsulta.IdTipoConsulta);
                ddlTipoSaida.Text = ObjValidacoes.TextoNull(ObjGuiaConsulta.IdTipoSaida);
                txtObservacao.Text = ObjGuiaConsulta.Observacao;
                //PathImg.NavigateUrl = "~/Guias/Consulta/ImgCaptura/" + System.IO.Path.GetFileName(ObjGuiaConsulta.PathImg);
                //Image1.ImageUrl = "getThumbnail.aspx?file=" + System.IO.Path.GetFileName(ObjGuiaConsulta.PathImg) + "&w=70&h=70";
                ImageButton1.ImageUrl = "getThumbnail.aspx?file=" + System.IO.Path.GetFileName(ObjGuiaConsulta.PathImg) + "&w=70&h=70";
                NomeImagem = System.IO.Path.GetFileName(ObjGuiaConsulta.PathImg);
            }
        }
        catch (Exception erro)
        {
            Response.Write(erro);
            Response.End();
        }
    }
    protected void ddlConselhoProfissional_PreRender(object sender, EventArgs e)
    {
        ddlConselhoProfissional.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }
    protected void ddlTipoDoenca_PreRender(object sender, EventArgs e)
    {
        ddlTipoDoenca.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }
    protected void ddlTempoDoencaUnidade_PreRender(object sender, EventArgs e)
    {
        ddlTempoDoencaUnidade.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }
    protected void ddlIndicacaoAcidente_PreRender(object sender, EventArgs e)
    {
        ddlIndicacaoAcidente.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }
    protected void ddlTipoConsulta_PreRender(object sender, EventArgs e)
    {
        ddlTipoConsulta.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }
    protected void ddlTipoSaida_PreRender(object sender, EventArgs e)
    {
        ddlTipoSaida.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }
    protected void txtTipoLogradouro_PreRender(object sender, EventArgs e)
    {
        ddlTipoLogradouro.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }
    protected void txtCBOS_PreRender(object sender, EventArgs e)
    {
        ddlCBOS.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }
    protected void txtCodTabela_PreRender(object sender, EventArgs e)
    {
        ddlCodTabela.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        //Chama a funcao que carrega o registro apenas para carregar o nome da imagem
        //Foi feito isto pois o evento é startado antes dessa funcao e nao carregava o nome da imagem da variavel global
        CarregaRegistro();
        //Abre a PopUp com a imagem
        //Page.ClientScript.RegisterStartupScript(GetType(), "OnLoad", "window.open('getThumbnail.aspx?file=" + NomeImagem + "&w=70&h=70',null,'left=400, top=100, height=600, width=800, status=no, resizable=yes, scrollbars=yes, toolbar=no,location= no, menubar=no');", true);
        Page.ClientScript.RegisterStartupScript(GetType(), "OnLoad", "window.open('ImgCaptura/" + NomeImagem + "',null,'left=400, top=100, height=600, width=800, status=no, resizable=yes, scrollbars=yes, toolbar=no,location= no, menubar=no');", true);
    }
}
