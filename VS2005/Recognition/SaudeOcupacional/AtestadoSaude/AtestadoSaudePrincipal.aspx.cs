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

public partial class AtestadoSaude_AtestadoSaudePrincipal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private void DataGrid()
    {
        Validacoes Valida = new Validacoes();
        ProntuarioClinicoDAL ObjProntuarioClinicoDAL = new ProntuarioClinicoDAL();
        AtestadoSaudeDAL ObjAtestadoSaudeDAL = new AtestadoSaudeDAL();
        GridView1.DataSource = ObjAtestadoSaudeDAL.SelectAll(Valida.TextoNull(DdlCliente.ValorInformado), Valida.TextoNull(TxtNome.Text), Valida.TextoNull(TxtCPF.Text), Valida.TextoNull(TxtRG.Text));
        GridView1.DataBind();
    }


    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        DataGrid();
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        DataGrid();
    }
}
