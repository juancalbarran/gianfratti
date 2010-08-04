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

public partial class AtestadoSaude_AtestadoSaudeHistorico : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        GridHistoricoAtestadoSaude.DataBind();
    }
    protected void GridHistoricoAtestadoSaude_SelectedIndexChanged(object sender, EventArgs e)
    {
        int id = Convert.ToInt32(GridHistoricoAtestadoSaude.SelectedDataKey.Value);
        Page.ClientScript.RegisterStartupScript(GetType(), "OnLoad", "window.open('AtestadoSaudeVisualizar.aspx?idAtestadoSaude=" + id + "',null,'left=50, top=5, height=880, width=1100, status=n o, resizable= no, scrollbars=yes, toolbar= no,location= no, menubar= no');", true);
    }
}
