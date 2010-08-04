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

public partial class AtestadoSaude_AtestadoSaudeVisualizar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CarredaAtestadoSaude();
        }
    }

    public void CarredaAtestadoSaude()
    {
        AtestadoSaude ObjAtestadoSaude = new AtestadoSaude();
        AtestadoSaudeDAL ObjAtestadoSaudeDAL = new AtestadoSaudeDAL();

        ObjAtestadoSaude = ObjAtestadoSaudeDAL.VisualizaAtestadoSaude(Convert.ToInt32(Request.QueryString["idAtestadoSaude"]));
        lblNome.Text = ObjAtestadoSaude.RefClienteFuncionario.Nome;
        lblRG.Text = ObjAtestadoSaude.RefClienteFuncionario.RG;
        lblCBO.Text = ObjAtestadoSaude.RefClienteFuncionario.RefClienteFuncionarioProfissional.RefCBO.COD_CBO;
        lblFuncao.Text = ObjAtestadoSaude.RefClienteFuncionario.RefClienteFuncionarioProfissional.RefCBO.FUNCAO;
        lblCliente.Text = ObjAtestadoSaude.RefClienteFuncionario.RefCliente.RazaoSocial;
        lblRisco.Text = ObjAtestadoSaude.RefClienteFuncionario.RefCliente.RefCNAE.Risco;
        lblMedicoResp.Text = ObjAtestadoSaude.RefClienteFuncionario.RefCliente.RefProfissional.Nome;
        lblConselhoNumero.Text = ObjAtestadoSaude.RefClienteFuncionario.RefCliente.RefProfissional.ConselhoNumero;
        lblConselhoUF.Text = ObjAtestadoSaude.RefClienteFuncionario.RefCliente.RefProfissional.ConselhoUF;
        lblTipoAtestado.Text = ObjAtestadoSaude.RefTipoAtestado.Nome;
        lblObservacoes.Text = ObjAtestadoSaude.Observacoes;
        lblStatusAtestado.Text = ObjAtestadoSaude.RefStatusAtestado.Nome;
        lblPendencia.Text = ObjAtestadoSaude.Pendencia;
        lblDataConsulta.Text = ObjAtestadoSaude.DataConsulta;   
    }

}

