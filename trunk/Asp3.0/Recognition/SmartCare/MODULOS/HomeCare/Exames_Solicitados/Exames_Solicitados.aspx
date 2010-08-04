<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Exames_Solicitados.aspx.vb" Inherits="SmartCare.Exames_Solicitados"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Exames_Solicitados</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../../../Bibliotecas/Css/default.css" type="text/css" rel="stylesheet">
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
			<FIELDSET id="FIELDSET1" style="WIDTH: 100%; HEIGHT: 30px"><LEGEND id="LEGEND1" align="center" runat="server">&nbsp;Exames 
					Solicitados&nbsp;</LEGEND>
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
						<TD colSpan="3"><asp:datagrid id="MyDataGrid" runat="server" Width="100%" BorderColor="#3366CC" BorderStyle="None"
								BorderWidth="1px" BackColor="White" CellPadding="4" AutoGenerateColumns="False" PageSize="20" AllowSorting="True"
								AllowPaging="True">
								<FooterStyle ForeColor="#003399" BackColor="#99CCCC"></FooterStyle>
								<SelectedItemStyle Font-Bold="True" ForeColor="#CCFF99" BackColor="#009999"></SelectedItemStyle>
								<ItemStyle Font-Size="8pt" Font-Names="Verdana" ForeColor="#003399" BackColor="White"></ItemStyle>
								<HeaderStyle Font-Size="8pt" Font-Names="Verdana" Font-Bold="True" ForeColor="White" BackColor="#003399"></HeaderStyle>
								<Columns>
									<asp:TemplateColumn>
										<ItemTemplate>
											<asp:Label id="Lbl_Img" runat="server"></asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:BoundColumn DataField="id_Atendimento" SortExpression="id_Atendimento" HeaderText="N&#186; Atend.">
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
									</asp:BoundColumn>
									<asp:BoundColumn DataField="Paciente" SortExpression="Paciente" HeaderText="Paciente"></asp:BoundColumn>
									<asp:BoundColumn DataField="Convenio" SortExpression="Convenio" HeaderText="Conv&#234;nio"></asp:BoundColumn>
									<asp:BoundColumn DataField="Data_Emissao" SortExpression="Data_Emissao" HeaderText="Dt. Emiss&#227;o"
										DataFormatString="{0:dd/MM/yyyy}"></asp:BoundColumn>
									<asp:BoundColumn DataField="Data_Coleta" SortExpression="Data_Coleta" HeaderText="Dt. coleta" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundColumn>
									<asp:BoundColumn DataField="Hora_Coleta" HeaderText="Hr. Coleta"></asp:BoundColumn>
									<asp:BoundColumn DataField="Medico" SortExpression="Medico" HeaderText="M&#233;dico"></asp:BoundColumn>
									<asp:BoundColumn DataField="Total_Exames" SortExpression="Total_Exames" HeaderText="Qtd. Exames"></asp:BoundColumn>
									<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="Update" CancelText="Cancel" EditText="&lt;img src=&quot;/SmartCare/images/ico_editar.gif&quot; border=0 alt=&quot;Visualizar registro&quot;&gt;"></asp:EditCommandColumn>
								</Columns>
								<PagerStyle HorizontalAlign="Left" ForeColor="#003399" BackColor="#99CCCC" Mode="NumericPages"></PagerStyle>
							</asp:datagrid><FONT color="#ff0000"></FONT></TD>
					</TR>
				</TABLE>
				<TABLE id="Tbl_Editar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
					<TR>
						<TD colSpan="3">
							<TABLE id="Table3" width="100%">
								<TR class="zebra_orange1">
									<TD style="FONT-WEIGHT: bold">Nº Atend.:</TD>
									<TD style="FONT-WEIGHT: bold">Paciente:</TD>
									<TD style="FONT-WEIGHT: bold">Comvênio:</TD>
								</TR>
								<TR class="zebra_orange1">
									<TD><asp:label id="Lbl_id_Atendimento" runat="server"></asp:label></TD>
									<TD><asp:label id="Lbl_Paciente" runat="server"></asp:label></TD>
									<TD><asp:label id="Lbl_Convenio" runat="server"></asp:label></TD>
								</TR>
							</TABLE>
							<TABLE id="Table4" width="100%">
								<TR class="zebra_orange1">
									<TD style="FONT-WEIGHT: bold">Sexo:</TD>
									<TD style="FONT-WEIGHT: bold">Idade:</TD>
									<TD style="FONT-WEIGHT: bold">Material:</TD>
									<TD style="FONT-WEIGHT: bold">Coleta:</TD>
								</TR>
								<TR class="zebra_orange1">
									<TD><asp:label id="Lbl_Sexo" runat="server"></asp:label></TD>
									<TD><asp:label id="Lbl_Idade" runat="server"></asp:label></TD>
									<TD><asp:label id="Lbl_Material" runat="server"></asp:label></TD>
									<TD><asp:label id="Lbl_Coleta" runat="server"></asp:label></TD>
								</TR>
								<TR class="zebra_orange1">
									<TD style="FONT-WEIGHT: bold" colSpan="4">Informações Clínicas:</TD>
								</TR>
								<TR class="zebra_orange1">
									<TD colSpan="4"><asp:label id="Lbl_InfoClinicas" runat="server"></asp:label></TD>
								</TR>
							</TABLE>
							<TABLE id="Table5" width="100%">
								<TR class="zebra_orange1">
									<TD class="texto" style="FONT-WEIGHT: bold">Exames:</TD>
								</TR>
								<TR class="zebra_orange1">
									<TD class="texto"><asp:datagrid id="Dtg_Exames" runat="server" Width="100%" BorderColor="#3366CC" BorderStyle="None"
											BorderWidth="1px" BackColor="White" CellPadding="4" AutoGenerateColumns="False" PageSize="20" AllowSorting="True"
											ShowHeader="False">
											<FooterStyle ForeColor="#003399" BackColor="#99CCCC"></FooterStyle>
											<SelectedItemStyle Font-Bold="True" ForeColor="#CCFF99" BackColor="#009999"></SelectedItemStyle>
											<ItemStyle Font-Size="8pt" Font-Names="Verdana" ForeColor="#003399" BackColor="White"></ItemStyle>
											<HeaderStyle Font-Size="8pt" Font-Names="Verdana" Font-Bold="True" ForeColor="White" BackColor="#003399"></HeaderStyle>
											<Columns>
												<asp:BoundColumn DataField="Exame" HeaderText="Exames"></asp:BoundColumn>
											</Columns>
											<PagerStyle HorizontalAlign="Left" ForeColor="#003399" BackColor="#99CCCC" Mode="NumericPages"></PagerStyle>
										</asp:datagrid></TD>
								</TR>
							</TABLE>
							<TABLE id="Table6" width="100%">
								<TR class="zebra_orange1">
									<TD style="FONT-WEIGHT: bold">Data Emissão:</TD>
									<TD style="FONT-WEIGHT: bold">Médico Solicitante:</TD>
									<TD style="FONT-WEIGHT: bold">CRM:</TD>
									<TD style="FONT-WEIGHT: bold">Nome Coletor:</TD>
									<TD style="FONT-WEIGHT: bold">Coleta Data:</TD>
									<TD style="FONT-WEIGHT: bold">Hora:</TD>
								</TR>
								<TR class="zebra_orange1">
									<TD><asp:label id="Lbl_DtEmissao" runat="server"></asp:label></TD>
									<TD><asp:label id="Lbl_Med_Solicitante" runat="server"></asp:label></TD>
									<TD><asp:label id="Lbl_CRM" runat="server"></asp:label></TD>
									<TD><asp:label id="Lbl_Coletor" runat="server"></asp:label></TD>
									<TD><asp:label id="Lbl_Coleta_Dt" runat="server"></asp:label></TD>
									<TD><asp:label id="Lbl_Hora" runat="server"></asp:label></TD>
								</TR>
							</TABLE>
							<asp:button id="Btn_Cancelar" runat="server" Text="Voltar"></asp:button></TD>
					</TR>
				</TABLE>
			</FIELDSET>
		</form>
	</body>
</HTML>
