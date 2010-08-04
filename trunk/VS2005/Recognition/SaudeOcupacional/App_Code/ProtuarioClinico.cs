using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;

/// <summary>
/// Summary description for ProtuarioClinico
/// </summary>
public class ProtuarioClinico
{
    private int mid;
    private int midFuncionario;
    private DateTime mdtCadastro;
    //Anamnese
    private string mAnamnese_Historico;
    private bool mAnamnese_AntecedentesPessoais_Diabetes;
    private bool mAnamnese_AntecedentesPessoais_HipertensaoArterial;
    private bool mAnamnese_AntecedentesPessoais_Tumores;
    private string mAnamnese_AntecedentesPessoais_Tumores_CID10;
    private string mAnamnese_AntecedentesPessoais_Tumores_Ano;
    private string mAnamnese_AntecedentesPessoais_Tumores_Tratado;
    private bool mAnamnese_AntecedentesPessoais_Alergias;
    private string mAnamnese_AntecedentesPessoais_Alergias_Quais;
    private bool mAnamnese_AntecedentesPessoais_Internacoes;
    private string mAnamnese_AntecedentesPessoais_Internacoes_Quais;
    private bool mAnamnese_AntecedentesPessoais_Cirugias;
    private string mAnamnese_AntecedentesPessoais_Cirugias_Quais;
    private bool mAnamnese_AntecedentesFamiliares_Diabetes;
    private bool mAnamnese_AntecedentesFamiliares_HipertensaoArterial;
    private bool mAnamnese_AntecedentesFamiliares_Tumores;
    private bool mAnamnese_AntecedentesObstetricos_Gestacoes;
    private string mAnamnese_AntecedentesObstetricos_Gestacoes_Quantos;
    private bool mAnamnese_AntecedentesObstetricos_Partos;
    private string mAnamnese_AntecedentesObstetricos_Partos_Quantos;
    private bool mAnamnese_AntecedentesObstetricos_Abortos;
    private string mAnamnese_AntecedentesObstetricos_Abortos_Quantos;
    private string mAnamnese_AntecedentesObstetricos_DtMenstruacao;
    //Habitos
    private bool mHabitos_Fumante;
    private string mHabitos_Fumante_Qtd;
    private string mHabitos_Fumante_Anos;
    private bool mHabitos_Bebidas;
    private string mHabitos_Bebidas_Qtd;
    private string mHabitos_Bebidas_Anos;
    private bool mHabitos_Exercicios;
    private string mHabitos_Exercicios_Qtd;
    //Antecedentes
    private bool mAntecedentes_Afastamento;
    private string mAntecedentes_Afastamento_Qual;
    private string mAntecedentes_Afastamento_Qtd_Dias;
    private string mAntecedentes_Afastamento_CAT;
    private bool mAntecedentes_Acidente;
    private string mAntecedentes_Acidente_Ano;
    private string mAntecedentes_Acidente_Qual;
    private bool mAntecedentes_Doenca;
    private string mAntecedentes_Doenca_Qual;
    private string mAntecedentes_Doenca_Ano;
    //ISDA
    private bool mISDA_SistemaNervoso;
    private string mISDA_SistemaNervoso_Consideracoes;
    private bool mISDA_Visao;
    private string mISDA_Visao_Consideracoes;
    private bool mISDA_Audicao;
    private string mISDA_Audicao_Consideracoes;
    private bool mISDA_SistemaCardiovascular;
    private string mISDA_SistemaCardiovascular_Consideracoes;
    private bool mISDA_SistemaPulmonar;
    private string mISDA_SistemaPulmonar_Consideracoes;
    private bool mISDA_SistemaGastroIntestinal;
    private string mISDA_SistemaGastroIntestinal_Consideracoes;
    private bool mISDA_SistemaGenitoUrinario;
    private string mISDA_SistemaGenitoUrinario_Consideracoes;
    private bool mISDA_SistemaOsteomolecular;
    private string mISDA_SistemaOsteomolecular_Consideracoes;
    private bool mISDA_SistemaTegumentar;
    private string mISDA_SistemaTegumentar_Consideracoes;
    private bool mISDA_SistemaImunologico;
    private string mISDA_SistemaImunologico_Consideracoes;
    //Exame Fisico
    private decimal mExameFisico_Peso;
    private decimal  mExameFisico_Altura;
    private bool mExameFisico_CabecaPescoco;
    private string mExameFisico_CabecaPescoco_Consideracoes;
    private string mExameFisico_Visao;
    private bool mExameFisico_Cardiovascular;
    private string mExameFisico_Cardiovascular_Consideracoes;
    private string mExameFisico_PA;
    private string mExameFisico_Pulso;
    private bool mExameFisico_Respiratorio;
    private string mExameFisico_Respiratorio_Consideracoes;
    private bool mExameFisico_Abdomen;
    private string mExameFisico_Abdomen_Consideracoes;
    private bool mExameFisico_MembrosSuperiores;
    private string mExameFisico_MembrosSuperiores_Consideracoes;
    private bool mExameFisico_MembrosInferiores;
    private string mExameFisico_MembrosInferiores_Consideracoes;
    //Exames Complementares
    private string mCID10_Primario;
    private string mCID10_Secundario_1;
    private string mCID10_Secundario_2;
    
	public ProtuarioClinico()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public int id
    {
        get { return mid; }
        set { mid = value; }
    }
    public int idFuncionario
    {
        get { return midFuncionario; }
        set { midFuncionario = value; }
    }
    public DateTime dtCadastro
    {
        get { return mdtCadastro; }
        set { mdtCadastro = value; }
    }
    //Anamnese
    public string Anamnese_Historico
    {
        get { return mAnamnese_Historico; }
        set { mAnamnese_Historico = value; }
    }
    public bool Anamnese_AntecedentesPessoais_Diabetes
    {
        get { return mAnamnese_AntecedentesPessoais_Diabetes; }
        set { mAnamnese_AntecedentesPessoais_Diabetes = value; }
    }
    public bool Anamnese_AntecedentesPessoais_HipertensaoArterial
    {
        get { return mAnamnese_AntecedentesPessoais_HipertensaoArterial; }
        set { mAnamnese_AntecedentesPessoais_HipertensaoArterial = value; }
    }
    public bool Anamnese_AntecedentesPessoais_Tumores
    {
        get { return mAnamnese_AntecedentesPessoais_Tumores; }
        set { mAnamnese_AntecedentesPessoais_Tumores = value; }
    }
    public string Anamnese_AntecedentesPessoais_Tumores_CID10
    {
        get { return mAnamnese_AntecedentesPessoais_Tumores_CID10; }
        set { mAnamnese_AntecedentesPessoais_Tumores_CID10 = value; }
    }
    public string Anamnese_AntecedentesPessoais_Tumores_Ano
    {
        get { return mAnamnese_AntecedentesPessoais_Tumores_Ano; }
        set { mAnamnese_AntecedentesPessoais_Tumores_Ano = value; }
    }
    public string Anamnese_AntecedentesPessoais_Tumores_Tratado
    {
        get { return mAnamnese_AntecedentesPessoais_Tumores_Tratado; }
        set { mAnamnese_AntecedentesPessoais_Tumores_Tratado = value; }
    }
    public bool Anamnese_AntecedentesPessoais_Alergias
    {
        get { return mAnamnese_AntecedentesPessoais_Alergias; }
        set { mAnamnese_AntecedentesPessoais_Alergias = value; }
    }
    public string Anamnese_AntecedentesPessoais_Alergias_Quais
    {
        get { return mAnamnese_AntecedentesPessoais_Alergias_Quais; }
        set { mAnamnese_AntecedentesPessoais_Alergias_Quais = value; }
    }
    public bool Anamnese_AntecedentesPessoais_Internacoes
    {
        get { return mAnamnese_AntecedentesPessoais_Internacoes; }
        set { mAnamnese_AntecedentesPessoais_Internacoes = value; }
    }
    public string Anamnese_AntecedentesPessoais_Internacoes_Quais
    {
        get { return mAnamnese_AntecedentesPessoais_Internacoes_Quais; }
        set { mAnamnese_AntecedentesPessoais_Internacoes_Quais = value; }
    }
    public bool Anamnese_AntecedentesPessoais_Cirugias
    {
        get { return mAnamnese_AntecedentesPessoais_Cirugias; }
        set { mAnamnese_AntecedentesPessoais_Cirugias = value; }
    }
    public string Anamnese_AntecedentesPessoais_Cirugias_Quais
    {
        get { return mAnamnese_AntecedentesPessoais_Cirugias_Quais; }
        set { mAnamnese_AntecedentesPessoais_Cirugias_Quais = value; }
    }
    public bool Anamnese_AntecedentesFamiliares_Diabetes
    {
        get { return mAnamnese_AntecedentesFamiliares_Diabetes; }
        set { mAnamnese_AntecedentesFamiliares_Diabetes = value; }
    }
    public bool Anamnese_AntecedentesFamiliares_HipertensaoArterial
    {
        get { return mAnamnese_AntecedentesFamiliares_HipertensaoArterial; }
        set { mAnamnese_AntecedentesFamiliares_HipertensaoArterial = value; }
    }
    public bool Anamnese_AntecedentesFamiliares_Tumores
    {
        get { return mAnamnese_AntecedentesFamiliares_Tumores; }
        set { mAnamnese_AntecedentesFamiliares_Tumores = value; }
    }
    public bool Anamnese_AntecedentesObstetricos_Gestacoes
    {
        get { return mAnamnese_AntecedentesObstetricos_Gestacoes; }
        set { mAnamnese_AntecedentesObstetricos_Gestacoes = value; }
    }
    public string Anamnese_AntecedentesObstetricos_Gestacoes_Quantos
    {
        get { return mAnamnese_AntecedentesObstetricos_Gestacoes_Quantos; }
        set { mAnamnese_AntecedentesObstetricos_Gestacoes_Quantos = value; }
    }
    public bool Anamnese_AntecedentesObstetricos_Partos
    {
        get { return mAnamnese_AntecedentesObstetricos_Partos; }
        set { mAnamnese_AntecedentesObstetricos_Partos = value; }
    }
    public string Anamnese_AntecedentesObstetricos_Partos_Quantos
    {
        get { return mAnamnese_AntecedentesObstetricos_Partos_Quantos; }
        set { mAnamnese_AntecedentesObstetricos_Partos_Quantos = value; }
    }
    public bool Anamnese_AntecedentesObstetricos_Abortos
    {
        get { return mAnamnese_AntecedentesObstetricos_Abortos; }
        set { mAnamnese_AntecedentesObstetricos_Abortos = value; }
    }
    public string Anamnese_AntecedentesObstetricos_Abortos_Quantos
    {
        get { return mAnamnese_AntecedentesObstetricos_Abortos_Quantos; }
        set { mAnamnese_AntecedentesObstetricos_Abortos_Quantos = value; }
    }
    public string Anamnese_AntecedentesObstetricos_DtMenstruacao
    {
        get { return mAnamnese_AntecedentesObstetricos_DtMenstruacao; }
        set { mAnamnese_AntecedentesObstetricos_DtMenstruacao = value; }
    }
    //Habitos_Fumante
    public bool Habitos_Fumante
    {
        get { return mHabitos_Fumante; }
        set { mHabitos_Fumante = value; }
    }
    public string Habitos_Fumante_Qtd
    {
        get { return mHabitos_Fumante_Qtd; }
        set { mHabitos_Fumante_Qtd = value; }
    }
    public string Habitos_Fumante_Anos
    {
        get { return mHabitos_Fumante_Anos; }
        set { mHabitos_Fumante_Anos = value; }
    }
    public bool Habitos_Bebidas
    {
        get { return mHabitos_Bebidas; }
        set { mHabitos_Bebidas = value; }
    }
    public string Habitos_Bebidas_Qtd
    {
        get { return mHabitos_Bebidas_Qtd; }
        set { mHabitos_Bebidas_Qtd = value; }
    }
    public string Habitos_Bebidas_Anos
    {
        get { return mHabitos_Bebidas_Anos; }
        set { mHabitos_Bebidas_Anos = value; }
    }
    public bool Habitos_Exercicios
    {
        get { return mHabitos_Exercicios; }
        set { mHabitos_Exercicios = value; }
    }
    public string Habitos_Exercicios_Qtd
    {
        get { return mHabitos_Exercicios_Qtd; }
        set { mHabitos_Exercicios_Qtd = value; }
    }
    //Antecedentes
    public bool Antecedentes_Afastamento
    {
        get { return mAntecedentes_Afastamento; }
        set { mAntecedentes_Afastamento = value; }
    }
    public string Antecedentes_Afastamento_Qual
    {
        get { return mAntecedentes_Afastamento_Qual; }
        set { mAntecedentes_Afastamento_Qual = value; }
    }
    public string Antecedentes_Afastamento_Qtd_Dias
    {
        get { return mAntecedentes_Afastamento_Qtd_Dias; }
        set { mAntecedentes_Afastamento_Qtd_Dias = value; }
    }
    public string Antecedentes_Afastamento_CAT
    {
        get { return mAntecedentes_Afastamento_CAT; }
        set { mAntecedentes_Afastamento_CAT = value; }
    }
    public bool Antecedentes_Acidente
    {
        get { return mAntecedentes_Acidente; }
        set { mAntecedentes_Acidente = value; }
    }
    public string Antecedentes_Acidente_Ano
    {
        get { return mAntecedentes_Acidente_Ano; }
        set { mAntecedentes_Acidente_Ano = value; }
    }
    public string Antecedentes_Acidente_Qual
    {
        get { return mAntecedentes_Acidente_Qual; }
        set { mAntecedentes_Acidente_Qual = value; }
    }
    public bool Antecedentes_Doenca
    {
        get { return mAntecedentes_Doenca; }
        set { mAntecedentes_Doenca = value; }
    }
    public string Antecedentes_Doenca_Qual
    {
        get { return mAntecedentes_Doenca_Qual; }
        set { mAntecedentes_Doenca_Qual = value; }
    }
    public string Antecedentes_Doenca_Ano
    {
        get { return mAntecedentes_Doenca_Ano; }
        set { mAntecedentes_Doenca_Ano = value; }
    }
    //ISDA
    public bool ISDA_SistemaNervoso
    {
        get { return mISDA_SistemaNervoso; }
        set { mISDA_SistemaNervoso = value; }
    }
    public string ISDA_SistemaNervoso_Consideracoes
    {
        get { return mISDA_SistemaNervoso_Consideracoes; }
        set { mISDA_SistemaNervoso_Consideracoes = value; }
    }
    public bool ISDA_Visao
    {
        get { return mISDA_Visao; }
        set { mISDA_Visao = value; }
    }
    public string ISDA_Visao_Consideracoes
    {
        get { return mISDA_Visao_Consideracoes; }
        set { mISDA_Visao_Consideracoes = value; }
    }
    public bool ISDA_Audicao
    {
        get { return mISDA_Audicao; }
        set { mISDA_Audicao = value; }
    }
    public string ISDA_Audicao_Consideracoes
    {
        get { return mISDA_Audicao_Consideracoes; }
        set { mISDA_Audicao_Consideracoes = value; }
    }
    public bool ISDA_SistemaCardiovascular
    {
        get { return mISDA_SistemaCardiovascular; }
        set { mISDA_SistemaCardiovascular = value; }
    }
    public string ISDA_SistemaCardiovascular_Consideracoes
    {
        get { return mISDA_SistemaCardiovascular_Consideracoes; }
        set { mISDA_SistemaCardiovascular_Consideracoes = value; }
    }
    public bool ISDA_SistemaPulmonar
    {
        get { return mISDA_SistemaPulmonar; }
        set { mISDA_SistemaPulmonar = value; }
    }
    public string ISDA_SistemaPulmonar_Consideracoes
    {
        get { return mISDA_SistemaPulmonar_Consideracoes; }
        set { mISDA_SistemaPulmonar_Consideracoes = value; }
    }
    public bool ISDA_SistemaGastroIntestinal
    {
        get { return mISDA_SistemaGastroIntestinal; }
        set { mISDA_SistemaGastroIntestinal = value; }
    }
    public string ISDA_SistemaGastroIntestinal_Consideracoes
    {
        get { return mISDA_SistemaGastroIntestinal_Consideracoes; }
        set { mISDA_SistemaGastroIntestinal_Consideracoes = value; }
    }
    public bool ISDA_SistemaGenitoUrinario
    {
        get { return mISDA_SistemaGenitoUrinario; }
        set { mISDA_SistemaGenitoUrinario = value; }
    }
    public string ISDA_SistemaGenitoUrinario_Consideracoes
    {
        get { return mISDA_SistemaGenitoUrinario_Consideracoes; }
        set { mISDA_SistemaGenitoUrinario_Consideracoes = value; }
    }
    public bool ISDA_SistemaOsteomolecular
    {
        get { return mISDA_SistemaOsteomolecular; }
        set { mISDA_SistemaOsteomolecular = value; }
    }
    public string ISDA_SistemaOsteomolecular_Consideracoes
    {
        get { return mISDA_SistemaOsteomolecular_Consideracoes; }
        set { mISDA_SistemaOsteomolecular_Consideracoes = value; }
    }
    public bool ISDA_SistemaTegumentar
    {
        get { return mISDA_SistemaTegumentar; }
        set { mISDA_SistemaTegumentar = value; }
    }
    public string ISDA_SistemaTegumentar_Consideracoes
    {
        get { return mISDA_SistemaTegumentar_Consideracoes; }
        set { mISDA_SistemaTegumentar_Consideracoes = value; }
    }
    public bool ISDA_SistemaImunologico
    {
        get { return mISDA_SistemaImunologico; }
        set { mISDA_SistemaImunologico = value; }
    }
    public string ISDA_SistemaImunologico_Consideracoes
    {
        get { return mISDA_SistemaImunologico_Consideracoes; }
        set { mISDA_SistemaImunologico_Consideracoes = value; }
    }
    //Exame Fisico
    public decimal ExameFisico_Peso
    {
        get { return mExameFisico_Peso; }
        set { mExameFisico_Peso = value; }
    }
    public decimal ExameFisico_Altura
    {
        get { return mExameFisico_Altura; }
        set { mExameFisico_Altura = value; }
    }
    public bool ExameFisico_CabecaPescoco
    {
        get { return mExameFisico_CabecaPescoco; }
        set { mExameFisico_CabecaPescoco = value; }
    }
    public string ExameFisico_CabecaPescoco_Consideracoes
    {
        get { return mExameFisico_CabecaPescoco_Consideracoes; }
        set { mExameFisico_CabecaPescoco_Consideracoes = value; }
    }
    public string ExameFisico_Visao
    {
        get { return mExameFisico_Visao; }
        set { mExameFisico_Visao = value; }
    }
    public bool ExameFisico_Cardiovascular
    {
        get { return mExameFisico_Cardiovascular; }
        set { mExameFisico_Cardiovascular = value; }
    }
    public string ExameFisico_Cardiovascular_Consideracoes
    {
        get { return mExameFisico_Cardiovascular_Consideracoes; }
        set { mExameFisico_Cardiovascular_Consideracoes = value; }
    }
    public string ExameFisico_PA
    {
        get { return mExameFisico_PA; }
        set { mExameFisico_PA = value; }
    }
    public string ExameFisico_Pulso
    {
        get { return mExameFisico_Pulso; }
        set { mExameFisico_Pulso = value; }
    }
    public bool ExameFisico_Respiratorio
    {
        get { return mExameFisico_Respiratorio; }
        set { mExameFisico_Respiratorio = value; }
    }
    public string ExameFisico_Respiratorio_Consideracoes
    {
        get { return mExameFisico_Respiratorio_Consideracoes; }
        set { mExameFisico_Respiratorio_Consideracoes = value; }
    }
    public bool ExameFisico_Abdomen
    {
        get { return mExameFisico_Abdomen; }
        set { mExameFisico_Abdomen = value; }
    }
    public string ExameFisico_Abdomen_Consideracoes
    {
        get { return mExameFisico_Abdomen_Consideracoes; }
        set { mExameFisico_Abdomen_Consideracoes = value; }
    }
    public bool ExameFisico_MembrosSuperiores
    {
        get { return mExameFisico_MembrosSuperiores; }
        set { mExameFisico_MembrosSuperiores = value; }
    }
    public string ExameFisico_MembrosSuperiores_Consideracoes
    {
        get { return mExameFisico_MembrosSuperiores_Consideracoes; }
        set { mExameFisico_MembrosSuperiores_Consideracoes = value; }
    }
    public bool ExameFisico_MembrosInferiores
    {
        get { return mExameFisico_MembrosInferiores; }
        set { mExameFisico_MembrosInferiores = value; }
    }
    public string ExameFisico_MembrosInferiores_Consideracoes
    {
        get { return mExameFisico_MembrosInferiores_Consideracoes; }
        set { mExameFisico_MembrosInferiores_Consideracoes = value; }
    }
    //Exames Complementares
    public string CID10_Primario
    {
        get { return mCID10_Primario; }
        set { mCID10_Primario = value; }
    }
    public string CID10_Secundario_1
    {
        get { return mCID10_Secundario_1; }
        set { mCID10_Secundario_1 = value; }
    }
    public string CID10_Secundario_2
    {
        get { return mCID10_Secundario_2; }
        set { mCID10_Secundario_2 = value; }
    }
}
