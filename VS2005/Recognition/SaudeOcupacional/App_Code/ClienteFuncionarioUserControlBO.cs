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
/// Summary description for ClienteFuncionarioUserControlBO
/// </summary>
public class ClienteFuncionarioUserControlBO
{
	public ClienteFuncionarioUserControlBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    //CARREGA REGISTROS
    public ClienteFuncionario CarregaFuncionario(int idFuncionario)
    {
        ClienteFuncionarioUserControlDAL ClienteFuncionarioUserControlDAL = new ClienteFuncionarioUserControlDAL();
        return ClienteFuncionarioUserControlDAL.SelectFuncionarioByID(idFuncionario);
    }
    //CARREGA REGISTROS
    public ClienteFuncionarioProfissional CarregaFuncionarioProfissional(int idFuncionario)
    {
        ClienteFuncionarioUserControlDAL ClienteFuncionarioUserControlDAL = new ClienteFuncionarioUserControlDAL();
        return ClienteFuncionarioUserControlDAL.SelectFuncionarioProfissionalByID(idFuncionario);
    }
}
