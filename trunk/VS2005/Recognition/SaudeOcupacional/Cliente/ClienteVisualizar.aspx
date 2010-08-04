<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="ClienteVisualizar.aspx.cs" Inherits="Cliente_ClienteVisualizar" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<fieldset style="height: 100%">
<legend  align="center">&nbsp;Cadastro de Cliente&nbsp;</legend>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="ds"
        ShowHeader="False" BorderStyle="None" GridLines="None" Width="100%">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>


                    <fieldset>
                    <legend  align=left >&nbsp;Ficha&nbsp;</legend>
                        <table border="0" cellpadding="0" cellspacing="1" style="width: 100%; height: 100%" class="texto">
                            <tr>
                                <td style="width: 10%;" valign="middle">
                                    CNPJ:</td>
                                <td style="width: 18%;" valign="top">
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("CNPJ_INCRA_CPF") %>'></asp:Label></td>
                                <td style="width: 10%;" valign="middle">
                                    Insc. Estatual:</td>
                                <td colspan="7" valign="middle">
                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("inscEstadual") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td valign="middle">
                                    Razão Social:</td>
                                <td colspan="9" valign="top">
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("RazaoSocial") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td valign="middle">
                                    Endereço:</td>
                                <td colspan="9" valign="top">
                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("Endereco") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td style="width: 10%;" valign="middle">
                                    Bairro:</td>
                                <td style="width: 18%;" valign="top">
                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("Bairro") %>'></asp:Label></td>
                                <td style="width: 10%;" valign="middle">
                                    CEP:</td>
                                <td colspan="3" style="width: 13%;" valign="top">
                                    &nbsp;<asp:Label ID="Label6" runat="server" Text='<%# Eval("CEP") %>'></asp:Label></td>
                                <td colspan="1" style="width: 10%;" valign="middle">
                                    Cidade:</td>
                                <td colspan="1" style="width: 18%;" valign="middle">
                                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("Cidade") %>'></asp:Label></td>
                                <td colspan="1" style="width: 5%;" valign="middle">
                                    UF:</td>
                                <td colspan="1" style="width: 16%;" valign="middle">
                                    &nbsp;<asp:Label ID="Label8" runat="server" Text='<%# Eval("UF") %>'></asp:Label></td>
                            </tr>
                             <tr>
                                <td style="width: 10%;" valign="middle">
                                    Telefone:</td>
                                <td style="width: 18%;" valign="top">
                                    <asp:Label ID="Label9" runat="server" Text='<%# Eval("Telefone") %>'></asp:Label></td>
                                <td style="width: 10%;" valign="middle">
                                    Fax:</td>
                                <td colspan="3" style="width: 13%;" valign="top">
                                    <asp:Label ID="Label10" runat="server" Text='<%# Eval("Fax") %>'></asp:Label></td>
                                <td colspan="1" style="width: 10%;" valign="middle">
                                    Contato:</td>
                                <td colspan="1" valign="middle">
                                    <asp:Label ID="Label11" runat="server" Text='<%# Eval("Contato") %>'></asp:Label></td>
                                    <td >
                                    E-Mail:</td>
                                    <td >
                                    <br />
                                        <asp:Label ID="Label12" runat="server" Text='<%# Eval("Email") %>'></asp:Label></td>
                                            
                            </tr>
                            <tr>
                                <td style="width: 10%;" valign="middle">
                                    CNAE:</td>
                                <td style="width: 18%;" valign="top">
                                    &nbsp;<asp:Label ID="Label13" runat="server" Text='<%# Eval("CNAE") %>'></asp:Label></td>
                                <td style="width: 10%;" valign="middle">
                                    GFIP:</td>
                                <td colspan="3" style="width: 13%;" valign="top">
                                    &nbsp;<asp:Label ID="Label14" runat="server" Text='<%# Eval("GFIP") %>'></asp:Label></td>
                                <td colspan="1" style="width: 10%;" valign="middle">
                                    SESMT:</td>
                                <td colspan="3" valign="middle">
                                    &nbsp;<asp:Label ID="Label15" runat="server" Text='<%# Eval("SESMT") %>'></asp:Label><br />
                                    </td>
                            </tr>
                        </table>
                    </fieldset>


                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ds" runat="server" SelectMethod="VisualizaCliente" TypeName="ClienteDAL">
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="ID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

<fieldset>
<legend>&nbsp;Departamentos e Setores&nbsp;</legend>
                <asp:GridView ID="GridView2" runat="server" Width="100%" CssClass="texto" DataSourceID="dsDeptoSetor" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="Departamento" HeaderText="Departamento(s)" />
                        <asp:BoundField DataField="Setor" HeaderText="Setor(s)" />
                    </Columns>
                </asp:GridView>
                <asp:ObjectDataSource ID="dsDeptoSetor" runat="server" SelectMethod="VisualizaClienteDepartamentoSetor"
                    TypeName="ClienteDAL">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="id" QueryStringField="ID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
</fieldset>

</fieldset>
</asp:Content>

