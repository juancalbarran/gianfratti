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

public partial class PCMSO_PCMSOPrincipal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GridView();
        }
    }

    private void GridView()
    {
        PCMSODAL ObjPCMSODAL = new PCMSODAL();
        GridView1.DataSource = ObjPCMSODAL.SelectAll(txtCliente.Text);
        GridView1.DataBind();
    }
    protected void BtnBuscar_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }


    private void Deletar(int id)
    {
        PCMSODAL ObjPCMSODAL = new PCMSODAL();
        ObjPCMSODAL.Delete(id);
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Deletar")
        {
            Deletar(Convert.ToInt32(e.CommandArgument));
        }

        GridView();
    }
}
