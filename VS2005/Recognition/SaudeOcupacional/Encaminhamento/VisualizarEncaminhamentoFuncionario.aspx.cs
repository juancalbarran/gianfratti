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

public partial class Encaminhamento_VisualizarEncaminhamentoFuncionario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Visualizar(Convert.ToInt32(Request.QueryString["id"]));

        if (Convert.ToInt32(Request.QueryString["idClienteFuncionario"]) != 0)
        {
            FuncionarioDadosBasicos1.IdFuncionario = Convert.ToInt32(Request.QueryString["idClienteFuncionario"]);
            
        }
        
        Datagrid(Convert.ToInt32(Request.QueryString["id"]));
    }

    public void Visualizar(int idEncaminhamento)
    {
        Encaminhamento ObjEncaminhamento = new Encaminhamento();
        EncaminhamentoDAL ObjEncaminhamentoDAL = new EncaminhamentoDAL();
        ObjEncaminhamento = ObjEncaminhamentoDAL.SelectVisualizaEncaminhamentoFuncionario(idEncaminhamento);
        lblTipoAtestadoClinico.Text = ObjEncaminhamento.RefTipoAtestado.Nome;
        lblMedicoExaminador.Text = ObjEncaminhamento.RefProfissional.Nome;
        lblDataRealizacao.Text = Convert.ToString(ObjEncaminhamento.DtRealizacao).Replace("00:00:00","");
    }

    public void Datagrid(int id)
    {
        try
        {
            EncaminhamentoXExamesComplementaresDAL Obj = new EncaminhamentoXExamesComplementaresDAL();
            GridView1.DataSource = Obj.SelectEncaminhamentoXExamesComplementares(id);
            GridView1.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }
}
