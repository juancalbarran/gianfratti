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
    public class ProfissionaisDAL
    {
        public DataTable Listar(string Nome, string RG, string CPF, string idProfissionalPerfil)
        {
            //Filtros da Query
            string Where = " Where Profissionais.id <> 1 and Profissionais.Deletado = 0 ";
            if (Nome != string.Empty) { Where += " and Profissionais.Nome LIKE '%" + Nome.Replace("'", string.Empty) + "%' "; }
            if (RG != string.Empty) { Where += " and Profissionais.RG = '" + RG.Replace("'", string.Empty) + "' "; }
            if (CPF != string.Empty) { Where += " and Profissionais.CPF = '" + CPF.Replace("'", string.Empty) + "' "; }
            if (idProfissionalPerfil != string.Empty) { Where += " and Profissionais.idProfissionalPerfil = " + Convert.ToUInt32(idProfissionalPerfil) + " "; }
            string OrderBy = " Order By Profissionais.Nome ";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("Select Profissionais.*, (Year(Date()) - Year(dtNascimento)) as Idade, ProfissionalPerfil.Nome as PerfilNome FROM ProfissionalPerfil INNER JOIN Profissionais ON ProfissionalPerfil.id = Profissionais.idProfissionalPerfil " + Where + OrderBy + "  ");
            DataTable dt = new DataTable();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                dt.Load(dr);
            }
            return dt;
        }

        public void Incluir(ProfissionaisBE profissionaisBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("INSERT INTO Profissionais ( idProfissionalPerfil, Nome, DtNascimento, Endereco, CEP, Bairro, UF, Cidade, Telefone, Celular, Email, Senha, RG, CPF, Sexo, Registro, FlgAtivo, Obs ) VALUES ('" + profissionaisBE.idProfissionalPerfil + "', '" + profissionaisBE.Nome + "', '" + profissionaisBE.DtNascimento + "', '" + profissionaisBE.Endereco + "', '" + profissionaisBE.CEP + "', '" + profissionaisBE.Bairro + "', '" + profissionaisBE.UF + "', '" + profissionaisBE.Cidade + "', '" + profissionaisBE.Telefone + "', '" + profissionaisBE.Celular + "', '" + profissionaisBE.Email + "', '" + profissionaisBE.Senha + "', '" + profissionaisBE.RG + "', '" + profissionaisBE.CPF + "', '" + profissionaisBE.Sexo + "', '" + profissionaisBE.Registro + "', " + profissionaisBE.FlgAtivo + ", '" + profissionaisBE.Obs + "')");
            db.ExecuteNonQuery(command);
        }

        public void Alterar(ProfissionaisBE profissionaisBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("UPDATE Profissionais SET idProfissionalPerfil = '" + profissionaisBE.idProfissionalPerfil + "', Nome = '" + profissionaisBE.Nome + "', DtNascimento = '" + profissionaisBE.DtNascimento + "' , Endereco = '" + profissionaisBE.Endereco + "', CEP = '" + profissionaisBE.CEP + "', Bairro = '" + profissionaisBE.Bairro + "', UF = '" + profissionaisBE.UF + "', Cidade = '" + profissionaisBE.Cidade + "', Telefone = '" + profissionaisBE.Telefone + "', Celular = '" + profissionaisBE.Celular + "', Email = '" + profissionaisBE.Email + "', Senha = '" + profissionaisBE.Senha + "', RG = '" + profissionaisBE.RG + "', CPF = '" + profissionaisBE.CPF + "', Sexo = '" + profissionaisBE.Sexo + "', Registro = '" + profissionaisBE.Registro + "', FlgAtivo =  " + profissionaisBE.FlgAtivo + " ,  Obs = '" + profissionaisBE.Obs + "'  Where id = " + profissionaisBE.id);
            db.ExecuteNonQuery(command);
        }

        public DataTable ListarByIdPerfil(int idProfissionalPerfil)
        {
            //Filtros da Query
            string Where = " Where ";
            if (idProfissionalPerfil != 0) { Where += " idProfissionalPerfil = " + idProfissionalPerfil + " "; }
            string OrderBy = " Order By Nome ";
            if(idProfissionalPerfil == 0)Where = null; //Caso 0 entao retorna todos os profissionais sem filtro

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("Select * From Profissionais " + Where + OrderBy + " ");
            DataTable dt = new DataTable();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                dt.Load(dr);
            }
            return dt;
        }

        public ProfissionaisBE Obter(int id)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("Select * From Profissionais Where Deletado = 0 AND id = " + id + " ");

            using (IDataReader dr = db.ExecuteReader(command))
            {
                ProfissionaisBE profissionaisBE = new ProfissionaisBE();
                if (dr.Read())
                {
                    profissionaisBE.id = Convert.ToInt32(dr["id"]);
                    profissionaisBE.idProfissionalPerfil = Convert.ToInt32(dr["idProfissionalPerfil"]);
                    profissionaisBE.Registro = Convert.ToString(dr["Registro"]);
                    profissionaisBE.Nome = Convert.ToString(dr["nome"]);
                    profissionaisBE.DtNascimento = Convert.ToDateTime(dr["DtNascimento"]);
                    profissionaisBE.Endereco = Convert.ToString(dr["Endereco"]);
                    profissionaisBE.CEP = Convert.ToString(dr["CEP"]);
                    profissionaisBE.Bairro = Convert.ToString(dr["Bairro"]);
                    profissionaisBE.UF = Convert.ToString(dr["UF"]);
                    profissionaisBE.Cidade = Convert.ToString(dr["Cidade"]);
                    profissionaisBE.Telefone = Convert.ToString(dr["Telefone"]);
                    profissionaisBE.Celular = Convert.ToString(dr["Celular"]);
                    profissionaisBE.Email = Convert.ToString(dr["Email"]);
                    profissionaisBE.RG = Convert.ToString(dr["RG"]);
                    profissionaisBE.CPF = Convert.ToString(dr["CPF"]);
                    profissionaisBE.Sexo = Convert.ToString(dr["Sexo"]);
                    profissionaisBE.Senha = Convert.ToString(dr["Senha"]);
                    profissionaisBE.FlgAtivo = Convert.ToBoolean(dr["FlgAtivo"]);
                    profissionaisBE.Obs = Convert.ToString(dr["Obs"]);
                }
                return profissionaisBE;
            }
        }

        /// <summary>
        /// Metodo que retorna o ultimo ID da base de dados
        /// </summary>
        /// <returns></returns>
        public int ObterMaxId()
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT Max(Profissionais.id) as Id FROM Profissionais ");

            int idProfissional = 0;
            using (IDataReader dr = db.ExecuteReader(command))
            {
                if (dr.Read())
                {
                    idProfissional = Convert.ToInt32(dr["id"]);
                }
                return idProfissional;
            }
        }

        public ProfissionaisBE Login(string Email, string Senha)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT Profissionais.id, Profissionais.idProfissionalPerfil, Profissionais.Nome, Profissionais.Email, ProfissionalPerfil.Nome as PerfilNome FROM ProfissionalPerfil INNER JOIN Profissionais ON ProfissionalPerfil.id = Profissionais.idProfissionalPerfil Where Profissionais.Email = '" + Email.Replace("'", "") + "' and Profissionais.Senha = '" + Senha.Replace("'", "") + "' and Profissionais.FlgAtivo = true ");

            using (IDataReader dr = db.ExecuteReader(command))
            {
                ProfissionaisBE profissionaisBE = new ProfissionaisBE();
                if (dr.Read())
                {
                    profissionaisBE.id = Convert.ToInt32(dr["id"]);
                    profissionaisBE.Nome = Convert.ToString(dr["Nome"]);
                    profissionaisBE.idProfissionalPerfil = Convert.ToInt32(dr["idProfissionalPerfil"]);
                    profissionaisBE.RefprofissionalPerfilBE.Nome = Convert.ToString(dr["PerfilNome"]);
                    profissionaisBE.Email = Convert.ToString(dr["Email"]);
                }
                return profissionaisBE;
            }
        }

        public void Excluir(int id)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("UPDATE Profissionais SET Deletado = 1 Where id = " + id);
            db.ExecuteNonQuery(command);
        }
    }
}
