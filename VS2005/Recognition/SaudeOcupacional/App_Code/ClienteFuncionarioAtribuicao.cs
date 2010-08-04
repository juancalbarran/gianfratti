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
/// Summary description for ClienteFuncionarioAtribuicao
/// </summary>
public class ClienteFuncionarioAtribuicao
{
    private int mid;
    private int midFuncionario;
    private int midSetor;
    private string mDataInicial;
    private string mDataFinal;
    private string mCNPJ_CEI;
    private string mCargo;
    private string mFuncao;
    private string mCBO;
    private string mGFIP;
    
	public ClienteFuncionarioAtribuicao()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public int id
    {
        get { return mid; }
        set { mid = value; }
    }
    public int idFuncionario
    {
        get { return midFuncionario; }
        set { midFuncionario = value; }
    }
    public int idSetor
    {
        get { return midSetor; }
        set { midSetor = value; }
    }
    public string DataInicial
    {
        get { return mDataInicial; }
        set { mDataInicial = value; }
    }
    public string  DataFinal
    {
        get { return mDataFinal; }
        set { mDataFinal = value; }
    }
    public string  CNPJ_CEI
    {
        get { return mCNPJ_CEI; }
        set { mCNPJ_CEI = value; }
    }
    public string  Cargo
    {
        get { return mCargo; }
        set { mCargo = value; }
    }
    public string  Funcao
    {
        get { return mFuncao; }
        set { mFuncao = value; }
    }
    public string  CBO
    {
        get { return mCBO; }
        set { mCBO = value; }
    }
    public string  GFIP
    {
        get { return mGFIP; }
        set { mGFIP = value; }
    }
}
