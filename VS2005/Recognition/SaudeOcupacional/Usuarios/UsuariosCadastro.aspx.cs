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

public partial class Usuarios_UsuariosCadastro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MontaChkBoxList();
            DataGridUsuarios();

            //Desabilita combo e label do profissional de saúde
            ddlProfissional.Visible = false;
            lblProfissional.Visible = false;
            //Desabilita listbox e label dos clientes
            ChkBoxList.Visible = false;
            lblCliente.Visible = false;
        }
    }

    //Evento responsavel por chamar as funções
    protected void GridUsuario_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Deletar")
        {
            Deletar(Convert.ToInt32(e.CommandArgument));
        }
        if (e.CommandName == "Editar")
        {
            Editar(Convert.ToInt32(e.CommandArgument));
        }
    }
    //Função que preenche o data grid
    private void DataGridUsuarios()
    {
        //UsuarioBO ObjUsuarioBO = new UsuarioBO();
        //GridUsuario.DataSource = ObjUsuarioBO.SelectUsuarioALL();
        //GridUsuario.DataBind();
    }

    //Evento responsavel por fazer o insert ou update
    protected void btnSalvarUsuario_Click(object sender, EventArgs e)
    {
        try
        {
            Validacoes ObjValida = new Validacoes();
            if (ValidaCampos() == true)
            {
                Usuario ObjUsuario = new Usuario();
                ObjUsuario.id = Convert.ToInt32(ObjValida.TextoNull(hddIUsuario.Value));
                ObjUsuario.idEmpresa = Request.QueryString["idEmpresa"];
                ObjUsuario.idStatus = Convert.ToInt32(ddlUsuarioStatus.ValorInformado);
                ObjUsuario.idPerfil = Convert.ToInt32(ddlUsuarioPerfil.ValorInformado);
                ObjUsuario.idProfissional = ddlProfissional.ValorInformado;
                ObjUsuario.Nome = txtUsuarioNome.Text;
                ObjUsuario.Usuarios = txtUsuario.Text;
                ObjUsuario.Senha = txtUsuarioSenha.Text;
                //Percore o ListBox de clientes colocando os ID's dos clientes selecionados em um List
                for (int i = 0; i <= ChkBoxList.Items.Count - 1; i++)
                {//Verifica se o cliente foi selecionado
                    if (ChkBoxList.Items[i].Selected)
                    {//caso selecionado entao add na lista
                        ObjUsuario.UsuarioXCliente.Add(new UsuarioXCliente(Convert.ToInt32(ObjValida.TextoNull(hddIUsuario.Value)), Convert.ToInt32(ChkBoxList.Items[i].Value)));
                    }
                }
                //Chama o BO e passa ObjUsuarios já com o List de clientes
                UsuarioBO ObjUsuarioBO = new UsuarioBO();
                ObjUsuarioBO.InsertUpdate(ObjUsuario);
                DataGridUsuarios();
                //Limpas os campos do form
                ObjValida.LimparCampos(this);
                ChkBoxList.ClearSelection();
                if (btnSalvarUsuario.Text == "Alterar Usuário") btnSalvarUsuario.Text = "Salvar Usuário";
            }

        }
        catch (Exception ex)
        {
            Response.Write("Error");
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
            btnSalvarUsuario.Text = "Alterar Usuário";
            txtUsuario.Enabled = false;
            Usuario ObjUsuario = new Usuario();
            UsuarioBO ObjUsuarioBO = new UsuarioBO();
            ObjUsuario = ObjUsuarioBO.SelectUsuarioByID(id);
            hddIUsuario.Value = Convert.ToString(ObjUsuario.id);
            ddlUsuarioStatus.TextoInformado = Convert.ToString(ObjUsuario.idStatus);
            ddlUsuarioPerfil.TextoInformado = Convert.ToString(ObjUsuario.idPerfil);
            ddlProfissional.ValorInformado = Convert.ToString(ObjUsuario.idProfissional);
            txtUsuarioNome.Text = ObjUsuario.Nome;
            txtUsuario.Text = ObjUsuario.Usuarios;
            if (ddlUsuarioPerfil.ValorInformado == "3")
            {
                ddlProfissional.Visible = true;
                lblProfissional.Visible = true;
                ChkBoxList.Visible = true;
                lblCliente.Visible = true;
            }else if (ddlUsuarioPerfil.ValorInformado == "2")
            {
                ddlProfissional.Visible = false;
                lblProfissional.Visible = false;
                ChkBoxList.Visible = true;
                lblCliente.Visible = true;
            }
            else
            {
                ddlProfissional.Visible = false;
                lblProfissional.Visible = false;
                ChkBoxList.Visible = false;
                lblCliente.Visible = false;
            }
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
        if ((ddlUsuarioStatus.ValorInformado == String.Empty) || (ddlUsuarioPerfil.ValorInformado == String.Empty) || (txtUsuarioNome.Text == String.Empty) || (txtUsuario.Text == String.Empty) || (txtUsuarioSenha.Text == String.Empty) || (txtUsuarioConfirmarSenha.Text == String.Empty))
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Campos (*) são de preenchimento obrigatório')", true);
            return false;
        }
        if (txtUsuario.Text.Length < 6)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('O Nome de Usuário deve conter no mínimo 6 Caracteres')", true);
            return false;
        }
        if (txtUsuarioSenha.Text.Length < 6)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('A Senha deve conter no mínimo 6 Caracteres')", true);
            return false;
        }
        if (txtUsuarioSenha.Text != txtUsuarioConfirmarSenha.Text)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('As Senhas digitadas não conferem')", true);
            return false;
        }
        if (ObjValida.ValidaSenhaAlfaNumerica(txtUsuarioSenha.Text) == false)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('O campo senha é do tipo alfa-numérico, deve conter letras,números e caracteres especiais')", true);
            return false;
        }
        if (Convert.ToInt32(ObjValida.TextoNull(hddIUsuario.Value)) == 0)
        {
            if (ObjUsuarioBO.SelectVerificaUsuario(txtUsuario.Text) == true)
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('O usuário escolhido já existe. Escolha um novo usuário.')", true);
                return false;
            }
        }
        return true;
    }
    //Envia para a mesma pagina
    protected void btnNovo_Click(object sender, EventArgs e)
    {
        Response.Redirect("UsuariosCadastro.aspx?idEmpresa=" + Request.QueryString["idEmpresa"]);
    }

    private void MontaChkBoxList()
    {
        ClienteDAL ObjClienteDAL = new ClienteDAL();
        ChkBoxList.DataSource = ObjClienteDAL.DropDownList(0, Convert.ToInt32(Session["idPerfil"]));
        ChkBoxList.DataTextField = "RazaoSocial";
        ChkBoxList.DataValueField = "ID";
        ChkBoxList.DataBind();
    }
    //Evento do ComboBox
    private void ddlUsuarioPerfil_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Habilita combo e label do profissional de saúde
        if (ddlUsuarioPerfil.ValorInformado == "3")
        {
            ddlProfissional.Visible = true;
            lblProfissional.Visible = true;

            ChkBoxList.Visible = true;
            lblCliente.Visible = true;
        }
        else if (ddlUsuarioPerfil.ValorInformado == "2")
        {
            ddlProfissional.Visible = false;
            lblProfissional.Visible = false;

            ChkBoxList.Visible = true;
            lblCliente.Visible = true;
        }
        else
        {
            ddlProfissional.Visible = false;
            lblProfissional.Visible = false;

            ChkBoxList.Visible = false;
            lblCliente.Visible = false;
        }
    }

    //Função para deletar um registro
    public void Deletar(int id)
    {
        try
        {
            Validacoes ObjValida = new Validacoes();
            UsuarioBO ObjUsuarioBO = new UsuarioBO();
            ObjUsuarioBO.DeleteUsuarioByID(id);
            DataGridUsuarios();
            txtUsuario.Enabled = true;
            ObjValida.LimparCampos(this);
            hddIUsuario.Value = "0";
            btnSalvarUsuario.Text = "Salvar Usuário";
            ChkBoxList.ClearSelection();
            ddlProfissional.Visible = false;
            lblProfissional.Visible = false;
            ChkBoxList.Visible = false;
            lblCliente.Visible = false;
        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }
    
}
