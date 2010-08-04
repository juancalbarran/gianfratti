using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for EncaminhamentoBO
/// </summary>
public class EncaminhamentoBO
{
	public EncaminhamentoBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    /// <summary>
    /// Insert ou Update
    /// </summary>
    /// <param name="ObjEncaminhamento"></param>
    public void InsertUpdate(Encaminhamento ObjEncaminhamento)
    {
        EncaminhamentoDAL ObjEncaminhamentoDAL = new EncaminhamentoDAL();
        ObjEncaminhamentoDAL.InsertUpdate(ObjEncaminhamento);
    }

    /// <summary>
    /// Retorna um DataTable.
    /// Pode-se fazer um filtro conforme parametros.
    /// </summary>
    /// <returns></returns>
    public DataTable SelectAll(string idCliente, string Nome, string CPF, string idTipoAtestado, string TipoEncaminhamento, string DtRealizacao)
    {
        EncaminhamentoDAL ObjEncaminhamentoDAL = new EncaminhamentoDAL();
        return ObjEncaminhamentoDAL.SelectAll(idCliente, Nome, CPF, idTipoAtestado, TipoEncaminhamento, DtRealizacao);
    }
}
