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
using System.Text;
using System.IO;
using System.Net;

public partial class Guias_SolicitacaoInternacao_GuiaSolicitacaoInternacaoCadastro : System.Web.UI.Page
{
    //Variaveis Globais
    GuiaSolicitacaoInternacao ObjGuiaSolicitacaoInternacao;
    private int Total_Procedimentos_Solicitado;
    private int Total_Procedimentos_Autorizado;
    private int Total_Qtd_OPM;
    private decimal Total_ValorUnitario_OPM;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //Linguagem de formatacao do pais. Usado nesta pagina pricipalmente para MOEDA
            UICulture = "pt-BR";
            //Primeiro acesso a página seta a session como vazia, sesseion que vai armazenar a classe
            Session["ObjSession"] = null;
            CarregaRegistro();
        }
    }
    protected void BtnSalvar_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["ObjSession"] == null)
            {
                ObjGuiaSolicitacaoInternacao = new GuiaSolicitacaoInternacao();
            }
            else
            {
                ObjGuiaSolicitacaoInternacao = Session["ObjSession"] as GuiaSolicitacaoInternacao;
            }
            //Chave primaria da tabela
            ObjGuiaSolicitacaoInternacao.id = Convert.ToInt32(Request.QueryString["id"]); 
            //Dados Gerais da Guia
            ObjGuiaSolicitacaoInternacao.RegANS = txtRegANS.Text;
            ObjGuiaSolicitacaoInternacao.DtAutorizacao = txtDtAutorizacao.Text;
            ObjGuiaSolicitacaoInternacao.Senha = txtSenha.Text;
            ObjGuiaSolicitacaoInternacao.DtValidadeSenha = txtDtValidadeSenha.Text;
            ObjGuiaSolicitacaoInternacao.DtEmissao = txtDtEmissao.Text;
            //Dados do Beneficiário
            ObjGuiaSolicitacaoInternacao.NumCarteira = txtNumCarteira.Text;
            ObjGuiaSolicitacaoInternacao.Plano = txtPlano.Text;
            ObjGuiaSolicitacaoInternacao.DtValidadeCarteira = txtDtValidadeCarteira.Text;
            ObjGuiaSolicitacaoInternacao.NomeBeneficiario = txtNomeBeneficiario.Text;
            ObjGuiaSolicitacaoInternacao.NumCartaoNacionalSaude = txtNumCartaoNacionalSaude.Text;
            //Dados do Contratado Solicitante
            ObjGuiaSolicitacaoInternacao.CodOperadoraCnpjCpf = txtCodOperadoraCnpjCpf.Text;
            ObjGuiaSolicitacaoInternacao.NomeContratado = txtNomeContratado.Text;
            ObjGuiaSolicitacaoInternacao.CNES = txtCNES.Text;
            ObjGuiaSolicitacaoInternacao.NomeProfissional = txtNomeProfissional.Text;
            ObjGuiaSolicitacaoInternacao.IdConselhoProfissional = ddlConselhoProfissional.ValorInformado;
            ObjGuiaSolicitacaoInternacao.NumeroConselho = txtNumeroConselho.Text;
            ObjGuiaSolicitacaoInternacao.UFConselho = txtUFConselho.Text;
            ObjGuiaSolicitacaoInternacao.IdCBOS = ddlCBOS.ValorInformado;
            //Dados do Contratado Solicitante / Dados da Internação
            ObjGuiaSolicitacaoInternacao.CodOperadoraCnpj = txtCodOperadoraCnpj.Text;
            ObjGuiaSolicitacaoInternacao.NomePrestador = txtNomePrestador.Text;
            ObjGuiaSolicitacaoInternacao.IdCaraterInternacao = ddlCaraterInternacao.ValorInformado;
            ObjGuiaSolicitacaoInternacao.IdTipoInternacao = ddlTipoInternacao.ValorInformado;
            ObjGuiaSolicitacaoInternacao.IdRegimeInternacao = ddlRegimeInternacao.ValorInformado;
            ObjGuiaSolicitacaoInternacao.QtdDiariasSolicitadas = txtQtdDiariasSolicitadas.Text;
            ObjGuiaSolicitacaoInternacao.IndicacaoClinica = txtIndicacaoClinica.Text;
            //Hipótese Diagnóstica
            ObjGuiaSolicitacaoInternacao.IdTipoDoenca = ddlTipoDoenca.ValorInformado;
            ObjGuiaSolicitacaoInternacao.TempoDoenca = txtTempoDoenca.Text;
            ObjGuiaSolicitacaoInternacao.IdTempoDoencaUnidade = ddlUnidadeTempoDoenca.ValorInformado;
            ObjGuiaSolicitacaoInternacao.IdIndicacaoAcidente = ddlIndicadorAcidente.ValorInformado;
            ObjGuiaSolicitacaoInternacao.CID10_1 = txtCID10_1.Text;
            ObjGuiaSolicitacaoInternacao.CID10_2 = txtCID10_2.Text;
            ObjGuiaSolicitacaoInternacao.CID10_3 = txtCID10_3.Text;
            ObjGuiaSolicitacaoInternacao.CID10_4 = txtCID10_4.Text;
            //Dados da Autorização
            ObjGuiaSolicitacaoInternacao.dtProvavelAdmissao = txtdtProvavelAdmissao.Text;
            ObjGuiaSolicitacaoInternacao.QtdDiariasAutorizadas = txtQtdDiariasAutorizadas.Text;
            ObjGuiaSolicitacaoInternacao.idTipoAcomodacao = ddlTipoAcomodacao.ValorInformado;
            ObjGuiaSolicitacaoInternacao.CodigoOperadoraCNPJ = txtCodigoOperadoraCNPJ.Text;
            ObjGuiaSolicitacaoInternacao.NomePrestadorAutorizado = txtNomePrestadorAutorizado.Text;
            ObjGuiaSolicitacaoInternacao.CodigoCNES = txtCodigoCNES.Text;
            ObjGuiaSolicitacaoInternacao.Observacoes = txtObservacoes.Text;
            //Chama o BO
            GuiaSolicitacaoInternacaoBO ObjGuiaSolicitacaoInternacaoBO = new GuiaSolicitacaoInternacaoBO();
            ObjGuiaSolicitacaoInternacaoBO.SalvaDados(ObjGuiaSolicitacaoInternacao);
            //Apos salvar faz o redirecionamento'
            Response.Redirect("Default.aspx");
        }
        catch (Exception Ex)
        {
            Response.Write(Ex);
            Response.End();
        }
    }
    //Inicio da inclussao e gerenciamentos de procedimentos solicitados
    protected void btnIncluirProcedimentos_Click(object sender, EventArgs e)
    {
        if (Session["ObjSession"] == null)
        {
            ObjGuiaSolicitacaoInternacao = new GuiaSolicitacaoInternacao();
        }
        else
        {
            ObjGuiaSolicitacaoInternacao = Session["ObjSession"] as GuiaSolicitacaoInternacao;
        }
        ObjGuiaSolicitacaoInternacao.RefProcedimentosSolicitados.Add(new ProcedimentosSolicitados(ddlTabelas_Procedimentos.ValorInformado, txtCodProcedimento.Text, txtDescProcedimento.Text, txtQtdSolicitada.Text, txtQtdAutorizado.Text));
        Session["ObjSession"] = ObjGuiaSolicitacaoInternacao;
        DataGridSolicitacaoInternacao();
    }
    private void DataGridSolicitacaoInternacao()
    {
        ObjGuiaSolicitacaoInternacao = Session["ObjSession"] as GuiaSolicitacaoInternacao;
        GridViewProcedimentos.DataSource = ObjGuiaSolicitacaoInternacao.RefProcedimentosSolicitados;
        GridViewProcedimentos.DataBind();
    }
    protected void GridViewProcedimentos_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Total_Procedimentos_Solicitado += Convert.ToInt32(e.Row.Cells[3].Text);
            Total_Procedimentos_Autorizado += Convert.ToInt32(e.Row.Cells[4].Text);
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[3].Text = "Total: " + Total_Procedimentos_Solicitado;
            e.Row.Cells[4].Text = "Total: " + Total_Procedimentos_Autorizado;
        }
    }
    protected void GridViewProcedimentos_SelectedIndexChanged(object sender, EventArgs e)
    {
        ObjGuiaSolicitacaoInternacao = Session["ObjSession"] as GuiaSolicitacaoInternacao;
        ObjGuiaSolicitacaoInternacao.RefProcedimentosSolicitados.RemoveAt(GridViewProcedimentos.SelectedIndex);
        Session["ObjSession"] = ObjGuiaSolicitacaoInternacao;
        GridViewProcedimentos.SelectedIndex = -1;
        DataGridSolicitacaoInternacao();
    }
    //Fim da inclussao e gerenciamentos de procedimentos solicitados

    //Inicio da inclussao e gerenciamentos de OPM Solicitados 
    protected void btnIncluirOPM_Click(object sender, EventArgs e)
    {
        if (Session["ObjSession"] == null)
        {
            ObjGuiaSolicitacaoInternacao = new GuiaSolicitacaoInternacao();
        }
        else
        {
            ObjGuiaSolicitacaoInternacao = Session["ObjSession"] as GuiaSolicitacaoInternacao;
        }
        ObjGuiaSolicitacaoInternacao.RefOPMSolicitadas.Add(new OPMSolicitadas(ddlTabelas_OPM.ValorInformado, txtCodOPM.Text, txtDescOPM.Text, txtQtdOPM.Text,txtFabricanteOPM.Text ,txtValorOPM.Text));
        Session["ObjSession"] = ObjGuiaSolicitacaoInternacao;
        DataGridOPMSolicitados();
    }
    private void DataGridOPMSolicitados()
    {
        ObjGuiaSolicitacaoInternacao = Session["ObjSession"] as GuiaSolicitacaoInternacao;
        GridViewOPMSolicitados.DataSource = ObjGuiaSolicitacaoInternacao.RefOPMSolicitadas;
        GridViewOPMSolicitados.DataBind();
    }
    protected void GridViewOPMSolicitados_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Total_Qtd_OPM += Convert.ToInt32(e.Row.Cells[3].Text);
            Total_ValorUnitario_OPM += Convert.ToDecimal(e.Row.Cells[5].Text);
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[3].Text = "Total: " + Total_Qtd_OPM;
            e.Row.Cells[5].Text = "Total: " + Total_ValorUnitario_OPM.ToString("C2"); //Faz formatacao de moeda R$
        }
    }
    protected void GridViewOPMSolicitados_SelectedIndexChanged(object sender, EventArgs e)
    {
        ObjGuiaSolicitacaoInternacao = Session["ObjSession"] as GuiaSolicitacaoInternacao;
        ObjGuiaSolicitacaoInternacao.RefOPMSolicitadas.RemoveAt(GridViewOPMSolicitados.SelectedIndex);
        Session["ObjSession"] = ObjGuiaSolicitacaoInternacao;
        GridViewOPMSolicitados.SelectedIndex = -1;
        DataGridOPMSolicitados();
    }
    //Fim da inclussao e gerenciamentos de OPM Solicitados

    //Carrega os dados para edição
    public void CarregaRegistro()
    {
        try
        {
            if (Convert.ToInt32(Request.QueryString["id"]) != 0)
            {
                GuiaSolicitacaoInternacao ObjGuiaSolicitacaoInternacao = new GuiaSolicitacaoInternacao();
                GuiaSolicitacaoInternacaoBO ObjGuiaSolicitacaoInternacaoBO = new GuiaSolicitacaoInternacaoBO();
                ObjGuiaSolicitacaoInternacao.id = Convert.ToInt32(Request.QueryString["id"]);
                ObjGuiaSolicitacaoInternacao = ObjGuiaSolicitacaoInternacaoBO.CarregaRegistro(ObjGuiaSolicitacaoInternacao) as GuiaSolicitacaoInternacao;
                //Dados gerais
                txtRegANS.Text = ObjGuiaSolicitacaoInternacao.RegANS;
                txtDtAutorizacao.Text = ObjGuiaSolicitacaoInternacao.DtAutorizacao;
                txtSenha.Text = ObjGuiaSolicitacaoInternacao.Senha;
                txtDtValidadeSenha.Text = ObjGuiaSolicitacaoInternacao.DtValidadeSenha;
                txtDtEmissao.Text = ObjGuiaSolicitacaoInternacao.DtEmissao;
                //Dados do Beneficiário
                txtNumCarteira.Text = ObjGuiaSolicitacaoInternacao.NumCarteira;
                txtPlano.Text = ObjGuiaSolicitacaoInternacao.Plano;
                txtDtValidadeCarteira.Text = ObjGuiaSolicitacaoInternacao.DtValidadeCarteira;
                txtNomeBeneficiario.Text = ObjGuiaSolicitacaoInternacao.NomeBeneficiario;
                txtNumCartaoNacionalSaude.Text = ObjGuiaSolicitacaoInternacao.NumCartaoNacionalSaude;
                //Dados do Contratado Solicitante
                txtCodOperadoraCnpjCpf.Text = ObjGuiaSolicitacaoInternacao.CodOperadoraCnpjCpf;
                txtNomeContratado.Text = ObjGuiaSolicitacaoInternacao.NomeContratado;
                txtCNES.Text = ObjGuiaSolicitacaoInternacao.CNES;
                txtNomeProfissional.Text = ObjGuiaSolicitacaoInternacao.NomeProfissional;
                ddlConselhoProfissional.ValorInformado = ObjGuiaSolicitacaoInternacao.IdConselhoProfissional;
                txtNumeroConselho.Text = ObjGuiaSolicitacaoInternacao.NumeroConselho;
                txtUFConselho.Text = ObjGuiaSolicitacaoInternacao.UFConselho;
                ddlCBOS.ValorInformado = ObjGuiaSolicitacaoInternacao.IdCBOS;
                //Dados do Contratado Solicitante / Dados da Internação
                txtCodOperadoraCnpj.Text = ObjGuiaSolicitacaoInternacao.CodOperadoraCnpj;
                txtNomePrestador.Text = ObjGuiaSolicitacaoInternacao.NomePrestador;
                ddlCaraterInternacao.ValorInformado = ObjGuiaSolicitacaoInternacao.IdCaraterInternacao;
                ddlTipoInternacao.ValorInformado = ObjGuiaSolicitacaoInternacao.IdTipoInternacao;
                ddlRegimeInternacao.ValorInformado = ObjGuiaSolicitacaoInternacao.IdRegimeInternacao;
                txtQtdDiariasSolicitadas.Text = ObjGuiaSolicitacaoInternacao.QtdDiariasSolicitadas;
                txtIndicacaoClinica.Text = ObjGuiaSolicitacaoInternacao.IndicacaoClinica;
                //Hipótese Diagnóstica
                ddlTipoDoenca.ValorInformado = ObjGuiaSolicitacaoInternacao.IdTipoDoenca;
                txtTempoDoenca.Text = ObjGuiaSolicitacaoInternacao.TempoDoenca;
                ddlUnidadeTempoDoenca.ValorInformado = ObjGuiaSolicitacaoInternacao.IdTempoDoencaUnidade;
                ddlIndicadorAcidente.ValorInformado = ObjGuiaSolicitacaoInternacao.IdIndicacaoAcidente;
                txtCID10_1.Text = ObjGuiaSolicitacaoInternacao.CID10_1;
                txtCID10_2.Text = ObjGuiaSolicitacaoInternacao.CID10_2;
                txtCID10_3.Text = ObjGuiaSolicitacaoInternacao.CID10_3;
                txtCID10_4.Text = ObjGuiaSolicitacaoInternacao.CID10_4;
                //Dados da Autorização
                txtdtProvavelAdmissao.Text = ObjGuiaSolicitacaoInternacao.dtProvavelAdmissao;
                txtQtdDiariasAutorizadas.Text = ObjGuiaSolicitacaoInternacao.QtdDiariasAutorizadas;
                ddlTipoAcomodacao.ValorInformado = ObjGuiaSolicitacaoInternacao.idTipoAcomodacao;
                txtCodigoOperadoraCNPJ.Text = ObjGuiaSolicitacaoInternacao.CodigoOperadoraCNPJ;
                txtNomePrestadorAutorizado.Text = ObjGuiaSolicitacaoInternacao.NomePrestadorAutorizado;
                txtCodigoCNES.Text = ObjGuiaSolicitacaoInternacao.CodigoCNES;
                txtObservacoes.Text = ObjGuiaSolicitacaoInternacao.Observacoes;
                //Cria os DALs para preencher as listas.
                ProcedimentosSolicitadosDAL ObjProcedimentosSolicitadosDAL = new ProcedimentosSolicitadosDAL();
                ObjGuiaSolicitacaoInternacao = ObjProcedimentosSolicitadosDAL.SelectRetornaListaProcedimentos(ObjGuiaSolicitacaoInternacao, Request.QueryString["id"], null);
                //OPMSolicitadasDAL ObjOPMSolicitadasDAL = new OPMSolicitadasDAL();
                //ObjGuiaSolicitacaoInternacao = ObjOPMSolicitadasDAL.SelectRetornaListaOPM(ObjGuiaSolicitacaoInternacao, null, Request.QueryString["id"]);
                //Salva as listas na Session
                Session["ObjSession"] = ObjGuiaSolicitacaoInternacao;
                //Preenche os DataGrids
                DataGridSolicitacaoInternacao(); //Chama GridView que mostra os dados dos procedimentos
                //DataGridOPMSolicitados(); //Chama GridView que mostra os dados dos procedimentos
            }
        }
        catch (Exception erro)
        {
            Response.Write(erro);
            Response.End();
        }
    }
}