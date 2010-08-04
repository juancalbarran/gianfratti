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

public partial class Guias_PaginasAuxiliares_Prorrogacoes_ProrrogacoesCadastro : System.Web.UI.Page
{
    //Variaveis Globais
    Prorrogacoes ObjProrrogacoes;
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
            Session["ObjSessionProrrogacoes"] = null;
            CarregaRegistro();
        }
    }
    //Evento para salvar a guia
    protected void BtnSalvar_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["ObjSessionProrrogacoes"] == null)
            {
                ObjProrrogacoes = new Prorrogacoes();
            }
            else
            {
                ObjProrrogacoes = Session["ObjSessionProrrogacoes"] as Prorrogacoes;
            }
            //Chave primaria da tabela
            ObjProrrogacoes.id = Convert.ToInt32(Request.QueryString["id"]);
            ObjProrrogacoes.idGuiaSolicitacaoInternacao = Convert.ToInt32(Request.QueryString["idGuiaSolicitacaoInternacao"]);
            //Dados Gerais da Guia
            ObjProrrogacoes.Data = txtData.Text;
            ObjProrrogacoes.Senha = txtSenha.Text;
            ObjProrrogacoes.Responsavel = txtResponsavel.Text;
            ObjProrrogacoes.idTipoAcomodacao = ddlTipoAcomodacao.ValorInformado;
            ObjProrrogacoes.DescricaoAcomodacao = txtDescAcomodacao.Text;
            ObjProrrogacoes.QtdAutorizada = txtQtdAutorizada.Text;
            //Chama o BO
            ProrrogacoesBO ObjProrrogacoesBO = new ProrrogacoesBO();
            ObjProrrogacoesBO.SalvaDados(ObjProrrogacoes);
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

    //Evento para incluir um novo procedimento
    protected void btnIncluirProcedimentos_Click(object sender, EventArgs e)
    {
        if (Session["ObjSessionProrrogacoes"] == null)
        {
            ObjProrrogacoes = new Prorrogacoes();
        }
        else
        {
            ObjProrrogacoes = Session["ObjSessionProrrogacoes"] as Prorrogacoes;
        }
        ObjProrrogacoes.RefProcedimentosSolicitados.Add(new ProcedimentosSolicitados(ddlTabelas_Procedimentos.ValorInformado, txtCodProcedimento.Text, txtDescProcedimento.Text, txtQtdSolicitada.Text, txtQtdAutorizado.Text));
        Session["ObjSessionProrrogacoes"] = ObjProrrogacoes;

        DataGridSolicitacaoInternacao();
    }
    //Função que preenche o data grid
    private void DataGridSolicitacaoInternacao()
    {
        ObjProrrogacoes = Session["ObjSessionProrrogacoes"] as Prorrogacoes;
        GridViewProcedimentos.DataSource = ObjProrrogacoes.RefProcedimentosSolicitados;
        GridViewProcedimentos.DataBind();
    }
    //Evento que faz o calculo e coloca no Footer do GridView
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
    //Evento usado para deletar um procedimento
    protected void GridViewProcedimentos_SelectedIndexChanged(object sender, EventArgs e)
    {
        ObjProrrogacoes = Session["ObjSessionProrrogacoes"] as Prorrogacoes;
        ObjProrrogacoes.RefProcedimentosSolicitados.RemoveAt(GridViewProcedimentos.SelectedIndex);
        Session["ObjSessionProrrogacoes"] = ObjProrrogacoes;
        GridViewProcedimentos.SelectedIndex = -1;
        DataGridSolicitacaoInternacao();
    }
    //Fim da inclussao e gerenciamentos de procedimentos solicitados

    //Inicio da inclussao e gerenciamentos de OPM Solicitados 

    //Evento para incluir um novo OPM
    protected void btnIncluirOPM_Click(object sender, EventArgs e)
    {
        if (Session["ObjSessionProrrogacoes"] == null)
        {
            ObjProrrogacoes = new Prorrogacoes();
        }
        else
        {
            ObjProrrogacoes = Session["ObjSessionProrrogacoes"] as Prorrogacoes;
        }
        ObjProrrogacoes.RefOPMSolicitadas.Add(new OPMSolicitadas(ddlTabelas_OPM.ValorInformado, txtCodOPM.Text, txtDescOPM.Text, txtQtdOPM.Text, txtFabricanteOPM.Text, txtValorOPM.Text));
        Session["ObjSessionProrrogacoes"] = ObjProrrogacoes;
        DataGridOPMSolicitados();
    }
    //Função que preenche o data grid
    private void DataGridOPMSolicitados()
    {
        ObjProrrogacoes = Session["ObjSessionProrrogacoes"] as Prorrogacoes;
        GridViewOPMSolicitados.DataSource = ObjProrrogacoes.RefOPMSolicitadas;
        GridViewOPMSolicitados.DataBind();
    }
    //Evento que faz o calculo e coloca no Footer do GridView
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
    //Evento usado para deletar um procedimento
    protected void GridViewOPMSolicitados_SelectedIndexChanged(object sender, EventArgs e)
    {
        ObjProrrogacoes = Session["ObjSessionProrrogacoes"] as Prorrogacoes;
        ObjProrrogacoes.RefOPMSolicitadas.RemoveAt(GridViewOPMSolicitados.SelectedIndex);
        Session["ObjSessionProrrogacoes"] = ObjProrrogacoes;
        GridViewOPMSolicitados.SelectedIndex = -1;
        DataGridOPMSolicitados();
    }
    //Fim da inclussao e gerenciamentos de OPM Solicitados

    //Carrega os dados basicos para edição e toda a lista de Procedimentos e OPM
    public void CarregaRegistro()
    {
        try
        {
            if (Convert.ToInt32(Request.QueryString["id"]) != 0)
            {
                if (Session["ObjSessionProrrogacoes"] == null)
                {
                    ObjProrrogacoes = new Prorrogacoes();
                }
                else
                {
                    ObjProrrogacoes = Session["ObjSessionProrrogacoes"] as Prorrogacoes;
                }
                ProrrogacoesBO ObjProrrogacoesBO = new ProrrogacoesBO();
                Validacoes ObjValidacoes = new Validacoes();
                ObjProrrogacoes.id = Convert.ToInt32(Request.QueryString["id"]);
                ObjProrrogacoes = ObjProrrogacoesBO.CarregaRegistro(ObjProrrogacoes) as Prorrogacoes;
                //Dados Gerais
                txtData.Text = ObjProrrogacoes.Data;
                txtSenha.Text = ObjProrrogacoes.Senha;
                txtResponsavel.Text = ObjProrrogacoes.Responsavel;
                ddlTipoAcomodacao.ValorInformado = ObjProrrogacoes.idTipoAcomodacao;
                txtDescAcomodacao.Text = ObjProrrogacoes.DescricaoAcomodacao;
                txtQtdAutorizada.Text = ObjProrrogacoes.QtdAutorizada;
                //Cria os DALs para preencher as listas.
                ProcedimentosSolicitadosDAL ObjProcedimentosSolicitadosDAL = new ProcedimentosSolicitadosDAL();
                ObjProrrogacoes = ObjProcedimentosSolicitadosDAL.SelectRetornaListaProcedimentos(ObjProrrogacoes, null, Request.QueryString["id"]);
                OPMSolicitadasDAL ObjOPMSolicitadasDAL = new OPMSolicitadasDAL();                
                ObjProrrogacoes = ObjOPMSolicitadasDAL.SelectRetornaListaOPM(ObjProrrogacoes,null, Request.QueryString["id"]);
                //Salva as listas na Session
                Session["ObjSessionProrrogacoes"] = ObjProrrogacoes;
                //Preenche os DataGrids
                DataGridSolicitacaoInternacao(); //Chama GridView que mostra os dados dos procedimentos
                DataGridOPMSolicitados(); //Chama GridView que mostra os dados dos procedimentos
            }
        }
        catch (Exception erro)
        {
            Response.Write(erro);
            Response.End();
        }
    }
}
