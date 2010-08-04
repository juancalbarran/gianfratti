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

public partial class Encaminhamento_EncaminhamentoCadastro : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        //Declaraco do evento que foi criado dentro do UserControl
        ddlCliente.SelectedIndexChanged += new EventHandler(ddlCliente_SelectedIndexChanged);

        if (!Page.IsPostBack)
        {
            //Inicia a página com as seguintes configurações
            Session["TmpIdFuncionarioEncaminhamento"] = null;
            MostraTblCliente.Visible = false;
            MostraTblProcessoSeletivo.Visible = false;
            BuscaFuncEfetivo.Visible = false;
            MostraTabDadosFunc.Visible = false;
            TipoAtestado();
            ExamesComplementares();
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
    //Evento do Radio Button que verifica o tipo de atestado que foi selecionado
    protected void rdoTipoAtestado_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Se selecionado atestado do tipo Admissional mostra os campos das pessoas que estão em processo seletivo
        if (rdoTipoAtestado.SelectedValue != "1")
        {
            MostraTblProcessoSeletivo.Visible = false;
            BuscaFuncEfetivo.Visible = true;
            MostraTblCliente.Visible = false;

            FuncionarioDadosBasicos1.IdFuncionario = Convert.ToInt32(Session["TmpIdFuncionarioEncaminhamento"]);
        }
        else //Caso não seja um atestado Admissional então mostra o campo de busca para localizar um funcionario já efeito
        {
            MostraTblCliente.Visible = true;
            MostraTblProcessoSeletivo.Visible = true;
            BuscaFuncEfetivo.Visible = false;
            MostraTabDadosFunc.Visible = false;
        }
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
            hddidCliente.Value = Convert.ToString(ObjClienteFuncionario.idCliente);
            Session["TmpIdFuncionarioEncaminhamento"] = ObjClienteFuncionario.id;
            FuncionarioDadosBasicos1.IdFuncionario = Convert.ToInt32(Session["TmpIdFuncionarioEncaminhamento"]);
            MostraTblProcessoSeletivo.Visible = false;
            MostraTabDadosFunc.Visible = true;
        }
    }
    //Evento do List Box Cliente
    private void ddlCliente_SelectedIndexChanged(object sender, EventArgs e)
    {
        hddidCliente.Value = ddlCliente.ValorInformado;
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
                ObjEncaminhamento.idCliente = ObjValida.InteiroNull(hddidCliente.Value);
                ObjEncaminhamento.idProcessoSeletivo = ObjValida.TextoNull(ObjValida.TextoNull(ddlProcessoSeletivo.SelectedValue));
                ObjEncaminhamento.idClienteFuncionario = ObjValida.TextoNull(Convert.ToString(Session["TmpIdFuncionarioEncaminhamento"]));
                ObjEncaminhamento.idTipoAtestado = Convert.ToInt32(rdoTipoAtestado.SelectedValue);
                ObjEncaminhamento.idProfissional = ObjValida.InteiroNull(ddlProfissional.ValorInformado);
                ObjEncaminhamento.DtRealizacao = Convert.ToDateTime(txtDtRealizacao.Text);
                EncaminhamentoBO ObjEncaminhamentoBO = new EncaminhamentoBO();
                ObjEncaminhamentoBO.InsertUpdate(ObjEncaminhamento);
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex);
            Response.End();
        }
        //for (int i = 0; i <= CheckBoxList1.Items.Count - 1; i++)
        //{//Verifica se o cliente foi selecionado
        //    if (CheckBoxList1.Items[i].Selected)
        //    {//caso selecionado entao add na lista
        //        //ObjUsuario.UsuarioXCliente.Add(new UsuarioXCliente(Convert.ToInt32(ObjValida.TextoNull(hddIUsuario.Value)), Convert.ToInt32(ListBoxCliente.Items[i].Value)));
        //        Response.Write(CheckBoxList1.Items[i].Value + "<br>");
        //    }
        //}
    }
    private bool ValidaCampos()
    {
        //verifica se é um Admissional
        if (rdoTipoAtestado.SelectedValue == "")
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Selecione o tipo de atestado')", true);
            return false;
        }
        //Caso seja um Admissional
        if (rdoTipoAtestado.SelectedValue == "1")
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
        //Caso NÃO seja um Admissional
        if (rdoTipoAtestado.SelectedValue != "1")
        {
            if (txtBuscar.Text == "")
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Digite o numero do CFP do funcionário e click em buscar')", true);
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
        else
        {
            return true;
        }
        
    }
}
