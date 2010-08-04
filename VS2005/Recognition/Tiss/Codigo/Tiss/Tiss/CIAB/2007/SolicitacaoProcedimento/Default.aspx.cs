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
using TissObjetos;

public partial class CIAB_2007_SolicitacaoProcedimento_Default : System.Web.UI.Page
{
    int Total = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Total ++;
        }
        else 
       if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[1].Text = "<b>Total</b>: " + Total;
        }
    }
}
