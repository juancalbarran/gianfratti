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

public partial class ClienteFuncionario_ClienteFuncionarioProfissional : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ClienteDepartamento1.SelectedIndexChanged += new EventHandler(ClienteDepartamento1_SelectedIndexChanged);
        ClienteSetor1.SelectedIndexChanged += new EventHandler(ClienteSetor1_SelectedIndexChanged);
        if (!Page.IsPostBack)
        {
            ClienteDepartamento1.idCliente = Convert.ToInt32(Request.QueryString["idCliente"]);
        }
    }

    private void ClienteDepartamento1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ClienteDepartamento1.ValorInformado != string.Empty)
        {
            ClienteSetor1.idClienteDepartamento = Convert.ToInt32(ClienteDepartamento1.ValorInformado);
        }
    }

    private void ClienteSetor1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ClienteSetor1.ValorInformado != string.Empty)
        {
            ClienteCargo1.idClienteSetor = Convert.ToInt32(ClienteSetor1.ValorInformado);
        }
    }

    protected void BtnSalvarProfissional_Click(object sender, EventArgs e)
    {
        //Chama a funcao que vai fazer a validacao nos campos da ficha profissional do funcionario
        if (Validacao())
        {
            //Verifica se existe o ID do Funcionario
            if (Convert.ToInt32(Request.QueryString["id"]) != 0)
            {
                try
                {
                    ClienteFuncionarioProfissional ObjClienteFuncionarioProfissional = new ClienteFuncionarioProfissional();
                    Validacoes Valida = new Validacoes();
                    //Chave primaria da tabela
                    ObjClienteFuncionarioProfissional.id = Convert.ToInt32(Valida.TextoNull(TxtIdFuncionarioProfissional.Value));
                    //Dados profissionais
                    ObjClienteFuncionarioProfissional.idFuncionario = Convert.ToInt32(Request.QueryString["id"]);
                    ObjClienteFuncionarioProfissional.idFuncionarioStatus = Convert.ToInt32(DdlStatus.Text);
                    ObjClienteFuncionarioProfissional.idDepartamento = Convert.ToString(ClienteDepartamento1.ValorInformado);
                    ObjClienteFuncionarioProfissional.idSetor = Convert.ToString(ClienteSetor1.ValorInformado);
                    ObjClienteFuncionarioProfissional.idCargo = Convert.ToString(ClienteCargo1.ValorInformado);
                    ObjClienteFuncionarioProfissional.NumMatricula = TxtNumMatricula.Text;
                    ObjClienteFuncionarioProfissional.DtAdmissao = TxtDtAdmissao.Text;
                    ObjClienteFuncionarioProfissional.DtDemissao = TxtDtDemissao.Text;
                    ObjClienteFuncionarioProfissional.Salario = TxtSalario.Text;
                    ObjClienteFuncionarioProfissional.Aposentado = DdlAposentado.Text;
                    ObjClienteFuncionarioProfissional.CBO = TxtCBO.Text;
                    ObjClienteFuncionarioProfissional.DtPeriodoInicial = TxtDtPeriodoInicial.Text;
                    ObjClienteFuncionarioProfissional.DtPeriodoFinal = TxtDtPeriodoFinal.Text;
                    ObjClienteFuncionarioProfissional.DescricaoAtividades = TxtDescricaoAtividades.Text;
                    ObjClienteFuncionarioProfissional.NumCTPS = TxtNumCTPS.Text;
                    ObjClienteFuncionarioProfissional.SerieCTPS = TxtSerieCTPS.Text;
                    ObjClienteFuncionarioProfissional.UFCTPS = ddlEstados.ValorInformado;
                    ObjClienteFuncionarioProfissional.FiliacaoPrevidencia = TxtFiliacaoPrevidencia.Text;
                    ObjClienteFuncionarioProfissional.PIS = TxtPIS.Text;
                    ClienteFuncionarioProfissionalDAL ObjClienteFuncionarioProfissionalDAL = new ClienteFuncionarioProfissionalDAL();
                    ObjClienteFuncionarioProfissionalDAL.InsertUpdate(ObjClienteFuncionarioProfissional);

                    Response.Write("<script>window.location='ClienteFuncionarioProfissional.aspx?id=" + Request.QueryString["id"] + "&idCliente=" + Request.QueryString["idCliente"] + "'</script>");
                }
                catch (Exception ex)
                {
                    Response.Write(ex);
                    Response.End();
                }
            }
            //Caso nao exista o ID do funcionario
            else
            {
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Salve antes a ficha pessoal do profissional')", true);
            }
        }
    }

    //CARREGA OS DADOS DO PROFISSIONAL PARA EDIÇÃO
    public void CarregaDadosFuncionarioProfissional(int IdFuncionarioProfissional)
    {
        try
        {
            if (Convert.ToInt32(IdFuncionarioProfissional) != 0)
            {
                ClienteFuncionarioProfissional ObjClienteFuncionarioProfissional = new ClienteFuncionarioProfissional();
                ClienteFuncionarioProfissionalBO ObjClienteFuncionarioProfissionalBO = new ClienteFuncionarioProfissionalBO();
                Validacoes Valida = new Validacoes();
                ObjClienteFuncionarioProfissional = ObjClienteFuncionarioProfissionalBO.CarregaFuncionarioProfissional(Convert.ToInt32(IdFuncionarioProfissional)) as ClienteFuncionarioProfissional;
                //DADOS PROFISSIONAIS
                DdlStatus.Text = Convert.ToString(ObjClienteFuncionarioProfissional.idFuncionarioStatus);
                ClienteDepartamento1.TextoInformado = Convert.ToString(ObjClienteFuncionarioProfissional.idDepartamento);
                ClienteSetor1.TextoInformado = Convert.ToString(ObjClienteFuncionarioProfissional.idSetor);
                ClienteCargo1.TextoInformado = Convert.ToString(ObjClienteFuncionarioProfissional.idCargo);
                TxtNumMatricula.Text = ObjClienteFuncionarioProfissional.NumMatricula;
                TxtDtAdmissao.Text = ObjClienteFuncionarioProfissional.DtAdmissao;
                TxtDtDemissao.Text = ObjClienteFuncionarioProfissional.DtDemissao;
                TxtSalario.Text = ObjClienteFuncionarioProfissional.Salario;
                DdlAposentado.Text = ObjClienteFuncionarioProfissional.Aposentado;
                TxtCBO.Text = ObjClienteFuncionarioProfissional.CBO;
                TxtCBOFuncao.Text = ObjClienteFuncionarioProfissional.CBO_Funcao;
                TxtDtPeriodoInicial.Text = ObjClienteFuncionarioProfissional.DtPeriodoInicial;
                TxtDtPeriodoFinal.Text = ObjClienteFuncionarioProfissional.DtPeriodoFinal;
                TxtDescricaoAtividades.Text = ObjClienteFuncionarioProfissional.DescricaoAtividades;
                TxtNumCTPS.Text = ObjClienteFuncionarioProfissional.NumCTPS;
                TxtSerieCTPS.Text = ObjClienteFuncionarioProfissional.SerieCTPS;
                ddlEstados.ValorInformado = ObjClienteFuncionarioProfissional.UFCTPS.Replace(" ", string.Empty);
                TxtFiliacaoPrevidencia.Text = ObjClienteFuncionarioProfissional.FiliacaoPrevidencia;
                TxtPIS.Text = ObjClienteFuncionarioProfissional.PIS;
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex);
            Response.End();
        }
    }

    public bool Validacao()
    {
        if (DdlStatus.Text.Trim() == "")
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Selecione um status')", true);
            return false;
        }
        else if (TxtDtAdmissao.Text.Trim() == "")
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Entre com a data de admissão do funcionário')", true);
            return false;
        }       else
        {
            return true;
        }
    }
    protected void DdlStatus_DataBound(object sender, EventArgs e)
    {
        DdlStatus.Items.Insert(0, new ListItem("<--Selecione-->", "")); //Texto Inicial do combo
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            //Passa id do profissional para um campo hidden
            TxtIdFuncionarioProfissional.Value = Convert.ToString(GridView1.SelectedDataKey.Value);
            //Carrega os dados Profissionais do Funcionario
            CarregaDadosFuncionarioProfissional(Convert.ToInt32(GridView1.SelectedDataKey.Value));
        }
        catch (Exception ex)
        {
            Response.Write(ex);
            Response.End();
        }
    }
}
