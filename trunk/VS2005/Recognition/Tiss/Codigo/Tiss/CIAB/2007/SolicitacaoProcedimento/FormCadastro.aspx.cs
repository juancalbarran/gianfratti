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
using System.IO;

public partial class CIAB_2007_SolicitacaoProcedimento_FormCadastro : System.Web.UI.Page
{
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
            CIAB2007SolicitacaoProcedimento Obj = new CIAB2007SolicitacaoProcedimento();
            Validacoes ObjValidacoes = new Validacoes();
            //Chave primaria da tabela
            Obj.id = Convert.ToInt32(Request.QueryString["id"]);
            //Dados
            Obj.GuiaTipo = rdoGuiaTipo.Text;
            Obj.GuiaData = txtGuiaData.Text;
            Obj.GuiaHora = txtGuiaHora.Text;
            Obj.Paciente = txtPaciente.Text;
            Obj.Sexo = rdoSexo.Text;
            Obj.Idade = txtIdade.Text;
            Obj.Peso = txtPeso.Text;
            Obj.Altura = txtAltura.Text;
            Obj.Plano = txtPlano.Text;
            Obj.Titular = txtTitular.Text;
            Obj.Codigo = txtCodigo.Text;
            Obj.Historico = txtHistorico.Text;
            Obj.TipoDoenca = rdoTipoDoenca.Text;
            Obj.TempoEvolucaoAnos = txtTempoEvolucaoAnos.Text;
            Obj.TempoEvolucaoMeses = txtTempoEvolucaoMeses.Text;
            Obj.TempoEvolucaoDias = txtTempoEvolucaoDias.Text;
            Obj.ResultadoExames = txtResultadoExames.Text;
            Obj.Diagnostico = txtDiagnostico.Text;
            Obj.Tratamento = txtTratamento.Text;
            Obj.CodigoProcedimentos = txtCodigoProcedimentos.Text;
            Obj.CodigoProcedimentos_1 = txtCodigoProcedimentos_1.Text;
            Obj.CodigoProcedimentos_2 = txtCodigoProcedimentos_2.Text;
            Obj.CodigoProcedimentos_3 = txtCodigoProcedimentos_3.Text;
            Obj.TipoTratamento = rdoTipoTratamento.Text;
            Obj.TipoInternacao = rdoTipoInternacao.Text;
            Obj.DataInternacao = txtDataInternacao.Text;
            Obj.DataCirurgia = txtDataCirurgia.Text;
            Obj.DiasInternacao = txtDiasInternacao.Text;
            Obj.ProcedimentoEfetuado = txtProcedimentoEfetuado.Text;
            Obj.DataProcedimento = txtDataProcedimento.Text;
            Obj.CRM = txtCRM.Text;
            //Chama o BO
            CIAB2007SolicitacaoProcedimentoBO ObjBO = new CIAB2007SolicitacaoProcedimentoBO();
            ObjBO.SalvaDados(Obj);
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
                CIAB2007SolicitacaoProcedimento Obj = new CIAB2007SolicitacaoProcedimento();
                CIAB2007SolicitacaoProcedimentoBO ObjBO = new CIAB2007SolicitacaoProcedimentoBO();
                Validacoes ObjValidacoes = new Validacoes();
                Obj.id = Convert.ToInt32(Request.QueryString["id"]);
                Obj = ObjBO.CarregaRegistro(Obj) as CIAB2007SolicitacaoProcedimento;
                //Dados
                rdoGuiaTipo.Text = Obj.GuiaTipo;
                txtGuiaData.Text = Obj.GuiaData;
                txtGuiaHora.Text = Obj.GuiaHora;
                txtPaciente.Text = Obj.Paciente;
                rdoSexo.Text = Obj.Sexo;
                txtIdade.Text = Obj.Idade;
                txtPeso.Text = Obj.Peso;
                txtAltura.Text = Obj.Altura;
                txtPlano.Text = Obj.Plano;
                txtTitular.Text = Obj.Titular;
                txtCodigo.Text = Obj.Codigo;
                txtHistorico.Text = Obj.Historico;
                rdoTipoDoenca.Text = Obj.TipoDoenca;
                txtTempoEvolucaoAnos.Text = Obj.TempoEvolucaoAnos;
                txtTempoEvolucaoMeses.Text = Obj.TempoEvolucaoMeses;
                txtTempoEvolucaoDias.Text = Obj.TempoEvolucaoDias;
                txtResultadoExames.Text = Obj.ResultadoExames;
                txtDiagnostico.Text = Obj.Diagnostico;
                txtTratamento.Text = Obj.Tratamento;
                txtCodigoProcedimentos.Text = Obj.CodigoProcedimentos;
                txtCodigoProcedimentos_1.Text = Obj.CodigoProcedimentos_1;
                txtCodigoProcedimentos_2.Text = Obj.CodigoProcedimentos_2;
                txtCodigoProcedimentos_3.Text = Obj.CodigoProcedimentos_3;
                rdoTipoTratamento.Text = Obj.TipoTratamento;
                rdoTipoInternacao.Text = Obj.TipoInternacao;
                txtDataInternacao.Text = Obj.DataInternacao;
                txtDataCirurgia.Text = Obj.DataCirurgia;
                txtDiasInternacao.Text = Obj.DiasInternacao;
                txtProcedimentoEfetuado.Text = Obj.ProcedimentoEfetuado;
                txtDataProcedimento.Text = Obj.DataProcedimento;
                txtCRM.Text = Obj.CRM;
                PathImg.NavigateUrl = "~/CIAB/2007/ImgCaptura/"  + System.IO.Path.GetFileName(Obj.PathImg);
                Image1.ImageUrl = "getThumbnail.aspx?file=" + System.IO.Path.GetFileName(Obj.PathImg) + "&w=100&h=100";
                //char[] sep = {'\\'};
                //SplitString(Convert.ToString(Obj.PathImg), sep);
                //GeraThumbnail("teste.jpg", "10", "10");
                CIAB2007SolicitacaoProcedimentoDAL ObjDAL = new CIAB2007SolicitacaoProcedimentoDAL();
                string NomeMedico = ObjDAL.SelectMedicoByCRM(Obj.CRM);
                lblNomeMedico.Text = Convert.ToString(NomeMedico);
            }
        }
        catch (Exception erro)
        {
            Response.Write(erro);
            Response.End();
        }
    }

    public void SplitString(string stringToSplit, char[] sep)
    {
        Array a = stringToSplit.Split(sep);
        for (int i = 0; i < a.Length; i++)
        {
            if (i == a.Length - 1)
            {
                Response.Write(a.GetValue(i).ToString());
                PathImg.NavigateUrl = a.GetValue(i).ToString();
            }
        }

    }

}
