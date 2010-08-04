<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="Empresa_Default" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Untitled Page</title>
        <!-- RESPONSAVEL POR NÃO DEIXA ARMAZENAR CACHE -->
        <meta http-equiv="Pragma" content="no-cache" />
        <meta http-equiv="expires" content="0" />
        <!-- FIM DO CACHE -->
    </head>
    <body>
        <fieldset style="height: 100%">
            <legend align="center">Cadastro de Empresa</legend>
            <table cellpadding="0" cellspacing="0" border="0" style="border-left: 1px solid #000000;
                width: 100%; height: 100%;">
                <tr>
                    <td class="tb-conteudo" valign="Top" style="border-top: 1px solid #000000; width: 100%;
                        height: 100%">
                        <iframe id="div_Aba1" class="conteudo" style="width: 100%; height: 100%;" frameborder="0" scrolling="no" src="EmpresaCadastro.aspx?idEmpresa=1"></iframe>
                    </td>
                </tr>
            </table>
        </fieldset>
    </body>
    </html>
</asp:Content>
