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
/// Summary description for UsuarioXCliente
/// </summary>
public class UsuarioXCliente
{
    private int mId;
    private int mIdUsuario;
    private int mIdCliente;

    //Construtor da Classe
    public UsuarioXCliente(int IdUsuario, int IdCliente)
	{
        mIdUsuario = IdUsuario;
        mIdCliente = IdCliente;
	}

    public int id
    {
        get { return mId; }
        set { mId = value; }
    }

    public int idUsuario
    {
        get { return mIdUsuario; }
        set { mIdUsuario = value; }
    }

    public int idCliente
    {
        get { return mIdCliente; }
        set { mIdCliente = value; }
    }
}
