using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.Practices.EnterpriseLibrary.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Sql;
using System.Data.Common;

/// <summary>
/// Summary description for ExamesComplementaresDAL
/// </summary>
public class ExamesComplementaresDAL
{
    public ExamesComplementaresDAL()
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
    /// <param name="ObjExamesComplementares"></param>
    public void InsertUpdate(ExamesComplementares ObjExamesComplementares)
    {
        try
        {
            string NomeProc;
            Database db = DatabaseFactory.CreateDatabase();
            Validacoes ObjValidacoes = new Validacoes();
            if (ObjExamesComplementares.id != 0) { NomeProc = "ExamesComplementaresUpdate"; } else { NomeProc = "ExamesComplementaresInsert"; }
            DbCommand command = db.GetStoredProcCommand(NomeProc);
            //Caso id(chave primaria for diferente de zero(0) então é passado o parametro para fazer o update
            if (ObjExamesComplementares.id != 0) { db.AddInParameter(command, "@ID", DbType.Int32, ObjExamesComplementares.id); }
            //Dados
            db.AddInParameter(command, "@Descricao", DbType.String, ObjExamesComplementares.Descricao);
            //Executa
            db.ExecuteNonQuery(command);
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    /// <summary>
    /// Retorna um DataTable com todos os exames.
    /// </summary>
    /// <returns></returns>
    /// 
    public DataTable SelectAll(string Descricao)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ExamesComplementaresSelectAll");
        db.AddInParameter(command, "@Descricao", DbType.String, Descricao);

        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }

    //USADO PARA POPULAR UM DROPDOWNLIST
    public DataTable DropDownlist()
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ExamesComplementaresSelectAll");

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
    /// <returns></returns>
    public ExamesComplementares SelectByID(int id)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ExamesComplementaresSelectByID");
        db.AddInParameter(command, "@id", DbType.Int32, id);

        using (IDataReader dr = db.ExecuteReader(command))
        {
            ExamesComplementares ObjExamesComplementares = new ExamesComplementares();
            if (dr.Read())
            {
                ObjExamesComplementares.id = Convert.ToInt32(dr["id"]);
                ObjExamesComplementares.Descricao = Convert.ToString(dr["Descricao"]);
            }
            return ObjExamesComplementares;
        }
    }

    //USADO PARA POPULAR UM POPULAR UM DataTable
    public DataTable DataTable()
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Select id,Descricao From ExamesComplementares Order By Descricao");

        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }


    /// <summary>
    /// Deletar um registro
    /// </summary>
    /// <param name="id"></param>
    public void Delete(int id)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("ExamesComplementaresDelete");
        db.AddInParameter(command, "@id", DbType.Int32, id);
        db.ExecuteNonQuery(command);
    }
}
