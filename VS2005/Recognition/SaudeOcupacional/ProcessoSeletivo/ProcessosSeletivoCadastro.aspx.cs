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

public partial class ProcessoSeletivo_ProcessosSeletivoCadastro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Declaraco do evento que foi criado dentro do UserControl
        ddlCliente.SelectedIndexChanged += new EventHandler(ddlCliente_SelectedIndexChanged);

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Convert.ToInt32(Request.QueryString["id"]) == 0){TblStatus.Visible = false;}
            Editar(Convert.ToInt32(Request.QueryString["id"]));
        }
    }

    private void Departamento()
    {
        if (ddlCliente.ValorInformado != "")
        {
            ClienteDepartamentoDAL ObjClienteDepartamentoDAL = new ClienteDepartamentoDAL();
            ddlDepartamento.DataSource = ObjClienteDepartamentoDAL.DropDownList(Convert.ToInt32(ddlCliente.ValorInformado));
            ddlDepartamento.DataTextField = "Nome";
            ddlDepartamento.DataValueField = "ID";
            ddlDepartamento.DataBind();
            Setor(Convert.ToInt32(ddlDepartamento.SelectedValue));
        }
    }

    private void Setor(int idDepartamento)
    {
        ClienteSetorDAL ObjClienteSetorDAL = new ClienteSetorDAL();
        ddlSetor.DataSource = ObjClienteSetorDAL.DropDownList(idDepartamento);
        ddlSetor.DataTextField = "Nome";
        ddlSetor.DataValueField = "ID";
        ddlSetor.DataBind();
    }

    private void ddlCliente_SelectedIndexChanged(object sender, EventArgs e)
    {
        Departamento();
    }

    protected void ddlDepartamento_SelectedIndexChanged(object sender, EventArgs e)
    {
        Setor(Convert.ToInt32(ddlDepartamento.SelectedValue));
    }

    protected void btnSalvar_Click(object sender, EventArgs e)
    {
        if (ValidaCampos() == true)
        {
            Validacoes Objvalida = new Validacoes();
            ProcessoSeletivo ObjProcessoSeletivo = new ProcessoSeletivo();
            ObjProcessoSeletivo.idCliente = Convert.ToInt32(ddlCliente.ValorInformado);
            ObjProcessoSeletivo.id = Convert.ToInt32(Request.QueryString["id"]);
            ObjProcessoSeletivo.Nome = txtNome.Text;
            ObjProcessoSeletivo.CPF = txtCPF.Text;
            ObjProcessoSeletivo.DtNascimento = txtDtNascimento.Text;
            ObjProcessoSeletivo.Sexo = ddlSexo.SelectedValue;
            ObjProcessoSeletivo.IdDepartamento = Convert.ToInt32(ddlDepartamento.SelectedValue);
            ObjProcessoSeletivo.IdSetor = Convert.ToInt32(ddlSetor.SelectedValue);
            ObjProcessoSeletivo.Funcao = txtFuncao.Text;
            if (ObjProcessoSeletivo.id == 0) { ObjProcessoSeletivo.IdProcessoSeletivoStatus = 1; } else { ObjProcessoSeletivo.IdProcessoSeletivoStatus = Convert.ToInt32(ddlProcessoSeletivoStatus.ValorInformado); }

            ProcessoSeletivoBO ObjProcessoSeletivoBO = new ProcessoSeletivoBO();
            ObjProcessoSeletivoBO.InsertUpdate(ObjProcessoSeletivo);

            Response.Redirect("ProcessosSeletivoPrincipal.aspx");
        }
        
    }

    private void Editar(int id)
    {
        if (id != 0)
        {
            ProcessoSeletivo ObjProcessoSeletivo = new ProcessoSeletivo();
            ProcessoSeletivoBO ObjProcessoSeletivoBO = new ProcessoSeletivoBO();
            ObjProcessoSeletivo = ObjProcessoSeletivoBO.SelectByID(id);
            ddlCliente.ValorInformado = ObjProcessoSeletivo.idCliente.ToString();
            txtNome.Text = ObjProcessoSeletivo.Nome;
            txtCPF.Text = ObjProcessoSeletivo.CPF;
            txtDtNascimento.Text = ObjProcessoSeletivo.DtNascimento;
            ddlSexo.SelectedValue = ObjProcessoSeletivo.Sexo;
            ddlDepartamento.SelectedValue = ObjProcessoSeletivo.IdDepartamento.ToString();
            ddlSetor.SelectedValue = ObjProcessoSeletivo.IdSetor.ToString();
            txtFuncao.Text = ObjProcessoSeletivo.Funcao;
            ddlProcessoSeletivoStatus.ValorInformado = ObjProcessoSeletivo.IdProcessoSeletivoStatus.ToString();
            Departamento();
        }
    }

    private bool ValidaCampos()
    {
        if (ddlCliente.ValorInformado == "")
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Selecione a razão social')", true);
            return false;
        }
        else if (txtNome.Text == "")
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Digite o nome do candidato')", true);
            return false;
        }
        else if (txtDtNascimento.Text == "")
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Digite a data de nascimento')", true);
            return false;
        }
        else if (ddlSexo.SelectedValue == "")
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Selecione o sexo')", true);
            return false;
        }
        else if (ddlDepartamento.SelectedValue == "")
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Selecione um departamento')", true);
            return false;
        }
        else if (ddlSetor.SelectedValue == "")
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Selecione um setor')", true);
            return false;
        }
        else if (ddlProcessoSeletivoStatus.ValorInformado == "" && Convert.ToInt32(Request.QueryString["id"]) != 0)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Selecione um status')", true);
            return false;
        }
        return true;
    }
}
