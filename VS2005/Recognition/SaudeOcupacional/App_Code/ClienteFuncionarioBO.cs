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
/// Summary description for ClienteFuncionarioBO
/// </summary>
public class ClienteFuncionarioBO
{
    //ClienteFuncionario ObjClienteFuncionario;
	public ClienteFuncionarioBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    //CARREGA TODO O REGISTRO DO FUNCIONARIO NO OBJETO.
    public object CarregaFuncionario(int idFuncionario)
    {
        ClienteFuncionarioDAL ObjClienteFuncionario = new ClienteFuncionarioDAL();
        return ObjClienteFuncionario.SelectFuncionarioByID(idFuncionario);
    }
    /// <summary>
    /// Deletar um registro
    /// </summary>
    /// <param name="id"></param>
    public void DeleteByID(int id)
    {
        ClienteDAL ObjClienteDAL = new ClienteDAL();
        ClienteFuncionarioDAL ObjClienteFuncionarioDAL = new ClienteFuncionarioDAL();
        ObjClienteFuncionarioDAL.DeleteClienteFuncionario(id);
    }
    public ClienteFuncionario SelectRetonarIdFuncionarioByCpf(string CPF)
    {
        ClienteFuncionarioDAL ObjClienteFuncionarioDAL = new ClienteFuncionarioDAL();
        return ObjClienteFuncionarioDAL.SelectRetonarIdFuncionarioByCpf(CPF);
    }
    /// <summary>
    /// Verifica se o CPF preenchido já esta cadastrado para um determinado cliente
    /// </summary>
    /// <param name="idCliente"></param>
    /// <param name="CPF"></param>
    /// <returns></returns>
    public bool VerificaDuplicidadeCPF(int idCliente, string CPF)
    {
        ClienteFuncionarioDAL ObjClienteFuncionarioDAL = new ClienteFuncionarioDAL();
        return ObjClienteFuncionarioDAL.VerificaDuplicidadeCPF(idCliente, CPF);
    }
}
