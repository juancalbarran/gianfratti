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


public partial class Funcionario_FuncionarioCadastra : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void BtnSalvar_Click(object sender, EventArgs e)
    {
        //ClienteFuncionario ObjClienteFuncionario = new ClienteFuncionario();
        //ObjClienteFuncionario.RefClienteFuncionarioAtribuicao = new ClienteFuncionarioAtribuicao();
        //Validacoes Valida = new Validacoes();
        ////DADOS PESSOAIS
        //ObjClienteFuncionario.idCliente = Convert.ToInt32(DdlCliente.Text);
        //ObjClienteFuncionario.CPF = TxtCPF.Text.Replace("-", String.Empty);        
        //ObjClienteFuncionario.RG = TxtRG.Text;
        //ObjClienteFuncionario.idOrgaoExpeditor = Valida.TextoNull(DdlOrgaoExpeditor.Text);
        //ObjClienteFuncionario.DtExpedicao = TxtDtExpedicao.Text;
        //ObjClienteFuncionario.RgUFemissao = TxtRgUFemissao.Text; 
        //ObjClienteFuncionario.Nome = TxtNome.Text;
        //ObjClienteFuncionario.DtNascimento = TxtDtNascimento.Text;
        //ObjClienteFuncionario.DtObito = TxtDtObito.Text;
        //ObjClienteFuncionario.Sexo = Valida.TextoNull(DdlSexo.Text);
        //ObjClienteFuncionario.EstadoCivil = Valida.TextoNull(DdlEstadoCivil.Text);
        //ObjClienteFuncionario.Mae = TxtMae.Text;
        //ObjClienteFuncionario.EndResidencia = TxtEndResidencia.Text;
        //ObjClienteFuncionario.Numero = TxtNumero.Text;
        //ObjClienteFuncionario.Complemento = TxtConplemento.Text;
        //ObjClienteFuncionario.Cidade = TxtCidade.Text;
        //ObjClienteFuncionario.UF = TxtUF.Text;
        //ObjClienteFuncionario.Bairro = TxtBairro.Text;
        //ObjClienteFuncionario.CEP = TxtCEP.Text;
        //ObjClienteFuncionario.DDDtel = TxtDDDtel.Text;
        //ObjClienteFuncionario.Telefone = TxtTelefone.Text;
        //ObjClienteFuncionario.DDDcel = TxtDDDcel.Text;
        //ObjClienteFuncionario.Celular = TxtCelular.Text;
        //ObjClienteFuncionario.DDDcontato = TxtDDDContato.Text;
        //ObjClienteFuncionario.TelefoneContato = TxtTelefoneContato.Text;
        //ObjClienteFuncionario.ContatoNome = TxtContatoNome.Text;
        ////DADOS PROFISSIONAIS
        //ObjClienteFuncionario.idFuncionarioStatus = Convert.ToInt32(DdlStatus.Text);
        //ObjClienteFuncionario.NumMatricula = TxtNumMatricula.Text;
        //ObjClienteFuncionario.DtAdmissao = TxtDtAdmissao.Text;
        //ObjClienteFuncionario.DtDemissao = TxtDtDemissao.Text;
        //ObjClienteFuncionario.idSetor = Convert.ToInt32(DdlSetor.Text);
        //ObjClienteFuncionario.Salario = TxtSalario.Text;
        //ObjClienteFuncionario.Aposentado = Valida.TextoNull(DdlAposentado.Text);
        //ObjClienteFuncionario.CBO = TxtCBO.Text;
        //ObjClienteFuncionario.NumCTPS = TxtNumCTPS.Text;
        //ObjClienteFuncionario.SerieCTPS = TxtSerieCTPS.Text;
        //ObjClienteFuncionario.UFCTPS = TxtUFCTPS.Text;
        //ObjClienteFuncionario.FiliacaoPrevidencia = TxtFiliacaoPrevidencia.Text;
        //ObjClienteFuncionario.PIS = TxtPIS.Text;
        ////DADOS PROFISSIONAIS DE ATRIBUIÇÃO DO FUNCIONARIO
        //ObjClienteFuncionario.RefClienteFuncionarioAtribuicao.DataInicial = TxtDtAdmissao.Text;
        //ObjClienteFuncionario.RefClienteFuncionarioAtribuicao.idSetor = Convert.ToInt32(DdlSetor.Text);
        //ObjClienteFuncionario.RefClienteFuncionarioAtribuicao.Cargo = TxtCargo.Text;
        //ObjClienteFuncionario.RefClienteFuncionarioAtribuicao.Funcao = TxtFuncao.Text;
        //ObjClienteFuncionario.RefClienteFuncionarioAtribuicao.CBO = TxtCBO.Text;
        //try
        //{
        //    //ClienteFuncionarioBO ObjClienteFuncionarioBO = new ClienteFuncionarioBO();
        //    //ObjClienteFuncionarioBO.SalvaDados(ObjClienteFuncionario, 1);
        //}
        //catch (Exception erro)
        //{
        //    Response.Write(erro);
        //    Response.End();
        //}
        //Response.Redirect("FuncionarioPrincipal.aspx");
    }

    protected void DdlCliente_DataBound(object sender, EventArgs e)
    {
        DdlCliente.Items.Insert(0, new ListItem("<--Selecione-->", "")); //Texto Inicial do combo
    }

    protected void DdlStatus_DataBound(object sender, EventArgs e)
    {
        DdlStatus.Items.Insert(0, new ListItem("<--Selecione-->", "")); //Texto Inicial do combo
    }
    protected void DdlOrgaoExpeditor_DataBound(object sender, EventArgs e)
    {
        DdlOrgaoExpeditor.Items.Insert(0, new ListItem("<--Selecione-->", "")); //Texto Inicial do combo
    }
}
