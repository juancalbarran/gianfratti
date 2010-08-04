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

public partial class ProntuarioClinico_ProntuarioClínicoVisualizar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        FuncionarioDadosBasicos1.IdFuncionario = Convert.ToInt32(Request.QueryString["idFuncionario"]);

        ProtuarioClinico ObjProntuarioClinico = new ProtuarioClinico();
        ProntuarioClinicoDAL ObjProntuarioClinicoDAL = new ProntuarioClinicoDAL();
        ObjProntuarioClinico = ObjProntuarioClinicoDAL.SelectProntuarioClinicoVisualizarByID(Convert.ToInt32(Request.QueryString["id"]));
        //Data Cadastro - Consulta
        lblDataCadastro.Text = Convert.ToString(ObjProntuarioClinico.dtCadastro).Replace("00:00:00","");
        //Historico
        lblAnamnese_Historico.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_Historico);
        //Antecedentes Pessoais
        lblAnamnese_AntecedentesPessoais_Diabetes.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesFamiliares_Diabetes).Replace("False","Não").Replace("True","Sim");
        lblAnamnese_AntecedentesPessoais_HipertensaoArterial.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesFamiliares_HipertensaoArterial).Replace("False", "Não").Replace("True", "Sim");
        lblAnamnese_AntecedentesPessoais_Tumores.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesPessoais_Tumores).Replace("False", "Não").Replace("True", "Sim");
        lblAnamnese_AntecedentesPessoais_Tumores_CID10.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesPessoais_Tumores_CID10);
        lblAnamnese_AntecedentesPessoais_Tumores_Ano.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesPessoais_Tumores_Ano);
        lblAnamnese_AntecedentesPessoais_Tumores_Tratado.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesPessoais_Tumores_Tratado);
        lblAnamnese_AntecedentesPessoais_Alergias.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesPessoais_Alergias).Replace("False", "Não").Replace("True", "Sim");
        lblAnamnese_AntecedentesPessoais_Alergias_Quais.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesPessoais_Alergias_Quais);
        lblAnamnese_AntecedentesPessoais_Internacoes.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesPessoais_Internacoes).Replace("False", "Não").Replace("True", "Sim");
        lblAnamnese_AntecedentesPessoais_Internacoes_Quais.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesPessoais_Internacoes_Quais);
        lblAnamnese_AntecedentesPessoais_Cirugias.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesPessoais_Cirugias).Replace("False", "Não").Replace("True", "Sim");
        lblAnamnese_AntecedentesPessoais_Cirugias_Quais.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesPessoais_Cirugias_Quais);
        //Antecedentes Familiares
        lblAnamnese_AntecedentesFamiliares_Diabetes.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesFamiliares_Diabetes).Replace("False", "Não").Replace("True", "Sim");
        lblAnamnese_AntecedentesFamiliares_HipertensaoArterial.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesFamiliares_HipertensaoArterial).Replace("False", "Não").Replace("True", "Sim");
        lblAnamnese_AntecedentesFamiliares_Tumores.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesFamiliares_Tumores).Replace("False", "Não").Replace("True", "Sim");
        //Antecedentes Obstétricos
        lblAnamnese_AntecedentesObstetricos_Gestacoes.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesObstetricos_Gestacoes).Replace("False", "Não").Replace("True", "Sim");
        lblAnamnese_AntecedentesObstetricos_Gestacoes_Quantos.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesObstetricos_Gestacoes_Quantos);
        lblAnamnese_AntecedentesObstetricos_Partos.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesObstetricos_Partos).Replace("False", "Não").Replace("True", "Sim");
        lblAnamnese_AntecedentesObstetricos_Partos_Quantos.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesObstetricos_Partos_Quantos);
        lblAnamnese_AntecedentesObstetricos_Abortos.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesObstetricos_Abortos).Replace("False", "Não").Replace("True", "Sim");
        lblAnamnese_AntecedentesObstetricos_Abortos_Quantos.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesObstetricos_Abortos_Quantos);
        lblAnamnese_AntecedentesObstetricos_DtMenstruacao.Text = Convert.ToString(ObjProntuarioClinico.Anamnese_AntecedentesObstetricos_DtMenstruacao);
        //Hábitos
        lblHabitos_Fumante.Text = Convert.ToString(ObjProntuarioClinico.Habitos_Fumante).Replace("False", "Não").Replace("True", "Sim");
        lblHabitos_Fumante_Qtd.Text = Convert.ToString(ObjProntuarioClinico.Habitos_Fumante_Qtd);
        lblHabitos_Fumante_Anos.Text = Convert.ToString(ObjProntuarioClinico.Habitos_Fumante_Anos);
        lblHabitos_Bebidas.Text = Convert.ToString(ObjProntuarioClinico.Habitos_Bebidas).Replace("False", "Não").Replace("True", "Sim");
        lblHabitos_Bebidas_Qtd.Text = Convert.ToString(ObjProntuarioClinico.Habitos_Bebidas_Qtd);
        lblHabitos_Bebidas_Anos.Text = Convert.ToString(ObjProntuarioClinico.Habitos_Bebidas_Anos);
        lblHabitos_Exercicios.Text = Convert.ToString(ObjProntuarioClinico.Habitos_Exercicios).Replace("False", "Não").Replace("True", "Sim");
        lblHabitos_Exercicios_Qtd.Text = Convert.ToString(ObjProntuarioClinico.Habitos_Exercicios_Qtd);
        //Antecedentes
        lblAntecedentes_Afastamento.Text = Convert.ToString(ObjProntuarioClinico.Antecedentes_Afastamento).Replace("False", "Não").Replace("True", "Sim");
        lblAntecedentes_Afastamento_Qual.Text = Convert.ToString(ObjProntuarioClinico.Antecedentes_Afastamento_Qual);
        lblAntecedentes_Afastamento_Qtd_Dias.Text = Convert.ToString(ObjProntuarioClinico.Antecedentes_Afastamento_Qtd_Dias);
        lblAntecedentes_Afastamento_CAT.Text = Convert.ToString(ObjProntuarioClinico.Antecedentes_Afastamento_CAT);
        lblAntecedentes_Acidente.Text = Convert.ToString(ObjProntuarioClinico.Antecedentes_Acidente).Replace("False", "Não").Replace("True", "Sim");
        lblAntecedentes_Acidente_Qual.Text = Convert.ToString(ObjProntuarioClinico.Antecedentes_Acidente_Qual);
        lblAntecedentes_Acidente_Ano.Text = Convert.ToString(ObjProntuarioClinico.Antecedentes_Acidente_Ano);
        lblAntecedentes_Doenca.Text = Convert.ToString(ObjProntuarioClinico.Antecedentes_Doenca).Replace("False", "Não").Replace("True", "Sim");
        lblAntecedentes_Doenca_Qual.Text = Convert.ToString(ObjProntuarioClinico.Antecedentes_Doenca_Qual);
        lblAntecedentes_Doenca_Ano.Text = Convert.ToString(ObjProntuarioClinico.Antecedentes_Doenca_Ano);
        //I.S.D.A.
        lblISDA_SistemaNervoso.Text = Convert.ToString(ObjProntuarioClinico.ISDA_SistemaNervoso).Replace("False", "Sem alterações").Replace("True", "Alterado");
        lblISDA_SistemaNervoso_Consideracoes.Text = Convert.ToString(ObjProntuarioClinico.ISDA_SistemaNervoso_Consideracoes);
        lblISDA_Visao.Text = Convert.ToString(ObjProntuarioClinico.ISDA_Visao).Replace("False", "Sem alterações").Replace("True", "Alterado");
        lblISDA_Visao_Consideracoes.Text = Convert.ToString(ObjProntuarioClinico.ISDA_Visao_Consideracoes);
        lblISDA_Audicao.Text = Convert.ToString(ObjProntuarioClinico.ISDA_Audicao).Replace("False", "Sem alterações").Replace("True", "Alterado");
        lblISDA_Audicao_Consideracoes.Text = Convert.ToString(ObjProntuarioClinico.ISDA_Audicao_Consideracoes);
        lblISDA_SistemaCardiovascular.Text = Convert.ToString(ObjProntuarioClinico.ISDA_SistemaCardiovascular).Replace("Sem alterações", "Não").Replace("True", "Alterado");
        lblISDA_SistemaCardiovascular_Consideracoes.Text = Convert.ToString(ObjProntuarioClinico.ISDA_SistemaCardiovascular_Consideracoes);
        lblISDA_SistemaPulmonar.Text = Convert.ToString(ObjProntuarioClinico.ISDA_SistemaPulmonar).Replace("Sem alterações", "Não").Replace("True", "Alterado");
        lblISDA_SistemaPulmonar_Consideracoes.Text = Convert.ToString(ObjProntuarioClinico.ISDA_SistemaPulmonar_Consideracoes);
        lblISDA_SistemaGastroIntestinal.Text = Convert.ToString(ObjProntuarioClinico.ISDA_SistemaGastroIntestinal).Replace("Sem alterações", "Não").Replace("True", "Alterado");
        lblISDA_SistemaGastroIntestinal_Consideracoes.Text = Convert.ToString(ObjProntuarioClinico.ISDA_SistemaGastroIntestinal_Consideracoes);
        lblISDA_SistemaGenitoUrinario.Text = Convert.ToString(ObjProntuarioClinico.ISDA_SistemaGenitoUrinario).Replace("Sem alterações", "Não").Replace("True", "Alterado");
        lblISDA_SistemaGenitoUrinario_Consideracoes.Text = Convert.ToString(ObjProntuarioClinico.ISDA_SistemaGenitoUrinario_Consideracoes);
        lblISDA_SistemaOsteomolecular.Text = Convert.ToString(ObjProntuarioClinico.ISDA_SistemaOsteomolecular).Replace("Sem alterações", "Não").Replace("True", "Alterado");
        lblISDA_SistemaOsteomolecular_Consideracoes.Text = Convert.ToString(ObjProntuarioClinico.ISDA_SistemaOsteomolecular_Consideracoes);
        lblISDA_SistemaTegumentar.Text = Convert.ToString(ObjProntuarioClinico.ISDA_SistemaTegumentar).Replace("Sem alterações", "Não").Replace("True", "Alterado");
        lblISDA_SistemaTegumentar_Consideracoes.Text = Convert.ToString(ObjProntuarioClinico.ISDA_SistemaTegumentar_Consideracoes);
        lblISDA_SistemaImunologico.Text = Convert.ToString(ObjProntuarioClinico.ISDA_SistemaImunologico).Replace("Sem alterações", "Não").Replace("True", "Alterado");
        lblISDA_SistemaImunologico_Consideracoes.Text = Convert.ToString(ObjProntuarioClinico.ISDA_SistemaImunologico_Consideracoes);
        //Exame Físico
        lblExameFisico_Peso.Text = Convert.ToString(ObjProntuarioClinico.ExameFisico_Peso);
        lblExameFisico_Altura.Text = Convert.ToString(ObjProntuarioClinico.ExameFisico_Altura);
        lblExameFisico_CabecaPescoco.Text = Convert.ToString(ObjProntuarioClinico.ExameFisico_CabecaPescoco).Replace("Sem alterações", "Não").Replace("True", "Alterado");
        lblExameFisico_CabecaPescoco_Consideracoes.Text = Convert.ToString(ObjProntuarioClinico.ExameFisico_CabecaPescoco_Consideracoes);
        lblExameFisico_Visao.Text = Convert.ToString(ObjProntuarioClinico.ExameFisico_Visao);
        lblExameFisico_Cardiovascular.Text = lblISDA_SistemaTegumentar.Text = Convert.ToString(ObjProntuarioClinico.ExameFisico_Cardiovascular).Replace("Sem alterações", "Não").Replace("True", "Alterado");
        lblExameFisico_Cardiovascular_Consideracoes.Text = Convert.ToString(ObjProntuarioClinico.ExameFisico_Cardiovascular_Consideracoes);
        lblExameFisico_PA.Text = Convert.ToString(ObjProntuarioClinico.ExameFisico_PA);
        lblExameFisico_Pulso.Text = Convert.ToString(ObjProntuarioClinico.ExameFisico_Pulso);
        lblExameFisico_Respiratorio.Text = Convert.ToString(ObjProntuarioClinico.ExameFisico_Respiratorio).Replace("Sem alterações", "Não").Replace("True", "Alterado");
        lblExameFisico_Respiratorio_Consideracoes.Text = Convert.ToString(ObjProntuarioClinico.ExameFisico_Respiratorio_Consideracoes);
        lblExameFisico_Abdomen.Text = Convert.ToString(ObjProntuarioClinico.ExameFisico_Abdomen).Replace("Sem alterações", "Não").Replace("True", "Alterado");
        lblExameFisico_Abdomen_Consideracoes.Text = Convert.ToString(ObjProntuarioClinico.ExameFisico_Abdomen_Consideracoes);
        lblExameFisico_MembrosSuperiores.Text = Convert.ToString(ObjProntuarioClinico.ExameFisico_MembrosSuperiores).Replace("Sem alterações", "Não").Replace("True", "Alterado");
        lblExameFisico_MembrosSuperiores_Consideracoes.Text = Convert.ToString(ObjProntuarioClinico.ExameFisico_MembrosSuperiores_Consideracoes);
        lblExameFisico_MembrosInferiores.Text = Convert.ToString(ObjProntuarioClinico.ExameFisico_MembrosInferiores).Replace("Sem alterações", "Não").Replace("True", "Alterado");
        lblExameFisico_MembrosInferiores_Consideracoes.Text = Convert.ToString(ObjProntuarioClinico.ExameFisico_MembrosInferiores_Consideracoes);
        //Exames complementares
        
    }
}
