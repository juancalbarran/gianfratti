<!-- #include virtual="/MailMarketing/Shared/inc/Listas.asp" -->
<%
If Opcao = 2 Then
	sBotao = "* Clique sobre o Botão [Alterar] para editar as informações."
	sOpcao = "Alterar"
ElseIf Opcao = 3 Then
	sBotao = "* Clique sobre o Botão [Excluir] para apagar as informações."
	sOpcao = "Excluir"
ElseIf Opcao = 4 Then
	sBotao = "* Clique sobre o Botão [Exibir] para Visualizar as informações."
	sOpcao = "Exibir"
End If
%>
<table align="center" cellpadding="0" cellspacing="0" border="0" width="100%">
<tr>
	<td style="padding-Left:10px" class="Font10Vinho"><%=sBotao%></td>
</tr>
<tr>
	<td>
		<table align="center" cellpadding="0" cellspacing="1" border="0" width="98%">
		<%
		pesquisa	= request("pesquisa")
		limpar		= request("limpar")
		
		if limpar <>"" then
			pesquisa = ""
		end if
		%>
		<form method="post" action="p_eventos.asp?opcao=<%=Opcao%>&acao=<%=Acao%>" onSubmit="return(document.frmPesquisa.pesquisa.value.toString().trim() == '')?false:true;" name="frmPesquisa">
			<tr>
				<td><img src="../Shared/img/spacer.gif" width="1" height="5"></td>
			</tr>
			<tr>
				<td>Digite o Nome do Evento (Assunto):</td>
			</tr>
			<tr>
				<td><input type="text" name="pesquisa" value="<%=Server.HTMLEncode(pesquisa)%>" maxlength="45" size="50" class="input">&nbsp;&nbsp;<input type="submit" value="Pesquisar" class="buttom"></td>
			</tr>
			
			<% if pesquisa <> "" then %>
			<tr>
				<td colspan="2" height="20">
					<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td width="80%">Pesquisando por: <b><%=pesquisa%></b>.</td>
							<td width="20%" align="right"><input type="button" value="Limpar Pesquisar" onclick="window.location.href('p_contatos.asp?opcao=<%=opcao%>&acao=1&limpar=1');" class="buttom"></td>
						</tr>
					</table>
				</td>
			</tr>
			<% end if %>
		</form>
		</table>
	</td>
</tr>
<%Mensagem = Request("mensagem")%>
<%If Mensagem <> "" Then%>
<tr>
	<td class="Font10Vermelho" height="7" align="center"><%=Mensagem%></td>
</tr>
<%End If%>
<tr>
	<td>
<%
sSQL = "SELECT Evento_CD As [Código], Evento_NM As [Nome], Remetente_eMail As [E-mail do Remetente]  "
sSQL = sSQL & " FROM Eventos inner join Remetentes on(Eventos.Remetente_CD = Remetentes.Remetente_CD) Where Eventos.Deletado=0 "

if pesquisa <> "" Then

	pesquisa = Replace(pesquisa, "'","''")
	
	sSQL = sSQL & " and ( Evento_NM Like '%" & pesquisa & "%' )"
End If

sSQl = sSQL & " Order By Evento_Data, Evento_NM, Remetente_SMTP"	
%>
<%Call RetonaLista(sSQL, "20", "p_eventos.asp?pesquisa=" & pesquisa & "&opcao=" & opcao & "&acao=" & acao , sOpcao, "p_eventos.asp?opcao=" & opcao & "&acao=2")%>
	</td>
</tr>
</table>
