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
using JomaBE;
using JomaDAL;

public partial class Forms_Profissionais : System.Web.UI.Page
{

    public Int32 TotalRegistros = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            MontaComboProfissionaisPerfil();
            MontaGridView();
        }
    }

    //Monta o GridView
    public void MontaGridView()
    {
        try
        {
            ProfissionaisDAL profissionaisDAL = new ProfissionaisDAL();
            GridView1.DataSource = profissionaisDAL.Listar(txtNome.Text, txtRG.Text, txtCPF.Text,ddlProfissionalPerfil.SelectedValue);
            GridView1.DataBind();
        }
        catch (Exception ex)
        {
            Label lblErro = (Label)Master.FindControl("lblErro");
            lblErro.Text = ex.ToString();
        }
    }

    protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
    {
        //Total de registos do footer do GridView
        TotalRegistros = Convert.ToInt32(GridView1.Rows.Count.ToString());

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //Confirmação de Exclusão
            ImageButton ImageButton = (ImageButton)e.Row.FindControl("ImgBtnApagar");
            ImageButton.Attributes.Add("onclick", "javascript:return confirm('O seguinte registro será apagado:\\n\\n" + DataBinder.Eval(e.Row.DataItem, "Nome") + "\\n\\nTem Certeza?');");

            //Insere atributo JavaScript ao passar o mouse sobre o Grid
            e.Row.Attributes["onmouseover"] = "javascript:setMouseOverColor(this);";
            e.Row.Attributes["onmouseout"] = "javascript:setMouseOutColor(this);";
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Editar")
        {
            Response.Redirect("ProfissionaisCadastrar.aspx?id=" + e.CommandArgument);
        }

        if (e.CommandName == "Apagar")
        {
            ProfissionaisDAL profissionaisDAL = new ProfissionaisDAL();
            profissionaisDAL.Excluir(Convert.ToInt32(e.CommandArgument));
            MontaGridView();
        }
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        MontaGridView();
    }


    protected void btmBuscar_Click(object sender, EventArgs e)
    {
        MontaGridView();
    }
    protected void btnLimpar_Click(object sender, EventArgs e)
    {
        ddlProfissionalPerfil.SelectedValue = string.Empty;
        txtNome.Text = string.Empty;
        txtRG.Text = string.Empty;
        txtCPF.Text = string.Empty;
        MontaGridView();
    }

    /// <summary>
    /// Monta combo com os perfis dos profissionais
    /// </summary>
    public void MontaComboProfissionaisPerfil()
    {
        try
        {
            ProfissionalPerfilDAL profissionalPerfilDAL = new ProfissionalPerfilDAL();
            ddlProfissionalPerfil.DataSource = profissionalPerfilDAL.Listar();
            ddlProfissionalPerfil.DataTextField = "Nome";
            ddlProfissionalPerfil.DataValueField = "ID";
            ddlProfissionalPerfil.DataBind();
            ddlProfissionalPerfil.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
        }
        catch (Exception ex)
        {
            Label lblErro = (Label)Master.FindControl("lblErro");
            lblErro.Text = ex.ToString();
        }
    }
}
