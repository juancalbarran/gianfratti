using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;
using System.Collections.Generic;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Sql;
using System.Data.Common;

/// <summary>
/// Summary description for PCMSODAL
/// </summary>
public class PCMSODAL
{
	public PCMSODAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    //INSERE UM NOVO REGISTRO
    public void Insert(PCMSO ObjPCMSO)
    {
        Database db = DatabaseFactory.CreateDatabase();
        using (DbConnection connection = db.CreateConnection())
        {
            connection.Open();
            DbTransaction transaction = connection.BeginTransaction();
            try
            {
                int idPCMSO = 0;
                if (ObjPCMSO.id == 0)
                {
                    DbCommand command = db.GetStoredProcCommand("PCMSOInsert");
                    db.AddInParameter(command, "@idCliente", DbType.String, ObjPCMSO.idCliente);
                    if (ObjPCMSO.id == 0)
                    {
                        //Parametros de OutPut
                        db.AddOutParameter(command, "@id", DbType.Int32, 8);
                    }
                    //Executa a procedure
                    db.ExecuteNonQuery(command, transaction);
                    idPCMSO = Convert.ToInt32(db.GetParameterValue(command, "@id"));
                }
                else
                {
                    idPCMSO = ObjPCMSO.id;
                }
                //Delete os registros para que sejam cadastrados novamente
                DeleteSetor(idPCMSO, ObjPCMSO.RefObjPCMSOXSetor.idSetor, ObjPCMSO.RefObjPCMSOXSetor.idCargo);
                DeleteRiscos(idPCMSO, ObjPCMSO.RefObjPCMSOXSetor.idCargo);
                DeleteExames(idPCMSO, ObjPCMSO.RefObjPCMSOXSetor.idCargo);

                //Inserts
                //Chama o DAL que vai fazer insert da tabela PCMSOXSetor
                PCMSOXSetorDAL ObjPCMSOXSetorDAL = new PCMSOXSetorDAL();
                ObjPCMSOXSetorDAL.Insert(transaction, ObjPCMSO.RefObjPCMSOXSetor, idPCMSO);
                //Chama o DAL que vai fazer insert da tabela PCMSOXRiscosOcupacionais
                PCMSOXRiscosOcupacionaisDAL ObjPCMSOXRiscosOcupacionaisDAL = new PCMSOXRiscosOcupacionaisDAL();
                ObjPCMSOXRiscosOcupacionaisDAL.Insert(transaction, ObjPCMSO.RefPCMSOXRiscosOcupacionais, idPCMSO);
                //Chama o DAL que vai fazer insert da tabela PCMSOXExamesComplementares
                PCMSOXExamesComplementaresDAL ObjPCMSOXExamesComplementaresDAL = new PCMSOXExamesComplementaresDAL();
                ObjPCMSOXExamesComplementaresDAL.Insert(transaction, ObjPCMSO.RefPCMSOXExamesComplementares, idPCMSO);
                
                //Commit na transação
                transaction.Commit();
            }
            catch (Exception ex)
            {
                // Roll back na transação 
                transaction.Rollback();
                throw ex;
            }
            connection.Close();
        }
    }

    public DataTable SelectAll(string Cliente)
    {

        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("PCMSOSelectAll");
        db.AddInParameter(command, "@Cliente", DbType.String, Cliente);
        DataTable dt = new DataTable();
        
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }

        return dt;
    }

    public DataTable PCMSO_Completo(int idCliente, int idPCMSO)
    {

        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("PCMSO_Completo");
        db.AddInParameter(command, "@idCliente", DbType.Int32, idCliente);
        db.AddInParameter(command, "@idPCMSO", DbType.Int32, idPCMSO);
        DataTable dt = new DataTable();

        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }

        return dt;
    }

    /// <summary>
    /// Deletar registro
    /// </summary>
    /// <param name="id"></param>
    public void Delete(int id)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("Delete From PCMSO Where id = " + id);
        db.ExecuteNonQuery(command);
    }
    /// <summary>
    /// Deleta registros
    /// </summary>
    /// <param name="idPCMSO"></param>
    /// <param name="idSetor"></param>
    /// <param name="idCargo"></param>
    public void DeleteSetor(int idPCMSO,int idSetor,int idCargo)
    {
        Database db = DatabaseFactory.CreateDatabase();
        String SQL = "Delete From PCMSOXSetor Where idPCMSO = " + idPCMSO + " and idSetor = " + idSetor + " and idCargo = " + idCargo;
        DbCommand command = db.GetSqlStringCommand(SQL);
        db.ExecuteNonQuery(command);
    }
    /// <summary>
    /// Deleta registros
    /// </summary>
    /// <param name="idPCMSO"></param>
    /// <param name="idCargo"></param>
    public void DeleteRiscos(int idPCMSO,int idCargo)
    {
        Database db = DatabaseFactory.CreateDatabase();
        String SQL = "Delete From PCMSOXRiscosOcupacionais Where idPCMSO = " + idPCMSO + " and idCargo = " + idCargo;
        DbCommand command = db.GetSqlStringCommand(SQL);
        db.ExecuteNonQuery(command);
    }
    /// <summary>
    /// Deleta registros
    /// </summary>
    /// <param name="idPCMSO"></param>
    /// <param name="idCargo"></param>
    public void DeleteExames(int idPCMSO, int idCargo)
    {
        Database db = DatabaseFactory.CreateDatabase();
        String SQL = "Delete From PCMSOXExamesComplementares Where idPCMSO = " + idPCMSO + " and idCargo = " + idCargo;
        DbCommand command = db.GetSqlStringCommand(SQL);
        db.ExecuteNonQuery(command);
    }
}
