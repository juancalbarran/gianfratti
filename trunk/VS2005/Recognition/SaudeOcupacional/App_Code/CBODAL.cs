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
/// Summary description for CBODAL
/// </summary>
public class CBODAL
{
    public CBODAL()
    {
        //
        // TODO: Add constructor logic here
        //
    }


    //FAZ UM SELECT EM TODOS OS REGISTROS DO CBO
    public DataTable SelectAll(string COD_CBO, string FUNCAO)
    {
        Validacoes ObjValida = new Validacoes();
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("CBOSelectAll");
        db.AddInParameter(command, "@Cod_CBO", DbType.String, ObjValida.TextoNull(COD_CBO));
        db.AddInParameter(command, "@Funcao", DbType.String, ObjValida.TextoNull(FUNCAO));
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
    /// <param name="idUsuario"></param>
    /// <returns></returns>
    public CBO SelectByID(int CBO)
    {
        Database db = DatabaseFactory.CreateDatabase();
        DbCommand command = db.GetStoredProcCommand("CBOSelectByID");
        db.AddInParameter(command, "@CBO", DbType.Int32, CBO);

        using (IDataReader dr = db.ExecuteReader(command))
        {
            CBO ObjCBO = new CBO();

            if (dr.Read())
            {
                ObjCBO.COD_CBO = Convert.ToString(dr["COD_CBO"]);
                ObjCBO.FUNCAO = Convert.ToString(dr["FUNCAO"]);
                ObjCBO.Descr_Familia = Convert.ToString(dr["Descr_Familia"]);
                ObjCBO.Cond_Exerc = Convert.ToString(dr["Cond_Exerc"]);
                ObjCBO.Form_Exp = Convert.ToString(dr["Form_Exp"]);
                ObjCBO.Descr_Excecao = Convert.ToString(dr["Descr_Excecao"]);
                ObjCBO.Cod_Int_Ocup = Convert.ToString(dr["Cod_Int_Ocup"]);
            }
            return ObjCBO;
        }
    }

    //FAZ UM SELECT EM TODOS OS REGISTROS DO CBO
    public DataTable CarregaSinonimosByCod(string CodOcupacao)
    {
        string sql;
        sql = "SELECT Cod_Int_Sin, Cod_Int_Ocup, Nom_Sin FROM dbo.CBO_Sinonimo WHERE Cod_Int_Ocup = " + CodOcupacao;
        Validacoes ObjValida = new Validacoes();
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
