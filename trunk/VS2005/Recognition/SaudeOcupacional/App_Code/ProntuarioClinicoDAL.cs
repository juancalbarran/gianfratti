using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Sql;
using System.Data.Common;

/// <summary>
/// Summary description for ProntuarioClinicoDAO
/// </summary>
public class ProntuarioClinicoDAL
{
    ProtuarioClinico ObjProntuario;

	public ProntuarioClinicoDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    //INSERE UM NOVO REGISTRO.
    public void InsertProntuarioClinico(object ObjPacote)
    {
        try
        {
            ObjProntuario = ObjPacote as ProtuarioClinico;
            Validacoes Valida = new Validacoes();
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetStoredProcCommand("[ProntuarioClinicoInsert]");

            db.AddInParameter(command, "@idFuncionario", DbType.Int32, ObjProntuario.idFuncionario);
            db.AddInParameter(command, "@dtCadastro", DbType.DateTime, ObjProntuario.dtCadastro);
            //Anamnese
            db.AddInParameter(command, "@Anamnese_Historico", DbType.String, ObjProntuario.Anamnese_Historico);
            db.AddInParameter(command, "@Anamnese_AntecedentesPessoais_Diabetes", DbType.Boolean, ObjProntuario.Anamnese_AntecedentesPessoais_Diabetes);
            db.AddInParameter(command, "@Anamnese_AntecedentesPessoais_HipertensaoArterial", DbType.Boolean, ObjProntuario.Anamnese_AntecedentesPessoais_HipertensaoArterial);
            db.AddInParameter(command, "@Anamnese_AntecedentesPessoais_Tumores", DbType.Boolean, ObjProntuario.Anamnese_AntecedentesPessoais_Tumores);
            db.AddInParameter(command, "@Anamnese_AntecedentesPessoais_Tumores_CID10", DbType.String, ObjProntuario.Anamnese_AntecedentesPessoais_Tumores_CID10);
            db.AddInParameter(command, "@Anamnese_AntecedentesPessoais_Tumores_Ano", DbType.String, ObjProntuario.Anamnese_AntecedentesPessoais_Tumores_Ano);
            db.AddInParameter(command, "@Anamnese_AntecedentesPessoais_Tumores_Tratado", DbType.String, ObjProntuario.Anamnese_AntecedentesPessoais_Tumores_Tratado);
            db.AddInParameter(command, "@Anamnese_AntecedentesPessoais_Alergias", DbType.Boolean, ObjProntuario.Anamnese_AntecedentesPessoais_Alergias);
            db.AddInParameter(command, "@Anamnese_AntecedentesPessoais_Alergias_Quais", DbType.String, ObjProntuario.Anamnese_AntecedentesPessoais_Alergias_Quais);
            db.AddInParameter(command, "@Anamnese_AntecedentesPessoais_Internacoes", DbType.Boolean, ObjProntuario.Anamnese_AntecedentesPessoais_Internacoes);
            db.AddInParameter(command, "@Anamnese_AntecedentesPessoais_Internacoes_Quais", DbType.String, ObjProntuario.Anamnese_AntecedentesPessoais_Internacoes_Quais);
            db.AddInParameter(command, "@Anamnese_AntecedentesPessoais_Cirugias", DbType.Boolean, ObjProntuario.Anamnese_AntecedentesPessoais_Cirugias);
            db.AddInParameter(command, "@Anamnese_AntecedentesPessoais_Cirugias_Quais", DbType.String, ObjProntuario.Anamnese_AntecedentesPessoais_Cirugias_Quais);
            db.AddInParameter(command, "@Anamnese_AntecedentesFamiliares_Diabetes", DbType.Boolean, ObjProntuario.Anamnese_AntecedentesFamiliares_Diabetes);
            db.AddInParameter(command, "@Anamnese_AntecedentesFamiliares_HipertensaoArterial", DbType.Boolean, ObjProntuario.Anamnese_AntecedentesFamiliares_HipertensaoArterial);
            db.AddInParameter(command, "@Anamnese_AntecedentesFamiliares_Tumores", DbType.Boolean, ObjProntuario.Anamnese_AntecedentesFamiliares_Tumores);
            db.AddInParameter(command, "@Anamnese_AntecedentesObstetricos_Gestacoes", DbType.Boolean, ObjProntuario.Anamnese_AntecedentesObstetricos_Gestacoes);
            db.AddInParameter(command, "@Anamnese_AntecedentesObstetricos_Gestacoes_Quantos", DbType.String, ObjProntuario.Anamnese_AntecedentesObstetricos_Gestacoes_Quantos);
            db.AddInParameter(command, "@Anamnese_AntecedentesObstetricos_Partos", DbType.Boolean, ObjProntuario.Anamnese_AntecedentesObstetricos_Partos);
            db.AddInParameter(command, "@Anamnese_AntecedentesObstetricos_Partos_Quantos", DbType.String, ObjProntuario.Anamnese_AntecedentesObstetricos_Partos_Quantos);
            db.AddInParameter(command, "@Anamnese_AntecedentesObstetricos_Abortos", DbType.Boolean, ObjProntuario.Anamnese_AntecedentesObstetricos_Abortos);
            db.AddInParameter(command, "@Anamnese_AntecedentesObstetricos_Abortos_Quantos", DbType.String, ObjProntuario.Anamnese_AntecedentesObstetricos_Abortos_Quantos);
            db.AddInParameter(command, "@Anamnese_AntecedentesObstetricos_DtMenstruacao", DbType.String, Valida.TextoNull(ObjProntuario.Anamnese_AntecedentesObstetricos_DtMenstruacao));
            //Habitos
            db.AddInParameter(command, "@Habitos_Fumante", DbType.Boolean, ObjProntuario.Habitos_Fumante);
            db.AddInParameter(command, "@Habitos_Fumante_Qtd", DbType.String, ObjProntuario.Habitos_Fumante_Qtd);
            db.AddInParameter(command, "@Habitos_Fumante_Anos", DbType.String, ObjProntuario.Habitos_Fumante_Anos);
            db.AddInParameter(command, "@Habitos_Bebidas", DbType.Boolean, ObjProntuario.Habitos_Bebidas);
            db.AddInParameter(command, "@Habitos_Bebidas_Qtd", DbType.String, ObjProntuario.Habitos_Bebidas_Qtd);
            db.AddInParameter(command, "@Habitos_Bebidas_Anos", DbType.String, ObjProntuario.Habitos_Bebidas_Anos);
            db.AddInParameter(command, "@Habitos_Exercicios", DbType.Boolean, ObjProntuario.Habitos_Exercicios);
            db.AddInParameter(command, "@Habitos_Exercicios_Qtd", DbType.String, ObjProntuario.Habitos_Exercicios_Qtd);
            //Antecedentes
            db.AddInParameter(command, "@Antecedentes_Afastamento", DbType.Boolean, ObjProntuario.Antecedentes_Afastamento);
            db.AddInParameter(command, "@Antecedentes_Afastamento_Qual", DbType.String, ObjProntuario.Antecedentes_Afastamento_Qual);
            db.AddInParameter(command, "@Antecedentes_Afastamento_Qtd_Dias", DbType.String, ObjProntuario.Antecedentes_Afastamento_Qtd_Dias);
            db.AddInParameter(command, "@Antecedentes_Afastamento_CAT", DbType.String, ObjProntuario.Antecedentes_Afastamento_CAT);
            db.AddInParameter(command, "@Antecedentes_Acidente", DbType.Boolean, ObjProntuario.Antecedentes_Acidente);
            db.AddInParameter(command, "@Antecedentes_Acidente_Ano", DbType.String, ObjProntuario.Antecedentes_Acidente_Ano);
            db.AddInParameter(command, "@Antecedentes_Acidente_Qual", DbType.String, ObjProntuario.Antecedentes_Acidente_Qual);
            db.AddInParameter(command, "@Antecedentes_Doenca", DbType.Boolean, ObjProntuario.Antecedentes_Doenca);
            db.AddInParameter(command, "@Antecedentes_Doenca_Qual", DbType.String, ObjProntuario.Antecedentes_Doenca_Qual);
            db.AddInParameter(command, "@Antecedentes_Doenca_Ano", DbType.String, ObjProntuario.Antecedentes_Doenca_Ano);
            //ISDA
            db.AddInParameter(command, "@ISDA_SistemaNervoso", DbType.Boolean, ObjProntuario.ISDA_SistemaNervoso);
            db.AddInParameter(command, "@ISDA_SistemaNervoso_Consideracoes", DbType.String, ObjProntuario.ISDA_SistemaNervoso_Consideracoes);
            db.AddInParameter(command, "@ISDA_Visao", DbType.Boolean, ObjProntuario.ISDA_Visao);
            db.AddInParameter(command, "@ISDA_Visao_Consideracoes", DbType.String, ObjProntuario.ISDA_Visao_Consideracoes);
            db.AddInParameter(command, "@ISDA_Audicao", DbType.Boolean, ObjProntuario.ISDA_Audicao);
            db.AddInParameter(command, "@ISDA_Audicao_Consideracoes", DbType.String, ObjProntuario.ISDA_Audicao_Consideracoes);
            db.AddInParameter(command, "@ISDA_SistemaCardiovascular", DbType.Boolean, ObjProntuario.ISDA_SistemaCardiovascular);
            db.AddInParameter(command, "@ISDA_SistemaCardiovascular_Consideracoes", DbType.String, ObjProntuario.ISDA_SistemaCardiovascular_Consideracoes);
            db.AddInParameter(command, "@ISDA_SistemaPulmonar", DbType.Boolean, ObjProntuario.ISDA_SistemaPulmonar);
            db.AddInParameter(command, "@ISDA_SistemaPulmonar_Consideracoes", DbType.String, ObjProntuario.ISDA_SistemaPulmonar_Consideracoes);
            db.AddInParameter(command, "@ISDA_SistemaGastroIntestinal", DbType.Boolean, ObjProntuario.ISDA_SistemaGastroIntestinal);
            db.AddInParameter(command, "@ISDA_SistemaGastroIntestinal_Consideracoes", DbType.String, ObjProntuario.ISDA_SistemaGastroIntestinal_Consideracoes);
            db.AddInParameter(command, "@ISDA_SistemaGenitoUrinario", DbType.Boolean, ObjProntuario.ISDA_SistemaGenitoUrinario);
            db.AddInParameter(command, "@ISDA_SistemaGenitoUrinario_Consideracoes", DbType.String, ObjProntuario.ISDA_SistemaGenitoUrinario_Consideracoes);
            db.AddInParameter(command, "@ISDA_SistemaOsteomolecular", DbType.Boolean, ObjProntuario.ISDA_SistemaOsteomolecular);
            db.AddInParameter(command, "@ISDA_SistemaOsteomolecular_Consideracoes", DbType.String, ObjProntuario.ISDA_SistemaOsteomolecular_Consideracoes);
            db.AddInParameter(command, "@ISDA_SistemaTegumentar", DbType.Boolean, ObjProntuario.ISDA_SistemaTegumentar);
            db.AddInParameter(command, "@ISDA_SistemaTegumentar_Consideracoes", DbType.String, ObjProntuario.ISDA_SistemaTegumentar_Consideracoes);
            db.AddInParameter(command, "@ISDA_SistemaImunologico", DbType.Boolean, ObjProntuario.ISDA_SistemaImunologico);
            db.AddInParameter(command, "@ISDA_SistemaImunologico_Consideracoes", DbType.String, ObjProntuario.ISDA_SistemaImunologico_Consideracoes);
            //Exame Fisico
            db.AddInParameter(command, "@ExameFisico_Peso", DbType.Decimal, ObjProntuario.ExameFisico_Peso);
            db.AddInParameter(command, "@ExameFisico_Altura", DbType.Decimal, ObjProntuario.ExameFisico_Altura);
            db.AddInParameter(command, "@ExameFisico_CabecaPescoco", DbType.Boolean, ObjProntuario.ExameFisico_CabecaPescoco);
            db.AddInParameter(command, "@ExameFisico_CabecaPescoco_Consideracoes", DbType.String, ObjProntuario.ExameFisico_CabecaPescoco_Consideracoes);
            db.AddInParameter(command, "@ExameFisico_Visao", DbType.String, ObjProntuario.ExameFisico_Visao);
            db.AddInParameter(command, "@ExameFisico_Cardiovascular", DbType.Boolean, ObjProntuario.ExameFisico_Cardiovascular);
            db.AddInParameter(command, "@ExameFisico_Cardiovascular_Consideracoes", DbType.String, ObjProntuario.ExameFisico_Cardiovascular_Consideracoes);
            db.AddInParameter(command, "@ExameFisico_PA", DbType.String, ObjProntuario.ExameFisico_PA);
            db.AddInParameter(command, "@ExameFisico_Pulso", DbType.String, ObjProntuario.ExameFisico_Pulso);
            db.AddInParameter(command, "@ExameFisico_Respiratorio", DbType.Boolean, ObjProntuario.ExameFisico_Respiratorio);
            db.AddInParameter(command, "@ExameFisico_Respiratorio_Consideracoes", DbType.String, ObjProntuario.ExameFisico_Respiratorio_Consideracoes);
            db.AddInParameter(command, "@ExameFisico_Abdomen", DbType.Boolean, ObjProntuario.ExameFisico_Abdomen);
            db.AddInParameter(command, "@ExameFisico_Abdomen_Consideracoes", DbType.String, ObjProntuario.ExameFisico_Abdomen_Consideracoes);
            db.AddInParameter(command, "@ExameFisico_MembrosSuperiores", DbType.Boolean, ObjProntuario.ExameFisico_MembrosSuperiores);
            db.AddInParameter(command, "@ExameFisico_MembrosSuperiores_Consideracoes", DbType.String, ObjProntuario.ExameFisico_MembrosSuperiores_Consideracoes);
            db.AddInParameter(command, "@ExameFisico_MembrosInferiores", DbType.Boolean, ObjProntuario.ExameFisico_MembrosInferiores);
            db.AddInParameter(command, "@ExameFisico_MembrosInferiores_Consideracoes", DbType.String, ObjProntuario.ExameFisico_MembrosInferiores_Consideracoes);
            //Exames Complementares
            db.AddInParameter(command, "@CID10_Primario", DbType.String, ObjProntuario.CID10_Primario);
            db.AddInParameter(command, "@CID10_Secundario_1", DbType.String, ObjProntuario.CID10_Secundario_1);
            db.AddInParameter(command, "@CID10_Secundario_2", DbType.String, ObjProntuario.CID10_Secundario_2);

            db.ExecuteNonQuery(command);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    //FAZ UM SELECT EM TODOS OS REGISTROS NA BASE
    public DataTable SelectAll(string idCliente, string Nome, string CPF, string RG, string DataInicial, string DataFinal)
    {
        Database db = DatabaseFactory.CreateDatabase();
        Validacoes Valida = new Validacoes();
        DbCommand command = db.GetStoredProcCommand("ProntuarioClinicoSelectAll");
        db.AddInParameter(command, "@idCliente", DbType.String, idCliente);
        db.AddInParameter(command, "@Nome", DbType.String, Valida.TextoNull(Nome));
        db.AddInParameter(command, "@CPF", DbType.String, Valida.TextoNull(CPF));
        db.AddInParameter(command, "@RG", DbType.String, Valida.TextoNull(RG));
        db.AddInParameter(command, "@DtIni", DbType.DateTime, Valida.TextoNull(DataInicial));
        db.AddInParameter(command, "@DtFim", DbType.DateTime, Valida.TextoNull(DataFinal));
        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }   
    

    //SELECIONA UM DETERMINADO REGISTRO PARA ALTERAÇÃO DE DADOS.
    public object SelectFuncionarioByID(int id)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ProntuarioClinicoByID");
        db.AddInParameter(command, "@id", DbType.Int32, id);

        using (IDataReader dr = db.ExecuteReader(command))
        {   
            if (dr.Read())
            {
                ObjProntuario = new ProtuarioClinico();

                ObjProntuario.idFuncionario = Convert.ToInt32(dr["idFuncionario"]);                
                //Anamnese
                ObjProntuario.Anamnese_Historico = Convert.ToString(dr["Anamnese_Historico"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Diabetes = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_Diabetes"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_HipertensaoArterial = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_HipertensaoArterial"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Tumores = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_Tumores"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Tumores_CID10 = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Tumores_CID10"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Tumores_Ano = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Tumores_Ano"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Tumores_Tratado = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Tumores_Tratado"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Alergias = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_Alergias"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Alergias_Quais = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Alergias_Quais"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Internacoes = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_Internacoes"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Internacoes_Quais = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Internacoes_Quais"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Cirugias = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_Cirugias"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Cirugias_Quais = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Cirugias_Quais"]);
                ObjProntuario.Anamnese_AntecedentesFamiliares_Diabetes = Convert.ToBoolean(dr["Anamnese_AntecedentesFamiliares_Diabetes"]);
                ObjProntuario.Anamnese_AntecedentesFamiliares_HipertensaoArterial = Convert.ToBoolean(dr["Anamnese_AntecedentesFamiliares_HipertensaoArterial"]);
                ObjProntuario.Anamnese_AntecedentesFamiliares_Tumores = Convert.ToBoolean(dr["Anamnese_AntecedentesFamiliares_Tumores"]);
                ObjProntuario.Anamnese_AntecedentesObstetricos_Gestacoes = Convert.ToBoolean(dr["Anamnese_AntecedentesObstetricos_Gestacoes"]);
                ObjProntuario.Anamnese_AntecedentesObstetricos_Gestacoes_Quantos = Convert.ToString(dr["Anamnese_AntecedentesObstetricos_Gestacoes_Quantos"]);
                ObjProntuario.Anamnese_AntecedentesObstetricos_Partos = Convert.ToBoolean(dr["Anamnese_AntecedentesObstetricos_Partos"]);
                ObjProntuario.Anamnese_AntecedentesObstetricos_Partos_Quantos = Convert.ToString(dr["Anamnese_AntecedentesObstetricos_Partos_Quantos"]);
                ObjProntuario.Anamnese_AntecedentesObstetricos_Abortos = Convert.ToBoolean(dr["Anamnese_AntecedentesObstetricos_Abortos"]);
                ObjProntuario.Anamnese_AntecedentesObstetricos_Abortos_Quantos = Convert.ToString(dr["Anamnese_AntecedentesObstetricos_Abortos_Quantos"]);
                ObjProntuario.Anamnese_AntecedentesObstetricos_DtMenstruacao = Convert.ToString(dr["Anamnese_AntecedentesObstetricos_DtMenstruacao"]).Replace("00:00:00", "");
                //Habitos
                ObjProntuario.Habitos_Fumante = Convert.ToBoolean(dr["Habitos_Fumante"]);
                ObjProntuario.Habitos_Fumante_Qtd = Convert.ToString(dr["Habitos_Fumante_Qtd"]);
                ObjProntuario.Habitos_Fumante_Anos = Convert.ToString(dr["Habitos_Fumante_Anos"]);
                ObjProntuario.Habitos_Bebidas = Convert.ToBoolean(dr["Habitos_Bebidas"]);
                ObjProntuario.Habitos_Bebidas_Qtd = Convert.ToString(dr["Habitos_Bebidas_Qtd"]);
                ObjProntuario.Habitos_Bebidas_Anos = Convert.ToString(dr["Habitos_Bebidas_Anos"]);
                ObjProntuario.Habitos_Exercicios = Convert.ToBoolean(dr["Habitos_Exercicios"]);
                ObjProntuario.Habitos_Exercicios_Qtd = Convert.ToString(dr["Habitos_Exercicios_Qtd"]);
                //Antecedentes
                ObjProntuario.Antecedentes_Afastamento = Convert.ToBoolean(dr["Antecedentes_Afastamento"]);
                ObjProntuario.Antecedentes_Afastamento_Qual = Convert.ToString(dr["Antecedentes_Afastamento_Qual"]);
                ObjProntuario.Antecedentes_Afastamento_Qtd_Dias = Convert.ToString(dr["Antecedentes_Afastamento_Qtd_Dias"]);
                ObjProntuario.Antecedentes_Afastamento_CAT = Convert.ToString(dr["Antecedentes_Afastamento_CAT"]);
                ObjProntuario.Antecedentes_Acidente = Convert.ToBoolean(dr["Antecedentes_Acidente"]);
                ObjProntuario.Antecedentes_Acidente_Ano = Convert.ToString(dr["Antecedentes_Acidente_Ano"]);
                ObjProntuario.Antecedentes_Acidente_Qual = Convert.ToString(dr["Antecedentes_Acidente_Qual"]);
                ObjProntuario.Antecedentes_Doenca = Convert.ToBoolean(dr["Antecedentes_Doenca"]);
                ObjProntuario.Antecedentes_Doenca_Qual = Convert.ToString(dr["Antecedentes_Doenca_Qual"]);
                ObjProntuario.Antecedentes_Doenca_Ano = Convert.ToString(dr["Antecedentes_Doenca_Ano"]);
                ////ISDA
                ObjProntuario.ISDA_SistemaNervoso = Convert.ToBoolean(dr["ISDA_SistemaNervoso"]);
                ObjProntuario.ISDA_SistemaNervoso_Consideracoes = Convert.ToString(dr["ISDA_SistemaNervoso_Consideracoes"]);
                ObjProntuario.ISDA_Visao = Convert.ToBoolean(dr["ISDA_Visao"]);
                ObjProntuario.ISDA_Visao_Consideracoes = Convert.ToString(dr["ISDA_Visao_Consideracoes"]);
                ObjProntuario.ISDA_Audicao = Convert.ToBoolean(dr["ISDA_Audicao"]);
                ObjProntuario.ISDA_Audicao_Consideracoes = Convert.ToString(dr["ISDA_Audicao_Consideracoes"]);
                ObjProntuario.ISDA_SistemaCardiovascular = Convert.ToBoolean(dr["ISDA_SistemaCardiovascular"]);
                ObjProntuario.ISDA_SistemaCardiovascular_Consideracoes = Convert.ToString(dr["ISDA_SistemaCardiovascular_Consideracoes"]);
                ObjProntuario.ISDA_SistemaPulmonar = Convert.ToBoolean(dr["ISDA_SistemaPulmonar"]);
                ObjProntuario.ISDA_SistemaPulmonar_Consideracoes = Convert.ToString(dr["ISDA_SistemaPulmonar_Consideracoes"]);
                ObjProntuario.ISDA_SistemaGastroIntestinal = Convert.ToBoolean(dr["ISDA_SistemaGastroIntestinal"]);
                ObjProntuario.ISDA_SistemaGastroIntestinal_Consideracoes = Convert.ToString(dr["ISDA_SistemaGastroIntestinal_Consideracoes"]);
                ObjProntuario.ISDA_SistemaGenitoUrinario = Convert.ToBoolean(dr["ISDA_SistemaGenitoUrinario"]);
                ObjProntuario.ISDA_SistemaGenitoUrinario_Consideracoes = Convert.ToString(dr["ISDA_SistemaGenitoUrinario_Consideracoes"]);
                ObjProntuario.ISDA_SistemaOsteomolecular = Convert.ToBoolean(dr["ISDA_SistemaOsteomolecular"]);
                ObjProntuario.ISDA_SistemaOsteomolecular_Consideracoes = Convert.ToString(dr["ISDA_SistemaOsteomolecular_Consideracoes"]);
                ObjProntuario.ISDA_SistemaTegumentar = Convert.ToBoolean(dr["ISDA_SistemaTegumentar"]);
                ObjProntuario.ISDA_SistemaTegumentar_Consideracoes = Convert.ToString(dr["ISDA_SistemaTegumentar_Consideracoes"]);
                ObjProntuario.ISDA_SistemaImunologico = Convert.ToBoolean(dr["ISDA_SistemaImunologico"]);
                ObjProntuario.ISDA_SistemaImunologico_Consideracoes = Convert.ToString(dr["ISDA_SistemaImunologico_Consideracoes"]);
                //Exame Fisico
                ObjProntuario.ExameFisico_Peso = Convert.ToDecimal(dr["ExameFisico_Peso"]);
                ObjProntuario.ExameFisico_Altura = Convert.ToDecimal(dr["ExameFisico_Altura"]);
                ObjProntuario.ExameFisico_CabecaPescoco = Convert.ToBoolean(dr["ExameFisico_CabecaPescoco"]);
                ObjProntuario.ExameFisico_CabecaPescoco_Consideracoes = Convert.ToString(dr["ExameFisico_CabecaPescoco_Consideracoes"]);
                ObjProntuario.ExameFisico_Visao = Convert.ToString(dr["ExameFisico_Visao"]);
                ObjProntuario.ExameFisico_Cardiovascular = Convert.ToBoolean(dr["ExameFisico_Cardiovascular"]);
                ObjProntuario.ExameFisico_Cardiovascular_Consideracoes = Convert.ToString(dr["ExameFisico_Cardiovascular_Consideracoes"]);
                ObjProntuario.ExameFisico_PA = Convert.ToString(dr["ExameFisico_PA"]);
                ObjProntuario.ExameFisico_Pulso = Convert.ToString(dr["ExameFisico_Pulso"]);
                ObjProntuario.ExameFisico_Respiratorio = Convert.ToBoolean(dr["ExameFisico_Respiratorio"]);
                ObjProntuario.ExameFisico_Respiratorio_Consideracoes = Convert.ToString(dr["ExameFisico_Respiratorio_Consideracoes"]);
                ObjProntuario.ExameFisico_Abdomen = Convert.ToBoolean(dr["ExameFisico_Abdomen"]);
                ObjProntuario.ExameFisico_Abdomen_Consideracoes = Convert.ToString(dr["ExameFisico_Abdomen_Consideracoes"]);
                ObjProntuario.ExameFisico_MembrosSuperiores = Convert.ToBoolean(dr["ExameFisico_MembrosSuperiores"]);
                ObjProntuario.ExameFisico_MembrosSuperiores_Consideracoes = Convert.ToString(dr["ExameFisico_MembrosSuperiores_Consideracoes"]);
                ObjProntuario.ExameFisico_MembrosInferiores = Convert.ToBoolean(dr["ExameFisico_MembrosInferiores"]);
                ObjProntuario.ExameFisico_MembrosInferiores_Consideracoes = Convert.ToString(dr["ExameFisico_MembrosInferiores_Consideracoes"]);
                //Exames Complementares
                ObjProntuario.CID10_Primario = Convert.ToString(dr["CID10_Primario"]);
                ObjProntuario.CID10_Secundario_1 = Convert.ToString(dr["CID10_Secundario_1"]);
                ObjProntuario.CID10_Secundario_2 = Convert.ToString(dr["CID10_Secundario_2"]);
            }
            return ObjProntuario;
        }
    }

    //SELECIONA UM DETERMINADO REGISTRO PARA ALTERAÇÃO DE DADOS.
    public ProtuarioClinico SelectProntuarioClinicoVisualizarByID(int id)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("SELECT * FROM dbo.ProntuarioClinico WHERE id =" + id );

        using (IDataReader dr = db.ExecuteReader(command))
        {
            if (dr.Read())
            {
                ObjProntuario = new ProtuarioClinico();

                ObjProntuario.idFuncionario = Convert.ToInt32(dr["idFuncionario"]);
                //Anamnese
                ObjProntuario.Anamnese_Historico = Convert.ToString(dr["Anamnese_Historico"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Diabetes = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_Diabetes"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_HipertensaoArterial = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_HipertensaoArterial"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Tumores = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_Tumores"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Tumores_CID10 = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Tumores_CID10"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Tumores_Ano = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Tumores_Ano"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Tumores_Tratado = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Tumores_Tratado"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Alergias = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_Alergias"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Alergias_Quais = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Alergias_Quais"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Internacoes = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_Internacoes"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Internacoes_Quais = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Internacoes_Quais"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Cirugias = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_Cirugias"]);
                ObjProntuario.Anamnese_AntecedentesPessoais_Cirugias_Quais = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Cirugias_Quais"]);
                ObjProntuario.Anamnese_AntecedentesFamiliares_Diabetes = Convert.ToBoolean(dr["Anamnese_AntecedentesFamiliares_Diabetes"]);
                ObjProntuario.Anamnese_AntecedentesFamiliares_HipertensaoArterial = Convert.ToBoolean(dr["Anamnese_AntecedentesFamiliares_HipertensaoArterial"]);
                ObjProntuario.Anamnese_AntecedentesFamiliares_Tumores = Convert.ToBoolean(dr["Anamnese_AntecedentesFamiliares_Tumores"]);
                ObjProntuario.Anamnese_AntecedentesObstetricos_Gestacoes = Convert.ToBoolean(dr["Anamnese_AntecedentesObstetricos_Gestacoes"]);
                ObjProntuario.Anamnese_AntecedentesObstetricos_Gestacoes_Quantos = Convert.ToString(dr["Anamnese_AntecedentesObstetricos_Gestacoes_Quantos"]);
                ObjProntuario.Anamnese_AntecedentesObstetricos_Partos = Convert.ToBoolean(dr["Anamnese_AntecedentesObstetricos_Partos"]);
                ObjProntuario.Anamnese_AntecedentesObstetricos_Partos_Quantos = Convert.ToString(dr["Anamnese_AntecedentesObstetricos_Partos_Quantos"]);
                ObjProntuario.Anamnese_AntecedentesObstetricos_Abortos = Convert.ToBoolean(dr["Anamnese_AntecedentesObstetricos_Abortos"]);
                ObjProntuario.Anamnese_AntecedentesObstetricos_Abortos_Quantos = Convert.ToString(dr["Anamnese_AntecedentesObstetricos_Abortos_Quantos"]);
                ObjProntuario.Anamnese_AntecedentesObstetricos_DtMenstruacao = Convert.ToString(dr["Anamnese_AntecedentesObstetricos_DtMenstruacao"]).Replace("00:00:00", "");
                //Habitos
                ObjProntuario.Habitos_Fumante = Convert.ToBoolean(dr["Habitos_Fumante"]);
                ObjProntuario.Habitos_Fumante_Qtd = Convert.ToString(dr["Habitos_Fumante_Qtd"]);
                ObjProntuario.Habitos_Fumante_Anos = Convert.ToString(dr["Habitos_Fumante_Anos"]);
                ObjProntuario.Habitos_Bebidas = Convert.ToBoolean(dr["Habitos_Bebidas"]);
                ObjProntuario.Habitos_Bebidas_Qtd = Convert.ToString(dr["Habitos_Bebidas_Qtd"]);
                ObjProntuario.Habitos_Bebidas_Anos = Convert.ToString(dr["Habitos_Bebidas_Anos"]);
                ObjProntuario.Habitos_Exercicios = Convert.ToBoolean(dr["Habitos_Exercicios"]);
                ObjProntuario.Habitos_Exercicios_Qtd = Convert.ToString(dr["Habitos_Exercicios_Qtd"]);
                //Antecedentes
                ObjProntuario.Antecedentes_Afastamento = Convert.ToBoolean(dr["Antecedentes_Afastamento"]);
                ObjProntuario.Antecedentes_Afastamento_Qual = Convert.ToString(dr["Antecedentes_Afastamento_Qual"]);
                ObjProntuario.Antecedentes_Afastamento_Qtd_Dias = Convert.ToString(dr["Antecedentes_Afastamento_Qtd_Dias"]);
                ObjProntuario.Antecedentes_Afastamento_CAT = Convert.ToString(dr["Antecedentes_Afastamento_CAT"]);
                ObjProntuario.Antecedentes_Acidente = Convert.ToBoolean(dr["Antecedentes_Acidente"]);
                ObjProntuario.Antecedentes_Acidente_Ano = Convert.ToString(dr["Antecedentes_Acidente_Ano"]);
                ObjProntuario.Antecedentes_Acidente_Qual = Convert.ToString(dr["Antecedentes_Acidente_Qual"]);
                ObjProntuario.Antecedentes_Doenca = Convert.ToBoolean(dr["Antecedentes_Doenca"]);
                ObjProntuario.Antecedentes_Doenca_Qual = Convert.ToString(dr["Antecedentes_Doenca_Qual"]);
                ObjProntuario.Antecedentes_Doenca_Ano = Convert.ToString(dr["Antecedentes_Doenca_Ano"]);
                ////ISDA
                ObjProntuario.ISDA_SistemaNervoso = Convert.ToBoolean(dr["ISDA_SistemaNervoso"]);
                ObjProntuario.ISDA_SistemaNervoso_Consideracoes = Convert.ToString(dr["ISDA_SistemaNervoso_Consideracoes"]);
                ObjProntuario.ISDA_Visao = Convert.ToBoolean(dr["ISDA_Visao"]);
                ObjProntuario.ISDA_Visao_Consideracoes = Convert.ToString(dr["ISDA_Visao_Consideracoes"]);
                ObjProntuario.ISDA_Audicao = Convert.ToBoolean(dr["ISDA_Audicao"]);
                ObjProntuario.ISDA_Audicao_Consideracoes = Convert.ToString(dr["ISDA_Audicao_Consideracoes"]);
                ObjProntuario.ISDA_SistemaCardiovascular = Convert.ToBoolean(dr["ISDA_SistemaCardiovascular"]);
                ObjProntuario.ISDA_SistemaCardiovascular_Consideracoes = Convert.ToString(dr["ISDA_SistemaCardiovascular_Consideracoes"]);
                ObjProntuario.ISDA_SistemaPulmonar = Convert.ToBoolean(dr["ISDA_SistemaPulmonar"]);
                ObjProntuario.ISDA_SistemaPulmonar_Consideracoes = Convert.ToString(dr["ISDA_SistemaPulmonar_Consideracoes"]);
                ObjProntuario.ISDA_SistemaGastroIntestinal = Convert.ToBoolean(dr["ISDA_SistemaGastroIntestinal"]);
                ObjProntuario.ISDA_SistemaGastroIntestinal_Consideracoes = Convert.ToString(dr["ISDA_SistemaGastroIntestinal_Consideracoes"]);
                ObjProntuario.ISDA_SistemaGenitoUrinario = Convert.ToBoolean(dr["ISDA_SistemaGenitoUrinario"]);
                ObjProntuario.ISDA_SistemaGenitoUrinario_Consideracoes = Convert.ToString(dr["ISDA_SistemaGenitoUrinario_Consideracoes"]);
                ObjProntuario.ISDA_SistemaOsteomolecular = Convert.ToBoolean(dr["ISDA_SistemaOsteomolecular"]);
                ObjProntuario.ISDA_SistemaOsteomolecular_Consideracoes = Convert.ToString(dr["ISDA_SistemaOsteomolecular_Consideracoes"]);
                ObjProntuario.ISDA_SistemaTegumentar = Convert.ToBoolean(dr["ISDA_SistemaTegumentar"]);
                ObjProntuario.ISDA_SistemaTegumentar_Consideracoes = Convert.ToString(dr["ISDA_SistemaTegumentar_Consideracoes"]);
                ObjProntuario.ISDA_SistemaImunologico = Convert.ToBoolean(dr["ISDA_SistemaImunologico"]);
                ObjProntuario.ISDA_SistemaImunologico_Consideracoes = Convert.ToString(dr["ISDA_SistemaImunologico_Consideracoes"]);
                //Exame Fisico
                ObjProntuario.ExameFisico_Peso = Convert.ToDecimal(dr["ExameFisico_Peso"]);
                ObjProntuario.ExameFisico_Altura = Convert.ToDecimal(dr["ExameFisico_Altura"]);
                ObjProntuario.ExameFisico_CabecaPescoco = Convert.ToBoolean(dr["ExameFisico_CabecaPescoco"]);
                ObjProntuario.ExameFisico_CabecaPescoco_Consideracoes = Convert.ToString(dr["ExameFisico_CabecaPescoco_Consideracoes"]);
                ObjProntuario.ExameFisico_Visao = Convert.ToString(dr["ExameFisico_Visao"]);
                ObjProntuario.ExameFisico_Cardiovascular = Convert.ToBoolean(dr["ExameFisico_Cardiovascular"]);
                ObjProntuario.ExameFisico_Cardiovascular_Consideracoes = Convert.ToString(dr["ExameFisico_Cardiovascular_Consideracoes"]);
                ObjProntuario.ExameFisico_PA = Convert.ToString(dr["ExameFisico_PA"]);
                ObjProntuario.ExameFisico_Pulso = Convert.ToString(dr["ExameFisico_Pulso"]);
                ObjProntuario.ExameFisico_Respiratorio = Convert.ToBoolean(dr["ExameFisico_Respiratorio"]);
                ObjProntuario.ExameFisico_Respiratorio_Consideracoes = Convert.ToString(dr["ExameFisico_Respiratorio_Consideracoes"]);
                ObjProntuario.ExameFisico_Abdomen = Convert.ToBoolean(dr["ExameFisico_Abdomen"]);
                ObjProntuario.ExameFisico_Abdomen_Consideracoes = Convert.ToString(dr["ExameFisico_Abdomen_Consideracoes"]);
                ObjProntuario.ExameFisico_MembrosSuperiores = Convert.ToBoolean(dr["ExameFisico_MembrosSuperiores"]);
                ObjProntuario.ExameFisico_MembrosSuperiores_Consideracoes = Convert.ToString(dr["ExameFisico_MembrosSuperiores_Consideracoes"]);
                ObjProntuario.ExameFisico_MembrosInferiores = Convert.ToBoolean(dr["ExameFisico_MembrosInferiores"]);
                ObjProntuario.ExameFisico_MembrosInferiores_Consideracoes = Convert.ToString(dr["ExameFisico_MembrosInferiores_Consideracoes"]);
                //Exames Complementares
                ObjProntuario.CID10_Primario = Convert.ToString(dr["CID10_Primario"]);
                ObjProntuario.CID10_Secundario_1 = Convert.ToString(dr["CID10_Secundario_1"]);
                ObjProntuario.CID10_Secundario_2 = Convert.ToString(dr["CID10_Secundario_2"]);
            }
            return ObjProntuario;
        }
    }

        //SELECIONA UM DETERMINADO REGISTRO PARA ALTERAÇÃO DE DADOS.
    public ProtuarioClinico SelectVisualizarProtuarioClinicoByID(int id)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("SELECT * FROM ProntuarioClinico");

        using (IDataReader dr = db.ExecuteReader(command))
        {
            ProtuarioClinico ObjProtuarioClinico = new ProtuarioClinico();
            if (dr.Read())
            {
                ObjProtuarioClinico.idFuncionario = Convert.ToInt32(dr["idFuncionario"]);
                //Anamnese
                ObjProtuarioClinico.dtCadastro = Convert.ToDateTime(dr["dtCadastro"]);
                ObjProtuarioClinico.Anamnese_Historico = Convert.ToString(dr["Anamnese_Historico"]);
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Diabetes = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_Diabetes"]);
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_HipertensaoArterial = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_HipertensaoArterial"]);
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Tumores = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_Tumores"]);
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Tumores_CID10 = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Tumores_CID10"]);
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Tumores_Ano = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Tumores_Ano"]);
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Tumores_Tratado = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Tumores_Tratado"]);
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Alergias = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_Alergias"]);
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Alergias_Quais = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Alergias_Quais"]);
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Internacoes = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_Internacoes"]);
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Internacoes_Quais = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Internacoes_Quais"]);
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Cirugias = Convert.ToBoolean(dr["Anamnese_AntecedentesPessoais_Cirugias"]);
                ObjProtuarioClinico.Anamnese_AntecedentesPessoais_Cirugias_Quais = Convert.ToString(dr["Anamnese_AntecedentesPessoais_Cirugias_Quais"]);
                ObjProtuarioClinico.Anamnese_AntecedentesFamiliares_Diabetes = Convert.ToBoolean(dr["Anamnese_AntecedentesFamiliares_Diabetes"]);
                ObjProtuarioClinico.Anamnese_AntecedentesFamiliares_HipertensaoArterial = Convert.ToBoolean(dr["Anamnese_AntecedentesFamiliares_HipertensaoArterial"]);
                ObjProtuarioClinico.Anamnese_AntecedentesFamiliares_Tumores = Convert.ToBoolean(dr["Anamnese_AntecedentesFamiliares_Tumores"]);
                ObjProtuarioClinico.Anamnese_AntecedentesObstetricos_Gestacoes = Convert.ToBoolean(dr["Anamnese_AntecedentesObstetricos_Gestacoes"]);
                ObjProtuarioClinico.Anamnese_AntecedentesObstetricos_Gestacoes_Quantos = Convert.ToString(dr["Anamnese_AntecedentesObstetricos_Gestacoes_Quantos"]);
                ObjProtuarioClinico.Anamnese_AntecedentesObstetricos_Partos = Convert.ToBoolean(dr["Anamnese_AntecedentesObstetricos_Partos"]);
                ObjProtuarioClinico.Anamnese_AntecedentesObstetricos_Partos_Quantos = Convert.ToString(dr["Anamnese_AntecedentesObstetricos_Partos_Quantos"]);
                ObjProtuarioClinico.Anamnese_AntecedentesObstetricos_Abortos = Convert.ToBoolean(dr["Anamnese_AntecedentesObstetricos_Abortos"]);
                ObjProtuarioClinico.Anamnese_AntecedentesObstetricos_Abortos_Quantos = Convert.ToString(dr["Anamnese_AntecedentesObstetricos_Abortos_Quantos"]);
                ObjProtuarioClinico.Anamnese_AntecedentesObstetricos_DtMenstruacao = Convert.ToString(dr["Anamnese_AntecedentesObstetricos_DtMenstruacao"]).Replace("00:00:00", "");
                //Habitos
                ObjProtuarioClinico.Habitos_Fumante = Convert.ToBoolean(dr["Habitos_Fumante"]);
                ObjProtuarioClinico.Habitos_Fumante_Qtd = Convert.ToString(dr["Habitos_Fumante_Qtd"]);
                ObjProtuarioClinico.Habitos_Fumante_Anos = Convert.ToString(dr["Habitos_Fumante_Anos"]);
                ObjProtuarioClinico.Habitos_Bebidas = Convert.ToBoolean(dr["Habitos_Bebidas"]);
                ObjProtuarioClinico.Habitos_Bebidas_Qtd = Convert.ToString(dr["Habitos_Bebidas_Qtd"]);
                ObjProtuarioClinico.Habitos_Bebidas_Anos = Convert.ToString(dr["Habitos_Bebidas_Anos"]);
                ObjProtuarioClinico.Habitos_Exercicios = Convert.ToBoolean(dr["Habitos_Exercicios"]);
                ObjProtuarioClinico.Habitos_Exercicios_Qtd = Convert.ToString(dr["Habitos_Exercicios_Qtd"]);
                //Antecedentes
                ObjProtuarioClinico.Antecedentes_Afastamento = Convert.ToBoolean(dr["Antecedentes_Afastamento"]);
                ObjProtuarioClinico.Antecedentes_Afastamento_Qual = Convert.ToString(dr["Antecedentes_Afastamento_Qual"]);
                ObjProtuarioClinico.Antecedentes_Afastamento_Qtd_Dias = Convert.ToString(dr["Antecedentes_Afastamento_Qtd_Dias"]);
                ObjProtuarioClinico.Antecedentes_Afastamento_CAT = Convert.ToString(dr["Antecedentes_Afastamento_CAT"]);
                ObjProtuarioClinico.Antecedentes_Acidente = Convert.ToBoolean(dr["Antecedentes_Acidente"]);
                ObjProtuarioClinico.Antecedentes_Acidente_Ano = Convert.ToString(dr["Antecedentes_Acidente_Ano"]);
                ObjProtuarioClinico.Antecedentes_Acidente_Qual = Convert.ToString(dr["Antecedentes_Acidente_Qual"]);
                ObjProtuarioClinico.Antecedentes_Doenca = Convert.ToBoolean(dr["Antecedentes_Doenca"]);
                ObjProtuarioClinico.Antecedentes_Doenca_Qual = Convert.ToString(dr["Antecedentes_Doenca_Qual"]);
                ObjProtuarioClinico.Antecedentes_Doenca_Ano = Convert.ToString(dr["Antecedentes_Doenca_Ano"]);
                ////ISDA
                ObjProtuarioClinico.ISDA_SistemaNervoso = Convert.ToBoolean(dr["ISDA_SistemaNervoso"]);
                ObjProtuarioClinico.ISDA_SistemaNervoso_Consideracoes = Convert.ToString(dr["ISDA_SistemaNervoso_Consideracoes"]);
                ObjProtuarioClinico.ISDA_Visao = Convert.ToBoolean(dr["ISDA_Visao"]);
                ObjProtuarioClinico.ISDA_Visao_Consideracoes = Convert.ToString(dr["ISDA_Visao_Consideracoes"]);
                ObjProtuarioClinico.ISDA_Audicao = Convert.ToBoolean(dr["ISDA_Audicao"]);
                ObjProtuarioClinico.ISDA_Audicao_Consideracoes = Convert.ToString(dr["ISDA_Audicao_Consideracoes"]);
                ObjProtuarioClinico.ISDA_SistemaCardiovascular = Convert.ToBoolean(dr["ISDA_SistemaCardiovascular"]);
                ObjProtuarioClinico.ISDA_SistemaCardiovascular_Consideracoes = Convert.ToString(dr["ISDA_SistemaCardiovascular_Consideracoes"]);
                ObjProtuarioClinico.ISDA_SistemaPulmonar = Convert.ToBoolean(dr["ISDA_SistemaPulmonar"]);
                ObjProtuarioClinico.ISDA_SistemaPulmonar_Consideracoes = Convert.ToString(dr["ISDA_SistemaPulmonar_Consideracoes"]);
                ObjProtuarioClinico.ISDA_SistemaGastroIntestinal = Convert.ToBoolean(dr["ISDA_SistemaGastroIntestinal"]);
                ObjProtuarioClinico.ISDA_SistemaGastroIntestinal_Consideracoes = Convert.ToString(dr["ISDA_SistemaGastroIntestinal_Consideracoes"]);
                ObjProtuarioClinico.ISDA_SistemaGenitoUrinario = Convert.ToBoolean(dr["ISDA_SistemaGenitoUrinario"]);
                ObjProtuarioClinico.ISDA_SistemaGenitoUrinario_Consideracoes = Convert.ToString(dr["ISDA_SistemaGenitoUrinario_Consideracoes"]);
                ObjProtuarioClinico.ISDA_SistemaOsteomolecular = Convert.ToBoolean(dr["ISDA_SistemaOsteomolecular"]);
                ObjProtuarioClinico.ISDA_SistemaOsteomolecular_Consideracoes = Convert.ToString(dr["ISDA_SistemaOsteomolecular_Consideracoes"]);
                ObjProtuarioClinico.ISDA_SistemaTegumentar = Convert.ToBoolean(dr["ISDA_SistemaTegumentar"]);
                ObjProtuarioClinico.ISDA_SistemaTegumentar_Consideracoes = Convert.ToString(dr["ISDA_SistemaTegumentar_Consideracoes"]);
                ObjProtuarioClinico.ISDA_SistemaImunologico = Convert.ToBoolean(dr["ISDA_SistemaImunologico"]);
                ObjProtuarioClinico.ISDA_SistemaImunologico_Consideracoes = Convert.ToString(dr["ISDA_SistemaImunologico_Consideracoes"]);
                //Exame Fisico
                ObjProtuarioClinico.ExameFisico_Peso = Convert.ToDecimal(dr["ExameFisico_Peso"]);
                ObjProtuarioClinico.ExameFisico_Altura = Convert.ToDecimal(dr["ExameFisico_Altura"]);
                ObjProtuarioClinico.ExameFisico_CabecaPescoco = Convert.ToBoolean(dr["ExameFisico_CabecaPescoco"]);
                ObjProtuarioClinico.ExameFisico_CabecaPescoco_Consideracoes = Convert.ToString(dr["ExameFisico_CabecaPescoco_Consideracoes"]);
                ObjProtuarioClinico.ExameFisico_Visao = Convert.ToString(dr["ExameFisico_Visao"]);
                ObjProtuarioClinico.ExameFisico_Cardiovascular = Convert.ToBoolean(dr["ExameFisico_Cardiovascular"]);
                ObjProtuarioClinico.ExameFisico_Cardiovascular_Consideracoes = Convert.ToString(dr["ExameFisico_Cardiovascular_Consideracoes"]);
                ObjProtuarioClinico.ExameFisico_PA = Convert.ToString(dr["ExameFisico_PA"]);
                ObjProtuarioClinico.ExameFisico_Pulso = Convert.ToString(dr["ExameFisico_Pulso"]);
                ObjProtuarioClinico.ExameFisico_Respiratorio = Convert.ToBoolean(dr["ExameFisico_Respiratorio"]);
                ObjProtuarioClinico.ExameFisico_Respiratorio_Consideracoes = Convert.ToString(dr["ExameFisico_Respiratorio_Consideracoes"]);
                ObjProtuarioClinico.ExameFisico_Abdomen = Convert.ToBoolean(dr["ExameFisico_Abdomen"]);
                ObjProtuarioClinico.ExameFisico_Abdomen_Consideracoes = Convert.ToString(dr["ExameFisico_Abdomen_Consideracoes"]);
                ObjProtuarioClinico.ExameFisico_MembrosSuperiores = Convert.ToBoolean(dr["ExameFisico_MembrosSuperiores"]);
                ObjProtuarioClinico.ExameFisico_MembrosSuperiores_Consideracoes = Convert.ToString(dr["ExameFisico_MembrosSuperiores_Consideracoes"]);
                ObjProtuarioClinico.ExameFisico_MembrosInferiores = Convert.ToBoolean(dr["ExameFisico_MembrosInferiores"]);
                ObjProtuarioClinico.ExameFisico_MembrosInferiores_Consideracoes = Convert.ToString(dr["ExameFisico_MembrosInferiores_Consideracoes"]);
                //Exames Complementares
                ObjProtuarioClinico.CID10_Primario = Convert.ToString(dr["CID10_Primario"]);
                ObjProtuarioClinico.CID10_Secundario_1 = Convert.ToString(dr["CID10_Secundario_1"]);
                ObjProtuarioClinico.CID10_Secundario_2 = Convert.ToString(dr["CID10_Secundario_2"]);
            }
            return ObjProtuarioClinico;
        }
    }

    public DataTable SelectProntuarioClinicoByID(Int32 idFuncionario)
    {
        Database db = DatabaseFactory.CreateDatabase();
        Validacoes Valida = new Validacoes();
        DbCommand command = db.GetStoredProcCommand("ProntuarioClinicoSelectByID");
        db.AddInParameter(command, "@idFuncionario", DbType.Int32, idFuncionario);
        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }

    //APAGA UM DETERMINADO REGISTRO DA BASE
    public void DeleteProntuarioClinico(int id)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ProntuarioClinicoDelete");
        db.AddInParameter(command, "@id", DbType.Int32, id);
        db.ExecuteNonQuery(command);
    }

}
