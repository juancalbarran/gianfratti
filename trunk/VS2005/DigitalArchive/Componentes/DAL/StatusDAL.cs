//Data:         13/02/2009
//Autor:        Fabrizio Gianfratti Manes
//Descrição:    Classe de acesso a Dados
//Atualização:

using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Sql;
using System.Data.Common;
using BE;

namespace DAL
{
    public class StatusDAL
    {
        /// <summary>
        /// Innclui um novo registro
        /// </summary>
        /// <param name="usuarioBE"></param>
        public void Incluir(StatusBE statusBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("INSERT INTO Status (Nome) VALUES (" + statusBE.Nome + ")");
            db.ExecuteNonQuery(command);
        }

        /// <summary>
        /// Retorna uma lista de registro
        /// </summary>
        /// <returns></returns>
        public List<StatusBE> Listar()
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT * FROM Status");
            List<StatusBE> Lista = new List<StatusBE>();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                while (dr.Read())
                {
                    StatusBE statusBE = new StatusBE();
                    statusBE.ID = Convert.ToInt32(dr["ID"]);
                    statusBE.Nome = Convert.ToString(dr["Nome"]);
                    Lista.Add(statusBE);
                }
            }
            return Lista;
        }

        /// <summary>
        /// Altera o cadastro
        /// </summary>
        /// <param name="usuarioBE"></param>
        public void Alterar(StatusBE statusBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("UPDATE Status SET Nome = " + statusBE.Nome + " Where id = " + statusBE.ID);
            db.ExecuteNonQuery(command);
        }

        /// <summary>
        /// Obtem dados do registro passando o ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public StatusBE Obter(int ID)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT * FROM Status WHERE id = " + ID);

            using (IDataReader dr = db.ExecuteReader(command))
            {
                StatusBE statusBE = new StatusBE();
                if (dr.Read())
                {
                    statusBE.ID = Convert.ToInt32(dr["ID"]);
                    statusBE.Nome = Convert.ToString(dr["Nome"]);
                }
                return statusBE;
            }
        }

        /// <summary>
        /// Exclui um o usuário passando o ID
        /// </summary>
        /// <param name="ID"></param>
        public void Excluir(int ID)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("DELETE FROM Status Where id = " + ID);
            db.ExecuteNonQuery(command);
        }

    }
}
