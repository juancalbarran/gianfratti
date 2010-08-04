using System;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for Departamento
/// </summary>
public class ClienteDepartamentoSetor
{
    //Membros da classe.
    private string mDepto;
    private int mIdCliente;
    private int mIdDepto;
    private string mSetor;

    public ClienteDepartamentoSetor()
    {       
    }

    /// <summary>
    /// Retorna o Nome do Departamento.
    /// </summary>
    public string Depto
    {
        get { return mDepto; } 
        set { mDepto = value; } 
    }

    /// <summary>
    /// Retorna o Id do Cliente.
    /// </summary>
    public int idCliente
    {
        get {return mIdCliente;} 
        set {mIdCliente = value;}
    }

    /// <summary>
    /// Retorna o Id do Depto.
    /// </summary>
    public int IdDepto
    {
        get { return mIdDepto; }
        set { mIdDepto = value; }
    }

    /// <summary>
    /// Retorna o nome do setor.
    /// </summary>
    public string Setor
    {
        get { return mSetor; }
        set { mSetor = value; }
    }
}
