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
    public class PacienteDAL
    {
        public DataTable Listar(string Nome, string RG, string CPF)
        {
            //Filtros da Query
            string Where = " Where Deletado = 0 ";
            if (Nome != string.Empty) { Where += " and Nome LIKE '%" + Nome.Replace("'", string.Empty) + "%' "; }
            if (RG != string.Empty) { Where += " and RG = '" + RG.Replace("'", string.Empty) + "' "; }
            if (CPF != string.Empty) { Where += " and CPF = '" + CPF.Replace("'", string.Empty) + "' "; }
            string OrderBy = " Order By Nome ";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("Select *, (Year(Date()) - Year(dtNascimento)) as Idade From Paciente " + Where + OrderBy + "  ");
            DataTable dt = new DataTable();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                dt.Load(dr);
            }
            return dt;
        }

        public void Incluir(PacienteBE pacienteBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("INSERT INTO Paciente ( idConvenio, Nome, NumeroConvenio, DtNascimento, Endereco, CEP, Bairro, UF, Cidade, Telefone, Celular, Email, RG, CPF, Sexo, Obs ) VALUES ('" + pacienteBE.idConvenio + "','" + pacienteBE.Nome + "','" + pacienteBE.NumeroConvenio + "','" + pacienteBE.DtNascimento + "', '" + pacienteBE.Endereco + "', '" + pacienteBE.CEP + "', '" + pacienteBE.Bairro + "', '" + pacienteBE.UF + "', '" + pacienteBE.Cidade + "', '" + pacienteBE.Telefone + "', '" + pacienteBE.Celular + "', '" + pacienteBE.Email + "', '" + pacienteBE.RG + "', '" + pacienteBE.CPF + "', '" + pacienteBE.Sexo + "', '" + pacienteBE.Obs + "')");
            db.ExecuteNonQuery(command);
        }

        public PacienteBE Obter(int id)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("Select * From Paciente Where Deletado = 0 AND id = " + id + " ");

            using (IDataReader dr = db.ExecuteReader(command))
            {
                PacienteBE paciente = new PacienteBE();
                if (dr.Read())
                {
                    paciente.id = Convert.ToInt32(dr["id"]);
                    paciente.idConvenio = Convert.ToString(dr["idConvenio"]);
                    paciente.Nome = Convert.ToString(dr["nome"]);
                    paciente.NumeroConvenio = Convert.ToString(dr["NumeroConvenio"]);
                    paciente.DtNascimento = Convert.ToDateTime(dr["DtNascimento"]);
                    paciente.Endereco = Convert.ToString(dr["Endereco"]);
                    paciente.CEP = Convert.ToString(dr["CEP"]);
                    paciente.Bairro = Convert.ToString(dr["Bairro"]);
                    paciente.UF = Convert.ToString(dr["UF"]);
                    paciente.Cidade = Convert.ToString(dr["Cidade"]);
                    paciente.Telefone = Convert.ToString(dr["Telefone"]);
                    paciente.Celular = Convert.ToString(dr["Celular"]);
                    paciente.Email = Convert.ToString(dr["Email"]);
                    paciente.RG = Convert.ToString(dr["RG"]);
                    paciente.CPF = Convert.ToString(dr["CPF"]);
                    paciente.Sexo = Convert.ToString(dr["Sexo"]);
                    paciente.Obs = Convert.ToString(dr["Obs"]);
                }
                return paciente;
            }
        }

        public void Alterar(PacienteBE pacienteBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("UPDATE Paciente SET idConvenio = '" + pacienteBE.idConvenio + "', Nome = '" + pacienteBE.Nome + "',NumeroConvenio = '" + pacienteBE.NumeroConvenio + "', DtNascimento = '" + pacienteBE.DtNascimento + "' , Endereco = '" + pacienteBE.Endereco + "', CEP = '" + pacienteBE.CEP + "', Bairro = '" + pacienteBE.Bairro + "', UF = '" + pacienteBE.UF + "', Cidade = '" + pacienteBE.Cidade + "', Telefone = '" + pacienteBE.Telefone + "', Celular = '" + pacienteBE.Celular + "', Email = '" + pacienteBE.Email + "', RG = '" + pacienteBE.RG + "', CPF = '" + pacienteBE.CPF + "', Sexo = '" + pacienteBE.Sexo + "', Obs = '" + pacienteBE.Obs + "'  Where id = " + pacienteBE.id);
            db.ExecuteNonQuery(command);
        }

        public void Excluir(int id)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("UPDATE Paciente SET Deletado = 1 Where id = " + id);
            db.ExecuteNonQuery(command);
        }
    }
}
