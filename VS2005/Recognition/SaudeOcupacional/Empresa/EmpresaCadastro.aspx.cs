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

public partial class Empresa_EmpresaCadastro : System.Web.UI.Page
{
    //protected HtmlInputText hddidEmpresa;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {       
            CarregaDadosEmpresa();
        }
        
    }
    //Carrega os dados da empresa
    private void CarregaDadosEmpresa()
    {
        Empresa ObjEmpresa = new Empresa();
        EmpresaDAL ObjEmpresaDAL = new EmpresaDAL();
        
        ObjEmpresa = ObjEmpresaDAL.SelectEmpresaByID(Convert.ToInt32(Request.QueryString["idEmpresa"]));//Esta passando o ID da empresa na mao 

        txtCNPJ.Text = ObjEmpresa.CNPJ;
        txtInscEstadual.Text = ObjEmpresa.InscEstadual;
        txtRazaoSocial.Text = ObjEmpresa.RazaoSocial;
        txtEndereco.Text = ObjEmpresa.Endereco;
        txtBairro.Text = ObjEmpresa.Bairro;
        txtCEP.Text = ObjEmpresa.CEP;
        txtCidade.Text = ObjEmpresa.Cidade;
        ddlEstados.ValorInformado = ObjEmpresa.UF;
        txtTel.Text = ObjEmpresa.Tel;
        txtDDDtel.Text = ObjEmpresa.DDDtel;
        txtDDDFax.Text = ObjEmpresa.DDDfax;
        txtFax.Text = ObjEmpresa.Fax;
        txtContato.Text = ObjEmpresa.Contato;
        txtEmail.Text = ObjEmpresa.Email;
    }


    //funcao que chamao DAL para salvar ou alterar
    //private void Salvar()
    //{
    //    try
    //    {
    //        Validacoes ObjValidacoes = new Validacoes();
    //        EmpresaUsuario ObjEmpresaUsuario = new EmpresaUsuario();
    //        ObjEmpresaUsuario.id = Convert.ToInt32(ObjValidacoes.TextoNull(hddidEmpresa.Value));
    //        ObjEmpresaUsuario.idEmpresa = Convert.ToInt32(Request.QueryString["idEmpresa"]);
    //        ObjEmpresaUsuario.Nome = txtNome.Text;
    //        ObjEmpresaUsuario.idEmpresaUsuarioPerfil = Convert.ToInt32(txtidEmpresaUsuarioPerfil.Text);
    //        ObjEmpresaUsuario.idEmpresaUsuarioStatus = Convert.ToInt32(txtidEmpresaUsuarioStatus.Text);
    //        ObjEmpresaUsuario.Usuario = txtUsuario.Text;
    //        ObjEmpresaUsuario.Senha = txtSenha.Text;

    //        EmpresaUsuarioDAL ObjEmpresaUsuarioDAL = new EmpresaUsuarioDAL();
    //        ObjEmpresaUsuarioDAL.InsertUpdate(ObjEmpresaUsuario);

    //        GridEmpresaUsuario.DataBind();
    //        Page.ClientScript.RegisterStartupScript(GetType(), "OnLoad", "AlternarAbas('td_CadastroUsuario','div_CadastroUsuario')", true);
    //    }
    //    catch (Exception erro)
    //    {
    //        Response.Write(erro);
    //        Response.End();
    //    }
    //}
    //evento do botao salvar
    //protected void btnSalvarEmpresaUsuario_Click(object sender, EventArgs e)
    //{
    //    //Faz as devidas validações antes de chamar a função que vai inserir ou alterar
    //    if (txtNome.Text == "" || txtUsuario.Text == "" || txtSenha.Text == "" || txtConfirmarSenha.Text == "")
    //    {
    //        Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('É obrigatorio o preenchimento de todos os campos')", true);
    //        Page.ClientScript.RegisterStartupScript(GetType(), "OnLoad", "AlternarAbas('td_CadastroUsuario','div_CadastroUsuario')", true);
    //    }
    //    else if (txtSenha.Text != txtConfirmarSenha.Text)
    //    {
    //        Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Senhas não conferem')", true);
    //        Page.ClientScript.RegisterStartupScript(GetType(), "OnLoad", "AlternarAbas('td_CadastroUsuario','div_CadastroUsuario')", true);
    //    }
    //    else
    //    {
    //        Salvar();
    //        ApagaCampos();
    //    }
    //}
    //evento do botao alterar
    //protected void btnAlterarEmpresaUsuario_Click(object sender, EventArgs e)
    //{
    //    //Faz as devidas validações antes de chamar a função que vai inserir ou alterar
    //    if (txtNome.Text == "")
    //    {
    //        Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('É obrigatorio o preenchimento de todos os campos')", true);
    //        Page.ClientScript.RegisterStartupScript(GetType(), "OnLoad", "AlternarAbas('td_CadastroUsuario','div_CadastroUsuario')", true);
    //    }
    //    else
    //    {
    //        Salvar();
    //        btnAlterarEmpresaUsuario.Visible = false;
    //        btnSalvarEmpresaUsuario.Visible = true;
    //        txtUsuario.Enabled = true;
    //        txtSenha.Enabled = true;
    //        txtConfirmarSenha.Enabled = true;
    //        ApagaCampos();
    //    }
    //}
    //Quando selecionado um registro no datagrid para edicao
    //protected void GridEmpresaUsuario_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    txtUsuario.Enabled = false;
    //    txtSenha.Enabled = false;
    //    txtConfirmarSenha.Enabled = false;
    //    btnSalvarEmpresaUsuario.Visible = false;

    //    EmpresaUsuario ObjEmpresaUsuario = new EmpresaUsuario();
    //    EmpresaUsuarioDAL objEmpresaUsuarioDAL = new EmpresaUsuarioDAL();
    //    ObjEmpresaUsuario = objEmpresaUsuarioDAL.SelectEmpresaUsuarioByID(Convert.ToInt32(GridEmpresaUsuario.SelectedDataKey.Value));
    //    hddidEmpresa.Value = Convert.ToString(ObjEmpresaUsuario.id);
    //    txtNome.Text = ObjEmpresaUsuario.Nome;
    //    txtidEmpresaUsuarioPerfil.Text = Convert.ToString(ObjEmpresaUsuario.idEmpresaUsuarioPerfil);
    //    txtUsuario.Text = ObjEmpresaUsuario.Usuario;
    //    txtidEmpresaUsuarioStatus.Text = Convert.ToString(ObjEmpresaUsuario.idEmpresaUsuarioStatus);

    //    btnSalvarEmpresaUsuario.Visible = false;
    //    btnAlterarEmpresaUsuario.Visible = true;
    //    Page.ClientScript.RegisterStartupScript(GetType(), "OnLoad", "AlternarAbas('td_CadastroUsuario','div_CadastroUsuario')", true);
    //}

    //private void ApagaCampos()
    //{
    //    hddidEmpresa.Value = null;
    //    txtNome.Text = null;
    //    txtidEmpresaUsuarioPerfil.Text = null;
    //    txtUsuario.Text = null;
    //    txtSenha.Text = null;
    //    txtConfirmarSenha.Text = null;
    //}

    //protected void GridEmpresaUsuario_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (e.CommandName == "DeletarEmpresaUsuario") 
    //    {
    //        try
    //        {
    //            EmpresaUsuarioDAL ObjEmpresaUsuarioDAL = new EmpresaUsuarioDAL();
    //            ObjEmpresaUsuarioDAL.DeleteEmpresaUsuario(Convert.ToInt32(e.CommandArgument));
    //            Page.ClientScript.RegisterStartupScript(GetType(), "OnLoad", "AlternarAbas('td_CadastroUsuario','div_CadastroUsuario')", true);
    //            GridEmpresaUsuario.DataBind();
    //        }
    //        catch (Exception)
    //        {
    //            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Ocorreu um erro ao apagar este usuário')", true);
    //            Page.ClientScript.RegisterStartupScript(GetType(), "OnLoad", "AlternarAbas('td_CadastroUsuario','div_CadastroUsuario')", true);
    //        }
    //    }
    //}
    protected void BtnSalvar_Click(object sender, EventArgs e)
    {
        try
        {
            if (!Validacoes.ValidaCNPJ(txtCNPJ.Text))
            {
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('CNPJ invalido')", true);
            }
            else
            {
                Validacoes ObjValidacoes = new Validacoes();
                Empresa ObjEmpresa = new Empresa();

                ObjEmpresa.id = Convert.ToInt32(Request.QueryString["idEmpresa"]);
                ObjEmpresa.CNPJ = txtCNPJ.Text;
                ObjEmpresa.InscEstadual = txtInscEstadual.Text;
                ObjEmpresa.RazaoSocial = txtRazaoSocial.Text;
                ObjEmpresa.Endereco = txtEndereco.Text;
                ObjEmpresa.Bairro = txtBairro.Text;
                ObjEmpresa.CEP = txtCEP.Text;
                ObjEmpresa.Cidade = txtCidade.Text;
                ObjEmpresa.UF = ddlEstados.ValorInformado;
                ObjEmpresa.DDDtel = txtDDDtel.Text;
                ObjEmpresa.Tel = txtTel.Text;
                ObjEmpresa.DDDfax = txtDDDFax.Text;
                ObjEmpresa.Fax = txtFax.Text;
                ObjEmpresa.Contato = txtContato.Text;
                ObjEmpresa.Email = txtEmail.Text;

                EmpresaBO ObjEmpresaBO = new EmpresaBO();
                ObjEmpresaBO.InsertUpdate(ObjEmpresa);

                Response.Write("<script>window.location='EmpresaCadastro.aspx?idEmpresa=1'</script>");

            }
        }
        catch (Exception ex)
        {
            Response.Write(ex);
            Response.End();
        }
    }
}
