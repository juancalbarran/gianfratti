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

public partial class Encaminhamento_EncaminhamentoPrincipal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //Verifica se foi passado o id do encaminhamento
            if (Request.QueryString["idEncaminhamento"] != null)
            {
                int id = Convert.ToInt32(Request.QueryString["idEncaminhamento"]);
                //Verifica se a visualização é de um funcionario efetivo
                if (Request.QueryString["idClienteFuncionario"] != string.Empty)
                {
                    //Caso seja uma funcionário efetivo então abre a popup com os seus dados
                    int idClienteFuncionario = Convert.ToInt32(Request.QueryString["idClienteFuncionario"]);
                    Page.ClientScript.RegisterStartupScript(GetType(), "OnLoad", "window.open('VisualizarEncaminhamentoFuncionario.aspx?id=" + id + "&idClienteFuncionario=" + idClienteFuncionario + "',null,'left=50, top=5, height=880, width=1100, status=n o, resizable= no, scrollbars=yes, toolbar= no,location= no, menubar= no');", true);
                }
                //Verifica se a visualização é de um candidato em processo seletivo
                if (Request.QueryString["idProcessoSeletivo"] != string.Empty)
                {
                    //Caso seja uma candidato em processo seletivo então abre a popup com os seus dados
                    int idProcessoSeletivo = Convert.ToInt32(Request.QueryString["idProcessoSeletivo"]);
                    Page.ClientScript.RegisterStartupScript(GetType(), "OnLoad", "window.open('VisualizarEncaminhamentoCandidato.aspx?id=" + id + "&idProcessoSeletivo=" + idProcessoSeletivo + "',null,'left=50, top=5, height=880, width=1100, status=n o, resizable= no, scrollbars=yes, toolbar= no,location= no, menubar= no');", true);
                }
            }
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GridView();
        }
    }

    private void GridView()
    {
        try
        {
            EncaminhamentoBO ObjEncaminhamentoBO = new EncaminhamentoBO();
            GridView1.DataSource = ObjEncaminhamentoBO.SelectAll(ddlCliente.ValorInformado, txtNome.Text, txtCPF.Text, ddlTipoAtestado.ValorInformado, ddlTipoEncaminhamento.SelectedValue, TxtDtRealizacao.Text);
            GridView1.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex);
            Response.End();
        }

    }

    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        GridView();
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //e.Row.Cells[1].Style.Add("visibility", "hidden");

            Image Img = (Image)e.Row.FindControl("Image1");
            if (e.Row.Cells[4].Text == "Candidato Processo Seletivo")
            {
                Img.ImageUrl = "~/Template/Img/Flg_amerelo_Escuro.gif";
                Img.AlternateText = "Funcionário Efetivo";
            }
            else if (e.Row.Cells[4].Text == "Funcion&#225;rio Efetivo")
            {
                Img.ImageUrl = "~/Template/Img/Flg_verde.gif";
                Img.AlternateText = "Candito em processo seletivo";
            }
        }
    }
    
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Visualizar")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            Page.ClientScript.RegisterStartupScript(GetType(), "OnLoad", "window.open('VisualizarEncaminhamentoFuncionario.aspx?id=" + id + "',null,'left=50, top=5, height=880, width=1100, status=n o, resizable= no, scrollbars=yes, toolbar= no,location= no, menubar= no');", true);
        }
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        GridView();
    }
}


