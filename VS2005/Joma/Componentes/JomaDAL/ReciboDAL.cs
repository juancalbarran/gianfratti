using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Sql;
using System.Data.Common;
using JomaBE;

namespace JomaDAL
{
    public class ReciboDAL
    {
        public ReciboBE Incluir(ReciboBE reciboBE)
        {
            //Verifico se a lista de AgendamentoSessoes tem registros senao não crio o recibo
            //if (reciboBE.RefReciboAgendamentoSessoesBE.Count == 0)
                //return;

            //Insiro o Recibo
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("INSERT INTO Recibo ( idPaciente, Data, ValorTotal, Desconto) VALUES ('" + reciboBE.idPaciente + "','" + reciboBE.Data + "','" + reciboBE.ValorTotal + "','" + reciboBE.Desconto + "' )");
            db.ExecuteNonQuery(command);

            //Busco o ultimo ID do recibo
            DbCommand command2 = db.GetSqlStringCommand("select max(id) From Recibo");
            Int32 idRecibo = Convert.ToInt32(db.ExecuteScalar(command2));

            //Percorro a lista de sessoes que vai costar no recibo e insiro na tabela
            for (int i = 0; i < reciboBE.RefReciboAgendamentoSessoesBE.Count; i++)
            {
                DbCommand command3 = db.GetSqlStringCommand("INSERT INTO ReciboAgendamentoSessoes ( idRecibo, idAgendamentoSessoes, Valor) VALUES ('" + idRecibo + "','" + reciboBE.RefReciboAgendamentoSessoesBE[i].idAgendamentoSessoes + "','" + reciboBE.RefReciboAgendamentoSessoesBE[i].Valor + "' )");
                db.ExecuteNonQuery(command3);
            }
            
            reciboBE.id = idRecibo;

            return reciboBE;

        }

        /// <summary>
        /// Metodo que obtem todos os agendamentos com status Confirmado e Acerto para que seja selecinado os registros e gerado o  relatorio
        /// </summary>
        /// <param name="idPaciente"></param>
        /// <param name="idConvenio"></param>
        /// <returns></returns>
        public DataTable ObterAgendamentos(string idPaciente, string idConvenio, string idProfissional)
        {
            //Filtros da Query
            string Where = " Where SessoesStatus.id in(2,5) and AgendamentoSessoes.Deletado = 0 ";
            if (idPaciente != string.Empty) { Where += " and AgendamentoSessoes.idPaciente = " + idPaciente.Replace("'", string.Empty) + " "; }
            if (idConvenio != string.Empty) { Where += " and AgendamentoSessoes.idConvenio = " + idConvenio.Replace("'", string.Empty) + " "; }
            if (idProfissional != string.Empty) { Where += " and AgendamentoSessoes.idProfissional = " + idProfissional.Replace("'", string.Empty) + " "; }
            string OrderBy = " Order By DataInicio ";

            Database db = DatabaseFactory.CreateDatabase();
            string Sql;
            Sql = "SELECT AgendamentoSessoes.id, AgendamentoSessoes.DataInicio, AgendamentoSessoes.HoraInicio, AgendamentoSessoes.HoraFim, AgendamentoSessoes.Qtd, Convenio.Nome AS Convenio, SessoesStatus.Nome AS Status, Convenio.Valor, AgendamentoSessoes.idPaciente, AgendamentoSessoes.idConvenio, Profissionais.Nome as Profissional ";
            Sql += "FROM Profissionais INNER JOIN (SessoesStatus INNER JOIN (Convenio INNER JOIN AgendamentoSessoes ON Convenio.id = AgendamentoSessoes.idConvenio) ON SessoesStatus.id = AgendamentoSessoes.idSessoesStatus) ON Profissionais.id = AgendamentoSessoes.idProfissional ";
            DbCommand command = db.GetSqlStringCommand(Sql + Where + OrderBy);
            DataTable dt = new DataTable();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                dt.Load(dr);
            }
            return dt;
        }

        /// <summary>
        /// Metodo que obtem todos recibos que foram emitidos
        /// </summary>
        /// <param name="idPaciente"></param>
        /// <param name="idConvenio"></param>
        /// <returns></returns>
        public DataTable ObterRecibosEmitidos(string PacienteNome, string DataInicio, string DataFim)
        {
            //Filtros da Query
            string Where = " Where Recibo.Deletado = 0 ";
            if (PacienteNome != string.Empty) { Where += " and Paciente.Nome LIKE '%" + PacienteNome.Replace("'", string.Empty) + "%' "; }
            if (DataInicio != string.Empty) { Where += " and Recibo.Data BetWeen '" + Convert.ToDateTime(DataInicio) + "' and '" + Convert.ToDateTime(DataFim) + "' "; }
            string OrderBy = " Order By Recibo.id ";

            Database db = DatabaseFactory.CreateDatabase();
            string Sql;
            Sql = "SELECT Paciente.Nome, Recibo.Data, Recibo.ValorTotal, Recibo.Desconto, Recibo.id, Recibo.idPaciente ";
            Sql += "FROM Paciente INNER JOIN Recibo ON Paciente.id = Recibo.idPaciente ";
            DbCommand command = db.GetSqlStringCommand(Sql + Where + OrderBy);
            DataTable dt = new DataTable();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                dt.Load(dr);
            }
            return dt;
        }

        public void Excluir(int id)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("UPDATE Recibo SET Deletado = 1 Where id = " + id);
            db.ExecuteNonQuery(command);
        }
    }
}
