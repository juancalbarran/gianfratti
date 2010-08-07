<%
'MYSUPPORT - ALGUNS DIREITOS RESERVADOS
'http://www.mysupport.com.br
'
'TERMOS DE LICENÇA DESTE SISTEMA
'
'Você pode:
'
'- Copiar, distribuir, exibir e executar a obra;
'- Criar obras derivadas.
'
'Sob as seguintes condições:
'
'- Atribuição. Você deve dar crédito ao autor original.
'- Uso Não-Comercial. Você não pode utilizar esta obra com finalidades comerciais.
'- Compartilhamento pela mesma Licença. Se você alterar, transformar, ou criar outra obra com base nesta, você somente poderá distribuir a obra resultante sob uma licença idêntica a esta.
'
'Para cada novo uso ou distribuição, você deve deixar claro para outros os termos da licença desta obra.
'Qualquer uma destas condições podem ser renunciadas, desde que você obtenha permissão do autor.
'Qualquer direito de uso legítimo (ou "fair use") concedido por lei, ou qualquer outro direito protegido pela legislação local, não são em hipótese alguma afetados pelo disposto acima.
'
'Este é um sumário para leigos da Licença Jurídica (na íntegra).
'
'LICENSE
'
'You are free:
'
'to copy, distribute, display, and perform the work;
'to make derivative works.
'
'Under the following conditions:
'
'- Attribution. You must give the original author credit.
'- Noncommercial. You may not use this work for commercial purposes.
'- Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under a license identical to this one. 
'
'For any reuse or distribution, you must make clear to others the license terms of this work.
'Any of these conditions can be waived if you get permission from the copyright holder.
'Your fair use and other rights are in no way affected by the above.
'
'This is a human-readable summary of the Legal Code (the full license).
%>
<!--#include file="db.asp"-->
<%
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	Session.lCid = 1033
	
	If inStr(LCase(Request.ServerVariables("HTTP_REFERER")), "http://" & LCase(Request.ServerVariables("HTTP_HOST"))) = 0 Then Response.End

Call AbreDB

strUltMsg 		  = FormataData(now,"yyyy/mm/dd hh:nn:ss")

intID		= OK(Request.QueryString("ID"))

If Request.ServerVariables("HTTP_METHOD") = "POST" Then
	strMensagem = ReplaceTags(OK(Request.Form("mensagem")))
	strMensagem = "<font color=""#000000""><b>"& Session("mysOpNome") &"&nbsp;&raquo;&nbsp;</b>" & setLink(Server.HTMLEncode(strMensagem)) & "</font><br><br>"
	
	strSQL = "UPDATE conversas SET tecla_op = False, texto = texto & '"& strMensagem &"', ult_msg = #"& strUltMsg &"# WHERE id = " & intID
	
	Conexao.Execute(strSQL)
	
	Response.Redirect "mysOpConversa.asp?m=POST&id=" & intID
End If

strSQL = "SELECT texto FROM conversas WHERE id = " & intID


Set rs = Conexao.Execute(strSQL)

strTexto = rs("texto")

rs.close
Call FechaDB
%>
<html>
<style>
a:link { font-family: Tahoma, Verdana; font-size: 8pt;
	color: #000000;
	text-decoration: none;
	}
a:visited { font-family: Tahoma, Verdana; font-size: 8pt;
	color: #000000;
	text-decoration: none;
	}
a:hover { font-family: Tahoma, Verdana; font-size: 8pt;
	color: #000000;
	text-decoration: underline;
	}

body { font-family: Tahoma, Verdana; font-size: 8pt; }

body 			{ scrollbar-face-color: #E2E5EA;}
body 			{ scrollbar-shadow-color: #687888;}
body 			{ scrollbar-highlight-color: #ffffff;}
body 			{ scrollbar-3dlight-color: #687888;}
body 			{ scrollbar-darkshadow-color: #E2E5EA;}
body 			{ scrollbar-track-color: #bcbfc0;}
body 			{ scrollbar-arrow-color: #6e7e88;}
</style>
<script language="JavaScript">
function scrollChat() {
  window.scroll(0,50000)
}
<%If Request("m")="POST"Then%>
parent.form.mensagem.value="";
<%Else%>
parent.tecla.innerHTML = "&nbsp;";
<%End If%>
</script>
<body topmargin="10" leftmargin="10" onload="scrollChat()">
<%
Response.Write strTexto

If inStr(strTexto,"mysChatFinalizado") Then
	Response.Write "<script>"
	Response.Write "alert('Cliente finalizou atendimento');"
	Response.Write "parent.window.close();"
	Response.Write "</script>"
End If
%>
</body>
</html>
