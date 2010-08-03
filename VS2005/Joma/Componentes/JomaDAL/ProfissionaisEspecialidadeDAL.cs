using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Sql;
using System.Data.Common;
using JomaBE;

namespace JomaDAL
{
    public class ProfissionaisEspecialidadeDAL
    {
        public void Incluir(List<ProfissionaisEspecialidadeBE> profissionaisEspecialidadeBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            for (int i = 0; i < profissionaisEspecialidadeBE.Count; i++)
            {
                DbCommand command = db.GetSqlStringCommand("INSERT INTO ProfissionaisEspecialidade ( idProfissional, idEspecialidade ) VALUES (" + profissionaisEspecialidadeBE[i].idProfissional + ", " + profissionaisEspecialidadeBE[i].idEspecialidade + ")");
                db.ExecuteNonQuery(command);
            }
        }

        /// <summary>
        /// Retorna um lista com as especialidades de um determinado profissional
        /// </summary>
        /// <param name="idProfissional"></param>
        /// <returns></returns>
        public List<ProfissionaisEspecialidadeBE> Obter(Int32 idProfissional)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT * FROM ProfissionaisEspecialidade Where idProfissional = " + idProfissional);

            using (IDataReader dr = db.ExecuteReader(command))
            {
                List<ProfissionaisEspecialidadeBE> Lista = new List<ProfissionaisEspecialidadeBE>();
                while (dr.Read())
                {
                    ProfissionaisEspecialidadeBE profissionaisEspecialidadeBE = new ProfissionaisEspecialidadeBE();
                    profissionaisEspecialidadeBE.id = Convert.ToInt32(dr["id"]);
                    profissionaisEspecialidadeBE.idProfissional = Convert.ToInt32(dr["idProfissional"]);
                    profissionaisEspecialidadeBE.idEspecialidade = Convert.ToInt32(dr["idEspecialidade"]);
                    Lista.Add(profissionaisEspecialidadeBE);
                }
                return Lista;
            }
        }


        /// <summary>
        /// Meotodo responsavel por apagar as especialidades do profissional
        /// </summary>
        /// <param name="idProfissional"></param>
        public void Delete(Int32 idProfissional)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("Delete From ProfissionaisEspecialidade Where idProfissional = " + idProfissional);
            db.ExecuteNonQuery(command);
        }
    }
}
