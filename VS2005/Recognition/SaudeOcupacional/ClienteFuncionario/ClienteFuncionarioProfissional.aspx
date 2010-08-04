<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClienteFuncionarioProfissional.aspx.cs"
    Inherits="ClienteFuncionario_ClienteFuncionarioProfissional" %>

<%@ Register Src="../UserControls/DropDownList/ClienteDepartamento.ascx" TagName="ClienteDepartamento"
    TagPrefix="uc2" %>
<%@ Register Src="../UserControls/DropDownList/ClienteSetor.ascx" TagName="ClienteSetor"
    TagPrefix="uc3" %>
<%@ Register Src="../UserControls/DropDownList/ClienteCargo.ascx" TagName="ClienteCargo"
    TagPrefix="uc4" %>

<%@ Register Src="../UserControls/DropDownList/Estados.ascx" TagName="Estados" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />

    <script language="JavaScript" type="text/javascript" src="../JS/Funcoes.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <fieldset runat="server" id="TblFichaProfissional">
            <legend align="left">&nbsp;Ficha Profissional&nbsp;</legend>
            <table class="texto" style="width: 100%; height: 100%" border="0" cellpadding="0"
                cellspacing="1">
                <tr>
                    <td style="width: 100px">
                        Status:<asp:HiddenField ID="TxtIdFuncionarioProfissional" runat="server" />
                    </td>
                    <td style="width: 100px">
                        Nº Matricula:</td>
                    <td style="width: 191px">
                        Data Admissão:</td>
                    <td style="width: 133px">
                        Data Demissão:</td>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <asp:DropDownList ID="DdlStatus" runat="server" DataSourceID="SqlDataSource4" DataTextField="Status"
                            DataValueField="id" OnDataBound="DdlStatus_DataBound">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:cnnString %>"
                            SelectCommand="SELECT [id], [Status] FROM [ClienteFuncionarioStatus]"></asp:SqlDataSource>
                    </td>
                    <td style="width: 100px">
                        <asp:TextBox ID="TxtNumMatricula" runat="server" MaxLength="50"></asp:TextBox></td>
                    <td style="width: 191px">
                        <asp:TextBox onblur="javascript:valida_data(this);" ID="TxtDtAdmissao" runat="server"
                            onKeyPress="return MascaraCampo(this.form.name, this, '99/99/9999', event);"
                            MaxLength="10"></asp:TextBox>
                    </td>
                    <td style="width: 133px">
                        <asp:TextBox onblur="javascript:valida_data(this);" ID="TxtDtDemissao" runat="server"
                            onKeyPress="return MascaraCampo(this.form.name, this, '99/99/9999', event);"
                            MaxLength="10"></asp:TextBox></td>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        Departamento:</td>
                    <td style="width: 100px">
                        Setor:</td>
                    <td style="width: 191px">
                        Data Período Inicial:</td>
                    <td style="width: 133px">
                        Data Período Final:</td>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <uc2:ClienteDepartamento ID="ClienteDepartamento1" runat="server" />
                    </td>
                    <td style="width: 100px">
                        <uc3:ClienteSetor ID="ClienteSetor1" runat="server" />
                    </td>
                    <td style="width: 191px">
                        <asp:TextBox onblur="javascript:valida_data(this);" ID="TxtDtPeriodoInicial" runat="server"
                            MaxLength="10" onkeypress="return MascaraCampo(this.form.name, this, '99/99/9999', event);"></asp:TextBox></td>
                    <td style="width: 133px">
                        <asp:TextBox onblur="javascript:valida_data(this);" ID="TxtDtPeriodoFinal" runat="server"
                            MaxLength="10" onkeypress="return MascaraCampo(this.form.name, this, '99/99/9999', event);"></asp:TextBox></td>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px; height: 19px;">
                        Cargo:</td>
                    <td style="width: 100px; height: 19px;">
                        Remuneração:</td>
                    <td style="width: 191px; height: 19px;">
                        Aposentado:</td>
                    <td style="width: 133px; height: 19px;">
                    </td>
                    <td style="width: 100px; height: 19px;">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <uc4:ClienteCargo ID="ClienteCargo1" runat="server" />
                    </td>
                    <td style="width: 100px">
                        <asp:TextBox ID="TxtSalario" runat="server" MaxLength="15" onkeypress="return(FormataMoeda(this,'','.',event))"></asp:TextBox></td>
                    <td style="width: 191px">
                        <asp:DropDownList ID="DdlAposentado" runat="server">
                            <asp:ListItem Value="N">N&#227;o</asp:ListItem>
                            <asp:ListItem Value="S">Sim</asp:ListItem>
                        </asp:DropDownList></td>
                    <td style="width: 133px">
                    </td>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        CBO: (Cadastro Brasilieiro de Ocupações)</td>
                </tr>
                <tr>
                    <td colspan="5">
                        <asp:TextBox ID="TxtCBO" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '9999-99', event);"
                            Width="64px" MaxLength="7"></asp:TextBox>
                        <a href="javascript:AbrePopUp('../Tabelas/CBO/PopUp/CBOPopUp.aspx','750','500',this,event)">
                            <img border="0" height="13" src="..\Template\img\pesquisa.gif" width="15" /></a><asp:TextBox
                                ID="TxtCBOFuncao" runat="server" ReadOnly="" Width="658px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="5">
                        Descrição das Atividades Exercidas:</td>
                </tr>
                <tr>
                    <td colspan="5">
                        <asp:TextBox ID="TxtDescricaoAtividades" runat="server" TextMode="MultiLine" Width="658px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="width: 100px; height: 13px;">
                        CTPS Nº:</td>
                    <td style="width: 100px; height: 13px;">
                        CTPS Serie:</td>
                    <td style="height: 13px; width: 191px;">
                        UF:</td>
                    <td colspan="2" style="height: 13px">
                        Filiação Previdenciaria:</td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <asp:TextBox ID="TxtNumCTPS" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '9999999', event);"
                            MaxLength="7"></asp:TextBox></td>
                    <td style="width: 100px">
                        <asp:TextBox ID="TxtSerieCTPS" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99999', event);"
                            MaxLength="5"></asp:TextBox></td>
                    <td style="width: 191px">
                        <uc1:Estados ID="ddlEstados" runat="server" />
                    </td>
                    <td style="width: 133px">
                        <asp:TextBox ID="TxtFiliacaoPrevidencia" runat="server" MaxLength="50"></asp:TextBox></td>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        NIT/PIS-PASEP:</td>
                    <td style="width: 100px">
                    </td>
                    <td style="width: 191px">
                    </td>
                    <td style="width: 133px">
                    </td>
                    <td style="width: 100px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <asp:TextBox ID="TxtPIS" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '999.99999.99-9', event);"
                            MaxLength="14"></asp:TextBox></td>
                    <td style="width: 100px">
                    </td>
                    <td style="width: 191px">
                    </td>
                    <td style="width: 133px">
                    </td>
                    <td style="width: 100px">
                    </td>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend>Riscos</legend>
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
                <tr>
                    <td style="width: 216px; height: 16px">
                        <strong><span style="font-size: 9pt">
                            </span></strong></td>
                    <td style="width: 236px; height: 16px">
                        <strong><span style="font-size: 9pt">
                            </span></strong></td>
                    <td style="width: 339px; height: 16px">
                        <span style="font-size: 9pt"><strong>
                            </strong></span></td>
                    <td style="width: 274px; height: 16px">
                        <strong><span style="font-size: 9pt">
                            </span></strong></td>
                    <td style="width: 189px; height: 16px">
                        <strong><span style="font-size: 9pt">
                            </span></strong></td>
                </tr>
            </table>
        </fieldset>
        <br />
        <fieldset>
            <table style="width: 100%">
                <tr>
                    <td align="center" style="width: 100%">
                        <asp:Button ID="BtnSalvarProfissional" runat="server" Text="Salvar Ficha Profissional"
                            OnClick="BtnSalvarProfissional_Click" /></td>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend align="left">&nbsp;Historico Profissional&nbsp;</legend>
            <table style="width: 100%">
                <tr>
                    <td style="width: 100%">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" CssClass="texto"
                            PageSize="5" Width="100%" DataKeyNames="Id" OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                            DataSourceID="ObjectDataSource5">
                            <FooterStyle BackColor="White" ForeColor="#000066" />
                            <Columns>
                                <asp:BoundField DataField="Status" HeaderText="Status">
                                    <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Nome" DataField="Nome">
                                    <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Departamento" HeaderText="Depto.">
                                    <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Setor" HeaderText="Setor">
                                    <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CBO" HeaderText="CBO">
                                    <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="DtPeriodoInicial" HeaderText="Dt. Per&#237;odo Inicial">
                                    <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="DtPeriodoFinal" HeaderText="Dt. Per&#237;odo Final">
                                    <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:CommandField ShowSelectButton="True" ButtonType="Image" SelectImageUrl="~/Template/Img/alterar.gif">
                                    <HeaderStyle ForeColor="Black" />
                                </asp:CommandField>
                                <asp:CommandField ButtonType="Image" DeleteImageUrl="~/Template/Img/excluir.gif"
                                    DeleteText="Apagar" ShowDeleteButton="True">
                                    <HeaderStyle ForeColor="Black" />
                                </asp:CommandField>
                            </Columns>
                            <RowStyle ForeColor="#000066" />
                            <SelectedRowStyle BackColor="WhiteSmoke" Font-Bold="True" ForeColor="Black" />
                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                            <HeaderStyle BackColor="#F3F7FC" Font-Bold="True" ForeColor="Black" />
                        </asp:GridView>
                        <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" DeleteMethod="DeleteClienteFuncionarioProfissional"
                            SelectMethod="SelectFuncionarioHistoricoProfissional" TypeName="ClienteFuncionarioProfissionalDAL">
                            <DeleteParameters>
                                <asp:Parameter Name="id" Type="Int32" />
                            </DeleteParameters>
                            <SelectParameters>
                                <asp:QueryStringParameter DefaultValue="" Name="idFuncionario" QueryStringField="id"
                                    Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </td>
                </tr>
            </table>
        </fieldset>
    </form>
</body>
</html>
