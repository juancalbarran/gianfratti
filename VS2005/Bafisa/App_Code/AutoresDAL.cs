using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.Practices.EnterpriseLibrary.Data;
//using System.Data.OleDb;
using System.Data.Common;

/// <summary>
/// Summary description for AutoresDAL
/// </summary>
public class AutoresDAL
{
	public AutoresDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    /// <summary>
    /// INSERE UM NOVO REGISTRO OU ATUALIZA UM DETERMINDO REGISTRO JÁ EXISTENTE.
    /// EXEMPLO:
    /// PARA INSERT BASTA PASSAR O ID DA TEBELA COMO ZERO(0)
    /// PARA UPDATE BASTA PASSAR O ID DA TABELA DIFERENTE DE ZERO(0)
    /// </summary>
    /// <param name="ObjAutores"></param>
    public void InsertUpdate(Autores ObjAutores)
    {
        try
        {
            string Sql;
            string Insert = "INSERT INTO Autores (Nome, Descricao, Img) VALUES ('" + ObjAutores.Nome + "', '" + ObjAutores.Descricao + "', '" + ObjAutores.Img + "')";
            string Update = "UPDATE Autores SET Nome = '" + ObjAutores.Nome + "' , Descricao = '" + ObjAutores.Descricao + "' , Img = '" + ObjAutores.Img + "' WHERE id = " + ObjAutores.id + " ";

            Database db = DatabaseFactory.CreateDatabase();
            if (ObjAutores.id != 0) { Sql = Update; } else { Sql = Insert; }
            DbCommand command = db.GetSqlStringCommand(Sql);
            //Executa
            db.ExecuteNonQuery(command);
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    /// <summary>
    /// Retorna todos os registros em um DataTable
    /// </summary>
    /// <returns></returns>
    public DataTable SelectAll()
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select id,Nome,Descricao,Img From Autores");

        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }

    /// <summary>
    /// Seleciona um determinado registro conformo o ID
    /// </summary>
    /// <param name="id"></param>
    /// <returns>ObjAutores</returns>
    public Autores SelectByID(int id)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select id,Nome,Descricao,Img From Autores Where id = " + id);

        using (IDataReader dr = db.ExecuteReader(command))
        {
            Autores ObjAutores = new Autores();
            if (dr.Read())
            {
                ObjAutores.id = Convert.ToInt32(dr["id"]);
                ObjAutores.Nome = Convert.ToString(dr["Nome"]);
                ObjAutores.Descricao = Convert.ToString(dr["Descricao"]);
                ObjAutores.Img = Convert.ToString(dr["Img"]);
            }
            return ObjAutores;
        }
    }

    /// <summary>
    /// Deletar um registro
    /// </summary>
    /// <param name="id"></param>
    public void DeleteByID(int id)
    {
        try
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetSqlStringCommand("Delete From Autores Where id = " + id);
            db.ExecuteNonQuery(command);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}
