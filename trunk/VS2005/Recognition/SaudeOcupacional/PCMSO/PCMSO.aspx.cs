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

public partial class PCMSO_PCMSO : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            PCMSODAL ObjPCMSODAL = new PCMSODAL();
            GridView1.DataSource = ObjPCMSODAL.PCMSO_Completo(Convert.ToInt32(Request.QueryString["idCliente"]), Convert.ToInt32(Request.QueryString["id"]));
            GridView1.DataBind();
            ClienteDadosBasicos1.IdCliente = Convert.ToInt32(Request.QueryString["idCliente"]);
        }
    }
   

    string Setor = "";
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (Setor == e.Row.Cells[0].Text)
            {
                e.Row.Cells[0].BorderStyle = BorderStyle.None;
                e.Row.Cells[0].Text = string.Empty;
            }
            else
            {
                e.Row.Cells[0].BorderStyle = BorderStyle.Solid;
                Setor = e.Row.Cells[0].Text;
            }

            e.Row.Cells[2].Text = e.Row.Cells[2].Text.Replace("-", "<br>");
            e.Row.Cells[3].Text = e.Row.Cells[3].Text.Replace("-", "<br>");
            e.Row.Cells[4].Text = e.Row.Cells[4].Text.Replace("-", "<br>").Replace("*", "&bull;");
            e.Row.Cells[5].Text = e.Row.Cells[5].Text.Replace("-", "<br>");
            e.Row.Cells[6].Text = e.Row.Cells[6].Text.Replace("-", "<br>");
        }
    }
}
