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
/// Summary description for PCMSOXRiscosOcupacionaisDAL
/// </summary>
public class PCMSOXRiscosOcupacionaisDAL
{
	public PCMSOXRiscosOcupacionaisDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public void Insert(DbTransaction transaction, List<PCMSOXRiscosOcupacionais> Obj, int idPCMSO)
    {
        try
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetStoredProcCommand("PCMSOXRiscosOcupacionaisInsert");
            Validacoes ObjValidacoes = new Validacoes();
            //Criando Parametros da Procedure
            db.AddInParameter(command, "@idPCMSO", DbType.Int32, null);
            db.AddInParameter(command, "@idCargo", DbType.Int32, null);
            db.AddInParameter(command, "@idRiscosOcupacionais", DbType.Int32, null);
            db.AddInParameter(command, "@idRiscosOcupacionaisItens", DbType.Int32, null);
            foreach (PCMSOXRiscosOcupacionais proc in Obj)
            {
                //Dados do Procedimento
                db.SetParameterValue(command, "@idPCMSO", idPCMSO);
                db.SetParameterValue(command, "@idCargo", proc.idCargo);
                db.SetParameterValue(command, "@idRiscosOcupacionais", proc.idRiscosOcupacionais);
                db.SetParameterValue(command, "@idRiscosOcupacionaisItens", proc.idRiscosOcupacionaisItens);
                //Executa a proc que esta em transação e salva as informacoes dos procedimentos solicitados
                db.ExecuteNonQuery(command, transaction);
            }
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    public PCMSO SelectByID(int idPCMSO,int idCargo)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("SELECT * FROM PCMSOXRiscosOcupacionais Where idPCMSO = " + idPCMSO + " and idCargo = " + idCargo + " ");

        using (IDataReader dr = db.ExecuteReader(command))
        {
            PCMSO ObjPCMSO = new PCMSO();
            while (dr.Read())
            {
                ObjPCMSO.RefPCMSOXRiscosOcupacionais.Add(new PCMSOXRiscosOcupacionais(Convert.ToInt32(dr["idPCMSO"]), Convert.ToInt32(dr["idCargo"]), Convert.ToInt32(dr["idRiscosOcupacionais"]), Convert.ToInt32(dr["idRiscosOcupacionaisItens"])));
            }
            return ObjPCMSO;
        }
    }
}
 