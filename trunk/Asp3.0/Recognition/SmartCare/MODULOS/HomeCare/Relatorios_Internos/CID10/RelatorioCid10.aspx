<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RelatorioCid10.aspx.vb" Inherits="SmartCare.RelatorioCid10" uiCulture="pt-BR"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>RelatorioCid10</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../../../../Bibliotecas/Css/default.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="../../../../Bibliotecas/Funcoes/funcoesNet.js"></script>
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
		<form id="Form" method="post" runat="server">
			<FIELDSET><LEGEND id="LEGEND1" align="center" runat="server">&nbsp;Relatório de 
					Diagnosticos&nbsp;</LEGEND>
				<TABLE id="Table1" cellSpacing="1" cellPadding="0" width="100%" border="0" runat="server">
					<TR>
						<TD class="texto" style="FONT-WEIGHT: bold; HEIGHT: 21px" width="10%" bgColor="#ece9d8">Cid:</TD>
						<TD class="textopqn" style="FONT-WEIGHT: bold; HEIGHT: 21px" width="10%" bgColor="#ece9d8"><asp:textbox id="TxtBoxCid10" runat="server" Width="32px" CssClass="campos" MaxLength="4"></asp:textbox>&nbsp;e/ou
							<asp:textbox id="TxtBoxCid10_2" runat="server" Width="32px" CssClass="campos" MaxLength="4"></asp:textbox></TD>
						<TD class="texto" style="FONT-WEIGHT: bold; HEIGHT: 21px" width="10%" bgColor="#ece9d8">Data 
							Inicio:</TD>
						<TD style="HEIGHT: 21px" width="10%" bgColor="#ece9d8"><asp:textbox id="TxtBoxData_Inicial" runat="server" Width="87px" CssClass="campos" MaxLength="10"></asp:textbox></TD>
						<TD class="texto" style="FONT-WEIGHT: bold; HEIGHT: 21px" width="10%" bgColor="#ece9d8">Data 
							Final:</TD>
						<TD style="HEIGHT: 21px" width="10%" bgColor="#ece9d8"><asp:textbox id="TxtBoxData_Final" runat="server" Width="87px" CssClass="campos" MaxLength="10"></asp:textbox></TD>
						<TD class="texto" style="FONT-WEIGHT: bold; HEIGHT: 21px" width="10%" bgColor="#ece9d8">Idade 
							Inicio:</TD>
						<TD style="HEIGHT: 21px" align="center" width="5%" bgColor="#ece9d8"><asp:textbox id="TxtBoxIdade_Inicial" runat="server" Width="32px" CssClass="campos" MaxLength="3"></asp:textbox></TD>
						<TD class="texto" style="FONT-WEIGHT: bold; HEIGHT: 21px" width="10%" bgColor="#ece9d8">Idade 
							Fim:</TD>
						<TD style="HEIGHT: 21px" align="center" width="5%" bgColor="#ece9d8"><asp:textbox id="TxtBoxIdade_Final" runat="server" Width="32px" CssClass="campos" MaxLength="3"></asp:textbox></TD>
						<TD class="texto" style="FONT-WEIGHT: bold; HEIGHT: 21px" width="5%" bgColor="#ece9d8">Sexo:</TD>
						<TD style="HEIGHT: 21px" width="15%" bgColor="#ece9d8"><asp:dropdownlist id="DDL_Sexo" runat="server">
								<asp:ListItem Value=" ">Selecione</asp:ListItem>
								<asp:ListItem Value="M">Masculino</asp:ListItem>
								<asp:ListItem Value="F">Feminino</asp:ListItem>
							</asp:dropdownlist></TD>
					</TR>
					<TR>
						<TD class="texto" style="FONT-WEIGHT: bold; WIDTH: 21px; HEIGHT: 14px" bgColor="#ece9d8">Convênio:</TD>
						<TD style="WIDTH: 42px; HEIGHT: 14px" bgColor="#ece9d8"><asp:dropdownlist id="DDL_Convenio" runat="server"></asp:dropdownlist></TD>
						<TD class="texto" style="FONT-WEIGHT: bold; WIDTH: 78px; HEIGHT: 14px" bgColor="#ece9d8">Cobertura:</TD>
						<TD style="WIDTH: 66px; HEIGHT: 14px" bgColor="#ece9d8"><asp:dropdownlist id="DDL_Cobertura" runat="server"></asp:dropdownlist></TD>
						<TD class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" bgColor="#ece9d8">UF:</TD>
						<TD style="HEIGHT: 14px" bgColor="#ece9d8"><asp:textbox id="Txtbox_UF" runat="server" Width="32px" CssClass="campos" MaxLength="2"></asp:textbox></TD>
						<TD class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" bgColor="#ece9d8">Funcionário:</TD>
						<TD style="HEIGHT: 14px" bgColor="#ece9d8" colSpan="5"><asp:dropdownlist id="DDL_Funcionario" runat="server"></asp:dropdownlist><asp:button id="Button1" runat="server" Text="Buscar"></asp:button><asp:button id="Button2" runat="server" Text="Limpar" CausesValidation="False"></asp:button></TD>
					</TR>
					<TR>
						<TD colSpan="12"><asp:datagrid id="MyDataGrid" runat="server" Width="100%" AllowPaging="True" AllowSorting="True"
								PageSize="100" AutoGenerateColumns="False" CellPadding="4" BackColor="White" BorderWidth="1px" BorderStyle="None"
								BorderColor="#3366CC" ShowFooter="True">
								<FooterStyle ForeColor="#003399" BackColor="#99CCCC"></FooterStyle>
								<SelectedItemStyle Font-Bold="True" ForeColor="#CCFF99" BackColor="#009999"></SelectedItemStyle>
								<ItemStyle Font-Size="8pt" Font-Names="Verdana" ForeColor="#003399" BackColor="White"></ItemStyle>
								<HeaderStyle Font-Size="8pt" Font-Names="Verdana" Font-Bold="True" ForeColor="White" BackColor="#003399"></HeaderStyle>
								<Columns>
									<asp:BoundColumn DataField="CID10" HeaderText="CID">
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
									</asp:BoundColumn>
									<asp:BoundColumn DataField="id_Atendimento" SortExpression="id_Atendimento" HeaderText="Atend. n&#186;">
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
									</asp:BoundColumn>
									<asp:BoundColumn DataField="Funcionario" SortExpression="Funcionario" HeaderText="Funcionario"></asp:BoundColumn>
									<asp:BoundColumn DataField="Nome" SortExpression="Nome" HeaderText="Paciente"></asp:BoundColumn>
									<asp:BoundColumn DataField="Sexo" SortExpression="Sexo" HeaderText="Sexo">
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
									</asp:BoundColumn>
									<asp:BoundColumn DataField="Idade" SortExpression="Idade" HeaderText="Idade">
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
									</asp:BoundColumn>
									<asp:BoundColumn DataField="UF" SortExpression="UF" HeaderText="UF">
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
									</asp:BoundColumn>
									<asp:BoundColumn DataField="Cobertura" SortExpression="Cobertura" HeaderText="Cobertura"></asp:BoundColumn>
									<asp:BoundColumn DataField="Convenio" SortExpression="Convenio" HeaderText="Convenio"></asp:BoundColumn>
									<asp:TemplateColumn SortExpression="Data_Cadastro" HeaderText="Data">
										<ItemTemplate>
											<asp:Label id=Label1 runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Data_Cadastro") %>'>
											</asp:Label>
										</ItemTemplate>
										<FooterStyle Font-Size="7pt" Font-Names="Verdana" Font-Bold="True" ForeColor="Black"></FooterStyle>
										<FooterTemplate>
											<asp:Label id="Lbl_Total_Registros" runat="server"></asp:Label>
										</FooterTemplate>
									</asp:TemplateColumn>
								</Columns>
								<PagerStyle HorizontalAlign="Left" ForeColor="#003399" BackColor="#99CCCC" Mode="NumericPages"></PagerStyle>
							</asp:datagrid></TD>
					</TR>
					<TR>
						<TD colSpan="12"><asp:validationsummary id="ValidationSummary1" runat="server" ShowSummary="False" ShowMessageBox="True"></asp:validationsummary><asp:comparevalidator id="CompareValidator2" runat="server" Operator="GreaterThan" ValueToCompare="01/01/1900"
								Type="Date" Display="None" ControlToValidate="TxtBoxData_Inicial" ErrorMessage="Data incial invalida"></asp:comparevalidator><asp:comparevalidator id="CompareValidator1" runat="server" Type="Date" Display="None" ControlToValidate="TxtBoxData_Final"
								ErrorMessage="Data inicial é maior que a data final" ControlToCompare="TxtBoxData_Inicial"></asp:comparevalidator><asp:comparevalidator id="CompareValidator3" runat="server" Operator="GreaterThan" ValueToCompare="01/01/1900"
								Type="Date" Display="None" ControlToValidate="TxtBoxData_Final" ErrorMessage="Data final invalida"></asp:comparevalidator></TD>
					</TR>
				</TABLE>
			</FIELDSET>
		</form>
	</body>
</HTML>
