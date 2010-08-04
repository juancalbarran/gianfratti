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
/// Summary description for PCMSOXExamesComplementaresDAL
/// </summary>
public class PCMSOXExamesComplementaresDAL
{
	public PCMSOXExamesComplementaresDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public void Insert(DbTransaction transaction, List<PCMSOXExamesComplementares> Obj, int idPCMSO)
    {
        try
        {
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand command = db.GetStoredProcCommand("PCMSOXExamesComplementaresInsert");
            Validacoes ObjValidacoes = new Validacoes();
            //Criando Parametros da Procedure
            db.AddInParameter(command, "@idPCMSO", DbType.Int32, null);
            db.AddInParameter(command, "@idCargo", DbType.Int32, null);
            db.AddInParameter(command, "@idTipoAtestado", DbType.Int32, null);
            db.AddInParameter(command, "@idExamesComplementares", DbType.Int32, null);
            db.AddInParameter(command, "@idPeriodicidade", DbType.Int32, null);
            foreach (PCMSOXExamesComplementares proc in Obj)
            {
                //Dados do Procedimento
                db.SetParameterValue(command, "@idPCMSO", idPCMSO);
                db.SetParameterValue(command, "@idCargo", proc.idCargo);
                db.SetParameterValue(command, "@idTipoAtestado", proc.idTipoAtestado);
                db.SetParameterValue(command, "@idExamesComplementares", proc.idExamesComplementares);
                db.SetParameterValue(command, "@idPeriodicidade", ObjValidacoes.TextoNull(proc.idPeriodicidade));
                //Executa a proc que esta em transação e salva as informacoes dos procedimentos solicitados
                db.ExecuteNonQuery(command, transaction);
            }
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    public PCMSO SelectByID(int idPCMSO, int idCargo, int idTipoAtestado)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand("SELECT * FROM PCMSOXExamesComplementares Where idPCMSO = " + idPCMSO + " and idCargo = " + idCargo + " and idTipoAtestado = " + idTipoAtestado + " ");

        using (IDataReader dr = db.ExecuteReader(command))
        {
            PCMSO ObjPCMSO = new PCMSO();
            while (dr.Read())
            {
                ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(Convert.ToInt32(dr["idPCMSO"]), Convert.ToInt32(dr["idCargo"]), Convert.ToInt32(dr["idTipoAtestado"]), Convert.ToInt32(dr["idExamesComplementares"]), Convert.ToString(dr["idPeriodicidade"])));
            }
            return ObjPCMSO;
        }
    }
}
