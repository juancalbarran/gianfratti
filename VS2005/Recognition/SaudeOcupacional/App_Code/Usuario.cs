using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;

/// <summary>
/// Summary description for Usuario
/// </summary>
public class Usuario
{
    //Referencias a outras classes
    private Empresa ObjEmpresa = new Empresa();
    private Profissional ObjProfissional = new Profissional();
    private UsuarioPerfil ObjUsuarioPerfil = new UsuarioPerfil();
    private UsuarioStatus ObjUsuarioStatus = new UsuarioStatus();
    private List<UsuarioXCliente> mUsuarioXCliente = new List<UsuarioXCliente>(); //Vai armazenar uma lista
    //Fim das referencias

    private int mId;
    private string mIdEmpresa;
    private string mIdProfissional;
    private int mIdPerfil;
    private int mIdStatus;
    private string mNome;
    private string mEmail;
    private string mUsuarios;
    private string mSenha;

	public Usuario()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    //Faz referencia a Classe de Cliente
    public Empresa RefEmpresa
    {
        get { return ObjEmpresa; }
        set { ObjEmpresa = value; }
    }
    public Profissional RefProfissional
    {
        get { return ObjProfissional; }
        set { ObjProfissional = value; }
    }
    public UsuarioPerfil RefUsuarioPerfil
    {
        get { return ObjUsuarioPerfil; }
        set { ObjUsuarioPerfil = value; }
    }
    public UsuarioStatus RefUsuarioStatus
    {
        get { return ObjUsuarioStatus; }
        set { ObjUsuarioStatus = value; }
    }
    public List<UsuarioXCliente> UsuarioXCliente //Vai armazenar uma lista
    {
        get { return mUsuarioXCliente; }
        set { mUsuarioXCliente = value; }
    }
    //Final das referencias as outras classes

    public int id
    {
        get { return mId; }
        set { mId = value; }
    }

    public string idEmpresa
    {
        get { return mIdEmpresa; }
        set { mIdEmpresa = value; }
    }

    public string idProfissional
    {
        get { return mIdProfissional; }
        set { mIdProfissional = value; }
    }
    public int idPerfil
    {
        get { return mIdPerfil; }
        set { mIdPerfil = value; }
    }

    public int idStatus
    {
        get { return mIdStatus; }
        set { mIdStatus = value; }
    }

    public string Nome
    {
        get { return mNome; }
        set { mNome = value; }
    }

    public string Email
    {
        get { return mEmail; }
        set { mEmail = value; }
    }

    public string Usuarios
    {
        get { return mUsuarios; }
        set { mUsuarios = value; }
    }

    public string Senha
    {
        get { return mSenha; }
        set { mSenha = value; }
    }
}

