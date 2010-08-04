using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;
using System.Collections.Generic;

/// <summary>
/// Summary description for PCMSO
/// </summary>
public class PCMSO
{    
	public PCMSO()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    private int mid;
    private int midCliente;
    private DateTime mDtCadastro;
    private PCMSOXSetor ObjPCMSOXSetor = new PCMSOXSetor();
    private List<PCMSOXExamesComplementares> ObjPCMSOXExamesComplementares = new List<PCMSOXExamesComplementares>();
    private List<PCMSOXRiscosOcupacionais> ObjPCMSOXRiscosOcupacionais = new List<PCMSOXRiscosOcupacionais>();

    public int id
    {
        get { return mid; }
        set { mid = value; }
    }

    public int idCliente
    {
        get { return midCliente; }
        set { midCliente = value; }
    }

    public DateTime DtCadastro
    {
        get { return mDtCadastro; }
        set { mDtCadastro = value; }
    }

    public PCMSOXSetor RefObjPCMSOXSetor
    {
        get { return ObjPCMSOXSetor; }
        set { ObjPCMSOXSetor = value; }
    }

    /// <summary>
    /// Retorna uma lista
    /// </summary>
    public List<PCMSOXExamesComplementares> RefPCMSOXExamesComplementares
    {
        get { return ObjPCMSOXExamesComplementares; }
        set { ObjPCMSOXExamesComplementares = value; }
    }

    /// <summary>
    /// Retorna uma lista
    /// </summary>
    public List<PCMSOXRiscosOcupacionais> RefPCMSOXRiscosOcupacionais
    {
        get { return ObjPCMSOXRiscosOcupacionais; }
        set { ObjPCMSOXRiscosOcupacionais = value; }
    }

}
