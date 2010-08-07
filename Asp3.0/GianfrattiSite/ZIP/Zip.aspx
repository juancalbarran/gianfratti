<%@ page language="VB" autoeventwireup="false" inherits="_Default, App_Web_qwblwpfr" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- Artigo desenvolvido por Thomas Alexander Semple para fins educativos -->
<!-- thomas.semple@t4w.com.br 2007 -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Criar Arquivos Zip em Asp.Net</title>
    <style type="text/css">
    body, input{
    font-family: verdana;
    font-size: 10px;
    }
    
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <strong>Este exemplo utiliza componentes de terceiros. Verifique o termo de uso.
                .</strong>
            <br />
            <br />
            <fieldset>
                <legend>Criar Arquivo Zip do Diretório Inteiro </legend>&nbsp;
                <table style="border: none;">
                    <tr>
                        <td>
                            Diretório de Origem:
                        </td>
                        <td>
                            <asp:TextBox ID="txtOrigem" runat="server" Columns="60"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Diretório de Destino:
                        </td>
                        <td>
                            <asp:TextBox ID="txtDestino" runat="server" Columns="60"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Button runat="server" ID="btnGerar" Text="Gerar Zip do Diretório inteiro" />
                            <asp:Label runat="server" ID="lblErro" Font-Bold="true" ForeColor="red"></asp:Label>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br />   <br />
            <fieldset>
                <legend>Criar Arquivo Zip de um único Arquivo </legend>&nbsp;
                <table style="border: none;">
                    <tr>
                        <td>
                            Arquivo para ser "zipado":
                        </td>
                        <td>
                            <asp:TextBox ID="txtArquivoOrigem" runat="server" Columns="60"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Diretório de Destino:
                        </td>
                        <td>
                            <asp:TextBox ID="txtArquivoDestino" runat="server" Columns="60"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Button runat="server" ID="btnGerarArquivo" Text="Gerar Zip de um único Arquivo" />
                            <asp:Label runat="server" ID="lblErroArquivo" Font-Bold="true" ForeColor="red"></asp:Label>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <br />   <br />
        <fieldset>
            <legend>Descompactar Arquivo .ZIP&nbsp;</legend>&nbsp;
            <table style="border: none;">
                <tr>
                    <td>
                        Arquivo para ser "deszipado":
                    </td>
                    <td>
                        <asp:TextBox ID="txtArquivoParaDescompactar" runat="server" Columns="60"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Diretório para arquivos serem descompactados :
                    </td>
                    <td>
                        <asp:TextBox ID="txtDescompactarArquivos" runat="server" Columns="60"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button runat="server" ID="btnDescompactar" Text="Descompactar arquivo zip" />
                        <asp:Label ID="lblErroDescompactar" runat="server" Font-Bold="true" ForeColor="red"></asp:Label>
                    </td>
                </tr>
            </table>
        </fieldset>
    </form>
</body>
</html>
