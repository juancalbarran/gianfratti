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
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Sql;
using System.Data.Common;

public partial class Cliente_ClienteAtualizar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Editar(Convert.ToInt32(Request.QueryString["idCliente"]));
        }
    }
    //Carrega registro para edição
    public void Editar(int id)
    {
        try
        {
            if (id != 0)
            {
                Cliente ObjCliente = new Cliente();
                ClienteBO ObjClienteBO = new ClienteBO();
                Validacoes Validacoes = new Validacoes();

                ObjCliente = ObjClienteBO.SelectByID(Convert.ToInt32(Request.QueryString["idCliente"])) as Cliente;

                DdlTipoIdentificacao.ValorInformado = Convert.ToString(ObjCliente.idTipoIdentificacao);
                DdlProfissional.ValorInformado = Validacoes.TextoNull(ObjCliente.idProfissional);
                DdlProfissional1.ValorInformado = Validacoes.TextoNull(ObjCliente.idProfissional1);
                DdlProfissional2.ValorInformado = Validacoes.TextoNull(ObjCliente.idProfissional2);
                DdlProfissional3.ValorInformado = Validacoes.TextoNull(ObjCliente.idProfissional3);
                TxtCNPJ_INCRA_CPF.Text = Validacoes.InsereMascaraCNPJ(ObjCliente.CNPJ_INCRA_CPF);
                TxtInscEstatual.Text = ObjCliente.InscEstadual;
                TxtRazaoSocial.Text = ObjCliente.RazaoSocial;
                TxtEndereco.Text = ObjCliente.Endereco;
                TxtBairro.Text = ObjCliente.Bairro;
                TxtCep.Text = ObjCliente.CEP;
                TxtCidade.Text = ObjCliente.Cidade;
                ddlEstados.ValorInformado = ObjCliente.UF;
                TxtCNAE.Text = ObjCliente.CNAE;
                TxtDenominacao.Text = ObjCliente.Denominacao;
                TxtRisco.Text = ObjCliente.Risco;
                TxtGFIP.Text = ObjCliente.GFIP;
                TxtDDDtel.Text = ObjCliente.DDDtel;
                TxtTelefone.Text = ObjCliente.Telefone;
                TxtDDDfax.Text = ObjCliente.DDDfax;
                TxtFax.Text = ObjCliente.Fax;
                TxtContato.Text = ObjCliente.Contato;
                TxtEmail.Text = ObjCliente.Email;
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex);
            Response.End();
        }
    }
    //Salva o registro
    protected void BtnSalvar_Click(object sender, EventArgs e)
    {
        try
        {
            if (!Validacoes.ValidaCNPJ(TxtCNPJ_INCRA_CPF.Text))
            {
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('CNPJ invalido')", true);
            }
            else
            {
                Validacoes ObjValidacoes = new Validacoes();
                Cliente ObjCliente = new Cliente();

                ObjCliente.id = Convert.ToInt32(Request.QueryString["idCliente"]);
                ObjCliente.idTipoIdentificacao = Convert.ToInt32(DdlTipoIdentificacao.ValorInformado);
                ObjCliente.idProfissional = ObjValidacoes.TextoNull(DdlProfissional.ValorInformado);
                ObjCliente.idProfissional1 = ObjValidacoes.TextoNull(DdlProfissional1.ValorInformado);
                ObjCliente.idProfissional2 = ObjValidacoes.TextoNull(DdlProfissional2.ValorInformado);
                ObjCliente.idProfissional3 = ObjValidacoes.TextoNull(DdlProfissional3.ValorInformado);
                ObjCliente.CNPJ_INCRA_CPF = TxtCNPJ_INCRA_CPF.Text;
                ObjCliente.InscEstadual = TxtInscEstatual.Text;
                ObjCliente.RazaoSocial = TxtRazaoSocial.Text;
                ObjCliente.Endereco = TxtEndereco.Text;
                ObjCliente.Bairro = TxtBairro.Text;
                ObjCliente.CEP = TxtCep.Text;
                ObjCliente.Cidade = TxtCidade.Text;
                ObjCliente.UF = ddlEstados.ValorInformado;
                ObjCliente.CNAE = TxtCNAE.Text;
                ObjCliente.GFIP = TxtGFIP.Text;
                ObjCliente.DDDtel = TxtDDDtel.Text;
                ObjCliente.Telefone = TxtTelefone.Text;
                ObjCliente.DDDfax = TxtDDDfax.Text;
                ObjCliente.Fax = TxtFax.Text;
                ObjCliente.Contato = TxtContato.Text;
                ObjCliente.Email = TxtEmail.Text;

                string idCliente = null;
                ClienteBO ObjClienteBO = new ClienteBO();
                ObjClienteBO.InsertUpdate(ObjCliente,out idCliente);

                Response.Write("<script>top.window.location='DefaultAbas.aspx?idCliente=" + idCliente + "'</script>");

            }
        }
        catch (Exception ex)
        {
            Response.Write(ex);
            Response.End();
        }
    }
}