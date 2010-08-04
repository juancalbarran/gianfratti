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
public class ClienteDepartamento
{
    //Membros da classe.
    private int mid;
    private string mNome = String.Empty;
    private int mIdCliente;

    private List<string> mSetores = new List<string>();

    /// <summary>
    /// Construtor que associa o nome do departamento.
    /// </summary>
    /// <param name="nomeDepartamento"></param>
    public ClienteDepartamento() //string nomeDepartamento
    {
        //mNome = nomeDepartamento;
    }


    public int id
    {
        get
        {
            return mid;
        }
        set
        {
            mid = value;
        }
    }
    /// <summary>
    /// Retorna o Nome do Departamento.
    /// </summary>
    public string Nome
    {
        get
        {
            return mNome;
        }
        set
        {
            mNome = value;
        }
    }

    public int IdCliente
    {
        get
        {
            return mIdCliente;
        }
        set
        {
            mIdCliente = value;
        }
    }
    /// <summary>
    /// Retorna os setores do departamento.
    /// </summary>
    public List<string> Setores
    {
        get
        {
            return mSetores;
        }
        set
        {
            mSetores = value;
        }
    }
}
