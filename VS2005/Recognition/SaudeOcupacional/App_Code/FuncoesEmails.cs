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
/// Summary description for FuncoesEmails
/// </summary>
public class FuncoesEmails
{
	public FuncoesEmails()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    /// <summary>
    /// Dispara email para o usuario cadastrado no sistema
    /// </summary>
    /// <param name="Nome"></param>
    /// <param name="Email"></param>
    /// <param name="Usuario"></param>
    /// <param name="Senha"></param>
    public void EmailCadastroUsuario(string Nome, string Email, string Usuario, string Senha)
    {
        try
        {
            string Remetente = "Recognition <fmanes@recognition.com.br>";

            string[] Destinatario = new string[1]; //Declara array de destinatarios
            Destinatario[0] = Nome + "<" + Email + ">";

            string[] CopiaOculta = new string[2]; //Declara array de Copia Oculta
            CopiaOculta[0] = "Fabrizio <fmanes@recognition.com.br>";
            CopiaOculta[1] = "Marcus <malmeida@recognition.com.br>";

            string Assunto = "Senha de Acesso - MK Assessoria em Saúde"; //Assunto do E-mail

            string Texto = "Sr(a) " + Nome + ",<br><br>"; //Texto do E-mail
            Texto += "Você acaba de receber sua credencial de acesso ao sistema de saúde ocupacional da empresa MK. <br><br>";
            Texto += "Usuário: " + Usuario + "<br>";
            Texto += "Senha: " + Senha + "<br><br>";
            Texto += "Link de acesso ao sistema: http://www.smartcaresuite.com.br/mk  <br><br>";
            Texto += "Atenciosamente,<br>";
            Texto += "Mk Assessoria em Saúde <br>";
            Texto += "Tel: (011) 4508-9777";

            Funcoes ObjFuncoes = new Funcoes(); //Instancia a Classe onde esta o metodo
            ObjFuncoes.Email(Remetente, Destinatario, null, CopiaOculta, Assunto, Texto);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}
