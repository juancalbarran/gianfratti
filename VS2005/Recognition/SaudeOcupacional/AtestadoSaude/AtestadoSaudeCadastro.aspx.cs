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

public partial class AtestadoSaude_AtestadoSaudeCadastro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CarredaDadosFuncionario();
        }
    }

    public void CarredaDadosFuncionario()
    {
        ClienteFuncionario ObjClienteFuncionario = new ClienteFuncionario();
        AtestatoSaudeBO ObjAtestatoSaudeBO = new AtestatoSaudeBO();
        
        ObjClienteFuncionario = ObjAtestatoSaudeBO.CarregaDadosFuncionario(Convert.ToInt32(Request.QueryString["idFuncionario"]));
        lblNome.Text = ObjClienteFuncionario.Nome;
        lblRG.Text = ObjClienteFuncionario.RG;
        lblCBO.Text = ObjClienteFuncionario.RefClienteFuncionarioProfissional.CBO;
        lblFuncao.Text = ObjClienteFuncionario.RefClienteFuncionarioProfissional.RefCBO.FUNCAO;
        lblCliente.Text = ObjClienteFuncionario.RefCliente.RazaoSocial;
        lblRisco.Text = ObjClienteFuncionario.RefCliente.Risco;
        lblMedicoResp.Text = ObjClienteFuncionario.RefCliente.RefProfissional.Nome;
        hddIdProfissional.Value = Convert.ToString(ObjClienteFuncionario.RefClienteFuncionarioProfissional.id);
        lblConselhoNumero.Text = ObjClienteFuncionario.RefCliente.RefProfissional.ConselhoNumero;
        lblConselhoUF.Text = ObjClienteFuncionario.RefCliente.RefProfissional.ConselhoUF;
    }

    protected void btnSalvar_Click(object sender, EventArgs e)
    {
        try
        {
            AtestadoSaude ObjAtestadoSaude = new AtestadoSaude();
            Validacoes Valida = new Validacoes();
            ObjAtestadoSaude.idProfissional_MedicoCoordenador = hddIdProfissional.Value;
            ObjAtestadoSaude.idTipoAtestado = rdoTipoAtestado.Text;
            ObjAtestadoSaude.idClienteFuncionario = Request.QueryString["idFuncionario"];
            ObjAtestadoSaude.idStatusAtestado = rdoStatusAtestado.Text;
            ObjAtestadoSaude.DataConsulta = Valida.TextoNull(txtDataConsulta.Text);
            ObjAtestadoSaude.Observacoes = Valida.TextoNull(txtObservacoes.Text);
            ObjAtestadoSaude.Pendencia = Valida.TextoNull(txtPendencia.Text);
            ObjAtestadoSaude.CRM = Valida.TextoNull(txtCRM.Text);
            AtestatoSaudeBO ObjAtestatoSaudeBO = new AtestatoSaudeBO();
            ObjAtestatoSaudeBO.InsertAtestado(ObjAtestadoSaude);
        }
        catch (Exception ex)
        {
            Response.Write(ex);
            Response.End();
        }
    }
 
}
