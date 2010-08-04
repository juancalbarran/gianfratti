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
using System.Data.Sql;
using System.Data.Common;

/// <summary>
/// Summary description for PCMSOXSetorDAL
/// </summary>
public class PCMSOXSetorDAL
{
	public PCMSOXSetorDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public void Insert(DbTransaction transaction,PCMSOXSetor ObjPCMSOXSetor,int idPCMSO)
    {
        try
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetStoredProcCommand("PCMSOXSetorInsert");            
            //Dados
            db.AddInParameter(command, "@idPCMSO", DbType.Int32, idPCMSO);
            db.AddInParameter(command, "@idSetor", DbType.Int32, ObjPCMSOXSetor.idSetor);
            db.AddInParameter(command, "@idCargo", DbType.Int32, ObjPCMSOXSetor.idCargo);
            ////Executa a proc que esta em transação e salva as informacoes dos procedimentos solicitados
            db.ExecuteNonQuery(command, transaction);
        }
        catch (Exception e)
        {
            throw e;
        }
    }
}
