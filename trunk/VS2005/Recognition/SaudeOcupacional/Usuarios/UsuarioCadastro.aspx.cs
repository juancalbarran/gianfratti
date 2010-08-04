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
using System.Collections.Generic;

public partial class Usuarios_UsuarioCadastro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ddlUsuarioPerfil.SelectedIndexChanged += new EventHandler(ddlUsuarioPerfil_SelectedIndexChanged);

        if (!Page.IsPostBack)
        {
            MontaChkBoxList();
            if (Convert.ToInt32(Request.QueryString["id"]) != 0) Editar(Convert.ToInt32(Request.QueryString["id"]));
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (ddlUsuarioPerfil.ValorInformado == "1")
            {
                ChkBoxList.ClearSelection();
                ChkBoxList.Enabled = false;
            }

            if (ddlUsuarioPerfil.ValorInformado == "3")
            {
                lblMédico.Visible = true;
                ddlProfissional.Visible = true;
            }
            else
            {
                lblMédico.Visible = false;
                ddlProfissional.Visible = false;
            }
        }
    }
    private void MontaChkBoxList()
    {
        ClienteDAL ObjClienteDAL = new ClienteDAL();
        ChkBoxList.DataSource = ObjClienteDAL.DropDownList(0, Convert.ToInt32(Session["idPerfil"]));
        ChkBoxList.DataTextField = "RazaoSocial";
        ChkBoxList.DataValueField = "ID";
        ChkBoxList.DataBind();
    }

    protected void btnSalvar_Click(object sender, EventArgs e)
    {
        try
        {
            Funcoes ObjFuncoes = new Funcoes();
            Validacoes ObjValida = new Validacoes();
            if (ValidaCampos() == true)
            {
                Usuario ObjUsuario = new Usuario();
                ObjUsuario.id = Convert.ToInt32(Request.QueryString["id"]);
                ObjUsuario.idEmpresa = Request.QueryString["idEmpresa"];
                ObjUsuario.idStatus = Convert.ToInt32(ddlUsuarioStatus.ValorInformado);
                ObjUsuario.idPerfil = Convert.ToInt32(ddlUsuarioPerfil.ValorInformado);
                ObjUsuario.idProfissional = ddlProfissional.ValorInformado;
                ObjUsuario.Nome = txtNome.Text;
                ObjUsuario.Email = txtEmail.Text;
                ObjUsuario.Usuarios = txtUsuario.Text;
                if (txtUsuario.Enabled == true) ObjUsuario.Senha = ObjFuncoes.GeraSenha();
                //Percore o ListBox de clientes colocando os ID's dos clientes selecionados em um List
                for (int i = 0; i <= ChkBoxList.Items.Count - 1; i++)
                {//Verifica se o cliente foi selecionado
                    if (ChkBoxList.Items[i].Selected)
                    {//caso selecionado entao add na lista
                        ObjUsuario.UsuarioXCliente.Add(new UsuarioXCliente(Convert.ToInt32(ObjValida.TextoNull(Request.QueryString["id"])), Convert.ToInt32(ChkBoxList.Items[i].Value)));
                    }
                }
                //Chama o BO e passa ObjUsuarios já com o List de clientes
                UsuarioBO ObjUsuarioBO = new UsuarioBO();
                ObjUsuarioBO.InsertUpdate(ObjUsuario);
                //Verifica se é um novo cadastro
                if (txtUsuario.Enabled == true)
                {
                    //Envia e-mail para um novo usuario
                    FuncoesEmails ObjFuncoesEmails = new FuncoesEmails();
                    ObjFuncoesEmails.EmailCadastroUsuario(ObjUsuario.Nome, ObjUsuario.Email, ObjUsuario.Usuarios, ObjUsuario.Senha);
                }
                //Limpas os campos do form
                ObjValida.LimparCampos(this);
                ChkBoxList.ClearSelection();
                Response.Redirect("default.aspx");
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex);
            Response.End();
        }
    }

    //Carrega um registro para edição
    public void Editar(int id)
    {
        try
        {
            Validacoes Valida = new Validacoes();
            Usuario ObjUsuario = new Usuario();
            UsuarioBO ObjUsuarioBO = new UsuarioBO();
            ObjUsuario = ObjUsuarioBO.SelectUsuarioByID(id);
            ddlUsuarioStatus.TextoInformado = Convert.ToString(ObjUsuario.idStatus);
            ddlUsuarioPerfil.TextoInformado = Convert.ToString(ObjUsuario.idPerfil);
            ddlProfissional.ValorInformado = Convert.ToString(Valida.TextoNull(ObjUsuario.idProfissional));
            txtNome.Text = ObjUsuario.Nome;
            txtEmail.Text = ObjUsuario.Email;
            txtEmailConfirmacao.Text = ObjUsuario.Email;
            txtUsuario.Enabled = false;
            txtUsuario.Text = ObjUsuario.Usuarios;

            CarregaListaClientes(ObjUsuario.UsuarioXCliente);
        }
        catch (Exception ex)
        {
            Response.Write(ex);
            Response.End();
        }
    }

    //Carrega a lista de clientes referente ao usuario
    private void CarregaListaClientes(List<UsuarioXCliente> Obj)
    {
        ChkBoxList.ClearSelection();
        for (int i = 0; i <= ChkBoxList.Items.Count - 1; i++)
        {
            foreach (UsuarioXCliente proc in Obj)
            {
                if (ChkBoxList.Items[i].Value == Convert.ToString(proc.idCliente))
                {
                    ChkBoxList.Items[i].Selected = true; //Seleciona o item do ListBox
                    break;
                }
            }
        }
    }

    //Evento do ComboBox
    private void ddlUsuarioPerfil_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlUsuarioPerfil.ValorInformado == "1")
        {
            ChkBoxList.ClearSelection();
            ChkBoxList.Enabled = false;
        }
        else
        {
            ChkBoxList.Enabled = true;
        }

        if (ddlUsuarioPerfil.ValorInformado == "3")
        {
            lblMédico.Visible = true;
            ddlProfissional.Visible = true;
        }
        else
        {
            lblMédico.Visible = false;
            ddlProfissional.Visible = false;
        }

    }

    //Valida os Campos 
    public bool ValidaCampos()
    {
        Validacoes ObjValida = new Validacoes();
        UsuarioBO ObjUsuarioBO = new UsuarioBO();
        //Caso o perfil de usuario seja MEDICO entao é obrigatorio selecionar um medico e um cliente
        if (ddlUsuarioPerfil.ValorInformado == "3" && ddlProfissional.ValorInformado == string.Empty)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Para o tipo de perfil selecionado é obrigatório selecionar um profissional de saúde')", true);
            return false;
        }
        if ((ddlUsuarioStatus.ValorInformado == String.Empty) || (ddlUsuarioPerfil.ValorInformado == String.Empty) || (txtUsuario.Text == String.Empty))
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Campos (*) são de preenchimento obrigatório')", true);
            return false;
        }
        if (txtUsuario.Text.Length < 6)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('O Nome de Usuário deve conter no mínimo 6 Caracteres')", true);
            return false;
        }
        if (ObjValida.ValidaEmail(txtEmail.Text) == false)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('O E-mail informado é invalido')", true);
            return false;
        }
        if (!txtEmail.Text.Equals(txtEmailConfirmacao.Text))
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('O E-mail informado é diferente da confirmação de E-mail')", true);
            return false;
        }
        if (txtUsuario.Enabled == true && ObjUsuarioBO.SelectVerificaUsuario(txtUsuario.Text) == true)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('O nome do usuário escolhido já existe. Escolha um novo usuário.')", true);
            return false;
        }
        return true;
    }
}
