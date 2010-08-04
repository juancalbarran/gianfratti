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

public partial class ClienteFuncionario_FuncionarioAtualizar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            //Carrega dos dados do Funcionario
            CarregaDadosFuncionario();
        }
    }
    //CARREGA OS DADOS DO FUNCIONARIO PARA EDIÇÃO
    public void CarregaDadosFuncionario()
    {
        try
        {
            if (Convert.ToInt32(Request.QueryString["id"]) != 0)
            {
                ClienteFuncionario ObjCLienteFuncionario = new ClienteFuncionario();
                ClienteFuncionarioBO ObjClienteFuncionarioBO = new ClienteFuncionarioBO();
                Validacoes Valida = new Validacoes();
                ObjCLienteFuncionario = ObjClienteFuncionarioBO.CarregaFuncionario(Convert.ToInt32(Request.QueryString["id"])) as ClienteFuncionario;
                //DADOS PESSOAIS
                DdlCliente.ValorInformado = Convert.ToString(ObjCLienteFuncionario.idCliente);
                TxtCPF.Enabled = false;
                TxtCPF.Text = ObjCLienteFuncionario.CPF;
                TxtRG.Text = ObjCLienteFuncionario.RG;
                DdlOrgaoExpeditor.Text = Valida.TextoNull(ObjCLienteFuncionario.idOrgaoExpeditor);
                TxtDtExpedicao.Text = ObjCLienteFuncionario.DtExpedicao;
                TxtRgUFemissao.Text = ObjCLienteFuncionario.RgUFemissao;
                TxtNome.Text = ObjCLienteFuncionario.Nome;
                TxtDtNascimento.Text = ObjCLienteFuncionario.DtNascimento;
                TxtDtObito.Text = ObjCLienteFuncionario.DtObito;
                DdlSexo.Text = Valida.TextoNull(ObjCLienteFuncionario.Sexo);
                DdlEstadoCivil.Text = Valida.TextoNull(ObjCLienteFuncionario.EstadoCivil);
                TxtMae.Text = ObjCLienteFuncionario.Mae;
                TxtEndResidencia.Text = ObjCLienteFuncionario.EndResidencia;
                TxtNumero.Text = ObjCLienteFuncionario.Numero;
                TxtConplemento.Text = ObjCLienteFuncionario.Complemento;
                TxtCidade.Text = ObjCLienteFuncionario.Cidade;
                ddlEstados.ValorInformado = ObjCLienteFuncionario.UF;
                TxtBairro.Text = ObjCLienteFuncionario.Bairro;
                TxtCEP.Text = ObjCLienteFuncionario.CEP;
                TxtDDDtel.Text = ObjCLienteFuncionario.DDDtel;
                TxtTelefone.Text = ObjCLienteFuncionario.Telefone;
                TxtDDDcel.Text = ObjCLienteFuncionario.DDDcel;
                TxtCelular.Text = ObjCLienteFuncionario.Celular;
                TxtDDDContato.Text = ObjCLienteFuncionario.DDDcontato;
                TxtTelefoneContato.Text = ObjCLienteFuncionario.TelefoneContato;
                TxtContatoNome.Text = ObjCLienteFuncionario.ContatoNome;
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex);
            Response.End();
        }
    }

    public bool Validacao()
    {
        Validacoes ObjValida = new Validacoes();
        ClienteFuncionarioBO ObjClienteFuncionarioBO = new ClienteFuncionarioBO();
        if (DdlCliente.ValorInformado == string.Empty)
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Selecione um cliente')", true);
            return false;
        }
        else if (!ObjClienteFuncionarioBO.VerificaDuplicidadeCPF(Convert.ToInt32(DdlCliente.ValorInformado), TxtCPF.Text) && TxtCPF.Enabled == true)
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('O número de CPF digitado já pertence a um funcionário do cliente selecionado')", true);
            return false;
        }
        else if (DdlCliente.ValorInformado == string.Empty)
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Selecione um cliente')", true);
            return false;
        }
        else if (!ObjValida.ValidaCpf(TxtCPF.Text))
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('CPF inválido')", true);
            return false;
        }
        else if (TxtNome.Text.Trim() == "")
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Entre com o nome do funcionário')", true);
            return false;
        }
        else
        {
            return true;
        }
    }
    //Salva os dados do funcionario
    protected void BtnSalvar_Click(object sender, EventArgs e)
    {
        //Chama a funcao que vai fazer a validacao nos campos da ficha pessoal do funcionario
        if (Validacao())
        {
            try
            {
                ClienteFuncionario ObjCLienteFuncionario = new ClienteFuncionario();
                Validacoes Valida = new Validacoes();
                //Chave primaria da tabela
                ObjCLienteFuncionario.id = Convert.ToInt32(Request.QueryString["id"]);
                //Dados Pessoais
                ObjCLienteFuncionario.idCliente = Convert.ToInt32(DdlCliente.ValorInformado);
                ObjCLienteFuncionario.CPF = TxtCPF.Text;
                ObjCLienteFuncionario.RG = TxtRG.Text;
                ObjCLienteFuncionario.idOrgaoExpeditor = Valida.TextoNull(DdlOrgaoExpeditor.Text);
                ObjCLienteFuncionario.DtExpedicao = TxtDtExpedicao.Text;
                ObjCLienteFuncionario.RgUFemissao = TxtRgUFemissao.Text;
                ObjCLienteFuncionario.Nome = TxtNome.Text;
                ObjCLienteFuncionario.DtNascimento = TxtDtNascimento.Text;
                ObjCLienteFuncionario.DtObito = TxtDtObito.Text;
                ObjCLienteFuncionario.Sexo = Valida.TextoNull(DdlSexo.Text);
                ObjCLienteFuncionario.EstadoCivil = Valida.TextoNull(DdlEstadoCivil.Text);
                ObjCLienteFuncionario.Mae = TxtMae.Text;
                ObjCLienteFuncionario.EndResidencia = TxtEndResidencia.Text;
                ObjCLienteFuncionario.Numero = TxtNumero.Text;
                ObjCLienteFuncionario.Complemento = TxtConplemento.Text;
                ObjCLienteFuncionario.Cidade = TxtCidade.Text;
                ObjCLienteFuncionario.UF = ddlEstados.ValorInformado;
                ObjCLienteFuncionario.Bairro = TxtBairro.Text;
                ObjCLienteFuncionario.CEP = TxtCEP.Text;
                ObjCLienteFuncionario.DDDtel = TxtDDDtel.Text;
                ObjCLienteFuncionario.Telefone = TxtTelefone.Text;
                ObjCLienteFuncionario.DDDcel = TxtDDDcel.Text;
                ObjCLienteFuncionario.Celular = TxtCelular.Text;
                ObjCLienteFuncionario.DDDcontato = TxtDDDContato.Text;
                ObjCLienteFuncionario.TelefoneContato = TxtTelefoneContato.Text;
                ObjCLienteFuncionario.ContatoNome = TxtContatoNome.Text;

                string idFuncionario = null;
                string idCliente = null;

                ClienteFuncionarioDAL ObjClienteFuncionarioDAL = new ClienteFuncionarioDAL();
                ObjClienteFuncionarioDAL.InsertUpdate(ObjCLienteFuncionario, out idFuncionario, out idCliente);

                Response.Write("<script>top.window.location='DefaultAbas.aspx?id=" + idFuncionario + "&idCliente=" + idCliente + "'</script>");
            }
            catch (Exception ex)
            {
                Response.Write(ex);
                Response.End();
            }
        }
    }

    protected void DdlOrgaoExpeditor_DataBound(object sender, EventArgs e)
    {
        DdlOrgaoExpeditor.Items.Insert(0, new ListItem("<--Selecione-->", "")); //Texto Inicial do combo
    }

}
