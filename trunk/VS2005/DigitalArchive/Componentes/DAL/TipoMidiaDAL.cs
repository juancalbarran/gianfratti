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
    public class TipoMidiaDAL
    {
        /// <summary>
        /// Innclui um novo registro
        /// </summary>
        /// <param name="usuarioBE"></param>
        public void Incluir(TipoMidiaBE tipoMidiaBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("INSERT INTO TipoMidia (idUsuario,Nome) VALUES (" + tipoMidiaBE.idUsuario + "," + tipoMidiaBE.Nome + ")");
            db.ExecuteNonQuery(command);
        }

        /// <summary>
        /// Retorna uma lista de registro
        /// </summary>
        /// <returns></returns>
        public List<TipoMidiaBE> Listar()
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT * FROM TipoMidia");
            List<TipoMidiaBE> Lista = new List<TipoMidiaBE>();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                while (dr.Read())
                {
                    TipoMidiaBE tipoMidiaBE = new TipoMidiaBE();
                    tipoMidiaBE.ID = Convert.ToInt32(dr["ID"]);
                    tipoMidiaBE.idUsuario = Convert.ToInt32(dr["idUsuario"]);
                    tipoMidiaBE.Nome = Convert.ToString(dr["Nome"]);
                    Lista.Add(tipoMidiaBE);
                }
            }
            return Lista;
        }

        /// <summary>
        /// Altera o cadastro
        /// </summary>
        /// <param name="usuarioBE"></param>
        public void Alterar(TipoMidiaBE tipoMidiaBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("UPDATE TipoMidia SET idUsuario = " + tipoMidiaBE.idUsuario + ",Nome = " + tipoMidiaBE.Nome + " Where id = " + tipoMidiaBE.ID);
            db.ExecuteNonQuery(command);
        }

        /// <summary>
        /// Obtem dados do registro passando o ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public TipoMidiaBE Obter(int ID)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT * FROM TipoMidia WHERE id = " + ID);

            using (IDataReader dr = db.ExecuteReader(command))
            {
                TipoMidiaBE tipoMidiaBE = new TipoMidiaBE();
                if (dr.Read())
                {
                    tipoMidiaBE.ID = Convert.ToInt32(dr["ID"]);
                    tipoMidiaBE.idUsuario = Convert.ToInt32(dr["idUsuario"]);
                    tipoMidiaBE.Nome = Convert.ToString(dr["Nome"]);
                }
                return tipoMidiaBE;
            }
        }

        /// <summary>
        /// Exclui um o usuário passando o ID
        /// </summary>
        /// <param name="ID"></param>
        public void Excluir(int ID)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("DELETE FROM TipoMidia Where id = " + ID);
            db.ExecuteNonQuery(command);
        }

    }
}
