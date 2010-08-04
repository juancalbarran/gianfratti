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

public partial class Cliente_ClienteDepartamento : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void BtnIncluirDepartamento_Click(object sender, EventArgs e)
    {
        if (TxtDepartamento.Text.Trim() == "")
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Entre com o nome do departamento')", true);
        }
        else
        {
            if (Convert.ToInt32(Request.QueryString["idCliente"]) != 0)
            {
                try
                {
                    Validacoes ObjValidacoes = new Validacoes();
                    ClienteDepartamento ObjClienteDepartamento = new ClienteDepartamento();
                    //Chave primaria da tabela
                    ObjClienteDepartamento.id = Convert.ToInt32(ObjValidacoes.TextoNull(TxtidDepartamento.Value));
                    //Dados
                    ObjClienteDepartamento.IdCliente = Convert.ToInt32(Request.QueryString["idCliente"]);
                    ObjClienteDepartamento.Nome = TxtDepartamento.Text;
                    ClienteDepartamentoBO ObjClienteDepartamentoDAL = new ClienteDepartamentoBO();
                    ObjClienteDepartamentoDAL.InsertUpdate(ObjClienteDepartamento);
                    DdlDepartamentos.DataBind();
                    GridDepartamentos.DataBind();
                    //Apaga os campos
                    TxtidDepartamento.Value = null;
                    TxtDepartamento.Text = null;
                }
                catch (Exception ex)
                {
                    Response.Write(ex);
                    Response.End();
                }
            }
            else
            {
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Salve o cadastro do cliente antes de inserir um departamento')", true);
            }
        }
    }
    protected void BtnIncluirSetor_Click(object sender, EventArgs e)
    {
        if (TxtSetor.Text.Trim() == "")
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Entre com o nome do setor')", true);
        }
        else
        {
            if (Convert.ToInt32(Request.QueryString["idCliente"]) != 0)
            {
                try
                {
                    Validacoes ObjValidacoes = new Validacoes();
                    ClienteSetor ObjClienteSetor = new ClienteSetor();
                    ObjClienteSetor.id = Convert.ToInt32(ObjValidacoes.TextoNull(txtidSetor.Value));
                    ObjClienteSetor.idClienteDepartamento = Convert.ToInt32(DdlDepartamentos.Text);
                    ObjClienteSetor.Nome = TxtSetor.Text;
                    ClienteSetorDAL ObjClienteSetorDAL = new ClienteSetorDAL();
                    ObjClienteSetorDAL.InsertUpdate(ObjClienteSetor);
                    GridSetores.DataBind();
                    TxtSetor.Text = null;
                    txtidSetor.Value = null;
                }
                catch (Exception ex)
                {
                    Response.Write(ex);
                    Response.End();
                }
            }
            else
            {
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Salve o cadastro do cliente antes de inserir um setor')", true);
            }
        }
    }
    protected void GridDepartamentos_SelectedIndexChanged(object sender, EventArgs e)
    {
        ClienteDepartamento ObjClienteDepartamento = new ClienteDepartamento();
        ClienteDepartamentoBO ObjClienteDepartamentoBO = new ClienteDepartamentoBO();
        ObjClienteDepartamento = ObjClienteDepartamentoBO.CarregaClienteDepartamento(Convert.ToInt32(GridDepartamentos.SelectedDataKey.Value)) as ClienteDepartamento;
        TxtidDepartamento.Value = Convert.ToString(ObjClienteDepartamento.id);
        TxtDepartamento.Text = ObjClienteDepartamento.Nome;
    }
    protected void GridDepartamentos_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DeletarDepartamento")
        {
            try
            {
                ClienteDepartamentoDAL ObjClienteDepartamentoDAL = new ClienteDepartamentoDAL();
                ObjClienteDepartamentoDAL.Delete(Convert.ToInt32(e.CommandArgument));
                GridDepartamentos.DataBind();
            }
            catch (Exception)
            {
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Você não pode apagar um departamento que contém funcionarios cadastrados')", true);
            }
        }
    }
    protected void GridSetores_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DeletarSetores")
        {
            try
            {
                ClienteSetorDAL ObjClienteSetorDAL = new ClienteSetorDAL();
                ObjClienteSetorDAL.Delete(Convert.ToInt32(e.CommandArgument));
                GridSetores.DataBind();
            }
            catch (Exception)
            {
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Você não pode apagar um setor que contém funcionarios cadastrados')", true);
            }
        }
    }
    protected void GridSetores_SelectedIndexChanged(object sender, EventArgs e)
    {
        ClienteSetor ObjClienteSetor = new ClienteSetor();
        ClienteSetorBO ObjClienteSetorBO = new ClienteSetorBO();
        ObjClienteSetor = ObjClienteSetorBO.CarregaClienteSetor(Convert.ToInt32(GridSetores.SelectedDataKey.Value)) as ClienteSetor;
        txtidSetor.Value = Convert.ToString(ObjClienteSetor.id);
        TxtSetor.Text = ObjClienteSetor.Nome;
    }
    protected void GridDepartamentos_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //Confirmação de Exclusão
            ImageButton ImageButton = (ImageButton)e.Row.FindControl("ImgDeleteDepartamento");
            ImageButton.Attributes.Add("onclick", "javascript:return confirm('Confirma a exclusão do departamento " + DataBinder.Eval(e.Row.DataItem, "Nome") + "?')");
        }
    }
    protected void GridSetores_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //Confirmação de Exclusão
            ImageButton ImageButton = (ImageButton)e.Row.FindControl("ImgDeleteSetor");
            ImageButton.Attributes.Add("onclick", "javascript:return confirm('Confirma a exclusão do setor " + DataBinder.Eval(e.Row.DataItem, "Nome") + "?')");
        }
    }
}
