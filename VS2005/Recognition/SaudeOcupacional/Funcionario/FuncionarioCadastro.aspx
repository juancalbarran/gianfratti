<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="FuncionarioCadastro.aspx.cs" Inherits="Funcionario_FuncionarioCadastra" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset style="height: 100%">
<legend  align=center >&nbsp;Cadastro de Funcionário&nbsp;</legend>
<fieldset>
<legend  align=left >&nbsp;Ficha Pessoal&nbsp;</legend>
    <table class=texto style="width: 100%; height: 100%" border="0" cellpadding="0" cellspacing="1">
        <tr>
            <td style="width: 100px">
                CPF:</td>
            <td style="width: 100px">
                RG:</td>
            <td style="width: 100px">
                Orgão Expeditor:</td>
            <td style="width: 100px">
                Data Expedição:</td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>&nbsp;</td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                Nome:</td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td colspan="5" style="height: 23px">
                <asp:TextBox ID="TextBox5" runat="server" Width="765px"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px; height: 10px;">
                Data Nasc.:</td>
            <td style="width: 100px; height: 10px;">
                Data Obito:</td>
            <td style="width: 100px; height: 10px;">
                Sexo:</td>
            <td style="width: 100px; height: 10px;">
                Estado Civil:</td>
            <td style="width: 100px; height: 10px;">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>&nbsp;</td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox9" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                Nome da mãe:</td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td colspan="5" style="height: 23px">
                <asp:TextBox ID="TextBox17" runat="server" Width="765px"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px">
                End. Residencial:</td>
            <td style="width: 100px">
                Cidade:</td>
            <td style="width: 100px">
                Bairro:</td>
            <td style="width: 100px">
                CEP:</td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox11" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox12" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox13" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox14" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                Telefone:</td>
            <td style="width: 100px">
                Celular:</td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox16" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox15" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
        </tr>
    </table>
</fieldset>

<fieldset>
<legend  align=left >&nbsp;Ficha Profissional&nbsp;</legend>
    <table class=texto style="width: 100%; height: 100%" border="0" cellpadding="0" cellspacing="1">
        <tr>
            <td style="width: 100px">
                Status:</td>
            <td style="width: 100px">
                Nº Matricula:</td>
            <td style="width: 100px">
                Data Admissão:</td>
            <td style="width: 100px">
                Data Demissão:</td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox30" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox10" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox18" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox19" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                Empresa:</td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td colspan="5" style="height: 23px">
                <asp:TextBox ID="TextBox33" runat="server" Width="765px"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px">
                Departamento:</td>
            <td style="width: 100px">
                Setor:</td>
            <td style="width: 100px">
                Função:</td>
            <td style="width: 100px">
                </td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox22" runat="server"></asp:TextBox>
                </td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox23" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox24" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                </td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                Remuneração:</td>
            <td style="width: 100px">
                Aposentado:</td>
            <td style="width: 100px">
                </td>
            <td style="width: 100px">
                </td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox27" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox28" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                </td>
            <td style="width: 100px">
                </td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td colspan="5">
                CBO (Cadastro Brasilieiro de Ocupações)</td>
        </tr>
        <tr>
            <td colspan="5">
                <asp:TextBox ID="TextBox31" runat="server" Width="64px"></asp:TextBox>
                <asp:TextBox ID="TextBox20" runat="server" Width="696px"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px">
                CTPS Nº:</td>
            <td style="width: 100px">
                CTPS Serie:</td>
            <td colspan="3">
                Filiação Previdenciaria:</td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox21" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox25" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox26" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                NIT/PIS-PASEP:</td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="TextBox29" runat="server"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
        </tr>
    </table>
</fieldset>
</fieldset>
</asp:Content>

