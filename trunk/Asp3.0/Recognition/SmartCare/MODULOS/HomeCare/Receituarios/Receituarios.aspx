<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Receituarios.aspx.vb" Inherits="SmartCare.Receituarios"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Exames_Solicitados</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../../../Bibliotecas/Css/default.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="../../../Bibliotecas/Funcoes/funcoesNet.js"></script>
		<script language="javascript"> 
	<!-- 
	//Função responsavel por pintar as linhas do data grid quando passa o mouse em cima
	var cor; 
	function CoresGrid( elemento ) 
	{ 
	cor=elemento.style.backgroundColor; 
	elemento.style.backgroundColor = "#ECE9D8"; 
	} 
	// Função para mudar a linha ao de-selecionar 
	function deCoresGrid( elemento) 
	{ 
	elemento.style.backgroundColor = cor; 
	} 

	//--> 
		</script>
	</HEAD>
	<body bottomMargin="0" leftMargin="0" topMargin="0" rightMargin="0">
		<form id="Form1" method="post" runat="server">
			&nbsp;
			<FIELDSET id="FIELDSET1" style="WIDTH: 100%; HEIGHT: 30px"><LEGEND id="LEGEND1" align="center" runat="server">&nbsp;Receituário&nbsp;</LEGEND>
				<TABLE id="Tbl_DataGrid" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
					<TR>
						<TD colSpan="3"></TD>
					</TR>
					<TR>
						<TD colSpan="3">
							<TABLE class="texto" id="TABLE1" width="100%" runat="server">
								<TR class="zebra_orange1">
									<TD id="TD1" width="40%" runat="server"><A href="default.asp?action=Form_Incluir_Atendimento"></A></TD>
									<TD align="center" width="3%"><IMG height="15" src="/SmartCare/images/Flg_verde.gif" width="15"></TD>
									<TD width="10%"><FONT class="texto" id="FONT1" color="#00cc00" runat="server">Hoje</FONT></TD>
									<TD align="center" width="3%"><FONT color="#00cc00"><IMG height="15" src="/SmartCare/images/Flg_azul.gif" width="15"></FONT></TD>
									<TD width="10%"><FONT class="texto" color="#0000f6">Amanhã</FONT></TD>
									<TD align="center" width="3%"><FONT color="#0000f6"><IMG height="15" src="/SmartCare/images/Flg_amerelo_escuro.gif" width="15"></FONT></TD>
									<TD width="10%"><FONT class="texto" color="#ffd700">Marcar</FONT></TD>
									<TD align="center" width="3%"><FONT color="#ffd700"><IMG height="15" src="/SmartCare/images/Flg_vermelho.gif" width="15"></FONT></TD>
									<TD width="10%"><FONT class="texto" color="#ff0000">Urgência</FONT></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
					<TR>
						<TD colSpan="3"><asp:datagrid id="MyDataGrid" runat="server" AllowPaging="True" AllowSorting="True" PageSize="20"
								AutoGenerateColumns="False" CellPadding="4" BackColor="White" BorderWidth="1px" BorderStyle="None" BorderColor="#3366CC"
								Width="100%">
								<FooterStyle ForeColor="#003399" BackColor="#99CCCC"></FooterStyle>
								<SelectedItemStyle Font-Bold="True" ForeColor="#CCFF99" BackColor="#009999"></SelectedItemStyle>
								<ItemStyle Font-Size="8pt" Font-Names="Verdana" ForeColor="#003399" BackColor="White"></ItemStyle>
								<HeaderStyle Font-Size="8pt" Font-Names="Verdana" Font-Bold="True" ForeColor="White" BackColor="#003399"></HeaderStyle>
								<Columns>
									<asp:BoundColumn DataField="id_Atendimento" SortExpression="id_Atendimento" HeaderText="N&#186; Atend.">
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
									</asp:BoundColumn>
									<asp:BoundColumn DataField="Data_Cadastro" SortExpression="Data_Emissao" HeaderText="Dt. Emiss&#227;o"
										DataFormatString="{0:dd/MM/yyyy}"></asp:BoundColumn>
									<asp:BoundColumn DataField="Paciente" SortExpression="Paciente" HeaderText="Paciente"></asp:BoundColumn>
									<asp:BoundColumn DataField="Convenio" SortExpression="Convenio" HeaderText="Conv&#234;nio"></asp:BoundColumn>
									<asp:BoundColumn DataField="Medico" SortExpression="Medico" HeaderText="M&#233;dico"></asp:BoundColumn>
									<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="Update" CancelText="Cancel" EditText="&lt;img src=&quot;/SmartCare/images/ico_editar.gif&quot; border=0 alt=&quot;Visualizar registro&quot;&gt;">
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
									</asp:EditCommandColumn>
								</Columns>
								<PagerStyle HorizontalAlign="Left" ForeColor="#003399" BackColor="#99CCCC" Mode="NumericPages"></PagerStyle>
							</asp:datagrid><FONT color="#ff0000"></FONT></TD>
					</TR>
				</TABLE>
				<TABLE id="Tbl_Editar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
					<TR>
						<TD colSpan="3">
							<table width="100%">
								<tr class="zebra_orange1">
									<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="12%">Nº 
										Atendimento:</td>
									<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="53%">Paciente:</td>
									<TD class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="5%">Idade:</TD>
									<TD class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="15%">Sexo:</TD>
									<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="15%">Convênio:</td>
								</tr>
								<tr class="zebra_orange1">
									<td class="texto"><asp:label id="Lbl_id_Atendimento" runat="server"></asp:label></td>
									<td class="texto"><asp:label id="Lbl_Paciente" runat="server"></asp:label></td>
									<TD class="texto" align="center"><asp:label id="Lbl_Idade" runat="server"></asp:label></TD>
									<TD class="texto"><asp:label id="Lbl_Sexo" runat="server"></asp:label></TD>
									<td class="texto"><asp:label id="Lbl_Convenio" runat="server"></asp:label>&nbsp;</td>
								</tr>
							</table>
							<table width="100%">
								<tr class="zebra_orange1">
									<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" colSpan="6">Receituario:</td>
								</tr>
								<tr class="zebra_orange1">
									<td class="texto" vAlign="top" colSpan="6" height="410"><asp:label id="Lbl_Texto" runat="server"></asp:label></td>
								</tr>
							</table>
							<table width="100%">
								<tr class="zebra_orange1">
									<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="15%">Data 
										Cadastro:</td>
									<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="75%">Médico:</td>
									<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="10%">CRM:</td>
								</tr>
								<tr class="zebra_orange1">
									<td class="texto" align="left"><asp:label id="Lbl_Cadastro" runat="server"></asp:label></td>
									<td class="texto"><asp:label id="Lbl_Medico" runat="server"></asp:label></td>
									<td class="texto" align="left"><asp:label id="Lbl_Crm" runat="server"></asp:label></td>
								</tr>
							</table>
							<table width="100%">
								<tr class="zebra_orange1">
									<td class="texto" align="center"><asp:button id="Btn_Voltar" runat="server" Text="Voltar"></asp:button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT type="button" value="Imprimir" OnClick="javascript:Imprimir()"></td>
								</tr>
							</table>
						</TD>
					</TR>
				</TABLE>
			</FIELDSET>
		</form>
	</body>
</HTML>
