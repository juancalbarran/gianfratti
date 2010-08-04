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

public partial class Encaminhamento_VisualizarEncaminhamentoCandidato : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToInt32(Request.QueryString["id"]) != 0)
        {
            Visualizar(Convert.ToInt32(Request.QueryString["id"]));
            Datagrid(Convert.ToInt32(Request.QueryString["id"]));

        }
    }

    public void Visualizar(int idEncaminhamento)
    {
        Encaminhamento ObjEncaminhamento = new Encaminhamento();
        EncaminhamentoDAL ObjEncaminhamentoDAL = new EncaminhamentoDAL();
        ObjEncaminhamento = ObjEncaminhamentoDAL.SelectVisualizaEncaminhamentoProcessoSeletivo(idEncaminhamento);
        lblRazaoSocial.Text = ObjEncaminhamento.RefCliente.RazaoSocial;
        lblNomeCandidato.Text = ObjEncaminhamento.RefProcessoSeletivo.Nome;
        lblTipoAtestadoClinico.Text = ObjEncaminhamento.RefTipoAtestado.Nome;
        lblMedicoExaminador.Text = ObjEncaminhamento.RefProfissional.Nome;
        lblDataRealizacao.Text = Convert.ToString(ObjEncaminhamento.DtRealizacao).Replace("00:00:00", "");
    }

    public void Datagrid(int idEncaminhamento)
    {
        try
        {            
            EncaminhamentoXExamesComplementaresDAL Obj = new EncaminhamentoXExamesComplementaresDAL();
            GridView1.DataSource = Obj.SelectEncaminhamentoXExamesComplementares(idEncaminhamento);
            GridView1.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }
}
