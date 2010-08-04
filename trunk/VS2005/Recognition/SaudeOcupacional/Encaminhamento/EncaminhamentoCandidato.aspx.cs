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

public partial class Encaminhamento_EncaminhamentoCandidato : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Declaraco do evento que foi criado dentro do UserControl
        ddlCliente.SelectedIndexChanged += new EventHandler(ddlCliente_SelectedIndexChanged);

        if (!Page.IsPostBack)
        {
            //Inicia a página com as seguintes configurações
            TipoAtestado();
            ExamesComplementares();
            //Desabilita algumas opcoes do controle radio button
            rdoTipoAtestado.Items[0].Selected = true;
            rdoTipoAtestado.Items[1].Enabled = false;
            rdoTipoAtestado.Items[2].Enabled = false;
            rdoTipoAtestado.Items[3].Enabled = false;
            rdoTipoAtestado.Items[4].Enabled = false;
            rdoTipoAtestado.Items[5].Enabled = false;
            rdoTipoAtestado.Items[6].Enabled = false;
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
    //Carrega o List Box com o nome das pessoas que estão em processo seletivo
    private void ProcessoSeletivo()
    {
        ProcessoSeletivoBO ObjProcessoSeletivoBO = new ProcessoSeletivoBO();
        ddlProcessoSeletivo.DataSource = ObjProcessoSeletivoBO.DropDownList(Convert.ToInt32(ddlCliente.ValorInformado));
        ddlProcessoSeletivo.DataTextField = "Nome";
        ddlProcessoSeletivo.DataValueField = "id";
        ddlProcessoSeletivo.DataBind();
        ddlProcessoSeletivo.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }
    //Evento do List Box Cliente
    private void ddlCliente_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Carrega as pessoas que estao em processo seletivo
        ProcessoSeletivo();
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
                ObjEncaminhamento.idCliente = Convert.ToInt32(ddlCliente.ValorInformado);
                ObjEncaminhamento.idProcessoSeletivo = ObjValida.TextoNull(ObjValida.TextoNull(ddlProcessoSeletivo.SelectedValue));
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
        if (ddlCliente.ValorInformado == "")
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Selecione a razão social')", true);
            return false;
        }
        else if (ddlProcessoSeletivo.SelectedValue == "")
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Selecione o canditado que esta participando do processo seletivo')", true);
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
