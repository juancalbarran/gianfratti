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

public partial class UserControls_ClienteFuncionario_FuncionarioDadosBasicos : System.Web.UI.UserControl
{
    private int mIdFuncionario = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        FichaPessoal(mIdFuncionario);
        FichaProfissional(mIdFuncionario);
    }

    public void FichaPessoal(int mIdFuncionario)
    {
        try
        {
            if (mIdFuncionario != 0)
            {
                ClienteFuncionario ClienteFuncionario = new ClienteFuncionario();
                ClienteFuncionarioUserControlBO ClienteFuncionarioUserControlBO = new ClienteFuncionarioUserControlBO();
                ClienteFuncionario = ClienteFuncionarioUserControlBO.CarregaFuncionario(mIdFuncionario) as ClienteFuncionario;
                lblNome.Text = ClienteFuncionario.Nome;
                lblRG.Text = ClienteFuncionario.RG;
                lblCPF.Text = ClienteFuncionario.CPF;
                lblSexo.Text = ClienteFuncionario.Sexo;
                lblDtNascimento.Text = ClienteFuncionario.DtNascimento;
                lblEstadoCivil.Text = ClienteFuncionario.EstadoCivil;
                lblEndResidencia.Text = ClienteFuncionario.EndResidencia;
                lblNumero.Text = ClienteFuncionario.Numero;
                lblComplemento.Text = ClienteFuncionario.Complemento;
                lblCEP.Text = ClienteFuncionario.CEP;
                lblBairro.Text = ClienteFuncionario.Bairro;
                lblCidade.Text = ClienteFuncionario.Cidade;
                lblUF.Text = ClienteFuncionario.UF;
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex);
            Response.End();
        }
    }

    public void FichaProfissional(int mIdFuncionario)
    {
        try
        {
            if (mIdFuncionario != 0)
            {
                ClienteFuncionarioProfissional ObjClienteFuncionarioProfissional = new ClienteFuncionarioProfissional();
                ClienteFuncionarioUserControlBO ClienteFuncionarioUserControlBO = new ClienteFuncionarioUserControlBO();
                ObjClienteFuncionarioProfissional = ClienteFuncionarioUserControlBO.CarregaFuncionarioProfissional(mIdFuncionario) as ClienteFuncionarioProfissional;
                LblDepartamento.Text = ObjClienteFuncionarioProfissional.Departamento;
                LblSetor.Text = ObjClienteFuncionarioProfissional.Setor;
                lblCliente.Text = ObjClienteFuncionarioProfissional.RefCliente.RazaoSocial;
                lblRisco.Text = ObjClienteFuncionarioProfissional.RefCliente.Risco;
                lblDenominacao.Text = ObjClienteFuncionarioProfissional.RefCliente.Denominacao;
                lblCNAE.Text = ObjClienteFuncionarioProfissional.RefCliente.CNAE;
                lblCBO.Text = ObjClienteFuncionarioProfissional.CBO;
                lblDescricaoAtividades.Text = ObjClienteFuncionarioProfissional.DescricaoAtividades;
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex);
            Response.End();
        }
    }

    public int IdFuncionario
    {
        get
        {
            return mIdFuncionario;
        }
        set
        {
            mIdFuncionario = value;
            FichaPessoal(mIdFuncionario);
            FichaProfissional(mIdFuncionario);
        }
    }
}
