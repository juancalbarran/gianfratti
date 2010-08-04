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
using System.Data.SqlClient;

/// <summary>
/// Data: 12/01/2007
/// Autor: Fabrizio Gianfratti Manes
/// Descrição: Página responsavel por efetuar o cadastro de clientes(dados cliente, departamentos, setores e usuarios)

public partial class Cliente_ClienteCadastro : System.Web.UI.Page
{   
    /// Declaração de variaveis
    Cliente ObjCliente;
    DropDownList ddlDepartamentos;

    /// Evento inicial
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.IsPostBack) //Se não for PostBack
        {
            GeraDropDownListDepartamentos();
        }
        else
        {
            Session["Cliente"] = null;
        }
    }

    /// Salva Departamento
    protected void BtnIncluirDepartamento_Click(object sender, EventArgs e)
    {
        //if (Session["Cliente"] == null)
        //{
        //    ObjCliente = new Cliente();
        //}
        //else
        //{
        //    ObjCliente = Session["Cliente"] as Cliente;
        //}
        //ClienteBO ObjClienteBO = new ClienteBO();
        ////Salva ObjCliente na Session para ser usado em outras etapas
        //Session["Cliente"] = ObjClienteBO.IncluirDepartamento(ObjCliente, TxtDepartamento.Text);
        //TxtDepartamento.Text = "";
    }

    /// Salva Setor
    protected void BtnIncluirSetor_Click(object sender, EventArgs e)
    {
        //if (Session["Cliente"] == null)
        //{
        //    ObjCliente = new Cliente();
        //}
        //else
        //{
        //    ObjCliente = Session["Cliente"] as Cliente;
        //}
        //ClienteBO ObjClienteBO = new ClienteBO();
        ////Salva ObjCliente na Session para ser usado em outras etapas
        //Session["Cliente"] = ObjClienteBO.IncluirSetor(ObjCliente, Convert.ToInt32(ddlDepartamentos.SelectedItem.Value), TxtSetor.Text);
        //TxtSetor.Text = "";
    }

    /// Lista todos os departamentos e os setores que estão na memoria
    public void ListaDepartamentosSetores()
    {
        ObjCliente = Session["Cliente"] as Cliente;
        if (Session["Cliente"] != null)
        {
            for (int i = 0; i < ObjCliente.Departamentos.Count; i++)
            {
                Response.Write(String.Concat("<b>", ObjCliente.Departamentos[i].Nome, "</b><br>")); //Response.Write(String.Concat("ID = ", i, "Nome = ", ObjCliente.Departamentos[i].Nome, "<br>"));
                foreach (string setor in ObjCliente.Departamentos[i].Setores)
                {
                    Response.Write(String.Concat("&nbsp;&nbsp;&nbsp;&nbsp;", setor, "<br/>"));
                }
            }
            this.GeraDropDownListDepartamentos();
        }
    }

    /// Gera DropDownList dos departamentos que já foram salvo na memoria
    public void GeraDropDownListDepartamentos()
    {
        ObjCliente = Session["Cliente"] as Cliente;
        if (Session["Cliente"] != null)
        {
            ddlDepartamentos = new DropDownList();
            ddlDepartamentos.ID = "ListaDepartamentos";
            for (int i = 0; i < ObjCliente.Departamentos.Count; i++)
            {
                ddlDepartamentos.Items.Add(new ListItem(ObjCliente.Departamentos[i].Nome, Convert.ToString(i)));
            }
            phlDrop.Controls.Add(ddlDepartamentos);
        }

    }

    /// Salva Dados Cliente
    protected void BtnIncluirUsuario_Click(object sender, EventArgs e)
    {
        //if (Session["Cliente"] == null)
        //{
        //    ObjCliente = new Cliente();
        //}
        //else
        //{
        //    ObjCliente = Session["Cliente"] as Cliente;
        //}
        //ObjCliente.Departamentos.Add(new ClienteDepartamento(TxtDepartamento.Text));
        ////ObjCliente.Usuarios.Add(new ClienteUsuario(TxtUsuarioNome.Text));
        ////Salva ObjCliente na Session para ser usado em outras etapas
        //Session["Cliente"] = ObjCliente;
        //TxtDepartamento.Text = "";
    }

    protected void BtnSalvar_Click(object sender, EventArgs e)
    {
        //if (Session["Cliente"] == null)
        //{
        //    ObjCliente = new Cliente();
        //}
        //else
        //{
        //    ObjCliente = Session["Cliente"] as Cliente;
        //}
        //Validacoes Valida = new Validacoes();
        //ObjCliente.idTipoIdentificacao = Convert.ToInt32(DdlTipoIdentificacao.Text);
        //ObjCliente.CNPJ_INCRA_CPF = TxtCNPJ_INCRA_CPF.Text;
        //ObjCliente.InscEstadual = TxtInscEstatual.Text;
        //ObjCliente.RazaoSocial = TxtRazaoSocial.Text;
        //ObjCliente.Endereco = TxtEndereco.Text;
        //ObjCliente.Bairro = TxtBairro.Text;
        //ObjCliente.CEP = TxtCep.Text;
        //ObjCliente.Cidade = TxtCidade.Text;
        //ObjCliente.UF = TxtUF.Text;
        //ObjCliente.idProfissional = Valida.TextoNull(DdlProfissional.Text);
        //ObjCliente.CNAE = TxtCNAE.Text;
        //ObjCliente.GFIP = TxtGFIP.Text;
        //ObjCliente.DDDtel = TxtDDDtel.Text;
        //ObjCliente.Telefone = TxtTelefone.Text;
        //ObjCliente.DDDfax = TxtDDDfax.Text;
        //ObjCliente.Fax = TxtFax.Text;
        //ObjCliente.Contato = TxtContato.Text;
        //ObjCliente.Email = TxtEmail.Text;
        
        //ClienteBO ObjClienteBO = new ClienteBO();
        //if (!ObjClienteBO.SalvaDados(ObjCliente,1))
        //{
        //    //Caso o CNPJ estiver errado Salva ObjCliente na Session para ser usado em outras etapas
        //    Session["Cliente"] = ObjCliente;
        //    Response.Write("<Script>alert('CNPJ inválido')</Script>");
        //    Response.Write("<Script>history.go(-1)</Script>");
        //    Response.End();
        //}
        //else
        //{
        //    Response.Redirect("ClientePrincipal.aspx");
        //}

    }
    protected void DdlProfissional_DataBound(object sender, EventArgs e)
    {
        DdlProfissional.Items.Insert(0, new ListItem("<--Selecione-->", "")); //Texto Inicial do combo
    }
}
