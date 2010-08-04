<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProrrogacoesCadastro.aspx.cs" Inherits="Guias_PaginasAuxiliares_Prorrogacoes_ProrrogacoesCadastro" %>

<%@ Register Src="../../../UserControls/Dominio/DropDownList/TipoAcomodacao.ascx"
    TagName="TipoAcomodacao" TagPrefix="uc1" %>

<%@ Register Src="../../../UserControls/Dominio/DropDownList/Tabelas.ascx" TagName="Tabelas"
    TagPrefix="uc9" %>

<link href="../../../Template/Css/default.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" type="text/javascript" src="../../../JS/Funcoes.js"></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Cadastro de Prorrogações</title>
</head>

<body>

<form id="form1" runat="server">
<fieldset>
<legend>Cadastro de Prorrogações</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
  <tr>
    <td colspan="6" style="background-color:#CCCCCC;">Prorroga&ccedil;&otilde;es</td>
      <td colspan="1" style="background-color: #cccccc">
      </td>
  </tr>
  <tr>
    <td style="height: 19px">55 - Data</td>
    <td style="height: 19px">56 - Senha</td>
    <td style="height: 19px">57 - Respons&aacute;vel pela Autoriza&ccedil;&atilde;o </td>
    <td style="height: 19px"></td>
    <td style="height: 19px"></td>
    <td style="height: 19px"></td>
      <td style="height: 19px">
      </td>
  </tr>
  <tr>
    <td style="height: 24px">
        &nbsp;<asp:TextBox ID="txtData" runat="server"></asp:TextBox></td>
    <td style="height: 24px">
        <asp:TextBox ID="txtSenha" runat="server"></asp:TextBox></td>
    <td style="height: 24px">
        <asp:TextBox ID="txtResponsavel" runat="server"></asp:TextBox></td>
    <td style="height: 24px"></td>
    <td style="height: 24px">&nbsp;</td>
    <td style="height: 24px">
        </td>
      <td style="height: 24px">
      </td>
  </tr>
  <tr>
    <td>58 - Tipo Acomod. </td>
    <td>59 - Acomoda&ccedil;&atilde;o </td>
    <td>60 - Qtde. Autorizada</td>
    <td></td>
    <td></td>
    <td></td>
      <td>
      </td>
  </tr>
  <tr>
    <td style="height: 24px">
        <uc1:TipoAcomodacao ID="ddlTipoAcomodacao" runat="server" />
        </td>
    <td style="height: 24px">
        <asp:TextBox ID="txtDescAcomodacao" runat="server"></asp:TextBox></td>
    <td style="height: 24px">
        <asp:TextBox ID="txtQtdAutorizada" runat="server"></asp:TextBox></td>
    <td style="height: 24px"></td>
    <td style="height: 24px">&nbsp;</td>
    <td style="height: 24px"></td>
      <td style="height: 24px">
      </td>
  </tr>
    <tr>
        <td colspan="7" style="background-color: #cccccc">
            Prorrogações</td>
    </tr>
  <tr>
    <td>61 - Tabela </td>
    <td>62 - Cód. Procedimento
    </td>
    <td>63 - Descri&ccedil;&atilde;o </td>
    <td>64 - Qt. Sol. </td>
    <td>65 - Qt. Aut. </td>
    <td></td>
      <td>
      </td>
  </tr>
  <tr>
    <td style="height: 21px">
        <uc9:Tabelas ID="ddlTabelas_Procedimentos" runat="server" />
    </td>
    <td style="height: 21px">
        <asp:TextBox ID="txtCodProcedimento" runat="server" MaxLength="10"></asp:TextBox></td>
    <td style="height: 21px">
        <asp:TextBox ID="txtDescProcedimento" runat="server" MaxLength="60"></asp:TextBox></td>
    <td style="height: 21px">
        <asp:TextBox ID="txtQtdSolicitada" runat="server" MaxLength="2" onkeypress="return MascaraCampo(document.form, this, '99', event);"
            Width="46px"></asp:TextBox></td>
    <td style="height: 21px">
        <asp:TextBox ID="txtQtdAutorizado" runat="server" MaxLength="2" onkeypress="return MascaraCampo(document.form, this, '99', event);"
            Width="46px"></asp:TextBox></td>
    <td style="height: 21px"></td>
      <td style="height: 21px">
          <asp:Button ID="btnIncluirProcedimentos" runat="server" Text="Incluir" CausesValidation="False" OnClick="btnIncluirProcedimentos_Click" /></td>
  </tr>
    <tr>
        <td colspan="7" style="height: 19px">
            <asp:GridView ID="GridViewProcedimentos" runat="server" AutoGenerateColumns="False"
                CellPadding="4" CssClass="texto" ForeColor="#333333" OnRowDataBound="GridViewProcedimentos_RowDataBound"
                OnSelectedIndexChanged="GridViewProcedimentos_SelectedIndexChanged" ShowFooter="True"
                Width="100%">
                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <Columns>
                    <asp:BoundField DataField="idTabela" HeaderText="Tabela">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Codigo" HeaderText="C&#243;digo">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Descricao" HeaderText="Descri&#231;&#227;o">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="QtdSolicitada" HeaderText="Qtd. Solicitada">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="QtdAutorizada" HeaderText="Qtd. Autorizada">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:CommandField SelectText="Excluir" ShowSelectButton="True">
                        <HeaderStyle HorizontalAlign="Right" />
                    </asp:CommandField>
                </Columns>
                <RowStyle BackColor="#E3EAEB" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
                <EditRowStyle BackColor="#7C6F57" />
            </asp:GridView>
        </td>
    </tr>
    <tr>
        <td colspan="7" style="background-color: #cccccc">
            OPM</td>
    </tr>
  <tr>
    <td>66 - Tabela </td>
    <td>67 - C&oacute;digo OPM </td>
    <td>68 - Descri&ccedil;&atilde;o OPM </td>
    <td>69 - Qtde. </td>
    <td>70 - Fabricante </td>
    <td>71 - Valor Unitario R$ </td>
      <td>
      </td>
  </tr>
  <tr>
    <td style="height: 21px">
        <uc9:Tabelas ID="ddlTabelas_OPM" runat="server" />
        </td>
    <td style="height: 21px">
        <asp:TextBox ID="txtCodOPM" runat="server" MaxLength="10"></asp:TextBox></td>
    <td style="height: 21px">
        <asp:TextBox ID="txtDescOPM" runat="server" MaxLength="60"></asp:TextBox></td>
    <td style="height: 21px">
        <asp:TextBox ID="txtQtdOPM" runat="server" MaxLength="2" Width="46px"></asp:TextBox></td>
    <td style="height: 21px">
        <asp:TextBox ID="txtFabricanteOPM" runat="server" MaxLength="40"></asp:TextBox></td>
    <td style="height: 21px">
        <asp:TextBox ID="txtValorOPM" runat="server" Width="46px"></asp:TextBox></td>
      <td style="height: 21px">
          <asp:Button ID="btnIncluirOPM" runat="server" Text="Incluir" CausesValidation="False" OnClick="btnIncluirOPM_Click" /></td>
  </tr>
    <tr>
        <td colspan="7" style="height: 21px">
            <asp:GridView ID="GridViewOPMSolicitados" runat="server" AutoGenerateColumns="False"
                CellPadding="4" CssClass="texto" ForeColor="#333333" OnRowDataBound="GridViewOPMSolicitados_RowDataBound"
                OnSelectedIndexChanged="GridViewOPMSolicitados_SelectedIndexChanged" ShowFooter="True"
                Width="100%">
                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <Columns>
                    <asp:BoundField DataField="idTabela" HeaderText="Tabela">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Codigo" HeaderText="C&#243;digo">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Descricao" HeaderText="Descri&#231;&#227;o">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Qtd" HeaderText="Qtd">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Fabricante" HeaderText="Fabricante">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ValorUni" HeaderText="ValorUnit&#225;rio" />
                    <asp:CommandField SelectText="Excluir" ShowSelectButton="True">
                        <HeaderStyle HorizontalAlign="Right" />
                    </asp:CommandField>
                </Columns>
                <RowStyle BackColor="#E3EAEB" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
                <EditRowStyle BackColor="#7C6F57" />
            </asp:GridView>
        </td>
    </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
<tr>
<td align="center" style="height: 50px">
    <asp:Button ID="BtnSalvar" runat="server" Text="Salvar" OnClick="BtnSalvar_Click" /></td>
</tr>
</table>
</fieldset>
    </form>
</body>
</html>
