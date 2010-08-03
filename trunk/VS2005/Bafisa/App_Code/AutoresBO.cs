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
/// Summary description for AutoresBO
/// </summary>
public class AutoresBO
{
	public AutoresBO()
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
        AutoresDAL ObjAutoresDAL = new AutoresDAL();
        ObjAutoresDAL.InsertUpdate(ObjAutores);
    }

    /// <summary>
    /// Retorna todos os registros em um DataTable
    /// </summary>
    /// <returns></returns>
    public DataTable SelectAll()
    {
        AutoresDAL ObjAutoresDAL = new AutoresDAL();
        return ObjAutoresDAL.SelectAll();
    }

    /// <summary>
    /// Seleciona um determinado registro conformo o ID
    /// </summary>
    /// <param name="id"></param>
    /// <returns>ObjAutores</returns>
    public Autores SelectByID(int id)
    {
        AutoresDAL ObjAutoresDAL = new AutoresDAL();
        return ObjAutoresDAL.SelectByID(id);
    }

    public void DeleteByID(int id)
    {
        AutoresDAL ObjAutoresDAL = new AutoresDAL();
        ObjAutoresDAL.DeleteByID(id);
    }
}
