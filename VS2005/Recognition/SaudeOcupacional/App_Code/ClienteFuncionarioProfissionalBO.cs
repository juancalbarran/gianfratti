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
/// Summary description for ClienteFuncionarioProfissionalBO
/// </summary>
public class ClienteFuncionarioProfissionalBO
{
	public ClienteFuncionarioProfissionalBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    //CARREGA TODO OS DADOS DO REGISTRO DO PROFISSIONAL.
    public ClienteFuncionarioProfissional CarregaFuncionarioProfissional(int idFuncionarioProfissional)
    {
        ClienteFuncionarioProfissionalDAL ObjClienteFuncionarioProfissionalDAL = new ClienteFuncionarioProfissionalDAL();
        return ObjClienteFuncionarioProfissionalDAL.SelectFuncionarioProfissionalByID(idFuncionarioProfissional);
    }
}
