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

public partial class Encaminhamento_EncaminhamentoFuncionario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            //Inicia a página com as seguintes configurações
            MostraTabDadosFunc.Visible = false;
            TipoAtestado();
            ExamesComplementares();
            //Desabilita o tipo de exame Admissional na lista pois ele devera acontecer apenas no encaminhamento do candidato
            rdoTipoAtestado.Items[0].Enabled = false;
            
        }
        else
        {
            DadosFuncionario();
        }
    }
    //Carrega o radio button com os tipos de atestados
    private void TipoAtestado()
    {
        AtestatoSaudeBO ObjAtestatoSaudeBO = new AtestatoSaudeBO();
        rdoTipoAtestado.DataSource = ObjAtestatoSaudeBO.TipoAtestatoDropDownList();
        rdoTipoAtestado.DataTextField = "Nome";
        rdoTipoAtestado.DataValueField = "id";
        rdoTipoAtestado.DataBind();
    }
    //Carrega os list box com os nomes dos exames compementares
    private void ExamesComplementares()
    {
        ExamesComplementaresBO ObjExamesComplementaresBO = new ExamesComplementaresBO();
        CheckBoxList1.DataSource = ObjExamesComplementaresBO.DataTable();
        CheckBoxList1.DataTextField = "Descricao";
        CheckBoxList1.DataValueField = "id";
        CheckBoxList1.DataBind();
    }
    //Evento do botão buscar funcionario. Responsavel por carregar um funcionario conforme passado CPF
    protected void btnBuscaDadosFuncionario_Click(object sender, EventArgs e)
    {
        ClienteFuncionario ObjClienteFuncionario = new ClienteFuncionario();
        ClienteFuncionarioBO ObjClienteFuncionarioBO = new ClienteFuncionarioBO();
        ObjClienteFuncionario = ObjClienteFuncionarioBO.SelectRetonarIdFuncionarioByCpf(txtBuscar.Text);
        if (ObjClienteFuncionario.id == 0)
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Número do CPF não encontrado')", true);
            MostraTabDadosFunc.Visible = false;
        }
        else
        {
            hddidFuncionario.Value =  Convert.ToString(ObjClienteFuncionario.id);
            hddidCliente.Value = Convert.ToString(ObjClienteFuncionario.idCliente);
            DadosFuncionario();
        }
    }
    //Carrega os dados do funcionario
    private void DadosFuncionario()
    {
        if (hddidFuncionario.Value != "")
        {
            FuncionarioDadosBasicos1.IdFuncionario = Convert.ToInt32(hddidFuncionario.Value);
            MostraTabDadosFunc.Visible = true;
        }
    }
    //Evento para savar o encaminhamento
    protected void btnSalvar_Click(object sender, EventArgs e)
    {
        try
        {
            if (ValidaCampos())
            {
                Validacoes ObjValida = new Validacoes();
                Encaminhamento ObjEncaminhamento = new Encaminhamento();
                ObjEncaminhamento.idCliente = ObjValida.InteiroNull(hddidCliente.Value);
                ObjEncaminhamento.idClienteFuncionario = ObjValida.TextoNull(hddidFuncionario.Value);
                ObjEncaminhamento.idTipoAtestado = Convert.ToInt32(rdoTipoAtestado.SelectedValue);
                ObjEncaminhamento.idProfissional = ObjValida.InteiroNull(ddlProfissional.ValorInformado);
                ObjEncaminhamento.DtRealizacao = Convert.ToDateTime(txtDtRealizacao.Text);
                EncaminhamentoBO ObjEncaminhamentoBO = new EncaminhamentoBO();

                for (int i = 0; i <= CheckBoxList1.Items.Count - 1; i++)
                {
                    if (CheckBoxList1.Items[i].Selected) //Verifica se o item selecionado
                    {
                        //caso selecionado entao add na lista
                        ObjEncaminhamento.EncaminhamentoXExamesComplementares.Add(new EncaminhamentoXExamesComplementares(7, Convert.ToInt32(CheckBoxList1.Items[i].Value)));
                    }
                }
                //Chama o BO e passa ObjEncaminhamentoBO já com o List de Exames
                ObjEncaminhamentoBO.InsertUpdate(ObjEncaminhamento);
                Response.Write("<script>top.window.location='EncaminhamentoPrincipal.aspx'</script>");
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex);
            Response.End();
        }
    }
    // Validação
    private bool ValidaCampos()
    {
        if (txtBuscar.Text == "")
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Digite o numero do CFP do funcionário e click em buscar')", true);
            return false;
        }
        else if (rdoTipoAtestado.SelectedValue == "")
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Selecione o tipo de atestado para o encaminhamento')", true);
            return false;
        }
        else if (ddlProfissional.ValorInformado == "")
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Selecione o médico examinador')", true);
            return false;
        }
        else if (txtDtRealizacao.Text == "")
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Digite a data de realização do exame')", true);
            return false;
        }
        else
        {
            return true;
        }
    }
}
