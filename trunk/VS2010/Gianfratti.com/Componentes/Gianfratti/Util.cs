using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Cryptography;
using System.Drawing;
using System.Drawing.Imaging;
using System.Web;
using System.Globalization;
using System.Text.RegularExpressions;
using System.Drawing.Drawing2D;

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
        public static bool validaEmail(string inputEmail)
        {

            string strRegex = @"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}" +
                  @"\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\" +
                  @".)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$";
            Regex re = new Regex(strRegex);
            if (re.IsMatch(inputEmail))
                return (true);
            else
                return (false);
        }

        /// <summary>
        /// Valida CEP
        /// </summary>
        /// <param name="valor"></param>
        /// <returns></returns>
        public static bool validaCEP(string valor)
        {
            valor = valor.Replace("-", String.Empty);

            String cep = extraiNumeros(valor);

            return (cep.Length == 8);
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

        #region Metodos de Converções

        /// <summary>
        /// Converte um objeto para Inteiro
        /// </summary>
        /// <param name="valor"></param>
        /// <returns></returns>
        public static int converteInteiro(object valor)
        {
            int retorno;

            try
            {
                retorno = int.Parse(valor.ToString());
            }
            catch
            {
                retorno = 0;
            }

            return retorno;
        }

        /// <summary>
        /// Converte um objeto para Numero
        /// </summary>
        /// <param name="valor"></param>
        /// <returns></returns>
        public static long converteNumero(object valor)
        {
            long retorno;

            try
            {
                retorno = long.Parse(valor.ToString());
            }
            catch
            {
                retorno = 0;
            }

            return retorno;
        }

        /// <summary>
        /// Converte um objeto para Short
        /// </summary>
        /// <param name="valor"></param>
        /// <returns></returns>
        public static short converteShort(object valor)
        {
            short retorno;

            try
            {
                retorno = short.Parse(valor.ToString());
            }
            catch
            {
                retorno = 0;
            }

            return retorno;
        }

        /// <summary>
        /// Converte um objeto para para String
        /// </summary>
        /// <param name="valor"></param>
        /// <returns></returns>
        public static String converteString(object valor)
        {
            return (valor != null) ? valor.ToString() : String.Empty;
        }

        /// <summary>
        /// Converte um objeto para para Float
        /// </summary>
        /// <param name="valor"></param>
        /// <returns></returns>
        public static float converteFloat(object valor)
        {
            float retorno;

            try
            {
                retorno = float.Parse(valor.ToString());
            }
            catch
            {
                retorno = 0;
            }

            return retorno;
        }

        /// <summary>
        /// Converte um objeto para para Bool
        /// </summary>
        /// <param name="valor"></param>
        /// <returns></returns>
        public static bool converteBool(object valor)
        {
            bool retorno;

            try
            {
                if ((valor.ToString().ToLower() == "0") || (valor.ToString().ToLower() == "false") || (valor.ToString().ToLower() == String.Empty))
                    retorno = false;
                else
                    retorno = true;
            }
            catch
            {
                retorno = false;
            }

            return retorno;
        }

        /// <summary>
        /// Converte um objeto para Decimal
        /// </summary>
        /// <param name="valor"></param>
        /// <returns></returns>
        public static decimal converteDecimal(object valor)
        {
            decimal retorno;

            try
            {
                retorno = decimal.Parse(valor.ToString());
            }
            catch
            {
                retorno = 0;
            }

            return retorno;
        }

        /// <summary>
        /// Converte Data para String
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static string converteDataToString(DateTime data)
        {
            string strAno = data.Year.ToString();
            string strMes = data.Month.ToString();
            string strDia = data.Day.ToString();

            if (Int16.Parse(strMes) <= 9)
                strMes = "0" + strMes;
            if (Int16.Parse(strDia) <= 9)
                strDia = "0" + strDia;

            string strData = strAno + strMes + strDia;
            return strData;
        }

        /// <summary>
        /// Converte uma String para DataTime
        /// </summary>
        /// <param name="strData"></param>
        /// <returns></returns>
        public static DateTime convertStringToData(string strData)
        {
            string strAno = strData.Substring(0, 4);
            string strMes = strData.Substring(4, 2);
            string strDia = strData.Substring(6, 2);
            return DateTime.Parse(strDia + "/" + strMes + "/" + strAno);
        }

        public static DateTime converteData(object valor)
        {
            return converteData(converteString(valor));
        }

        public static DateTime converteData(string valor)
        {
            return DateTime.Parse(valor);
        }

        /// <summary>
        /// Converte Data para Juliano
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static long converteDataParaJuliano(DateTime dt)
        {
            int m = dt.Month;
            int d = dt.Day;
            int y = dt.Year;

            if (m < 3)
            {
                m = m + 12;
                y = y - 1;
            }
            long jd = d + (153 * m - 457) / 5 + 365 * y + (y / 4) - (y / 100) + (y / 400) + 1721119;
            return jd;
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

        /// <summary>
        /// Formata o valor booleano (True/False) para (Sim/Não)
        /// </summary>
        /// <param name="valor"></param>
        /// <returns></returns>
        public static string formataBoolString(bool valor)
        {
            if (valor)
                return "Sim";
            else
                return "Não";
        }

        /// <summary>
        /// Extrai os numeros de uma string
        /// </summary>
        /// <param name="valor"></param>
        /// <returns></returns>
        public static String extraiNumeros(string valor)
        {
            return string.Join(null, System.Text.RegularExpressions.Regex.Split(valor, "[^\\d]"));
        }

        /// <summary>
        /// Metodo que Converte a primeira letra para Maiúscula 
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        public static string primeiraLetraMaiuscula(string s)
        {
            StringBuilder sb = new StringBuilder(s);
            sb[0] = Char.ToUpper(sb[0]);
            return sb.ToString();
        }

        /// <summary>
        /// Extrai o numero de dias entre 2 datas
        /// </summary>
        /// <param name="dataInicial"></param>
        /// <param name="dataFinal"></param>
        /// <returns></returns>
        public static int extraiNumeroDiasEntreDatas(DateTime dataInicial, DateTime dataFinal)
        {
            int ano = 0;
            int dias = 0;

            TimeSpan ts = new TimeSpan();
            ts = dataFinal.Subtract(dataInicial);
            ano = (ts.Days / 365);

            dias = dataFinal.Subtract(dataInicial.AddYears(ano)).Days;

            return dias;
        }

        /// <summary>
        /// Formata um objeto para Moeda
        /// </summary>
        /// <param name="valor"></param>
        /// <returns></returns>
        public static String formataMoeda(object valor)
        {
            return String.Format("{0:c}", valor);
        }

        /// <summary>
        /// Formata telefone xxxx-xxxx
        /// </summary>
        /// <param name="numero">Numero</param>
        public static string formataTelefone(Object numero)
        {
            string num = converteString(numero);
            string n = "";

            for (int i = 0; i < num.Length; i++)
            {
                n += num.Substring(i, 1);
                if (i == 3)
                    n += "-";
            }

            return n;
        }

        /// <summary>
        /// Formata telefone (xx)xxxx-xxxx
        /// </summary>
        /// <param name="numero">Numero</param>
        public static string formataTelefoneDDD(Object numero)
        {
            string num = converteString(numero);
            string n = "";

            for (int i = 0; i < num.Length; i++)
            {
                if (i == 0)
                    n += "(";

                n += num.Substring(i, 1);

                if (i == 1)
                    n += ")";

                if (i == 5)
                    n += "-";
            }

            return n;
        }

        /// <summary>
        /// Formata Cep xxxxx-xxx
        /// </summary>
        /// <param name="cep">CEP</param>
        public static string formataCep(Object cep)
        {
            string num = converteString(cep).Replace("-", String.Empty);
            string n = "";

            for (int i = 0; i < num.Length; i++)
            {
                n += num.Substring(i, 1);
                if (i == 4)
                    n += "-";
            }

            return n;
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

        /// <summary>
        /// Recorta uma área da imagem
        /// </summary>
        /// <param name="imagem_origem">Arquivo de Origem</param>
        /// <param name="imagem_destino">Arquivo de Destino</param>
        /// <param name="posicaoCorteX">Distância a partir da esquerda para recortar a imagem</param>
        /// <param name="posicaoCorteY">Distância a partir do topo para recortar a imagem</param>
        /// <param name="larguraCorte">Largura da área para recortar a imagem</param>
        /// <param name="alturaCorte">Altura da área para recortar a imagem</param>
        public static void RecortaImagem(String imagem_origem, String imagem_destino, int posicaoCorteX, int posicaoCorteY, int larguraCorte, int alturaCorte)
        {

            //Corta uma área da imagem
            Bitmap BitmapOriginal = new Bitmap(imagem_origem);
            Bitmap BitmaCortado = new Bitmap(larguraCorte, alturaCorte);

            Graphics Imagem = Graphics.FromImage(BitmaCortado);
            Imagem.CompositingQuality = CompositingQuality.HighQuality;
            Imagem.SmoothingMode = SmoothingMode.HighQuality;
            Imagem.PixelOffsetMode = PixelOffsetMode.HighQuality;
            Imagem.InterpolationMode = InterpolationMode.HighQualityBicubic;
            Imagem.DrawImage(BitmapOriginal, new Rectangle(0, 0, BitmaCortado.Width, BitmaCortado.Height), posicaoCorteX, posicaoCorteY, BitmaCortado.Width, BitmaCortado.Height, GraphicsUnit.Pixel);

            BitmaCortado.Save(imagem_destino, BitmaCortado.RawFormat);


            Imagem.Dispose();
            BitmaCortado.Dispose();
            BitmapOriginal.Dispose();

        }

        /// <summary>
        /// Corte e Redimensiona a imagem fornecendo largura e altura finais
        /// </summary>
        /// <param name="imagem_origem">Arquivo de Origem</param>
        /// <param name="imagem_destino">Arquivo de Destino</param>
        /// <param name="posicaoCorteX">Distância a partir da esquerda para recortar a imagem</param>
        /// <param name="posicaoCorteY">Distância a partir do topo para recortar a imagem</param>
        /// <param name="larguraCorte">Largura da área para recortar a imagem</param>
        /// <param name="alturaCorte">Altura da área para recortar a imagem</param>
        /// <param name="larguraFinal">Largura da imagem para redimensionamento</param>
        /// <param name="alturaFinal">Altura final da imagem para redimensionamento</param>
        public static void redimensionarImagem(String imagem_origem, String imagem_destino, int posicaoCorteX, int posicaoCorteY, int larguraCorte, int alturaCorte, int larguraFinal, int alturaFinal)
        {
            //Corta e redimensiona uma área da imagem 

            Bitmap BitmapOriginal = new Bitmap(imagem_origem);
            Bitmap BitmapCortado = new Bitmap(larguraCorte, alturaCorte);
            Graphics GraficoCortado = Graphics.FromImage(BitmapCortado);
            GraficoCortado.DrawImage(BitmapOriginal, new Rectangle(0, 0, BitmapCortado.Width, BitmapCortado.Height), posicaoCorteX, posicaoCorteY, BitmapCortado.Width, BitmapCortado.Height, GraphicsUnit.Pixel);

            Size NovoTamanho = new Size(larguraFinal, alturaFinal);
            System.Drawing.Image gdi = new Bitmap(NovoTamanho.Width, NovoTamanho.Height);

            Graphics BitmapZoom = Graphics.FromImage(gdi);
            BitmapZoom.InterpolationMode = InterpolationMode.HighQualityBicubic;
            BitmapZoom.CompositingQuality = CompositingQuality.HighQuality;
            BitmapZoom.SmoothingMode = SmoothingMode.HighQuality;
            BitmapZoom.PixelOffsetMode = PixelOffsetMode.HighQuality;
            BitmapZoom.InterpolationMode = InterpolationMode.HighQualityBicubic;
            BitmapZoom.DrawImage(BitmapCortado, new Rectangle(new Point(0, 0), NovoTamanho), new Rectangle(new Point(0, 0), BitmapCortado.Size), GraphicsUnit.Pixel);
            BitmapZoom.Dispose();

            gdi.Save(imagem_destino);

            GraficoCortado.Dispose();
            BitmapCortado.Dispose();
            BitmapOriginal.Dispose();

        }

        /// <param name="imagem_origem">Arquivo de Origem</param>
        /// <param name="imagem_destino">Arquivo de Destino</param>
        /// <param name="w_novo">Largura final da imagem</param>
        /// <param name="h_novo">Altura final da imagem</param>
        public static bool zoomImagem(String imagem_origem, String imagem_destino, int w_novo, int h_novo)
        {
            bool acao_ok = false;

            //Redimensiona uma área da imagem 

            try
            {
                System.Drawing.Image BitmapOriginal = System.Drawing.Image.FromFile(imagem_origem);
                Size NovoTamanho = new Size(w_novo, h_novo);

                System.Drawing.Image gdi = new Bitmap(NovoTamanho.Width, NovoTamanho.Height);

                Graphics BitmapZoom = Graphics.FromImage(gdi);
                BitmapZoom.InterpolationMode = InterpolationMode.HighQualityBicubic;
                BitmapZoom.CompositingQuality = CompositingQuality.HighQuality;
                BitmapZoom.SmoothingMode = SmoothingMode.HighQuality;
                BitmapZoom.PixelOffsetMode = PixelOffsetMode.HighQuality;
                BitmapZoom.InterpolationMode = InterpolationMode.HighQualityBicubic;
                BitmapZoom.DrawImage(BitmapOriginal, new Rectangle(new Point(0, 0), NovoTamanho), new Rectangle(new Point(0, 0), BitmapOriginal.Size), GraphicsUnit.Pixel);
                BitmapZoom.Dispose();

                gdi.Save(imagem_destino, gdi.RawFormat);

                acao_ok = true;

            }
            catch { }

            return acao_ok;
        }

        //Classe usada para manipular as imagens
        public class Dimensao
        {
            float altura;
            float largura;

            #region Altura
            public float Altura
            {
                get { return altura; }
                set { altura = value; }
            }
            #endregion

            #region Largura
            public float Largura
            {
                get { return largura; }
                set { largura = value; }
            }
            #endregion
        }

        /// <summary>
        /// Retorna as dimenções da Imagem, Deve ser passado o caminho inteiro onde a imagem esta armazenada
        /// </summary>
        /// <param name="nomeArquivo"></param>
        /// <returns></returns>
        public static Dimensao retornaTamanhoImagem(string nomeArquivo)
        {
            //Pega imagem
            System.Drawing.Image imagemEnviada = System.Drawing.Image.FromFile(nomeArquivo);

            //Determina largura e altura
            Dimensao dimensao = new Dimensao();
            dimensao.Largura = imagemEnviada.PhysicalDimension.Width;
            dimensao.Altura = imagemEnviada.PhysicalDimension.Height;

            return dimensao;
        }

        /// <param name="nomeArquivo">Caminho do Arquivo</param>
        /// <param name="maxLarg">Largura Máxima</param>
        /// <param name="maxAlt">Altura Máxima</param>
        /// <param name="largura">Largura</param>
        /// <param name="altura">Altura</param>
        public static Dimensao retornaProporcaoImagem(string nomeArquivo, float maxLarg, float maxAlt, float largura, float altura)
        {
            System.Drawing.Image OriImg = System.Drawing.Image.FromFile(nomeArquivo);
            Dimensao dimensao = new Dimensao();
            if (OriImg.Width > OriImg.Width)
            {
                //Padrão Paisagem
                if (OriImg.Width > maxLarg)
                {
                    dimensao.Largura = maxLarg;
                    dimensao.Altura = Convert.ToInt32(OriImg.Height * dimensao.Largura / OriImg.Width);
                }
                else
                {
                    dimensao.Largura = OriImg.Width;
                    dimensao.Altura = OriImg.Height;
                }
            }
            else
            {
                //Padrão Retrato		
                if (OriImg.Height > maxAlt)
                {
                    dimensao.Altura = maxAlt;
                    dimensao.Largura = Convert.ToInt32(OriImg.Width * dimensao.Largura / OriImg.Height);
                }
                else
                {
                    dimensao.Largura = OriImg.Width;
                    dimensao.Altura = OriImg.Height;
                }

            }

            return dimensao;
        }

        /// <summary>
        /// Corta e Redimensiona uma área da imagem
        /// </summary>
        /// <param name="imagem_origem">Arquivo de Origem</param>
        /// <param name="imagem_destino">Arquivo de Destino</param>
        /// <param name="posicaoCorteX">Distância a partir da esquerda para recortar a imagem</param>
        /// <param name="posicaoCorteY">Distância a partir do topo para recortar a imagem</param>
        /// <param name="larguraCorte">Largura da área para recortar a imagem</param>
        /// <param name="alturaCorte">Altura da área para recortar a imagem</param>
        /// <param name="novaLargura">Largura da imagem final</param>
        /// <param name="novaAltura">Altura da imagem final</param>
        public static void cortaRedimensionaImagem(String imagem_origem, String imagem_destino, int posicaoCorteX, int posicaoCorteY, int larguraCorte, int alturaCorte, int novaLargura, int novaAltura)
        {

            //Corta uma área da imagem
            Bitmap BitmapOriginal = new Bitmap(imagem_origem);
            Bitmap BitmaCortado = new Bitmap(larguraCorte, alturaCorte);

            Graphics Imagem = Graphics.FromImage(BitmaCortado);
            Imagem.CompositingQuality = CompositingQuality.HighQuality;
            Imagem.SmoothingMode = SmoothingMode.HighQuality;
            Imagem.PixelOffsetMode = PixelOffsetMode.HighQuality;
            Imagem.InterpolationMode = InterpolationMode.HighQualityBicubic;
            Imagem.DrawImage(BitmapOriginal, new Rectangle(0, 0, BitmaCortado.Width, BitmaCortado.Height), posicaoCorteX, posicaoCorteY, BitmaCortado.Width, BitmaCortado.Height, GraphicsUnit.Pixel);

            /////////////////////////////////
            Size NovoTamanho = new Size(novaLargura, novaAltura);

            System.Drawing.Image gdi = new Bitmap(NovoTamanho.Width, NovoTamanho.Height);

            Graphics BitmapZoom = Graphics.FromImage(gdi);
            BitmapZoom.InterpolationMode = InterpolationMode.HighQualityBicubic;
            BitmapZoom.CompositingQuality = CompositingQuality.HighQuality;
            BitmapZoom.SmoothingMode = SmoothingMode.HighQuality;
            BitmapZoom.PixelOffsetMode = PixelOffsetMode.HighQuality;
            BitmapZoom.InterpolationMode = InterpolationMode.HighQualityBicubic;
            BitmapZoom.DrawImage(BitmaCortado, new Rectangle(new Point(0, 0), NovoTamanho), new Rectangle(new Point(0, 0), BitmaCortado.Size), GraphicsUnit.Pixel);
            BitmapZoom.Dispose();

            gdi.Save(imagem_destino, gdi.RawFormat);

            /////////////////////////

            Imagem.Dispose();
            gdi.Dispose();
            BitmaCortado.Dispose();
            BitmapOriginal.Dispose();
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
