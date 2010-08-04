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
/// Summary description for AtestatoSaudeBO
/// </summary>
public class AtestatoSaudeBO
{
	public AtestatoSaudeBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    //CHAMA A FUNÇÃO DO DAL QUE VAI CARREGAR OS DADOS DO FUNCIONARIO
    public ClienteFuncionario CarregaDadosFuncionario(int idFuncionario)
    {
        AtestadoSaudeDAL ObjAtestadoSaudeDAL = new AtestadoSaudeDAL();
        return ObjAtestadoSaudeDAL.CarregaDadosFuncionario(idFuncionario);
    }
    //CHAMA A FUNÇÃO DO DAL QUE VAI FAZER O INSERT DO FUNCIONARIO
    public void InsertAtestado(AtestadoSaude ObjAtestadoSaude)
    {
        try
        {
            AtestadoSaudeDAL ObjAtestadoSaudeDAL = new AtestadoSaudeDAL();
            ObjAtestadoSaudeDAL.InsertAtestado(ObjAtestadoSaude);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable TipoAtestatoDropDownList()
    {
        AtestadoSaudeDAL ObjAtestadoSaudeDAL = new AtestadoSaudeDAL();
        return ObjAtestadoSaudeDAL.TipoAtestatoDropDownList();
    }
}
