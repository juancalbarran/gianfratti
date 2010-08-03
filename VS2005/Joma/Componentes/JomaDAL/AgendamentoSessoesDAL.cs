using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Collections;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Sql;
using System.Data.Common;
using JomaBE;
namespace JomaDAL
{
    public class AgendamentoSessoesDAL
    {
        public DataTable Listar(string idPaciente,string PacienteNome,string RG,string CPF,string idConvenio,string ConvenioNumero,string DataInicio,string DataFim, string idProfissional,string idEspecialidade, string idStatus)
        {
            //Filtros da Query
            string Where = " Where AgendamentoSessoes.idSessoesStatus <> 5 and AgendamentoSessoes.Deletado = 0 ";
            if (idPaciente != string.Empty) { Where += " and AgendamentoSessoes.idPaciente = " + Convert.ToInt32(idPaciente) + " "; }
            if (PacienteNome != string.Empty) { Where += " and Paciente.Nome like '%" + PacienteNome + "%' "; }
            if (RG != string.Empty) { Where += " and Paciente.RG Like '%" + RG + "%' "; }
            if (CPF != string.Empty) { Where += " and Paciente.CPF Like '%" + CPF + "%' "; }
            if (idConvenio != string.Empty) { Where += " and Convenio.id = " + Convert.ToInt32(idConvenio) + " "; }
            if (ConvenioNumero != string.Empty) { Where += " and AgendamentoSessoes.NumeroConvenio Like '%" + ConvenioNumero + "%' "; }
            if (DataInicio != string.Empty) { Where += " and AgendamentoSessoes.DataInicio BetWeen '" + Convert.ToDateTime(DataInicio) + "' and '" + Convert.ToDateTime(DataFim) + "' "; }
            if (idProfissional != string.Empty) { Where += " and Profissionais.id = " + Convert.ToInt32(idProfissional) + " "; }
            if (idEspecialidade != string.Empty) { Where += " and Especialidade.id = " + Convert.ToInt32(idEspecialidade) + " "; }
            if (idStatus != string.Empty) { Where += " and AgendamentoSessoes.idSessoesStatus = " + Convert.ToInt32(idStatus) + " "; }
            string OrderBy = " Order By AgendamentoSessoes.DataInicio  ";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT AgendamentoSessoes.*, Paciente.Nome as PacienteNome,Paciente.RG, Convenio.Nome as ConvenioNome, Profissionais.Nome as ProfissionaisNome, Especialidade.Nome as EspecialidadeNome, SessoesStatus.Nome as StatusNome FROM SessoesStatus INNER JOIN (Especialidade INNER JOIN (Profissionais INNER JOIN (Convenio INNER JOIN (Paciente INNER JOIN AgendamentoSessoes ON Paciente.id = AgendamentoSessoes.idPaciente) ON Convenio.id = AgendamentoSessoes.idConvenio) ON Profissionais.id = AgendamentoSessoes.idProfissional) ON Especialidade.id = AgendamentoSessoes.idEspecialidade) ON SessoesStatus.id = AgendamentoSessoes.idSessoesStatus " + Where + OrderBy + "  ");
            DataTable dt = new DataTable();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                dt.Load(dr);
            }
            return dt;
        }

        public DataTable ListarAgendaMultiProfissionais(string idProfissional)
        {
            //Filtros da Query
            string Where = " Where AgendamentoSessoes.idSessoesStatus <> 5 ";
            if (idProfissional != string.Empty) { Where += " and AgendamentoSessoes.idProfissional = " + idProfissional + " "; }
            //string OrderBy = " Order By Nome ";
            if (idProfissional == string.Empty) Where = null; //Caso 0 entao retorna todos os profissionais sem filtro

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT AgendamentoSessoes.*, Paciente.Nome AS PacienteNome, Profissionais.Nome as ProfissionalNome FROM Profissionais INNER JOIN (Paciente INNER JOIN AgendamentoSessoes ON Paciente.id = AgendamentoSessoes.idPaciente) ON Profissionais.id = AgendamentoSessoes.idProfissional " + Where + " ");
            DataTable dt = new DataTable();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                dt.Load(dr);
            }
            return dt;
        }

        public void Incluir(List<AgendamentoSessoesBE> agendamentoSessoesBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            for (int i = 0; i < agendamentoSessoesBE.Count; i++)
            {
                DbCommand command = db.GetSqlStringCommand("INSERT INTO AgendamentoSessoes (idPaciente,idConvenio,idProfissional,idEspecialidade,idSessoesStatus,NumeroConvenio,Qtd,DataInicio,DataFim,HoraInicio,HoraFim,Valor) VALUES ('" + agendamentoSessoesBE[i].idPaciente + "','" + agendamentoSessoesBE[i].idConvenio + "','" + agendamentoSessoesBE[i].idProfissional + "','" + agendamentoSessoesBE[i].idEspecialidade + "','" + agendamentoSessoesBE[i].idSessoesStatus + "','" + agendamentoSessoesBE[i].NumeroConvenio + "','" + agendamentoSessoesBE[i].Qtd + "','" + agendamentoSessoesBE[i].DataInicio + "','" + agendamentoSessoesBE[i].DataFim + "','" + agendamentoSessoesBE[i].HoraInicio + "','" + agendamentoSessoesBE[i].HoraFim + "','" + agendamentoSessoesBE[i].Valor + "' )");
                db.ExecuteNonQuery(command);
            }
        }

        public void AlteraStatus(int idAgendamentoSessoes, int idSessoesStatus)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("UPDATE AgendamentoSessoes SET idSessoesStatus = '" + idSessoesStatus + "' Where id = " + idAgendamentoSessoes);
            db.ExecuteNonQuery(command);
        }
    }
}
