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

public partial class Tabelas_ExamesComplementares_ExamesComplementaresCadastro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Convert.ToInt32(Request.QueryString["id"]) != 0)
            {
                Editar(Convert.ToInt32(Request.QueryString["id"]));
            }
        }
    }

    private void Editar(int id)
    {
        ExamesComplementares ObjExamesComplementares = new ExamesComplementares();
        ExamesComplementaresDAL ObjExamesComplementaresDAL = new ExamesComplementaresDAL();
        ObjExamesComplementares = ObjExamesComplementaresDAL.SelectByID(id);
        txtTipoExame.Text = ObjExamesComplementares.Descricao;
    }

    protected void btnSalvar_Click(object sender, EventArgs e)
    {
        try
        {
        if (txtTipoExame.Text != "")
        {

            ExamesComplementares Obj = new ExamesComplementares();
            Obj.id = Convert.ToInt32(Request.QueryString["id"]);
            Obj.Descricao = txtTipoExame.Text;
            ExamesComplementaresDAL ObjDAL = new ExamesComplementaresDAL();
            ObjDAL.InsertUpdate(Obj);
            Response.Redirect("default.aspx");
        }
        else
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Campo Obrigatório')", true);
        }
        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }
}