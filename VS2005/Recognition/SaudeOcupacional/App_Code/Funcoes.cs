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
/// Summary description for Funcoes
/// </summary>
public class Funcoes
{
	public Funcoes()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    /// <summary>
    /// Metodo que retorna uma string AlfaNumerica de 06 caracteres randomicamente
    /// </summary>
    /// <returns></returns>
    public string GeraSenha()
    {
        Random ObjRandomiza = new Random();
        //String AlfaNumerica que sera usado para gerar a senha
        string AlfaNumerico = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        //String que vai concatenar a senha gerada
        string SenhaGerada = null;
        char[] Senha ={
                        AlfaNumerico[ (ObjRandomiza.Next(0,36))],
                        AlfaNumerico[ (ObjRandomiza.Next(0,36))],
                        AlfaNumerico[ (ObjRandomiza.Next(0,36))],
                        AlfaNumerico[ (ObjRandomiza.Next(0,36))],
                        AlfaNumerico[ (ObjRandomiza.Next(0,36))],
                        AlfaNumerico[ (ObjRandomiza.Next(0,36))]
                        };
        for (int i = 0; i <= Senha.Length - 1; i++)
        {
            SenhaGerada += Senha[i].ToString();
        }
        return SenhaGerada;
    }

    /// <summary>
    /// Metodo para enviar e-mail
    /// </summary>
    /// <param name="Remetente"></param>
    /// <param name="Destinatario"></param>
    /// <param name="Copia"></param>
    /// <param name="CopiaOculta"></param>
    /// <param name="Assunto"></param>
    /// <param name="Texto"></param>
    //Exemplo de como usar:
    //string[] Destinatario = new string[1]; //Declara array de destinatarios
    //Destinatario[0] = "Fabrizio <fmanes@recognition.com.br>";

    //string[] Copia = new string[1]; //Declara array de Copia
    //Copia[0] = "Fabrizio Manes <fmanes@recognition.com.br>";

    //string[] CopiaOculta = new string[1]; //Declara array de Copia Oculta
    //CopiaOculta[0] = "Marcus <malmeida@recognition.com.br>";

    //Funcoes ObjFuncoes = new Funcoes(); //Instancia a Classe onde esta o metodo
    //ObjFuncoes.Email("Fabrizio <fmanes@recognition.com.br>", Destinatario, null, null, "Assunto", "Texto do email");
    public void Email(string Remetente, string[] Destinatario, string[] Copia, string[] CopiaOculta, string Assunto, string Texto)
    {
        //cria objeto com dados do e-mail 
        System.Net.Mail.MailMessage objEmail = new System.Net.Mail.MailMessage();

        //remetente do e-mail 
        objEmail.From = new System.Net.Mail.MailAddress(Remetente);

        //Desmonta o Array do email Destinatario
        if (Destinatario.Length != 0)
        {
            for (int i = 0; i <= Destinatario.Length - 1; i++)
            {
                if (Destinatario[i] != null)
                {
                    //destinatários do e-mail 
                    objEmail.To.Add(Destinatario[i]);
                }
            }
        }

        //Desmonta o Array do email Copia
        if (Copia != null && Copia.Length > 0)
        {
            for (int i = 0; i <= Copia.Length - 1; i++)
            {
                if (Copia[i] != null)
                {
                    //enviar cópia para 
                    objEmail.CC.Add(Copia[i]);
                }
            }
        }

        //Desmonta o Array do email Copia Oculta
        if (CopiaOculta != null && CopiaOculta.Length > 0)
        {
            for (int i = 0; i <= CopiaOculta.Length - 1; i++)
            {
                if (CopiaOculta[i] != null)
                {
                    //enviar cópia para 
                    objEmail.Bcc.Add(CopiaOculta[i]);
                }
            }
        }

        //prioridade do e-mail 
        objEmail.Priority = System.Net.Mail.MailPriority.Normal;

        //formato do e-mail HTML (caso não queira HTML alocar valor false) 
        objEmail.IsBodyHtml = true;

        //título do e-mail 
        objEmail.Subject = Assunto;

        //corpo do e-mail 
        objEmail.Body = Texto;

        //Para evitar problemas de caracteres "estranhos", configuramos o charset para "ISO-8859-1" 
        objEmail.SubjectEncoding = System.Text.Encoding.GetEncoding("ISO-8859-1");
        objEmail.BodyEncoding = System.Text.Encoding.GetEncoding("ISO-8859-1");

        //cria objeto com os dados do SMTP 
        System.Net.Mail.SmtpClient objSmtp = new System.Net.Mail.SmtpClient();

        //alocamos o endereço do host para enviar os e-mails, localhost ou smtp.servidor.com.br 
        //Endereço SMTP fica no Web.Config
        objSmtp.Host = ConfigurationSettings.AppSettings["SMTP"];

        //enviamos o e-mail através do método .send() 
        try
        {
            objSmtp.Send(objEmail);
            //Response.Write("E-mail enviado com sucesso !");
        }
        catch (Exception ex)
        {
            //Response.Write("Ocorreram problemas no envio do e-mail. Error = " + ex.Message);
        }
        //excluímos o objeto de e-mail da memória 
        objEmail.Dispose();
    }

}
