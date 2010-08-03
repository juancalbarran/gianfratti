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
    public class TipoArquivoDAL
    {
        /// <summary>
        /// Innclui um novo registro
        /// </summary>
        /// <param name="usuarioBE"></param>
        public void Incluir(TipoArquivoBE tipoArquivoBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("INSERT INTO TipoArquivo (idUsuario,idTipoQualidade,Nome) VALUES (" + tipoArquivoBE.idUsuario + "," + tipoArquivoBE.IdTipoQualidade + ","+ tipoArquivoBE.Nome +" )");
            db.ExecuteNonQuery(command);
        }

        /// <summary>
        /// Retorna uma lista de registro
        /// </summary>
        /// <returns></returns>
        public List<TipoArquivoBE> Listar()
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT * FROM TipoArquivo");
            List<TipoArquivoBE> Lista = new List<TipoArquivoBE>();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                while (dr.Read())
                {
                    TipoArquivoBE tipoArquivoBE = new TipoArquivoBE();
                    tipoArquivoBE.ID = Convert.ToInt32(dr["ID"]);
                    tipoArquivoBE.idUsuario = Convert.ToInt32(dr["idUsuario"]);
                    tipoArquivoBE.IdTipoQualidade = Convert.ToInt32(dr["IdTipoQualidade"]);
                    tipoArquivoBE.Nome = Convert.ToString(dr["Nome"]);
                    Lista.Add(tipoArquivoBE);
                }
            }
            return Lista;
        }

        /// <summary>
        /// Altera o cadastro
        /// </summary>
        /// <param name="usuarioBE"></param>
        public void Alterar(TipoArquivoBE tipoArquivoBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("UPDATE TipoArquivo SET idUsuario = " + tipoArquivoBE.idUsuario + ",IdTipoQualidade = " + tipoArquivoBE.IdTipoQualidade + ",Nome = " + tipoArquivoBE.Nome + " Where id = " + tipoArquivoBE.ID);
            db.ExecuteNonQuery(command);
        }

        /// <summary>
        /// Obtem dados do registro passando o ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public TipoArquivoBE Obter(int ID)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT * FROM TipoArquivo WHERE id = " + ID);

            using (IDataReader dr = db.ExecuteReader(command))
            {
                TipoArquivoBE tipoArquivoBE = new TipoArquivoBE();
                if (dr.Read())
                {
                    tipoArquivoBE.ID = Convert.ToInt32(dr["ID"]);
                    tipoArquivoBE.idUsuario = Convert.ToInt32(dr["idUsuario"]);
                    tipoArquivoBE.IdTipoQualidade = Convert.ToInt32(dr["IdTipoQualidade"]);
                    tipoArquivoBE.Nome = Convert.ToString(dr["Nome"]);
                }
                return tipoArquivoBE;
            }
        }

        /// <summary>
        /// Exclui um o usuário passando o ID
        /// </summary>
        /// <param name="ID"></param>
        public void Excluir(int ID)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("DELETE FROM TipoArquivo Where id = " + ID);
            db.ExecuteNonQuery(command);
        }

    }
}
