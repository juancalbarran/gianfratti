using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using JomaBE;
using JomaDAL;

public partial class Forms_ProfissionaisCadastrar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            MontaComboProfissionaisPerfil();
            CheckBoxListEspecialidades();

            //Verifico se existe o ID na URL, caso existe é uma edição
            if (Request.QueryString["id"] != null)
            {
                BtnCadastrar.Text = "Alterar"; //Alteto o texto do botao
                ObtemDados(); //chamo o metodo que carrega os dados
                CarregaEspecialidades(Convert.ToInt32(Request.QueryString["id"]));
            }
        }
    }

    /// <summary>
    /// Evento para Inserir um novo registro ou atualizar um registro ja existente
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void BtnCadastrar_Click(object sender, EventArgs e)
    {
        try
        {
            ProfissionaisBE profissionaisBE = new ProfissionaisBE();
            profissionaisBE.id = Convert.ToInt32(Request.QueryString["id"]);
            profissionaisBE.idProfissionalPerfil = Convert.ToInt32(ddlProfissionalPerfil.SelectedValue);
            profissionaisBE.Registro = txtRegistro.Text;
            profissionaisBE.Nome = txtNome.Text;
            profissionaisBE.Sexo = ddlSexo.SelectedValue;
            profissionaisBE.DtNascimento = Convert.ToDateTime(txtDtNascimento.Text);
            profissionaisBE.RG = txtRG.Text;
            profissionaisBE.CPF = txtCPF.Text;
            profissionaisBE.Endereco = txtEndereco.Text;
            profissionaisBE.Bairro = txtBairro.Text;
            profissionaisBE.CEP = txtCEP.Text;
            profissionaisBE.Cidade = txtCidade.Text;
            profissionaisBE.UF = ddlUF.SelectedValue;
            profissionaisBE.Telefone = txtTelefone.Text;
            profissionaisBE.Celular = txtCelular.Text;
            profissionaisBE.Email = txtEmail.Text;
            profissionaisBE.Senha = txtSenha.Text;
            profissionaisBE.FlgAtivo = Convert.ToBoolean(Convert.ToInt32(ddlFlgAtivo.SelectedValue));
            profissionaisBE.Obs = txtObs.Text;
            ProfissionaisDAL profissionaisDAL = new ProfissionaisDAL();

            if (Request.QueryString["id"] != null)
            {
                //Chamo o metodo que altera o registro
                profissionaisDAL.Alterar(profissionaisBE);
            }
            else
            {
                //Chamo o metodo que insere um novo registro
                profissionaisDAL.Incluir(profissionaisBE);
            }
            //Chamo o metodo responsavel por gravar as especialidades do profissional
            GravaEspecialidades();
            //Envio para a pagina principal de profissionais
            Response.Redirect("Profissionais.aspx");
        }
        catch (Exception ex)
        {
            Label lblErro = (Label)Master.FindControl("lblErro");
            lblErro.Text = ex.ToString();
        }

    }

    /// <summary>
    /// Metodo que gravar as especialidades do profissional
    /// </summary>
    public void GravaEspecialidades()
    {
        //Busco o ultimo ID inserido na base para gravar as especialidades do profissinal.
        //Isso não é uma boa pratica, mas como no momento estamos usando banco de dados access, foi o que deu.
        ProfissionaisDAL profissionaisDAL = new ProfissionaisDAL();
        Int32 idProfissional = profissionaisDAL.ObterMaxId();

        //Crio uma lista para armazenar as especialidades selecionadas no CheckBoxList
        List<ProfissionaisEspecialidadeBE> Lista = new List<ProfissionaisEspecialidadeBE>();
        //Percorro o controle CheckBoxList
        for (int i = 0; i < ChkEspecialidade.Items.Count; i++)
        {
            if (ChkEspecialidade.Items[i].Selected) //Verifico quais foram selecionadas para adicionar na lista
            {
                ProfissionaisEspecialidadeBE profissionaisEspecialidadeBE = new ProfissionaisEspecialidadeBE();
                profissionaisEspecialidadeBE.idEspecialidade = Convert.ToInt32(ChkEspecialidade.Items[i].Value);
                profissionaisEspecialidadeBE.idProfissional = idProfissional;
                Lista.Add(profissionaisEspecialidadeBE);
            }
        }
        ProfissionaisEspecialidadeDAL profissionaisEspecialidadeDAL = new ProfissionaisEspecialidadeDAL();
        profissionaisEspecialidadeDAL.Delete(idProfissional); //Delete os registros antes de fazer a inserção das especialidades
        profissionaisEspecialidadeDAL.Incluir(Lista); //Chamo o metodo DAL responsavel por gravar
    }

    /// <summary>
    /// Carrega as especialidades do profissional
    /// </summary>
    /// <param name="idProfissional"></param>
    public void CarregaEspecialidades(Int32 idProfissional)
    {
        ProfissionaisEspecialidadeDAL profissionaisEspecialidadeDAL = new ProfissionaisEspecialidadeDAL();
        List<ProfissionaisEspecialidadeBE> Lista = new List<ProfissionaisEspecialidadeBE>();
        Lista = profissionaisEspecialidadeDAL.Obter(idProfissional);

        //Percorro todas as opções do CheckBoxList
        for (int x = 0; x < ChkEspecialidade.Items.Count; x++)
        {
            //Percorro a lista
            for (int i = 0; i < Lista.Count; i++)
            {
                //Verifico se o id do controle é igual i id da lista de especialidades
                if (ChkEspecialidade.Items[x].Value == Lista[i].idEspecialidade.ToString())
                {
                    ChkEspecialidade.Items[x].Selected = true;
                }
            }
        }
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

    //Metodo responsavel por carregar um determinado registro para edição
    public void ObtemDados()
    {
        try
        {
            ProfissionaisBE profissionaisBE = new ProfissionaisBE();
            ProfissionaisDAL profissionaisDAL = new ProfissionaisDAL();
            profissionaisBE = profissionaisDAL.Obter(Convert.ToInt32(Request.QueryString["id"]));

            ddlProfissionalPerfil.SelectedValue = Convert.ToString(profissionaisBE.idProfissionalPerfil);
            txtRegistro.Text = profissionaisBE.Registro;
            txtNome.Text = profissionaisBE.Nome;
            ddlSexo.SelectedValue = profissionaisBE.Sexo;
            txtDtNascimento.Text = profissionaisBE.DtNascimento.ToString("dd/MM/yyyy");
            txtRG.Text = profissionaisBE.RG;
            txtCPF.Text = profissionaisBE.CPF;
            txtEndereco.Text = profissionaisBE.Endereco;
            txtBairro.Text = profissionaisBE.Bairro;
            txtCEP.Text = profissionaisBE.CEP;
            txtCidade.Text = profissionaisBE.Cidade;
            ddlUF.SelectedValue = profissionaisBE.UF;
            txtTelefone.Text = profissionaisBE.Telefone;
            txtCelular.Text = profissionaisBE.Celular;
            txtEmail.Text = profissionaisBE.Email;
            txtSenha.Text = profissionaisBE.Senha;
            txtSenhaConfirma.Text = profissionaisBE.Senha;
            ddlFlgAtivo.SelectedValue = Convert.ToString(Convert.ToBoolean(profissionaisBE.FlgAtivo));
            txtObs.Text = profissionaisBE.Obs;
        }
        catch (Exception ex)
        {
            Label lblErro = (Label)Master.FindControl("lblErro");
            lblErro.Text = ex.ToString();
        }
    }

    /// <summary>
    /// Monta combo com os perfis dos profissionais
    /// </summary>
    public void CheckBoxListEspecialidades()
    {
        try
        {
            EspecialidadeDAL especialidadeDAL = new EspecialidadeDAL();
            ChkEspecialidade.DataSource = especialidadeDAL.Listar();
            ChkEspecialidade.DataTextField = "Nome";
            ChkEspecialidade.DataValueField = "ID";
            ChkEspecialidade.DataBind();
        }
        catch (Exception ex)
        {
            Label lblErro = (Label)Master.FindControl("lblErro");
            lblErro.Text = ex.ToString();
        }
    }
}
