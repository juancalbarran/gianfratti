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
    public class EspecialidadeDAL
    {

        public DataTable Listar()
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("Select * From Especialidade Order By Nome ");
            DataTable dt = new DataTable();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                dt.Load(dr);
            }
            return dt;
        }


        public DataTable ListarByIdProfissionalEspecialidade(int idProfissional)
        {
            //Filtros da Query
            string Where = " Where ";
            if (idProfissional != 0) { Where += " ProfissionaisEspecialidade.idProfissional = " + idProfissional + " "; }
            string OrderBy = " Order By Especialidade.Nome ";
            if (idProfissional == 0) Where = null; //Caso 0 entao retorna todos os profissionais sem filtro

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("SELECT Especialidade.Nome, ProfissionaisEspecialidade.idEspecialidade, ProfissionaisEspecialidade.idProfissional, Especialidade.id FROM Especialidade INNER JOIN ProfissionaisEspecialidade ON Especialidade.id = ProfissionaisEspecialidade.idEspecialidade " + Where + OrderBy + " ");
            DataTable dt = new DataTable();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                dt.Load(dr);
            }
            return dt;
        }
    }
}
