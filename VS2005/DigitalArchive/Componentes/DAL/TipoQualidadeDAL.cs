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
    public class TipoQualidadeDAL
    {
        /// <summary>
        /// Innclui um novo registro
        /// </summary>
        /// <param name="usuarioBE"></param>
        public void Incluir(TipoQualidadeBE tipoQualidadeBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("INSERT INTO TipoQualidade (idUsuario,Nome) VALUES (" + tipoQualidadeBE.idUsuario + "," + tipoQualidadeBE.Nome + ")");
            db.ExecuteNonQuery(command);
        }

        /// <summary>
        /// Retorna uma lista de registro
        /// </summary>
        /// <returns></returns>
        public List<TipoQualidadeBE> Listar()
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT * FROM TipoQualidade");
            List<TipoQualidadeBE> Lista = new List<TipoQualidadeBE>();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                while (dr.Read())
                {
                    TipoQualidadeBE tipoQualidadeBE = new TipoQualidadeBE();
                    tipoQualidadeBE.ID = Convert.ToInt32(dr["ID"]);
                    tipoQualidadeBE.idUsuario = Convert.ToInt32(dr["idUsuario"]);
                    tipoQualidadeBE.Nome = Convert.ToString(dr["Nome"]);
                    Lista.Add(tipoQualidadeBE);
                }
            }
            return Lista;
        }

        /// <summary>
        /// Altera o cadastro
        /// </summary>
        /// <param name="usuarioBE"></param>
        public void Alterar(TipoQualidadeBE tipoQualidadeBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("UPDATE TipoQualidade SET idUsuario = " + tipoQualidadeBE.idUsuario + ",Nome = " + tipoQualidadeBE.Nome + " Where id = " + tipoQualidadeBE.ID);
            db.ExecuteNonQuery(command);
        }

        /// <summary>
        /// Obtem dados do registro passando o ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public TipoQualidadeBE Obter(int ID)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT * FROM TipoQualidade WHERE id = " + ID);

            using (IDataReader dr = db.ExecuteReader(command))
            {
                TipoQualidadeBE tipoQualidadeBE = new TipoQualidadeBE();
                if (dr.Read())
                {
                    tipoQualidadeBE.ID = Convert.ToInt32(dr["ID"]);
                    tipoQualidadeBE.idUsuario = Convert.ToInt32(dr["idUsuario"]);
                    tipoQualidadeBE.Nome = Convert.ToString(dr["Nome"]);
                }
                return tipoQualidadeBE;
            }
        }

        /// <summary>
        /// Exclui um o usuário passando o ID
        /// </summary>
        /// <param name="ID"></param>
        public void Excluir(int ID)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("DELETE FROM TipoQualidade Where id = " + ID);
            db.ExecuteNonQuery(command);
        }

    }
}
