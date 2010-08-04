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
/// Summary description for Validacoes
/// </summary>
public class Validacoes
{
    public Validacoes()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    /// <summary>
    /// Limpa campos de um formulario. Exemplo LimparCampos(this)
    /// </summary>
    /// <param name="pai"></param>
    public void LimparCampos(Control pai)
    {
        foreach (Control ctl in pai.Controls)
        {
            if (ctl is TextBox)
                ((TextBox)ctl).Text = string.Empty;
            else if (ctl is DropDownList)
                ((DropDownList)ctl).Text = string.Empty;
            else if (ctl is RadioButtonList)
                ((RadioButtonList)ctl).Text = "0";
            else if (ctl.Controls.Count > 0)
                LimparCampos(ctl);
        }
    }
    /// <summary>
    /// Função que passado uma string retorna se a string é do tipo alfanumerica
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
    /// Valida o e-mail informado de acordo com caracteristicas de exigencia de '@' e '.' e tamanho minimo de 4 no nome da pessoa e do provedor.
    /// </summary>
    /// <param name="emailInformado"></param>
    /// <returns></returns>
    public bool ValidaEmail(string emailInformado)
    {
        //Verifica se tem @ e . no e-mail
        if (!emailInformado.Contains("@") || !emailInformado.Contains("."))
            return false;

        //Divide em antes e depois do @
        string[] campos = emailInformado.Split('@');

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

    //Valida CPF
    //Exemplo de como chamar: if (Validacoes.ValidaCpf(CPF.Text)) Response.Write("cpf válido!"); else Response.Write("cpf inválido!");
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
    //Valida CNPJ
    //Exemplo de como chamar: if (Validacoes.ValidaCNPJ(CNPJ.Text)) Response.Write("CNPJ válido!"); else Response.Write("CNPJ inválido!");
    public static bool ValidaCNPJ(string vrCNPJ)
    {
        string CNPJ = vrCNPJ.Replace(".", "");
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

    //Mascara para CNPJ
    public string InsereMascaraCNPJ(string cnpj)
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

    //Função responsavel por validar o numero do PIS de um funcionário
    public bool ValidaPis(string pis)
    {
        int[] multiplicador = new int[10] { 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 };
        int soma;
        int resto;

        if (pis.Trim().Length == 0)
            return false;

        pis = pis.Trim();
        pis = pis.Replace("-", "").Replace(".", "").PadLeft(11, '0');

        soma = 0;
        for (int i = 0; i < 10; i++)
            soma += int.Parse(pis[i].ToString()) * multiplicador[i];

        resto = soma % 11;

        if (resto < 2)
            resto = 0;
        else
            resto = 11 - resto;

        return pis.EndsWith(resto.ToString());
    }

    //Função que forma o nome e sobrenome de uma string passada
    //Exemplo: Daniel de Souza Santos -- retorno: Daniel de Souza; Fernando Abreu Silva -- retorno: Fernando Abreu. 
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

    //PASSSADO UM VALOR QUALQUER NO FORMATO STRING SERA RETORNADO O VALOR STRING NULL
    public string TextoNull(string valor)
    {
        if (valor == "")
        {
            valor = null;
        }
        return valor;
    }
    //PASSSADO UM VALOR QUALQUER NO FORMATO STRING SERA RETORNADO O VALOR INTEIRO NULL
    public int InteiroNull(string valor)
    {
        if (valor == string.Empty || valor == "")
        {
            valor = null;
        }
        return Convert.ToInt32(valor);
    }
    //PASSSADO UM VALOR QUALQUER NO FORMATO STRING SERA RETORNADO O VALOR DECIMAL NULL
    public decimal DecimalNull(string valor)
    {
        if (valor == string.Empty || valor == "")
        {
            valor = null;
        }
        return Convert.ToDecimal(valor);
    }
}
