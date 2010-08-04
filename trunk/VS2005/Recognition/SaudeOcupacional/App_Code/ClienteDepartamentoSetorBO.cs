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
/// Summary description for ClienteDepartamentoSetorBO
/// </summary>
public class ClienteDepartamentoSetorBO
{
    ClienteDepartamentoSetor ObjClienteDepartamentoSetor;

	public ClienteDepartamentoSetorBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}


    public bool SalvaDadosDepartamento(object ObjPacote)
    {
        ObjClienteDepartamentoSetor = ObjPacote as ClienteDepartamentoSetor;
        ClienteDepartamentoSetorDAL ClienteDepartamentoSetorDAL = new ClienteDepartamentoSetorDAL();
        ClienteDepartamentoSetorDAL.InsertClienteDepartamento(ObjPacote);
        return true;
    }

    public bool SalvaDadosSetor(object ObjPacote)
    {
        try
        {
            ObjClienteDepartamentoSetor = ObjPacote as ClienteDepartamentoSetor;
            ClienteDepartamentoSetorDAL ClienteDepartamentoSetorDAL = new ClienteDepartamentoSetorDAL();
            ClienteDepartamentoSetorDAL.InsertClienteSetor(ObjPacote);
            return true;
        }
        catch (Exception e)
        {
            return false;
            throw e;
        }
    }


}
