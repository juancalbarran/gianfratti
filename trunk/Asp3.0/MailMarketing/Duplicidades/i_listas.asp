<!-- #include virtual="/MailMarketing/Shared/inc/Listas.asp" -->
<%
	sBotao = "* Clique sobre o Botão [Excluir] para apagar as informações."
	sOpcao = "Excluir"
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
		<form method="post" action="p_duplicidades.asp?opcao=<%=Opcao%>&acao=<%=Acao%>" onSubmit="return(document.frmPesquisa.pesquisa.value.toString().trim() == '')?false:true;" name="frmPesquisa">
			<tr>
				<td><img src="../Shared/img/spacer.gif" width="1" height="5"></td>
			</tr>
			<tr>
				<td>Digite o E-mail do Contato:</td>
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
							<td width="20%" align="right"><input type="button" value="Limpar Pesquisar" onclick="window.location.href('p_duplicidades.asp?opcao=<%=opcao%>&acao=1&limpar=1');" class="buttom"></td>
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

sSQL = "SELECT "
sSQL = sSQL & "	Max (C.CONTATO_CD) As [Contato_CD], "
sSQL = sSQL & "	C.CONTATO_EMAIL AS [E-mail] "
'sSQL = sSQL & "	(COUNT(C.CONTATO_EMAIL) - 1) AS [Qtd Duplicados]  "
sSQL = sSQL & "FROM  "
sSQL = sSQL & "	CONTATOS C WHERE C.DeLetado = 0 "

if pesquisa <> "" Then

	pesquisa = Replace(pesquisa, "'","''")
	
	sSQL = sSQL & " AND C.Contato_Email Like '%" & pesquisa & "%' "
End If

sSQL = sSQL & " AND	NOT EXISTS (SELECT TOP 1 1 FROM EMAILS_ENVIADOS E WHERE E.CONTATO_CD = C.CONTATO_CD) "
sSQL = sSQL & " AND	NOT EXISTS (SELECT TOP 1 1 FROM GRUPOS_CONTATOS G WHERE G.CONTATO_CD = C.CONTATO_CD) "
sSQL = sSQL & "GROUP BY  "
sSQL = sSQL & "	C.CONTATO_EMAIL  "
sSQL = sSQL & "HAVING  "
sSQL = sSQL & "COUNT(C.CONTATO_EMAIL ) > 1  "	
sSQl = sSQL & " ORDER BY CONTATO_EMAIL "	

'Response.Write(sSQL) : Response.End()
%>
<%Call RetonaLista(sSQL, "50", "p_duplicidades.asp?pesquisa=" & pesquisa & "&opcao=" & opcao & "&acao=" & acao , sOpcao, "p_duplicidades.asp?opcao=" & opcao & "&acao=2")%>
	</td>
</tr>
</table>
