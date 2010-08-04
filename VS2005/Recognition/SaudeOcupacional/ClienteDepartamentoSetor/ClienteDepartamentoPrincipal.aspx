<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClienteDepartamentoPrincipal.aspx.cs" Inherits="ClienteDepartamentoSetor_ClienteDepartamentoPrincipal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />
    <title>Cadastro de Departamentos</title>
</head>
<body style="margin:5px">
    <form id="form1" runat="server">
    
    <table cellpadding="1" cellspacing="1" border="0" width="100%">
        <tr>
            <td>
            <fieldset>
            <legend>&nbsp;Departamento&nbsp;</legend>
            <table cellpadding="2" cellspacing="2" border="0" width="100%">
                <tr>
                    <td>
                        Nome:
                        <asp:TextBox ID="txtDepto" runat="server"></asp:TextBox>
                        <asp:Button ID="btnCadastrarDepto" runat="server" Text="Cadastrar" OnClick="btnCadastrarDepto_Click" /></td>
                </tr>
            </table>
            </fieldset>
            </td>
        </tr>
        <tr><td style="height:5px"></td></tr>
        <tr>
            <td>
            <fieldset>
                <legend>&nbsp;Setor&nbsp;</legend>
                <table cellpadding="2" cellspacing="2" border="0" width="100%">
                    <tr>
                        <td>
                            Departamento:
                            <asp:DropDownList ID="ddlDepto" runat="server" DataSourceID="SqlDataSource1"
                                DataTextField="Nome" DataValueField="id">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnString %>"
                                SelectCommand="SELECT [Nome], [id] FROM [ClienteDepartamento] WHERE ([idCliente] = @idCliente) ORDER BY [Nome]">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="idCliente" QueryStringField="IdCliente" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <br />
                            Nome:
                            <asp:TextBox ID="txtSetor" runat="server"></asp:TextBox>
                            <asp:Button ID="btnCadastarSetor" runat="server" Text="Cadastrar" OnClick="btnCadastarSetor_Click" /></td>
                    </tr>
                </table>
            </fieldset>
            </td>
        </tr>
        <tr><td style="height:10px"></td></tr>
        <tr><td style="text-align:right; height: 15px;">
             <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Excluir" /></td></tr>
    </table>
    
    </form>
</body>
</html>
