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

public partial class ProntuarioClinico_ProntuarioClinicoCadastro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //CHAMA FUNÇÃO QUE IRA CARREGAR OS DADOS DO ULTIMO PRONTUARIO
            CarregaUltimoProntuario(Convert.ToInt32(Request.QueryString["idFuncionario"]));
            //Chama o user control que vai preencher os dados do funcionario
            FuncionarioDadosBasicos1.IdFuncionario = Convert.ToInt32(Request.QueryString["idFuncionario"]);
            //txtDataCadastro.Text = DateTime.Now.ToString("dd/MM/yyyy");
        }

    }

    //SALVA O FORMULARIO
    protected void BtnSalvar_Click(object sender, EventArgs e)
    {
        if (txtDataCadastro.Text.Trim() != "")
        {
            try
            {
                ProtuarioClinico ObjProtuarioClinico = new ProtuarioClinico();
                Validacoes Valida = new Validacoes();
                //Pega o id do Funcionario e a Data de Cadastro
                ObjProtuarioClinico.idFuncionario = Convert.ToInt32(Convert.ToInt32(Request.QueryString["idFuncionario"]));
                ObjProtuarioClinico.dtCadastro = Convert.ToDateTime(txtDataCadastro.Text);
                //Anamnese
                ObjProtuarioClinico.Anamnese_Historico = txtAnamnese_Historico.Text;
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Diabetes = Convert.ToBoolean(Convert.ToInt32(rdoAnamnese_AntecedentesPessoais_Diabetes.Text));
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_HipertensaoArterial = Convert.ToBoolean(Convert.ToInt32(rdoAnamnese_AntecedentesPessoais_HipertensaoArterial.Text));
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Tumores = Convert.ToBoolean(Convert.ToInt32(rdoAnamnese_AntecedentesPessoais_Tumores.Text));
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Tumores_CID10 = Valida.TextoNull(txtAnamnese_AntecedentesPessoais_Tumores_CID10.Text);
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Tumores_Ano = Valida.TextoNull(txtAnamnese_AntecedentesPessoais_Tumores_Ano.Text);
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Tumores_Tratado = Valida.TextoNull(txtAnamnese_AntecedentesPessoais_Tumores_Tratado.Text);
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Alergias = Convert.ToBoolean(Convert.ToInt32(rdoAnamnese_AntecedentesPessoais_Alergias.Text));
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Alergias_Quais = Valida.TextoNull(txtAnamnese_AntecedentesPessoais_Alergias_Quais.Text);
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Internacoes = Convert.ToBoolean(Convert.ToInt32(rdoAnamnese_AntecedentesPessoais_Internacoes.Text));
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Internacoes_Quais = Valida.TextoNull(txtAnamnese_AntecedentesPessoais_Internacoes_Quais.Text);
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Cirugias = Convert.ToBoolean(Convert.ToInt32(rdoAnamnese_AntecedentesPessoais_Cirugias.Text));
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Cirugias_Quais = Valida.TextoNull(txtAnamnese_AntecedentesPessoais_Cirugias_Quais.Text);
                ObjProtuarioClinico.Anamnese_AntecedentesFamiliares_Diabetes = Convert.ToBoolean(Convert.ToInt32(rdoAnamnese_AntecedentesFamiliares_Diabetes.Text));
                ObjProtuarioClinico.Anamnese_AntecedentesFamiliares_HipertensaoArterial = Convert.ToBoolean(Convert.ToInt32(rdoAnamnese_AntecedentesFamiliares_HipertensaoArterial.Text));
                ObjProtuarioClinico.Anamnese_AntecedentesFamiliares_Tumores = Convert.ToBoolean(Convert.ToInt32(rdoAnamnese_AntecedentesFamiliares_Tumores.Text));
                ObjProtuarioClinico.Anamnese_AntecedentesObstetricos_Gestacoes = Convert.ToBoolean(Convert.ToInt32(rdoAnamnese_AntecedentesObstetricos_Gestacoes.Text));
                ObjProtuarioClinico.Anamnese_AntecedentesObstetricos_Gestacoes_Quantos = Valida.TextoNull(txtAnamnese_AntecedentesObstetricos_Gestacoes_Quantos.Text);
                ObjProtuarioClinico.Anamnese_AntecedentesObstetricos_Partos = Convert.ToBoolean(Convert.ToInt32(rdoAnamnese_AntecedentesObstetricos_Partos.Text));
                ObjProtuarioClinico.Anamnese_AntecedentesObstetricos_Partos_Quantos = Valida.TextoNull(txtAnamnese_AntecedentesObstetricos_Partos_Quantos.Text);
                ObjProtuarioClinico.Anamnese_AntecedentesObstetricos_Abortos = Convert.ToBoolean(Convert.ToInt32(rdoAnamnese_AntecedentesObstetricos_Abortos.Text));
                ObjProtuarioClinico.Anamnese_AntecedentesObstetricos_Abortos_Quantos = Valida.TextoNull(txtAnamnese_AntecedentesObstetricos_Abortos_Quantos.Text);
                ObjProtuarioClinico.Anamnese_AntecedentesObstetricos_DtMenstruacao = Valida.TextoNull(txtAnamnese_AntecedentesObstetricos_DtMenstruacao.Text);
                //Habitos
                ObjProtuarioClinico.Habitos_Fumante = Convert.ToBoolean(Convert.ToInt32(rdoHabitos_Fumante.Text));
                ObjProtuarioClinico.Habitos_Fumante_Qtd = Valida.TextoNull(txtHabitos_Fumante_Qtd.Text);
                ObjProtuarioClinico.Habitos_Fumante_Anos = Valida.TextoNull(txtHabitos_Fumante_Anos.Text);
                ObjProtuarioClinico.Habitos_Bebidas = Convert.ToBoolean(Convert.ToInt32(rdoHabitos_Bebidas.Text));
                ObjProtuarioClinico.Habitos_Bebidas_Qtd = Valida.TextoNull(txtHabitos_Bebidas_Qtd.Text);
                ObjProtuarioClinico.Habitos_Bebidas_Anos = Valida.TextoNull(txtHabitos_Bebidas_Anos.Text);
                ObjProtuarioClinico.Habitos_Exercicios = Convert.ToBoolean(Convert.ToInt32(rdoHabitos_Exercicios.Text));
                ObjProtuarioClinico.Habitos_Exercicios_Qtd = Valida.TextoNull(txtHabitos_Exercicios_Qtd.Text);
                //Antecedentes
                ObjProtuarioClinico.Antecedentes_Afastamento = Convert.ToBoolean(Convert.ToInt32(rdoAntecedentes_Afastamento.Text));
                ObjProtuarioClinico.Antecedentes_Afastamento_Qual = Valida.TextoNull(txtAntecedentes_Afastamento_Qual.Text);
                ObjProtuarioClinico.Antecedentes_Afastamento_Qtd_Dias = Valida.TextoNull(txtAntecedentes_Afastamento_Qtd_Dias.Text);
                ObjProtuarioClinico.Antecedentes_Afastamento_CAT = Valida.TextoNull(txtAntecedentes_Afastamento_CAT.Text);
                ObjProtuarioClinico.Antecedentes_Acidente = Convert.ToBoolean(Convert.ToInt32(rdoAntecedentes_Acidente.Text));
                ObjProtuarioClinico.Antecedentes_Acidente_Ano = Valida.TextoNull(txtAntecedentes_Acidente_Ano.Text);
                ObjProtuarioClinico.Antecedentes_Acidente_Qual = Valida.TextoNull(txtAntecedentes_Acidente_Qual.Text);
                ObjProtuarioClinico.Antecedentes_Doenca = Convert.ToBoolean(Convert.ToInt32(rdoAntecedentes_Doenca.Text));
                ObjProtuarioClinico.Antecedentes_Doenca_Qual = Valida.TextoNull(txtAntecedentes_Doenca_Qual.Text);
                ObjProtuarioClinico.Antecedentes_Doenca_Ano = Valida.TextoNull(txtAntecedentes_Doenca_Ano.Text);
                //ISDA
                ObjProtuarioClinico.ISDA_SistemaNervoso = Convert.ToBoolean(Convert.ToInt32(rdoISDA_SistemaNervoso.Text));
                ObjProtuarioClinico.ISDA_SistemaNervoso_Consideracoes = Valida.TextoNull(txtISDA_SistemaNervoso_Consideracoes.Text);
                ObjProtuarioClinico.ISDA_Visao = Convert.ToBoolean(Convert.ToInt32(rdoISDA_Visao.Text));
                ObjProtuarioClinico.ISDA_Visao_Consideracoes = Valida.TextoNull(txtISDA_Visao_Consideracoes.Text);
                ObjProtuarioClinico.ISDA_Audicao = Convert.ToBoolean(Convert.ToInt32(rdoISDA_Audicao.Text));
                ObjProtuarioClinico.ISDA_Audicao_Consideracoes = Valida.TextoNull(txtISDA_Audicao_Consideracoes.Text);
                ObjProtuarioClinico.ISDA_SistemaCardiovascular = Convert.ToBoolean(Convert.ToInt32(rdoISDA_SistemaCardiovascular.Text));
                ObjProtuarioClinico.ISDA_SistemaCardiovascular_Consideracoes = Valida.TextoNull(txtISDA_SistemaCardiovascular_Consideracoes.Text);
                ObjProtuarioClinico.ISDA_SistemaPulmonar = Convert.ToBoolean(Convert.ToInt32(rdoISDA_SistemaPulmonar.Text));
                ObjProtuarioClinico.ISDA_SistemaPulmonar_Consideracoes = Valida.TextoNull(txtISDA_SistemaPulmonar_Consideracoes.Text);
                ObjProtuarioClinico.ISDA_SistemaGastroIntestinal = Convert.ToBoolean(Convert.ToInt32(rdoISDA_SistemaGastroIntestinal.Text));
                ObjProtuarioClinico.ISDA_SistemaGastroIntestinal_Consideracoes = Valida.TextoNull(txtISDA_SistemaGastroIntestinal_Consideracoes.Text);
                ObjProtuarioClinico.ISDA_SistemaGenitoUrinario = Convert.ToBoolean(Convert.ToInt32(rdoISDA_SistemaGenitoUrinario.Text));
                ObjProtuarioClinico.ISDA_SistemaGenitoUrinario_Consideracoes = Valida.TextoNull(txtISDA_SistemaGenitoUrinario_Consideracoes.Text);
                ObjProtuarioClinico.ISDA_SistemaOsteomolecular = Convert.ToBoolean(Convert.ToInt32(rdoISDA_SistemaOsteomolecular.Text));
                ObjProtuarioClinico.ISDA_SistemaOsteomolecular_Consideracoes = Valida.TextoNull(txtISDA_SistemaOsteomolecular_Consideracoes.Text);
                ObjProtuarioClinico.ISDA_SistemaTegumentar = Convert.ToBoolean(Convert.ToInt32(rdoISDA_SistemaTegumentar.Text));
                ObjProtuarioClinico.ISDA_SistemaTegumentar_Consideracoes = Valida.TextoNull(txtISDA_SistemaTegumentar_Consideracoes.Text);
                ObjProtuarioClinico.ISDA_SistemaImunologico = Convert.ToBoolean(Convert.ToInt32(rdoISDA_SistemaImunologico.Text));
                ObjProtuarioClinico.ISDA_SistemaImunologico_Consideracoes = Valida.TextoNull(txtISDA_SistemaImunologico_Consideracoes.Text);
                //Exame Fisico
                ObjProtuarioClinico.ExameFisico_Peso = Valida.DecimalNull(txtExameFisico_Peso.Text);
                ObjProtuarioClinico.ExameFisico_Altura = Valida.DecimalNull(txtExameFisico_Altura.Text);
                ObjProtuarioClinico.ExameFisico_CabecaPescoco = Convert.ToBoolean(Convert.ToInt32(rdoExameFisico_CabecaPescoco.Text));
                ObjProtuarioClinico.ExameFisico_CabecaPescoco_Consideracoes = Valida.TextoNull(txtExameFisico_CabecaPescoco_Consideracoes.Text);
                ObjProtuarioClinico.ExameFisico_Visao = Valida.TextoNull(txtExameFisico_Visao.Text);
                ObjProtuarioClinico.ExameFisico_Cardiovascular = Convert.ToBoolean(Convert.ToInt32(rdoExameFisico_Cardiovascular.Text));
                ObjProtuarioClinico.ExameFisico_Cardiovascular_Consideracoes = Valida.TextoNull(txtExameFisico_Cardiovascular_Consideracoes.Text);
                ObjProtuarioClinico.ExameFisico_PA = Valida.TextoNull(txtExameFisico_PA.Text);
                ObjProtuarioClinico.ExameFisico_Pulso = Valida.TextoNull(txtExameFisico_Pulso.Text);
                ObjProtuarioClinico.ExameFisico_Respiratorio = Convert.ToBoolean(Convert.ToInt32(rdoExameFisico_Respiratorio.Text));
                ObjProtuarioClinico.ExameFisico_Respiratorio_Consideracoes = Valida.TextoNull(txtExameFisico_Respiratorio_Consideracoes.Text);
                ObjProtuarioClinico.ExameFisico_Abdomen = Convert.ToBoolean(Convert.ToInt32(rdoExameFisico_Abdomen.Text));
                ObjProtuarioClinico.ExameFisico_Abdomen_Consideracoes = Valida.TextoNull(txtExameFisico_Abdomen_Consideracoes.Text);
                ObjProtuarioClinico.ExameFisico_MembrosSuperiores = Convert.ToBoolean(Convert.ToInt32(rdoExameFisico_MembrosSuperiores.Text));
                ObjProtuarioClinico.ExameFisico_MembrosSuperiores_Consideracoes = Valida.TextoNull(txtExameFisico_MembrosSuperiores_Consideracoes.Text);
                ObjProtuarioClinico.ExameFisico_MembrosInferiores = Convert.ToBoolean(Convert.ToInt32(rdoExameFisico_MembrosInferiores.Text));
                ObjProtuarioClinico.ExameFisico_MembrosInferiores_Consideracoes = Valida.TextoNull(txtExameFisico_MembrosInferiores_Consideracoes.Text);
                //Exames complementares
                ObjProtuarioClinico.CID10_Primario = Valida.TextoNull(txtCID10_Primario.Text);
                ObjProtuarioClinico.CID10_Secundario_1 = Valida.TextoNull(txtCID10_Secundario_1.Text);
                ObjProtuarioClinico.CID10_Secundario_2 = Valida.TextoNull(txtCID10_Secundario_2.Text);

                ProntuarioClinicoBO ProntuarioClinicoBO = new ProntuarioClinicoBO();
                ProntuarioClinicoBO.SalvaDados(ObjProtuarioClinico);
            }
            catch (Exception ex)
            {
                Response.Write(ex);
                Response.End();
            }
            Response.Redirect("ProntuarioClinicoPrincipal.aspx");
        }
        else
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Entre com uma data')", true);
        }
    }
    //ASSIM QUE ENTRAR NA PÁGINA É CARREGADO O ULTIMO PRONTUARIO CLINICO DO FUNCIONARIO PARA AGILIZAR O PREENCHIMENTO
    private void CarregaUltimoProntuario(int idFuncionario)
    {
        try
        {
            //CHAMA FUNÇÃO QUE ESCREVE A DATA ATUAL NO TEXBOX DO FORMULARIO
            DataAtual();
            ProtuarioClinico ProtuarioClinico = new ProtuarioClinico();
            ProntuarioClinicoBO ProntuarioClinicoBO = new ProntuarioClinicoBO();
            ProtuarioClinico = ProntuarioClinicoBO.CarregaFuncionario(Convert.ToInt32(idFuncionario)) as ProtuarioClinico;
            if (ProtuarioClinico != null)
            {
                //Anamnese
                txtAnamnese_Historico.Text = ProtuarioClinico.Anamnese_Historico;
                rdoAnamnese_AntecedentesPessoais_Diabetes.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Anamnese_AntecedentesPessoais_Diabetes));
                rdoAnamnese_AntecedentesPessoais_HipertensaoArterial.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Anamnese_AntecedentesPessoais_HipertensaoArterial));
                rdoAnamnese_AntecedentesPessoais_Tumores.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Anamnese_AntecedentesPessoais_Tumores));
                txtAnamnese_AntecedentesPessoais_Tumores_CID10.Text = Convert.ToString(Convert.ToString(ProtuarioClinico.Anamnese_AntecedentesPessoais_Tumores_CID10));
                txtAnamnese_AntecedentesPessoais_Tumores_Ano.Text = Convert.ToString(Convert.ToString(ProtuarioClinico.Anamnese_AntecedentesPessoais_Tumores_Ano));
                txtAnamnese_AntecedentesPessoais_Tumores_Tratado.Text = Convert.ToString(ProtuarioClinico.Anamnese_AntecedentesPessoais_Tumores_Tratado);
                rdoAnamnese_AntecedentesPessoais_Alergias.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Anamnese_AntecedentesPessoais_Alergias));
                txtAnamnese_AntecedentesPessoais_Alergias_Quais.Text = ProtuarioClinico.Anamnese_AntecedentesPessoais_Alergias_Quais;
                rdoAnamnese_AntecedentesPessoais_Internacoes.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Anamnese_AntecedentesPessoais_Internacoes));
                txtAnamnese_AntecedentesPessoais_Internacoes_Quais.Text = ProtuarioClinico.Anamnese_AntecedentesPessoais_Internacoes_Quais;
                rdoAnamnese_AntecedentesPessoais_Cirugias.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Anamnese_AntecedentesPessoais_Cirugias));
                txtAnamnese_AntecedentesPessoais_Cirugias_Quais.Text = ProtuarioClinico.Anamnese_AntecedentesPessoais_Cirugias_Quais;
                rdoAnamnese_AntecedentesFamiliares_Diabetes.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Anamnese_AntecedentesFamiliares_Diabetes));
                rdoAnamnese_AntecedentesFamiliares_HipertensaoArterial.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Anamnese_AntecedentesFamiliares_HipertensaoArterial));
                rdoAnamnese_AntecedentesFamiliares_Tumores.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Anamnese_AntecedentesFamiliares_Tumores));
                rdoAnamnese_AntecedentesObstetricos_Gestacoes.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Anamnese_AntecedentesObstetricos_Gestacoes));
                txtAnamnese_AntecedentesObstetricos_Gestacoes_Quantos.Text = Convert.ToString(ProtuarioClinico.Anamnese_AntecedentesObstetricos_Gestacoes_Quantos);
                rdoAnamnese_AntecedentesObstetricos_Partos.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Anamnese_AntecedentesObstetricos_Partos));
                txtAnamnese_AntecedentesObstetricos_Partos_Quantos.Text = Convert.ToString(ProtuarioClinico.Anamnese_AntecedentesObstetricos_Partos_Quantos);
                rdoAnamnese_AntecedentesObstetricos_Abortos.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Anamnese_AntecedentesObstetricos_Abortos));
                txtAnamnese_AntecedentesObstetricos_Abortos_Quantos.Text = Convert.ToString(ProtuarioClinico.Anamnese_AntecedentesObstetricos_Abortos_Quantos);
                txtAnamnese_AntecedentesObstetricos_DtMenstruacao.Text = Convert.ToString(ProtuarioClinico.Anamnese_AntecedentesObstetricos_DtMenstruacao);
                //Habitos
                rdoHabitos_Fumante.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Habitos_Fumante));
                txtHabitos_Fumante_Qtd.Text = Convert.ToString(ProtuarioClinico.Habitos_Fumante_Qtd);
                txtHabitos_Fumante_Anos.Text = Convert.ToString(ProtuarioClinico.Habitos_Fumante_Anos);
                rdoHabitos_Bebidas.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Habitos_Bebidas));
                txtHabitos_Bebidas_Qtd.Text = Convert.ToString(ProtuarioClinico.Habitos_Bebidas_Qtd);
                txtHabitos_Bebidas_Anos.Text = Convert.ToString(ProtuarioClinico.Habitos_Bebidas_Anos);
                rdoHabitos_Exercicios.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Habitos_Exercicios));
                txtHabitos_Exercicios_Qtd.Text = Convert.ToString(ProtuarioClinico.Habitos_Exercicios_Qtd);
                //Antecedentes
                rdoAntecedentes_Afastamento.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Antecedentes_Afastamento));
                txtAntecedentes_Afastamento_Qual.Text = Convert.ToString(ProtuarioClinico.Antecedentes_Afastamento_Qual);
                txtAntecedentes_Afastamento_Qtd_Dias.Text = Convert.ToString(ProtuarioClinico.Antecedentes_Afastamento_Qtd_Dias);
                txtAntecedentes_Afastamento_CAT.Text = Convert.ToString(ProtuarioClinico.Antecedentes_Afastamento_CAT);
                rdoAntecedentes_Acidente.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Antecedentes_Acidente));
                txtAntecedentes_Acidente_Ano.Text = Convert.ToString(ProtuarioClinico.Antecedentes_Acidente_Ano);
                txtAntecedentes_Acidente_Qual.Text = Convert.ToString(ProtuarioClinico.Antecedentes_Acidente_Qual);
                rdoAntecedentes_Doenca.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.Antecedentes_Doenca));
                txtAntecedentes_Doenca_Qual.Text = Convert.ToString(ProtuarioClinico.Antecedentes_Doenca_Qual);
                txtAntecedentes_Doenca_Ano.Text = Convert.ToString(ProtuarioClinico.Antecedentes_Doenca_Ano);
                //ISDA
                rdoISDA_SistemaNervoso.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.ISDA_SistemaNervoso));
                txtISDA_SistemaNervoso_Consideracoes.Text = Convert.ToString(ProtuarioClinico.ISDA_SistemaNervoso_Consideracoes);
                rdoISDA_Visao.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.ISDA_Visao));
                txtISDA_Visao_Consideracoes.Text = Convert.ToString(ProtuarioClinico.ISDA_Visao_Consideracoes);
                rdoISDA_Audicao.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.ISDA_Audicao));
                txtISDA_Audicao_Consideracoes.Text = Convert.ToString(ProtuarioClinico.ISDA_Audicao_Consideracoes);
                rdoISDA_SistemaCardiovascular.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.ISDA_SistemaCardiovascular));
                txtISDA_SistemaCardiovascular_Consideracoes.Text = Convert.ToString(ProtuarioClinico.ISDA_SistemaCardiovascular_Consideracoes);
                rdoISDA_SistemaPulmonar.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.ISDA_SistemaPulmonar));
                txtISDA_SistemaPulmonar_Consideracoes.Text = Convert.ToString(ProtuarioClinico.ISDA_SistemaPulmonar_Consideracoes);
                rdoISDA_SistemaGastroIntestinal.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.ISDA_SistemaGastroIntestinal));
                txtISDA_SistemaGastroIntestinal_Consideracoes.Text = Convert.ToString(ProtuarioClinico.ISDA_SistemaGastroIntestinal_Consideracoes);
                rdoISDA_SistemaGenitoUrinario.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.ISDA_SistemaGenitoUrinario));
                txtISDA_SistemaGenitoUrinario_Consideracoes.Text = Convert.ToString(ProtuarioClinico.ISDA_SistemaGenitoUrinario_Consideracoes);
                rdoISDA_SistemaOsteomolecular.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.ISDA_SistemaOsteomolecular));
                txtISDA_SistemaOsteomolecular_Consideracoes.Text = Convert.ToString(ProtuarioClinico.ISDA_SistemaOsteomolecular_Consideracoes);
                rdoISDA_SistemaTegumentar.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.ISDA_SistemaTegumentar));
                txtISDA_SistemaTegumentar_Consideracoes.Text = Convert.ToString(ProtuarioClinico.ISDA_SistemaTegumentar_Consideracoes);
                rdoISDA_SistemaImunologico.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.ISDA_SistemaImunologico));
                txtISDA_SistemaImunologico_Consideracoes.Text = Convert.ToString(ProtuarioClinico.ISDA_SistemaImunologico_Consideracoes);
                //Exame Fisico
                txtExameFisico_Peso.Text = Convert.ToString(ProtuarioClinico.ExameFisico_Peso);
                txtExameFisico_Altura.Text = Convert.ToString(ProtuarioClinico.ExameFisico_Altura);
                rdoExameFisico_CabecaPescoco.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.ExameFisico_CabecaPescoco));
                txtExameFisico_CabecaPescoco_Consideracoes.Text = Convert.ToString(ProtuarioClinico.ExameFisico_CabecaPescoco_Consideracoes);
                txtExameFisico_Visao.Text = Convert.ToString(ProtuarioClinico.ExameFisico_Visao);
                rdoExameFisico_Cardiovascular.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.ExameFisico_Cardiovascular));
                txtExameFisico_Cardiovascular_Consideracoes.Text = Convert.ToString(ProtuarioClinico.ExameFisico_Cardiovascular_Consideracoes);
                txtExameFisico_PA.Text = Convert.ToString(ProtuarioClinico.ExameFisico_PA);
                txtExameFisico_Pulso.Text = Convert.ToString(ProtuarioClinico.ExameFisico_Pulso);
                rdoExameFisico_Respiratorio.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.ExameFisico_Respiratorio));
                txtExameFisico_Respiratorio_Consideracoes.Text = Convert.ToString(ProtuarioClinico.ExameFisico_Respiratorio_Consideracoes);
                rdoExameFisico_Abdomen.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.ExameFisico_Abdomen));
                txtExameFisico_Abdomen_Consideracoes.Text = Convert.ToString(ProtuarioClinico.ExameFisico_Abdomen_Consideracoes);
                rdoExameFisico_MembrosSuperiores.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.ExameFisico_MembrosSuperiores));
                txtExameFisico_MembrosSuperiores_Consideracoes.Text = Convert.ToString(ProtuarioClinico.ExameFisico_MembrosSuperiores_Consideracoes);
                rdoExameFisico_MembrosInferiores.Text = Convert.ToString(Convert.ToInt32(ProtuarioClinico.ExameFisico_MembrosInferiores));
                txtExameFisico_MembrosInferiores_Consideracoes.Text = Convert.ToString(ProtuarioClinico.ExameFisico_MembrosInferiores_Consideracoes);
                //Exames Complementares
                txtCID10_Primario.Text = Convert.ToString(ProtuarioClinico.CID10_Primario);
                txtCID10_Secundario_1.Text = Convert.ToString(ProtuarioClinico.CID10_Secundario_1);
                txtCID10_Secundario_2.Text = Convert.ToString(ProtuarioClinico.CID10_Secundario_2);

                //if (Convert.ToBoolean(Convert.ToInt32(rdoAnamnese_AntecedentesPessoais_Tumores.Text)))
                //{
                //    Page.ClientScript.RegisterStartupScript(GetType(), "OnLoad", "document.getElementById('Tbl_AntecedentesPessoais_Tumores_Cancer').style.visibility='visible'", true);
                //}
            }
        }
        catch (Exception erro)
        {
            Response.Write(erro);
            Response.End();
        }
    }

    public void DataAtual()
    {
        //MOSTRA A DATA ATUAL NO CAMPO DE DATA DO CADASTRO
        DateTime dtData = new DateTime();
        dtData = DateTime.Today;
        txtDataCadastro.Text = Convert.ToString(dtData).Replace("00:00:00", "");
    }
    //Pega o id do funcinario, função chamada no HTML no IFRAME
    public void PegaIdFuncionario()
    {
        Response.Write(Request.QueryString["idFuncionario"]);
    }

    //protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    //{
    //    Response.Write("<Script>parent.location='ProntuarioClinicoCadastro.aspx?idFuncionario=61'</Script>");
    //}
    protected void btnLimpar_Click(object sender, EventArgs e)
    {
        //Chama a função que apaga todos os campos do formulario
        ApagarTextBox(this);
    }
    private void ApagarTextBox(Control pai)
    {
        foreach (Control ctl in pai.Controls)
        {
            if (ctl is TextBox)
                ((TextBox)ctl).Text = string.Empty;
            else if (ctl is DropDownList)
                ((DropDownList)ctl).Text = string.Empty;
            else if (ctl is RadioButtonList)
                ((RadioButtonList)ctl).Text = "0";
            else if (ctl.Controls.Count > 0)
                ApagarTextBox(ctl);
        }
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        int id = Convert.ToInt32(GridView1.SelectedDataKey.Value);
        string idFuncionacio = GridView1.SelectedRow.Cells[1].Text;
        Page.ClientScript.RegisterStartupScript(GetType(), "", "window.open('ProntuarioClínicoVisualizar.aspx?id=" + id + "&idFuncionario=" + Request.QueryString["idFuncionario"] + "',null,'left=400, top=100, height=600, width=800, status=n o, resizable= no, scrollbars=yes, toolbar= no,location= no, menubar= no');", true);
    }
}
