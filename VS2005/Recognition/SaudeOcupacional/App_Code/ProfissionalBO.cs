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
/// Summary description for ProfissionalBO
/// </summary>
public class ProfissionalBO
{
	public ProfissionalBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    
    public void SalvaDados(Profissional ObjProfissional)
    {
        try
        {
            ProfissionalDAL ObjProfissionalDAL = new ProfissionalDAL();
            ObjProfissionalDAL.InsertUpdateProfissional(ObjProfissional);
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }
    //CARREGA TODOS OS REGISTROS PARA EDIÇÃO
    public object CarregaProfissional(int idProfissional)
    {
        try
        {
            ProfissionalDAL ObjProfissionalDAL = new ProfissionalDAL();
            return ObjProfissionalDAL.SelectProfissionalByID(idProfissional);
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }
    /// <summary>
    /// Usuado para gerar um DropDownList
    /// </summary>
    /// <returns></returns>
    public DataTable DropDownList()
    {
        ProfissionalDAL ObjProfissionalDAL = new ProfissionalDAL();
        return ObjProfissionalDAL.DropDownList();
    }
}
