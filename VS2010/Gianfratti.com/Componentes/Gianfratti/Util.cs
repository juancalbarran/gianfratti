using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Cryptography;
using System.Drawing;
using System.Drawing.Imaging;
using System.Web;
using System.Globalization;

namespace Gianfratti
{
    /// <summary>
    /// Classe que contém metodos de Segurança, Validações,Mascaras,Formatações,Imagens, Digito Verifiador.
    /// </summary>
    public class Util
    {
        #region Metodos de Segurança

        /// <summary>
        /// Metodo que retorna uma string AlfaNumerica de 06 caracteres randomicamente
        /// </summary>
        /// <returns></returns>
        public string GeraSenhaAlfaNumerica()
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
        /// Metodo que retorna um Hash MD5 de uma string
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        public string GeraMD5Hash(string input)
        {
            if (String.IsNullOrEmpty(input))
                return null;

            MD5 md5 = MD5.Create();
            byte[] inputBytes = Encoding.ASCII.GetBytes(input);

            byte[] hash = md5.ComputeHash(inputBytes);
            StringBuilder sb = new StringBuilder();

            for (int i = 0; i < hash.Length; i++)
            {
                sb.Append(hash[i].ToString("X2"));
            }

            return sb.ToString();
        }

        #endregion

        #region Metodos de Validações

        /// <summary>
        /// Valida o e-mail informado de acordo com caracteristicas de exigencia de '@' e '.' e tamanho minimo de 4 no nome da pessoa e do provedor.
        /// </summary>
        /// <param name="emailInformado"></param>
        /// <returns></returns>
        public bool ValidaEmail(string EmailInformado)
        {
            //Verifica se tem @ e . no e-mail
            if (!EmailInformado.Contains("@") || !EmailInformado.Contains("."))
                return false;

            //Divide em antes e depois do @
            string[] campos = EmailInformado.Split('@');

            //se tiver mais que 1 arroba, não é valido
            if (campos.Length != 2)
                return false;

            //se for menor que 4 caracteres, tá errado
            if (campos[0].Length < 3)
                return false;

            //Agora eu pego depois do arroba e divido os pontos
            if (!campos[1].Contains("."))
                return false;
            campos = campos[1].Split('.');

            //se for menor que 4, é falso
            if (campos[0].Length < 3)
                return false;

            //se chegou aqui, pode ser verdadeiro
            return true;
        }

        /// <summary>
        /// Valida CPF
        /// </summary>
        /// <param name="vrCPF"></param>
        /// <returns></returns>
        public bool ValidaCpf(string vrCPF)
        {
            string valor = vrCPF.Replace(".", "");
            valor = valor.Replace("-", "");
            if (valor.Length != 11)
                return false;
            bool igual = true;
            for (int i = 1; i < 11 && igual; i++)
                if (valor[i] != valor[0])
                    igual = false;
            if (igual || valor == "12345678909")
                return false;
            int[] numeros = new int[11];
            for (int i = 0; i < 11; i++)
                numeros[i] = int.Parse(valor[i].ToString());
            int soma = 0;
            for (int i = 0; i < 9; i++)
                soma += (10 - i) * numeros[i];
            int resultado = soma % 11;
            if (resultado == 1 || resultado == 0)
            {
                if (numeros[9] != 0)
                    return false;
            }
            else if (numeros[9] != 11 - resultado)
                return false;
            soma = 0;
            for (int i = 0; i < 10; i++)
                soma += (11 - i) * numeros[i];
            resultado = soma % 11;
            if (resultado == 1 || resultado == 0)
            {
                if (numeros[10] != 0)
                    return false;
            }
            else
                if (numeros[10] != 11 - resultado)
                    return false;
            return true;
        }

        /// <summary>
        /// Valida CNPJ
        /// </summary>
        /// <param name="vrCNPJ"></param>
        /// <returns></returns>
        public static bool ValidaCNPJ(string CNPJInformato)
        {
            string CNPJ = CNPJInformato.Replace(".", "");
            CNPJ = CNPJ.Replace("/", "");
            CNPJ = CNPJ.Replace("-", "");
            int[] digitos, soma, resultado;
            int nrdig;
            string ftmt;
            bool[] CNPJok;
            ftmt = "6543298765432";
            digitos = new int[14];
            soma = new int[2];
            soma[0] = 0;
            soma[1] = 0;
            resultado = new int[2];
            resultado[0] = 0;
            resultado[1] = 0;
            CNPJok = new bool[2];
            CNPJok[0] = false;
            CNPJok[1] = false;
            try
            {
                for (nrdig = 0; nrdig < 14; nrdig++)
                {
                    digitos[nrdig] = int.Parse(CNPJ.Substring(nrdig, 1));
                    if (nrdig <= 11)
                        soma[0] += (digitos[nrdig] *
                          int.Parse(ftmt.Substring(
                          nrdig + 1, 1)));
                    if (nrdig <= 12)
                        soma[1] += (digitos[nrdig] *
                          int.Parse(ftmt.Substring(
                          nrdig, 1)));
                }
                for (nrdig = 0; nrdig < 2; nrdig++)
                {
                    resultado[nrdig] = (soma[nrdig] % 11);
                    if ((resultado[nrdig] == 0) || (
                         resultado[nrdig] == 1))
                        CNPJok[nrdig] = (
                        digitos[12 + nrdig] == 0);
                    else
                        CNPJok[nrdig] = (
                        digitos[12 + nrdig] == (
                        11 - resultado[nrdig]));
                }
                return (CNPJok[0] && CNPJok[1]);
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Valida se uma string é do tipo Alfanumerica (Contém letras e Números)
        /// </summary>
        /// <param name="senha"></param>
        /// <returns></returns>
        public bool ValidaSenhaAlfaNumerica(string senha)
        {
            bool possuiLetra = false;
            bool possuiNum = false;
            bool possuiEsp = false;
            foreach (char c in senha)
            {
                possuiLetra = possuiLetra ? possuiLetra : Char.IsLetter(c);
                possuiNum = possuiNum ? possuiNum : Char.IsNumber(c);
                possuiEsp = possuiEsp ? possuiEsp : (Char.IsSymbol(c) || Char.IsPunctuation(c));
                if (possuiLetra && possuiNum && possuiEsp)
                    return true;
            }
            return false;
        }

        /// <summary>
        /// Método que remove acentos, espaços e carateres indesejados
        /// </summary>
        /// <param name="texto"></param>
        /// <returns></returns>
        public static string RetiraAcentosCaracteresEspeciais(string texto)
        {
            string ComAcentos = "!@#$%¨&*()-?:{}][ÄÅÁÂÀÃäáâàãÉÊËÈéêëèÍÎÏÌíîïìÖÓÔÒÕöóôòõÜÚÛüúûùÇç ";
            string SemAcentos = "_________________AAAAAAaaaaaEEEEeeeeIIIIiiiiOOOOOoooooUUUuuuuCc_";
            for (int i = 0; i < ComAcentos.Length; i++)
                texto = texto.Replace(ComAcentos[i].ToString(), SemAcentos[i].ToString()).Trim();
            return texto;
        }

        /// <summary>
        /// Função que remove acentos de uma string
        /// </summary>
        /// <param name="texto"></param>
        /// <returns></returns>
        public string RetiraAcentos(string texto)
        {
            texto = texto.Normalize(NormalizationForm.FormD);
            StringBuilder sb = new StringBuilder();

            foreach (char c in texto.ToCharArray())
            {
                if (CharUnicodeInfo.GetUnicodeCategory(c) != UnicodeCategory.NonSpacingMark)
                {
                    sb.Append(c);
                }
            }
            return sb.ToString();
        }

        /// <summary>
        /// Valida a data para o SQL Server
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        private DateTime ValidaDataSQL(DateTime data)
        {
            //SQL Server não aceita datas antes de 1/1/1753 12:00:00 AM e depois de 12/31/9999 11:59:59 PM então valido e retorno a data valida
            DateTime dataInicial = new DateTime(1753, 1, 1, 0, 0, 0);
            DateTime dataFinal = new DateTime(9999, 12, 31, 23, 59, 59);

            if (data < dataInicial || data > dataFinal)
                return DateTime.Now;
            else
                return data;
        }

        /// <summary>
        /// Retorna true se todos os caracteres do string forem números
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        static public bool IsNumber(string val)
        {
            // if (val == null) 
            if (val == null || val.Length == 0) // Jzo 2005.12.20
                return false;

            foreach (char c in val)
            {
                if (!System.Char.IsNumber(c))
                    return false;
            }

            return true;
        }

        /// <summary>
        /// Retorna um string sem os caracteres alpha
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        static public string RemoveAlpha(string val)
        {
            if (val == null)
                return string.Empty;

            System.Text.StringBuilder result = new System.Text.StringBuilder();
            foreach (char c in val)
            {
                if (System.Char.IsNumber(c))
                    result.Append(c);
            }

            return result.ToString();
        }

        #endregion

        #region Metodos de Mascaras

        /// <summary>
        /// Método para formatar strings
        /// formatar valores,  Telefone, CPF, CNPJ, etc…
        /// Exemplo: string cpf = Formatar("12345678900", "###.###.###-##");
        /// </summary>
        /// <param name="valor"></param>
        /// <param name="mascara"></param>
        /// <returns></returns>
        public static string Formatar(string valor, string mascara)
        {
            StringBuilder dado = new StringBuilder();

            // remove caracteres nao numericos  
            foreach (char c in valor)
            {
                if (Char.IsNumber(c))
                    dado.Append(c);
            }

            int indMascara = mascara.Length;
            int indCampo = dado.Length;

            for (; indCampo > 0 && indMascara > 0; )
            {
                if (mascara[--indMascara] == '#')
                    indCampo--;
            }

            StringBuilder saida = new StringBuilder();

            for (; indMascara < mascara.Length; indMascara++)
                saida.Append((mascara[indMascara] == '#') ? dado[indCampo++] : mascara[indMascara]);

            return saida.ToString();
        }

        /// <summary>
        /// Mascara para CNPJ
        /// </summary>
        /// <param name="cnpj"></param>
        /// <returns></returns>
        public string MascaraCNPJ(string cnpj)
        {
            if (cnpj.Length < 13)
                return String.Empty;

            char[] cnpjCh = cnpj.ToCharArray();
            string cnpjFormat = String.Empty;
            int j = 1;
            for (int i = cnpjCh.Length - 1; i >= 0; i--)
            {
                switch (j)
                {
                    case 3:
                        cnpjFormat = String.Concat("-", cnpjFormat);
                        break;
                    case 7:
                        cnpjFormat = String.Concat("/", cnpjFormat);
                        break;
                    case 10:
                        cnpjFormat = String.Concat(".", cnpjFormat);
                        break;
                    case 13:
                        cnpjFormat = String.Concat(".", cnpjFormat);
                        break;
                }
                j++;
                cnpjFormat = String.Concat(cnpjCh[i], cnpjFormat);
            }
            return cnpjFormat;
        }


        #endregion

        #region Metodos de Formatações

        /// <summary>
        /// Função que forma o nome e sobrenome de uma string passada
        /// Exemplo: Daniel de Souza Santos -- retorno: Daniel de Souza; Fernando Abreu Silva -- retorno: Fernando Abreu.
        /// </summary>
        /// <param name="nome"></param>
        /// <returns></returns>
        public string FormataNomeSobrenome(string nome)
        {
            int primeiro, segundo, terceiro;
            string completo;
            string nome1, nome2, nome3, nome4;

            primeiro = nome.IndexOf(" ");

            nome1 = nome.Substring(0, primeiro + 1);
            nome2 = nome.Substring(primeiro + 1, (nome.Length - (primeiro + 1)));

            completo = nome1.Trim() + " " + nome2;

            segundo = nome2.IndexOf(" ");

            if (segundo > 0)
            {
                nome3 = nome2.Substring(segundo + 1, (nome2.Length - (segundo + 1)));
                nome2 = nome2.Substring(0, segundo);

                if (nome2.Length <= 3)
                {
                    terceiro = nome3.IndexOf(" ");

                    if (terceiro > 0)
                    {
                        // achei um espaço
                        nome4 = nome3.Substring(0, terceiro + 1);
                        completo = nome1.Trim() + " " + nome2 + " " + nome4.Trim();
                    }
                    else
                    {
                        // n achei, terminou o nome
                        completo = nome1.Trim() + " " + nome2 + " " + nome3;
                    }
                }
                else
                {
                    completo = nome1.Trim() + " " + nome2.Substring(0, segundo);
                }
            }
            return completo;
        }


        #endregion

        #region Metodos de Imagens

        /// <summary>
        /// Gera uma imagem com um texto especifico
        /// Para usar: GeraTextoImagem(Context, "Fabrizio Manes", "Arial", 20, 50, 200);
        /// ATENÇÂO: o primeiro parametro é um Context do objeto, basta usar da forma como esta no exemplo que funciona, depois vc entendera..rs
        /// </summary>
        /// <param name="Contexto"></param>
        /// <param name="Texto"></param>
        /// <param name="Fonte"></param>
        /// <param name="FonteTamanho"></param>
        /// <param name="Altura"></param>
        /// <param name="Largura"></param>
        public void GeraTextoImagem(HttpContext Contexto, string Texto, string Fonte, int FonteTamanho, int Altura, int Largura)
        {
            //Criando um novo Bitmap que recebe 2 parametros em seu construtor, o primeiro é a largura e o segundo a altura da imagem
            Bitmap bmp = new Bitmap(Largura, Altura);
            //Aqui instanciamos o objeto SolidBlush que receberá a cor do texto
            SolidBrush brush = new SolidBrush(Color.White);
            // criamos um outro objeto do tipo grafics que receberá a imagem acima
            Graphics graphics = Graphics.FromImage(bmp);
            // Passaremos ao método DrawString alguns parametros para nossa imagem, os ultimos parametros (5,8) são os pontos que você queira que aparecerá o texto
            graphics.DrawString(Texto, new Font(Fonte, FonteTamanho), brush, 5, 8);
            //Modificamos a saída 
            Contexto.Response.ContentType = "image/jpeg";
            //Salvamos nossa imagem em Stream passando o formato de imagem a ser gerada
            bmp.Save(Contexto.Response.OutputStream, ImageFormat.Jpeg);
            //Nunca se esqueça de fechar os objetos
            graphics.Dispose();
            bmp.Dispose();
        }

        #endregion

        #region Calculo de Digito Verificardo - Modulos

        /// <summary>
        /// Calcula o módulo 10 de uma string numérica
        /// </summary>
        /// <param name="sTxt">String contendo os dígitos para verificação</param>
        /// <returns>O dígito verificador correspondente</returns>
        public static char M10(string sTxt)
        {
            int soma = 0, cont = 2, digito;
            for (int i = sTxt.Length - 1; i >= 0; i--)
            {
                digito = sTxt[i] - '0';

                if (cont == 2)
                {
                    digito *= cont;
                    cont = 1;
                }
                else
                {
                    cont = 2;
                }

                if (digito >= 10) digito -= 9;
                soma += digito;
            }

            digito = (10 - soma % 10) % 10;
            return Convert.ToChar(digito + '0');
        }

        /// <summary>
        /// Calcula o módulo 11 de uma string numérica
        /// </summary>
        /// <param name="sTxt">String contendo os dígitos para verificação</param>
        /// <returns>O dígito verificador correspondente</returns>
        public static char M11(string sTxt)
        {
            int dv;
            int soma = 0, cont = 2, digito;

            for (int i = sTxt.Length - 1; i >= 0; i--)
            {
                digito = sTxt[i] - '0';

                digito *= cont;
                if (++cont > 9) cont = 2;
                soma += digito;
            }
            digito = (11 - soma % 11) % 11;
            dv = digito <= 9 ? digito : 0;

            return Convert.ToChar(dv + '0');
        }


        public static char M11B(string sTxt)
        {
            int dv;
            int soma = 0, cont = 2, digito;

            for (int i = sTxt.Length - 1; i >= 0; i--)
            {
                digito = sTxt[i] - '0';
                digito *= cont;
                cont++;
                soma += digito;
            }
            digito = (11 - soma % 11) % 11;
            dv = digito <= 9 ? digito : 0;
            return Convert.ToChar(dv + '0');
        }


        /// <summary>
        /// Calcula o módulo 11 de uma string numérica.
        /// Se o resto for 0,1,10, considera dv 1.
        /// 
        /// </summary>
        /// <param name="sTxt">String contendo os dígitos para verificação</param>
        /// <returns>O dígito verificador correspondente</returns>
        public static char M11C(string sTxt)
        {
            int dv;
            int soma = 0, cont = 2, digito;

            for (int i = sTxt.Length - 1; i >= 0; i--)
            {
                digito = sTxt[i] - '0';

                digito *= cont;
                if (++cont > 9) cont = 2;
                soma += digito;
            }
            digito = (11 - soma % 11) % 11;
            dv = ((digito <= 9) && (digito >= 2)) ? digito : 1;

            return Convert.ToChar(dv + '0');
        }

        #endregion


    }
}
