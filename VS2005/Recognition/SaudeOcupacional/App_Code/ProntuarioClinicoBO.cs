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
/// Summary description for ProntuarioClinicoBO
/// </summary>
public class ProntuarioClinicoBO
{
    ProtuarioClinico ObjProntuario;

	public ProntuarioClinicoBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public void SalvaDados(object ObjPacote)
    {
        try
        {
            ObjProntuario = ObjPacote as ProtuarioClinico;
            ProntuarioClinicoDAL ProntuarioClinicoDAL = new ProntuarioClinicoDAL();
            ProntuarioClinicoDAL.InsertProntuarioClinico(ObjPacote);
            //return true;
        }
        catch (Exception ex)
        {
            //return false;
            throw ex;

        }

    }
    //CARREGA TODO OS RESGISTROS DO PRONTUARIO.
    public object CarregaFuncionario(int idFuncionario)
    {
        ProntuarioClinicoDAL ProntuarioClinicoDAL = new ProntuarioClinicoDAL();
        return ProntuarioClinicoDAL.SelectFuncionarioByID(idFuncionario);
    }
}
