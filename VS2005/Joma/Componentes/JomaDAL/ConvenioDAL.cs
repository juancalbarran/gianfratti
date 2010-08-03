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
    public class ConvenioDAL
    {
        public DataTable Listar(string Nome)
        {
            //Filtros da Query
            string Where = " Where Deletado = 0 ";
            if (Nome != string.Empty) { Where += " and Nome like '%" + Nome + "%' "; }

            string OrderBy = " Order By Nome  ";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("Select * From Convenio " + Where + OrderBy + "  ");
            DataTable dt = new DataTable();
            using (IDataReader dr = db.ExecuteReader(command))
            {
                dt.Load(dr);
            }
            return dt;
        }

        public ConvenioBE Obter(int id)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("Select * From Convenio Where Deletado = 0 AND id = " + id + " ");

            using (IDataReader dr = db.ExecuteReader(command))
            {
                ConvenioBE convenioBE = new ConvenioBE();
                if (dr.Read())
                {
                    convenioBE.Nome = Convert.ToString(dr["nome"]);
                    convenioBE.Valor = Convert.ToDouble(dr["valor"]);
                }
                return convenioBE;
            }
        }

        public void Incluir(ConvenioBE convenioBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("INSERT INTO Convenio ( Nome, Valor ) VALUES ('" + convenioBE.Nome + "','" + convenioBE.Valor.ToString("00.00") + "')");
            db.ExecuteNonQuery(command);
        }

        public void Alterar(ConvenioBE convenioBE)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("UPDATE Convenio SET Nome = '" + convenioBE.Nome + "', Valor = '" + convenioBE.Valor.ToString("00.00") + "'  Where id = " + convenioBE.id);
            db.ExecuteNonQuery(command);
        }

        public void Excluir(int id)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("UPDATE Convenio SET Deletado = 1 Where id = " + id);
            db.ExecuteNonQuery(command);
        }
    }
}
