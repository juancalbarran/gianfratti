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
using System.Collections.Generic;

/// <summary>
/// Summary description for EncaminhamentoXExamesComplementaresDAL
/// </summary>
public class EncaminhamentoXExamesComplementaresDAL
{
	public EncaminhamentoXExamesComplementaresDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    //Faz o insert na tabela de usuarios X clientes
    public void InsertEncaminhamentoXExamesComplementares(List<EncaminhamentoXExamesComplementares> Obj, int IdEncaminhamento)
    {
        try
        {
            //Na proc de Insert de usuario tem o comando DELETE, antes do insert ele deleta todos
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand commandDelete = db.GetSqlStringCommand("Delete From EncaminhamentoXExamesComplementares Where idEncaminhamento = " + IdEncaminhamento);
            db.ExecuteNonQuery(commandDelete);

            DbCommand command = db.GetStoredProcCommand("Encaminhamento_X_ExamesComplementares");
            Validacoes ObjValidacoes = new Validacoes();
            //Criando Parametros da Procedure
            db.AddInParameter(command, "@idEncaminhamento", DbType.Int32, null);
            db.AddInParameter(command, "@idExamesComplementares", DbType.Int32, null);

            foreach (EncaminhamentoXExamesComplementares proc in Obj)
            {
                if (IdEncaminhamento == 0)
                    IdEncaminhamento = proc.IdEncaminhamento;

                //Dados
                db.SetParameterValue(command, "@idEncaminhamento", IdEncaminhamento);
                db.SetParameterValue(command, "@idExamesComplementares", proc.IdExamesComplementares);
                //Executa a proc que esta em transação
                db.ExecuteNonQuery(command);
            }
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    public DataTable SelectEncaminhamentoXExamesComplementares(int idEncaminhamento)
    {
        string sql;
        sql = "SELECT dbo.EncaminhamentoXExamesComplementares.id, dbo.EncaminhamentoXExamesComplementares.idEncaminhamento, " +
                "dbo.EncaminhamentoXExamesComplementares.idExamesComplementares, dbo.ExamesComplementares.Descricao " +
                "FROM dbo.EncaminhamentoXExamesComplementares INNER JOIN " +
                "dbo.ExamesComplementares ON " +
                "dbo.EncaminhamentoXExamesComplementares.idExamesComplementares = dbo.ExamesComplementares.id " +
                "WHERE dbo.EncaminhamentoXExamesComplementares.idEncaminhamento = " + idEncaminhamento;
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetSqlStringCommand(sql);
        DataTable dt = new DataTable();
        using (IDataReader dr = db.ExecuteReader(command))
        {
            dt.Load(dr);
        }
        return dt;
    }
}
