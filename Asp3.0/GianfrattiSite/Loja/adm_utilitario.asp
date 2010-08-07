<!--#include file="adm_restrito.asp"-->
<%

'##### UTILITÁRIO

'Sub UtilASP
If Request("acaba") = "sim" Then
Session("adm_descprod") = ""
Session("adm_email") = ""
End If
Select Case strAcao

case "atendimentoon"

'##### A.O.L IMPLEMENTADO POR ROGÉRIO SILVA

strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/conf_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Utilitários (Atendimento Online)</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<br><br><center><strong><FONT face=tahoma color=#000000 style=font-size:11px>Abra o link abaixo para iniciar o seu atendimento on-line<P><a href=""chat/admin/login.asp"" target=""_blank"">Iniciar atendimento</a></strong></center>"
strTextoHtml = strTextoHtml & "<table><tr><Td></TD></tr></table><center><br><Br><hr size=1 color=#cccccc width=""100%""><font face=tahoma style=font-size:11px><b><a HREF=""?"">Voltar para Página Inicial</a></b></font></center><br>"
case "ftp"
strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/conf_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Utilitários (Gerenciador de Arquivos)</B></FONT><hr size=1 color=#cccccc>"

'#########################################################################
'#########################################################################

Server.ScriptTimeout = 60

If Request("metodo") = "1" Then
Response.Expires = 0
byteCount = Request.TotalBytes
RequestBin = Request.BinaryRead(byteCount)
Set UploadRequest = CreateObject("Scripting.Dictionary")
BuildUploadRequest RequestBin
'variaveis

Set fso = Server.CreateObject("Scripting.FileSystemObject")

Path = Replace(Trim(UploadRequest.Item("Pasta").Item("Value")), "~barra~", "\")
If CStr(Path) = CStr("") Then
Path = Replace(Server.MapPath("administrador.asp"), "administrador.asp", "")
End If

arq = Trim(UploadRequest.Item("arq").Item("Value"))

ContentType = UploadRequest.Item("arq").Item("ContentType")
filepathname = UploadRequest.Item("arq").Item("FileName")
FileName = Right(filepathname, Len(filepathname) - InStrRev(filepathname, "\"))

If CStr(FileName) = CStr("") Or InStr(FileName, """") <> 0 Or InStr(FileName, "'") <> 0 Or InStr(FileName, "%") <> 0 Or InStr(FileName, "@") <> 0 Or InStr(FileName, "¨") <> 0 Or InStr(FileName, "=") <> 0 Or InStr(FileName, "+") <> 0 Or InStr(FileName, "!") <> 0 Or InStr(FileName, "$") <> 0 Or InStr(FileName, "#") <> 0 Or InStr(FileName, "&") <> 0 Or InStr(FileName, "/") <> 0 Or InStr(FileName, "\") <> 0 Or InStr(FileName, ":") <> 0 Or InStr(FileName, "*") <> 0 Or InStr(FileName, "?") <> 0 Or InStr(FileName, "|") <> 0 Or InStr(FileName, "<") <> 0 Or InStr(FileName, ">") <> 0 Then
Response.Redirect "administrador.asp?link=util&acao=ftp&acaba=sim&Pasta=" & Path & "&erroarq=sim"
Exit Sub
End If

Set ts = fso.GetFolder(Path)
For Each Arquiv In ts.Files
If CStr(Arquiv.Name) = CStr(FileName) Then
Response.Redirect "administrador.asp?link=util&acao=ftp&acaba=sim&Pasta=" & Path & "&erroarq=mesmo"
Exit For
End If
Next
Set ts = Nothing
Set fso = Nothing

Value = UploadRequest.Item("arq").Item("Value")
Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")

If CStr(Path) = CStr(Replace(Server.MapPath("administrador.asp"), "administrador.asp", "")) Then
Set MyFile = ScriptObject.CreateTextFile(Path & FileName)
Else
Set MyFile = ScriptObject.CreateTextFile(Path & "\" & FileName)
End If

For I = 1 To LenB(Value)
MyFile.Write Chr(AscB(MidB(Value, I, 1)))
Next
MyFile.Close
Set MyFile = Nothing
Set ScriptObject = Nothing
Set UploadRequest = Nothing
Response.Redirect "administrador.asp?link=util&acao=ftp&acaba=sim&Pasta=" & Path

Else

Path = Replace(Request("Pasta"), "~barra~", "\")
If Path = "" Then
Path = Replace(Server.MapPath("administrador.asp"), "administrador.asp", "")
End If


strTextoHtml = strTextoHtml & "<br><style type=""text/css"">"
strTextoHtml = strTextoHtml & "<!--"
strTextoHtml = strTextoHtml & "a:link       { color: #000000; text-decoration:none }"
strTextoHtml = strTextoHtml & "a:visited    { color: #000000; text-decoration:none }"
strTextoHtml = strTextoHtml & "a:hover      { color: #365efc; text-decoration:underline }"
strTextoHtml = strTextoHtml & "-->"
strTextoHtml = strTextoHtml & "</style>"

'#########################################################################
'#########################################################################

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set ts = fso.GetFolder(Path)

If CStr(Request("action")) = CStr("createfolder") Then
For Each Pasta In ts.Subfolders
If CStr(Pasta.Name) = CStr(Request("novapasta")) Then
ErroUPasta = "sim"
Response.Write "<script>alert ('Esta pasta já existe, especifique outro nome e tente novamente!');</script>"
End If
Next
End If

If CStr(Request("action")) = CStr("createfolder") And ErroUPasta <> "sim" Then
If CStr(Request("novapasta")) = CStr("") Or InStr(Request("novapasta"), """") <> 0 Or InStr(Request("novapasta"), "'") <> 0 Or InStr(Request("novapasta"), "%") <> 0 Or InStr(Request("novapasta"), "@") <> 0 Or InStr(Request("novapasta"), "¨") <> 0 Or InStr(Request("novapasta"), "=") <> 0 Or InStr(Request("novapasta"), "+") <> 0 Or InStr(Request("novapasta"), "!") <> 0 Or InStr(Request("novapasta"), "$") <> 0 Or InStr(Request("novapasta"), "#") <> 0 Or InStr(Request("novapasta"), "#") <> 0 Or InStr(Request("novapasta"), "&") <> 0 Or InStr(Request("novapasta"), "/") <> 0 Or InStr(Request("novapasta"), "\") <> 0 Or InStr(Request("novapasta"), ":") <> 0 Or InStr(Request("novapasta"), "*") <> 0 Or InStr(Request("novapasta"), "?") <> 0 Or InStr(Request("novapasta"), "|") <> 0 Or InStr(Request("novapasta"), "<") <> 0 Or InStr(Request("novapasta"), ">") <> 0 Then
Response.Write "<script>alert ('O nome da pasta não pode conter os  caracteres:\n             ""/\\|#!@$\'%¨&+=:*?<>');</script>"
Else
If CStr(Path) = CStr(Replace(Server.MapPath("administrador.asp"), "administrador.asp", "")) Then
fso.CreateFolder (Path & Request("novapasta"))
Else
fso.CreateFolder (Path & "/" & Request("novapasta"))
End If
End If
End If

If Request.QueryString("action") = "delete" Then

Nomedoarquivo = Replace(Replace(Request.QueryString("filename"), "~ponto~", "."), "~barra~", "\")

If Request.QueryString("type") = "file" Then
fso.DeleteFile (Nomedoarquivo)
End If
If Request.QueryString("type") = "folder" Then
fso.DeleteFolder (Replace(Replace(Request.QueryString("folder"), "~ponto~", "."), "~barra~", "\"))
End If
End If

If Right(Path, 1) = "\" Then
Path = Mid(Path, 1, Len(Path) - 1)
End If

pos = InStrRev(Path, "\")
Vstr = Left(Path, pos)

If CStr(Request("erroarq")) = CStr("sim") Then
Response.Write "<script>alert ('O nome do arquivo não pode conter os  caracteres:\n             ""/\\|#!@$\'%¨&+=:*?<>');</script>"
End If

If CStr(Request("erroarq")) = CStr("mesmo") Then
Response.Write "<script>alert ('Este arquivo já existe, especifique outro nome e tente novamente!');</script>"
End If

If CStr(Request("erroarq")) = CStr("tamanho") Then
Response.Write "<script>alert ('O arquivo excede a quantidade de MB suportada pela pasta!');</script>"
End If

parentdirectory = Vstr

strTextoHtml = strTextoHtml & "<table cellspacing=0 cellpadding=0 border=0 align=center>"
strTextoHtml = strTextoHtml & " <tr>"
strTextoHtml = strTextoHtml & "  </form><td>"

strTextoHtml = strTextoHtml & "        <table cellspacing=0 cellpadding=0 border=0 width=100% >"
strTextoHtml = strTextoHtml & "         <tr>"

strTextoHtml = strTextoHtml & "          <td align=left><table cellpadding=0 cellspacing=0 width=400><tr><td><FONT face=Tahoma color=#000000 style=font-size:11px>&nbsp;&nbsp;Listagem de arquivos de...<table><tr><td></td></tr></table>&nbsp;&nbsp;<strong>" & Path & "\</strong></td></tr></table><table><tr><td height=3></td></tr></table></td>"

strTextoHtml = strTextoHtml & "          <td align=right>"
strTextoHtml = strTextoHtml & "                <FONT face=tahoma  style=font-size:11px>"
strTextoHtml = strTextoHtml & "                &nbsp;"

If Not CStr(Path & "\") = CStr(Replace(Server.MapPath("administrador.asp"), "administrador.asp", "")) Then
strTextoHtml = strTextoHtml & "                <a href=""administrador.asp?link=util&acao=ftp&acaba=sim&Pasta=" & parentdirectory & """ class=virtuastore>"
Else
strTextoHtml = strTextoHtml & "                <a href=""javascript: alert('Acesso negado!');"" class=virtuastore>"
End If

strTextoHtml = strTextoHtml & "                <u><FONT face=tahoma  style=font-size:11px><strong>Diretório Acima</strong></u></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<table><tr><td height=5></td></tr></table>"
strTextoHtml = strTextoHtml & "                </font>"
strTextoHtml = strTextoHtml & "          </td>"
strTextoHtml = strTextoHtml & "         </tr>"
strTextoHtml = strTextoHtml & "        </table>"
strTextoHtml = strTextoHtml & "        <table cellspacing=0 cellpadding=0 border=0>"
strTextoHtml = strTextoHtml & "         <tr>"
strTextoHtml = strTextoHtml & "          <td width=15></td>"
strTextoHtml = strTextoHtml & "          </td>"
strTextoHtml = strTextoHtml & "          <td width=15></td>"
strTextoHtml = strTextoHtml & "         </tr>"
strTextoHtml = strTextoHtml & "         <tr>"
strTextoHtml = strTextoHtml & "          </td>"
strTextoHtml = strTextoHtml & "          <td bgcolor=white>"
strTextoHtml = strTextoHtml & "<table cellspacing=2 cellpadding=2 border=0 align=center>"
strTextoHtml = strTextoHtml & " <tr>"
strTextoHtml = strTextoHtml & "  <td width=220 bgcolor=#ffffff><FONT face=tahoma  style=font-size:11px><b>&nbsp;Nome</b></font></td>"
strTextoHtml = strTextoHtml & "  <td width=65 bgcolor=#ffffff><FONT face=tahoma  style=font-size:11px><b>&nbsp;Tamanho</b></font></td>"
strTextoHtml = strTextoHtml & "  <td width=160 bgcolor=#ffffff><FONT face=tahoma  style=font-size:11px><b>&nbsp;Tipo</b></font></td>"
strTextoHtml = strTextoHtml & "  <td colspan=2 width=64 bgcolor=#ffffff><FONT face=tahoma  style=font-size:11px><b>&nbsp;Opções</b></font></td>"
strTextoHtml = strTextoHtml & " </tr></table>"
strTextoHtml = strTextoHtml & "<table cellspacing=2 cellpadding=0 border=0 align=center>"

I = 0
For Each SubF In ts.Subfolders
 
 I = I + 1
 
  If Right(Path, 1) = "\" Then
   FolderPath = Path & SubF.Name
 Else
   FolderPath = Path & "\" & SubF.Name
 End If
 
 Pathz = Replace(FolderPath, "\", "~barra~")
 
strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
strTextoHtml = strTextoHtml & "function Pasta" & I & "(){" & vbNewLine
strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir a pasta """ & SubF.Name & """?'))" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "window.location.href('administrador.asp?link=util&acao=ftp&acaba=sim&Pasta=" & Replace(Request.QueryString("Pasta"), "\", "~barra~") & "&action=delete&type=folder&folder=" & Pathz & "');" & vbNewLine
strTextoHtml = strTextoHtml & "}" & vbNewLine
strTextoHtml = strTextoHtml & "else" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "}}" & vbNewLine
strTextoHtml = strTextoHtml & "</script>" & vbNewLine

strTextoHtml = strTextoHtml & " <tr>"
strTextoHtml = strTextoHtml & "  <td width=220><TABLE cellspacing=0 cellpading=0 style=cursor:default><tr><td width=18><img src=adm_imagens/folder.gif border=0 align=middle></td><td><FONT face=tahoma  style=font-size:11px><a href=""administrador.asp?link=util&acao=ftp&acaba=sim&Pasta=" & FolderPath & """>" & SubF.Name & "</a></td></tr></table></font></td>"
strTextoHtml = strTextoHtml & "  <td width=65></td>"
strTextoHtml = strTextoHtml & "  <td width=160><FONT face=tahoma  style=font-size:11px>&nbsp;Pasta de Arquivos</font></td>"
strTextoHtml = strTextoHtml & "  <td width=32></td>"
strTextoHtml = strTextoHtml & "  <td width=32>&nbsp;<a href=""javascript: Pasta" & I & "();""><img src=adm_imagens/btn_excluir.gif border=0 alt=Excluír></a></td>"
strTextoHtml = strTextoHtml & " </tr>"

Next

If CStr(I) = CStr("0") Then
ifzao = "sim"
Else
ifzao = "nao"
End If

I = 0
For Each File In ts.Files

I = I + 1
 If Right(Path, 1) = "\" Then
   WholeFile = Path & File.Name
 Else
   WholeFile = Path & "\" & File.Name
 End If
 
NomeArquivo = "Arquivo " & UCase(Right(File.Name, 3))

 fileSize = FormatNumber(File.Size / 1024, 0)
 If File.Size > 0 And fileSize = 0 Then
   fileSize = 1
 End If
  
 TipoArquivoImg = "file.gif"
 
WholeFile = Replace(Replace(WholeFile, ".", "~ponto~"), "\", "~barra~")
Pathz = Replace(Path, "\", "~barra~")

strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
strTextoHtml = strTextoHtml & "function Arquivo" & I & "(){" & vbNewLine
strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir o arquivo """ & File.Name & """?'))" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "window.location.href('administrador.asp?link=util&acao=ftp&acaba=sim&Pasta=" & Pathz & "&action=delete&type=file&filename=" & WholeFile & "');" & vbNewLine
strTextoHtml = strTextoHtml & "}" & vbNewLine
strTextoHtml = strTextoHtml & "else" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "}}" & vbNewLine
strTextoHtml = strTextoHtml & "</script>" & vbNewLine

WholeFile = Replace(WholeFile, "~ponto~", ".")

strTextoHtml = strTextoHtml & " <tr>"
strTextoHtml = strTextoHtml & "  <td width=220><TABLE cellspacing=0 cellpading=0 style=cursor:default><tr><td width=18 align=center><img src=""adm_imagens/" & TipoArquivoImg & """ border=0 align=middle></td><td><FONT face=tahoma  style=font-size:11px>" & File.Name & "</td></tr></table></font></td>"
strTextoHtml = strTextoHtml & "  <td width=65 align=right><FONT face=tahoma  style=font-size:11px>" & fileSize & " Kb&nbsp;&nbsp;&nbsp;</font></td>"
strTextoHtml = strTextoHtml & "  <td width=160><FONT face=tahoma  style=font-size:11px>&nbsp;" & NomeArquivo & "</font></td>"
strTextoHtml = strTextoHtml & "  <td width=32 align=right><FONT face=Verdana  style=font-size:10px>&nbsp;<a href=""dwarq.asp?NomeZ=" & WholeFile & "&ArquivoZ=" & File.Name & """ target=framearq><image src=adm_imagens/btn_editar_adm.gif border=0 alt=Download></a></font></td>"
strTextoHtml = strTextoHtml & "  <td width=32>&nbsp;<a href=""javascript: Arquivo" & I & "();""><img src=adm_imagens/btn_excluir.gif border=0 alt=Excluír></a></td>"
strTextoHtml = strTextoHtml & " </tr>"


 Next
 
 If CStr(I) = CStr("0") And ifzao = "sim" Then
strTextoHtml = strTextoHtml & "<tr><td colspan=6><font style=font-size:11px;font-family:tahoma><table><tr><td></td></tr></table><center>Nenhum arquivo encontrado</center></td></tr>"
 End If
 strTextoHtml = strTextoHtml & "<tr><td colspan=6 width=530 style=""border-bottom:1px #cccccc dotted""><font style=font-size:11px;font-family:tahoma><table><tr><td></td></tr></table></td></tr>"

strTextoHtml = strTextoHtml & "</table><iframe width=0 height=0 name=framearq frameborder=0 border=0 scrolling=no src=""about:blank""></iframe>"

strTextoHtml = strTextoHtml & "          </td>"
strTextoHtml = strTextoHtml & "          </td>"
strTextoHtml = strTextoHtml & "         </tr>"
strTextoHtml = strTextoHtml & "         <tr>"
strTextoHtml = strTextoHtml & "          <td></td>"
strTextoHtml = strTextoHtml & "          </td>"
strTextoHtml = strTextoHtml & "          <td></td>"
strTextoHtml = strTextoHtml & "         </tr>"
strTextoHtml = strTextoHtml & "        </table>"


strTextoHtml = strTextoHtml & "        <table cellspacing=1 cellpadding=1 border=0 width=532 ><tr><td height=5></td></tr><form action=""administrador.asp"" method=get><tr><td valign=top align=left><font face=tahoma style=font-size:11px>&nbsp;&nbsp;</font></td><td align=right>"
strTextoHtml = strTextoHtml & "<FONT face=tahoma  style=font-size:11px>"
strTextoHtml = strTextoHtml & "<input type=hidden name=acao value=ftp><input type=hidden name=link value=util><input type=hidden name=Pasta value=""" & Request.QueryString("Pasta") & """><input type=hidden name=action value=createfolder>"
strTextoHtml = strTextoHtml & " Nova pasta: <input type=text name=novapasta style=font-size:11px;font-family:tahoma>&nbsp;<input type=submit style=font-size:11px;font-family:tahoma value="" Criar Pasta "">"

strTextoHtml = strTextoHtml & "</td></form></tr><form method=post ENCTYPE=""multipart/form-data"" action=""administrador.asp?link=util&acao=ftp&acaba=sim&metodo=1""><input type=hidden name=Pasta value=""" &  Replace(Request.QueryString("Pasta"), "\", "~barra~") & """><tr><td colspan=2 align=right>"
strTextoHtml = strTextoHtml & "<FONT face=tahoma  style=font-size:11px>&nbsp; Novo Arquivo: <input type=file name=arq size=18 style=font-size:11px;font-family:tahoma> &nbsp;<input type=submit style=font-size:11px;font-family:tahoma value="" Gravar "">"

strTextoHtml = strTextoHtml & "        </td></tr></table>"

strTextoHtml = strTextoHtml & "  </td>"
strTextoHtml = strTextoHtml & " </tr>"
strTextoHtml = strTextoHtml & "</table>"

strTextoHtml = strTextoHtml & "</font>"
strTextoHtml = strTextoHtml & "</center>"

'#########################################################################
'#########################################################################

End If



strTextoHtml = strTextoHtml & "<br><table><tr><Td></TD></tr></table><center><hr size=1 color=#cccccc width=""100%""><font face=tahoma style=font-size:11px><b><a HREF=""?"">Voltar para Página Inicial</a></b></font></center><br>"

'#########################################################################
'#########################################################################

case "exclui"

set rs = conexao.execute("select idcompra from compras where status='Compra em Aberto'")
if rs.eof then
else
do while not rs.eof 

'Sem as 2 rotina, aparece "carrinhos-fantasmas" ...
conexao.execute("delete * from pedidos where idcompra='" & rs("idcompra") & "'")
conexao.Execute("delete * from compras where idcompra=" & rs("idcompra") & ";")

rs.movenext
loop
end if
rs.close
set rs = nothing
conexao.execute("delete from compras where status='Compra em Aberto'")

response.redirect "administrador.asp?link=util&acao=limpar&sucesso=sim&acaba=sim"

Case "limpar"

strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/conf_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Utilitários (Otimizar banco de dados)</B></FONT><hr size=1 color=#cccccc>"

set rs = conexao.execute("select count(idcompra) as total from compras where status='Compra em Aberto'")
total_de_compras = rs("total")
rs.close
set rs = nothing

if Request.QueryString("sucesso") = "sim" then
    strSucesso = UCASE("<font face=tahoma style=font-size:11px;color:003366><b>Banco de Dados otimizado com Sucesso!</b></font>")
else
	strSucesso = ""
end if

strTextoHtml = strTextoHtml & "<table><tr><td align=left valign=top><table border=0 cellspacing=4 cellpadding=4 width=""100%""><tr><td>"
strTextoHtml = strTextoHtml & "<table cellspacing=3 cellpadding=3 align=center width=""570"">"
strTextoHtml = strTextoHtml & "<tr><td height=15></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td align=center><font face=tahoma style=font-size:11px;color:000000>Clique no Botão 'Otimizar Agora!' para Efetuar a Operação.<br></font><font face=tahoma style=font-size:11px;color:000000><b>Realize esta operação no minímo a cada 15 dias!</b></font></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td height=25 align=center>" & strSucesso & "</td><form name=frmcompras action=administrador.asp><input type=hidden name=link value=util><input type=hidden name=acao value=exclui></tr>"
strTextoHtml = strTextoHtml & "<tr><td align=center><input type=submit value=""Otimizar Agora!"" style=""cursor:hand;font-family:tahoma; font-size: 11px;""></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=tahoma style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td></tr>"
strTextoHtml = strTextoHtml & "</table></td></form></tr></table></table>"

case "executa"

strSql = Request.QueryString("comando")
strArea_transferencia = Request.QueryString("area_transferencia")

'grava a area de transferencia em cookies
if strArea_transferencia<>"" then
response.cookies("AreaTransferenciaSql")= strArea_transferencia
response.cookies("AreaTransferenciaSql").Expires= #January 01, 2010#
end if

on error resume next
conexao.execute(strSql)
if err.number = 0 Then
   response.redirect "administrador.asp?link=util&acao=sql&sucesso=sim"
else
   response.redirect "administrador.asp?link=util&acao=sql&erro=" & err.description
end if



case "stats"
'####################################################
' ESTATISTICAS DA LOJA VIRTUA STORE
' RESPONSÁVEL ROGÉRIO SILVA
' WEBMASTER_WB@BRFREE.COM.BR
' ICQ: 72674360
' MSN: WORLDBILY@HOTMAIL.COM (SEG A SEX)
'####################################################
strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/conf_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Utilitários (Estatísticas de acesso)</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<script language=""javascript"" src=""layer.js""></script>"
strTextoHtml = strTextoHtml & "<style type=""text/css"">"
strTextoHtml = strTextoHtml & "<!--"
strTextoHtml = strTextoHtml & ".titulo {"
strTextoHtml = strTextoHtml & "	font-family: tahoma, Arial, Helvetica, sans-serif;"
strTextoHtml = strTextoHtml & "	font-size: small;"
strTextoHtml = strTextoHtml & "	font-weight: bold;"
strTextoHtml = strTextoHtml & "}"
strTextoHtml = strTextoHtml & ".conteudo {"
strTextoHtml = strTextoHtml & "	font-family: tahoma, Arial, Helvetica, sans-serif;"
strTextoHtml = strTextoHtml & "	font-size: x-small;"
strTextoHtml = strTextoHtml & "	color: #0000FF;"
strTextoHtml = strTextoHtml & "}"
strTextoHtml = strTextoHtml & "-->"
strTextoHtml = strTextoHtml & "</style>"
'####################################################
strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#000000 style=font-size:11px><br>&nbsp;<b>Estatísticas</b> &nbsp;&nbsp;&nbsp;&nbsp;<a href=""administrador.asp?link=util&acao=export&acaba=sim""><u>Exportar?</u></a>  - <a href=""administrador.asp?link=util&acao=zero&acaba=sim""><u>Resetar Contadores?</u></a></FONT><br><br><hr size=1 color=#cccccc>"
'####################################################
strTextoHtml = strTextoHtml & "<TABLE BORDER=0 CELLPADDING=2 CELLSPACING=0 WIDTH=""100%"" class=""titulo"">"
strTextoHtml = strTextoHtml & "<TR>"
strTextoHtml = strTextoHtml & "    <TD width=""70%"">Navegadores Utilizados</TD>"
strTextoHtml = strTextoHtml & "  </TR>"
strTextoHtml = strTextoHtml & "<TR> "
strTextoHtml = strTextoHtml & "<TD colspan=2> <TABLE BORDER=1 BORDERCOLOR=""#ECECEC"" CELLPADDING=2 CELLSPACING=0 WIDTH=""100%"" class=""conteudo"">"
strTextoHtml = strTextoHtml & "<TR bgcolor=""#ECECEC""> "
strTextoHtml = strTextoHtml & "          <TH colspan=""2"">Navegadores</TH>"
strTextoHtml = strTextoHtml & "          <TH bgcolor=""#CCCCCC"" width=68>Hits</TH>"
strTextoHtml = strTextoHtml & "</TR>"

'Recupera informações sobre os browsers
SQL_Navegador = "select * from browsers order by id desc"
Set RS_Navegador = abredb.Execute(SQL_Navegador)

total = 1

'Utiliza um contador para verificar o total -> isso para todos os ítens que são "pontuados"
Do Until RS_Navegador.EOF
total = total + RS_Navegador("acessos")
RS_Navegador.MoveNext
Loop

RS_Navegador.MoveFirst

'####################################################
Response.Cookies("VSOpenNavegador").Expires=#May 10,2010#
'####################################################
Do Until RS_Navegador.EOF
'####################################################
Response.Cookies("VSOpenNavegador")(RS_Navegador("browser")) = RS_Navegador("acessos")
'####################################################

strTextoHtml = strTextoHtml & "<TR> "
strTextoHtml = strTextoHtml & "<TD width=""30%"">"&RS_Navegador("browser")&"</TD>"
strTextoHtml = strTextoHtml & "<TD width=""50%"" align=""left""><hr size=""4"" color=""#0099FF"" width="""&Round(CDbl(RS_Navegador("acessos"))/total, 2) * 100 * 2&"""></TD>"
strTextoHtml = strTextoHtml & "<TD width=""20%"">"&RS_Navegador("acessos")&"</TD>"
strTextoHtml = strTextoHtml & "</TR>"
RS_Navegador.MoveNext
Loop

strTextoHtml = strTextoHtml & "</TABLE></TD></TR>"
strTextoHtml = strTextoHtml & "</TABLE>"
strTextoHtml = strTextoHtml & "<br><BR>"
strTextoHtml = strTextoHtml & "<TABLE BORDER=0 CELLPADDING=2 CELLSPACING=0 WIDTH=""100%"" class=""titulo"">"
strTextoHtml = strTextoHtml & "  <TR><TD width=""70%"">Hosts dos usuários</TD></TR>"
strTextoHtml = strTextoHtml & "<TR>" 
strTextoHtml = strTextoHtml & "<TD colspan=2> <TABLE BORDER=1 BORDERCOLOR=""#ECECEC"" CELLPADDING=2 CELLSPACING=0 WIDTH=""100%"" class=""conteudo"">"
strTextoHtml = strTextoHtml & "<TR bgcolor=""#ECECEC""> "
strTextoHtml = strTextoHtml & "<TH width=""697"" colspan=""2"">Origem (Últimos 20 acessos)</TH>"
strTextoHtml = strTextoHtml & "</TR>"

if VersaoDb = 1 then
	SQL_Host = "select * from hosts LIMIT 0,20"
else
	SQL_Host = "select top 20 * from hosts order by id desc"
end if

Set RS_Host = abredb.Execute(SQL_Host)
cont = 1
Do Until RS_Host.EOF

strTextoHtml = strTextoHtml & "<TR>"
strTextoHtml = strTextoHtml & "<TD>"&right("00"&cont,2)&"</TD>"
strTextoHtml = strTextoHtml & "<TD>"&RS_Host("host")&"</TD>"
strTextoHtml = strTextoHtml & "</TR>"

RS_Host.MoveNext
cont =cont +1
Loop

strTextoHtml = strTextoHtml & "</TABLE></TD></TR></TABLE>"
strTextoHtml = strTextoHtml & "<br><BR>"
strTextoHtml = strTextoHtml & "<TABLE BORDER=0 CELLPADDING=2 CELLSPACING=0 WIDTH=""100%"" class=""titulo"">"
strTextoHtml = strTextoHtml & "  <TR><TD width=""70%"">Referências ao site</TD></TR>"
strTextoHtml = strTextoHtml & "<TR> "
strTextoHtml = strTextoHtml & "<TD colspan=2> <TABLE BORDER=1 BORDERCOLOR=""#ECECEC"" CELLPADDING=2 CELLSPACING=0 WIDTH=""100%"" class=""conteudo"">"
strTextoHtml = strTextoHtml & "<TR bgcolor=""#ECECEC""> "
strTextoHtml = strTextoHtml & "<TH width=""697"">Páginas utilizadas como link (Últimos 20 acessos)</TH>"
strTextoHtml = strTextoHtml & "</TR>"

if VersaoDb = 1 then
	SQL_Referencia = "select * from referencias LIMIT 0,20"
else
	SQL_Referencia = "select top 20 * from referencias order by id desc"
end if

Set RS_Referencia = abredb.Execute(SQL_Referencia)

Do Until RS_Referencia.EOF

strTextoHtml = strTextoHtml & "<TR><TD>"&RS_Referencia("referencia")&"</TD></TR>"
RS_Referencia.MoveNext
Loop

strTextoHtml = strTextoHtml & "</TABLE></TD></TR></TABLE>"
strTextoHtml = strTextoHtml & "<br>"
strTextoHtml = strTextoHtml & "<br>"
strTextoHtml = strTextoHtml & "<TABLE BORDER=0 CELLPADDING=2 CELLSPACING=0 WIDTH=""100%"" class=""titulo"">"
strTextoHtml = strTextoHtml & "  <TR><TD width=""70%"">Visualização por Meses</TD></TR>"
strTextoHtml = strTextoHtml & "<TR> "
strTextoHtml = strTextoHtml & "<TD colspan=2> <TABLE BORDER=1 BORDERCOLOR=""#ECECEC"" CELLPADDING=2 CELLSPACING=0 WIDTH=""100%"" class=""conteudo"">"
strTextoHtml = strTextoHtml & "<TR bgcolor=""#ECECEC""> "
strTextoHtml = strTextoHtml & "<TH colspan=""2"">Mês</TH>"
strTextoHtml = strTextoHtml & "          <TH bgcolor=""#CCCCCC"" width=262>Hits</TH>"
strTextoHtml = strTextoHtml & "</TR>"

SQL_Mes = "select * from meses order by id desc"
Set RS_Mes = abredb.Execute(SQL_Mes)

total = 1

Do Until RS_Mes.EOF
total = total + RS_Mes("acessos")
RS_Mes.MoveNext
Loop

RS_Mes.MoveFirst

Do Until RS_Mes.EOF

strTextoHtml = strTextoHtml & "<TR>" 
strTextoHtml = strTextoHtml & "<TD width=""156"">"&MonthName(RS_Mes("mes"))&"</TD>"
strTextoHtml = strTextoHtml & "<TD width=""535"" align=""left""><hr size=4 color=""#0099FF"" width="""&Round(CDbl(RS_Mes("acessos"))/total, 2) * 100 * 2&""" ></TD>"
strTextoHtml = strTextoHtml & "<TD>"&RS_Mes("acessos")&"</TD>"
strTextoHtml = strTextoHtml & "</TR>"

RS_Mes.MoveNext
Loop

strTextoHtml = strTextoHtml & "</TABLE></TD></TR></TABLE>"
strTextoHtml = strTextoHtml & "<br><br>"
strTextoHtml = strTextoHtml & "<TABLE BORDER=0 CELLPADDING=2 CELLSPACING=0 WIDTH=""100%"" class=""titulo"">"
strTextoHtml = strTextoHtml & "  <TR><TD width=""70%"">Visualização por Dias da Semana</TD></TR>"
strTextoHtml = strTextoHtml & "<TR> "
strTextoHtml = strTextoHtml & "<TD colspan=2> <TABLE BORDER=1 BORDERCOLOR=""#ECECEC"" CELLPADDING=2 CELLSPACING=0 WIDTH=""100%"" class=""conteudo"">"
strTextoHtml = strTextoHtml & "<TR bgcolor=""#ECECEC""> "
strTextoHtml = strTextoHtml & "<TH colspan=""2"">Dia da Semana</TH>"
strTextoHtml = strTextoHtml & "          <TH bgcolor=""#CCCCCC"" width=262>Hits</TH>"
strTextoHtml = strTextoHtml & "</TR>"

SQL_Semana = "select * from semana order by id desc"
Set RS_Semana = abredb.Execute(SQL_Semana)

total = 1

Do Until RS_Semana.EOF
total = total + RS_Semana("acessos")
RS_Semana.MoveNext
Loop

RS_Semana.MoveFirst

Do Until RS_Semana.EOF

strTextoHtml = strTextoHtml & "<TR> "
strTextoHtml = strTextoHtml & "<TD width=""157"">"& WeekdayName(Weekday(RS_Semana("dia_semana"),1))&"</TD>"
strTextoHtml = strTextoHtml & "<TD width=""534"" align=""left""><hr size=4 color=""#0099FF""  width="""&Round(CDbl(RS_Semana("acessos"))/total, 2) * 100 * 2&"""></TD>"
strTextoHtml = strTextoHtml & "<TD>"&RS_Semana("acessos")&"</TD>"
strTextoHtml = strTextoHtml & "</TR>"

RS_Semana.MoveNext
Loop

strTextoHtml = strTextoHtml & "</TABLE></TD></TR></TABLE>"
strTextoHtml = strTextoHtml & "<br><br>"
strTextoHtml = strTextoHtml & "<TABLE BORDER=0 CELLPADDING=2 CELLSPACING=0 WIDTH=""100%"" class=""titulo"">"
strTextoHtml = strTextoHtml & "  <TR> "
strTextoHtml = strTextoHtml & "<TD width=""100%"">Visualização por Horários</TD>"
strTextoHtml = strTextoHtml & "</TR>"
strTextoHtml = strTextoHtml & "<TR> "
strTextoHtml = strTextoHtml & "<TD colspan=2> <TABLE BORDER=1 BORDERCOLOR=""#ECECEC"" CELLPADDING=2 CELLSPACING=0 WIDTH=""100%"" class=""conteudo"">"
strTextoHtml = strTextoHtml & "<TR bgcolor=""#ECECEC""> "
strTextoHtml = strTextoHtml & "<TH colspan=""2"">Horários</TH>"
strTextoHtml = strTextoHtml & "          <TH bgcolor=""#CCCCCC"" width=262>Hits</TH>"
strTextoHtml = strTextoHtml & "</TR>"

SQL_Hora = "select * from horas order by id desc"
Set RS_Hora = abredb.Execute(SQL_Hora)

total = 1

Do Until RS_Hora.EOF
total = total + RS_Hora("acessos")
RS_Hora.MoveNext
Loop

RS_Hora.MoveFirst

Do Until RS_Hora.EOF

strTextoHtml = strTextoHtml & "<TR>" 
strTextoHtml = strTextoHtml & "<TD width=""33"">"&RS_Hora("hora")&"</TD>"
strTextoHtml = strTextoHtml & "<TD width=""658"" align=""left""><hr size=4 color=""#0099FF""  width="""&Round(CDbl(RS_Hora("acessos"))/total, 2) * 100 * 2&"""></TD>"
strTextoHtml = strTextoHtml & "<TD>"&RS_Hora("acessos")&"</TD>"
strTextoHtml = strTextoHtml & "</TR>"

RS_Hora.MoveNext
Loop

strTextoHtml = strTextoHtml & "</TABLE></TD>"
strTextoHtml = strTextoHtml & "</TR>"

strTextoHtml = strTextoHtml & "<TR><TD colspan=""3""> <a href='http://worldbily.cjb.net' target='_blank'><font face=tahoma size=1 color=#EFEFEF>&copy;Rogério Silva</a></font></td></TABLE>"
case "sql"

strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/conf_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Utilitários (SQL Manager)</B></FONT><hr size=1 color=#cccccc>"

if Request.QueryString("sucesso") = "sim" then
    strSucesso = UCASE("<font face=tahoma style=font-size:11px;color:003366><b>O Comando Foi Executado Com Sucesso!</b></font>")
else
	strSucesso = ""
end if

erro = Request.QueryString("erro")

if erro <> "" then
   	strSucesso = "<font face=tahoma style=font-size:11px;color:ff0000><b>Ocorreu o Seguinte Erro ao Executar:</b></br>" & erro & "</font>"
end if

area_transferencia = Request.Cookies("AreaTransferenciaSql")

strTextoHtml = strTextoHtml & "<table><tr><td align=left valign=top><table border=0 cellspacing=4 cellpadding=4 width=""100%""><tr><td align=center>"
strTextoHtml = strTextoHtml & "<font face=tahoma style=font-size:11px;color:000000>Utilize o SQL Manager Para Executar Comandos SQL Como: INSERT, UPDATE, DELETE, etc...<br><b>ATENÇÃO!! Qualquer Comando acima Executado no SQL Manager é Irreversível!!</b><br><br><img align=absmiddle border=0 src=""adm_imagens/folder.gif"" >&nbsp;&nbsp;&nbsp;<a HREF=""adm_sql.asp"" target=""_blank"">Para executar comandos SELECT clique aqui para abrir uma nova janela para melhor visualização</a><br><hr size=1 color=#dddddd width=""100%"">"
strTextoHtml = strTextoHtml & "<table cellspacing=3 cellpadding=3 align=center width=""570"">"
strTextoHtml = strTextoHtml & "<tr><td height=25 align=center>" & strSucesso &"</td><form action=administrador.asp><input type=hidden name=link value=util><input type=hidden name=acao value=executa></tr>"
strTextoHtml = strTextoHtml & "<tr><td align=center><font face=tahoma style=font-size:11px;color:000000>Comando SQL</font><br><textarea name=comando rows=8 cols=80 style=""font-family:tahoma; font-size: 11px; color:003366"">" & comando &"</textarea></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td align=center><font face=tahoma style=font-size:11px;color:000000>Área de Transferência</font><br><textarea name=area_transferencia rows=5 cols=80 style=""font-family:tahoma; font-size: 11px; color:003366"">" & area_transferencia &"</textarea></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td align=center><input type=submit value=""      Executar      "" style=""cursor:hand;font-family:tahoma; font-size: 11px;""></td></form></tr>"
strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=tahoma style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td></tr>"
strTextoHtml = strTextoHtml & "</table></td></form></tr></table></table>"

'########################################################
case "export"
'########################################################
strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/conf_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Utilitários (Estatísticas de acesso - Exportação)</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#000000 style=font-size:11px><br><a href=""administrador.asp?link=util&acao=stats&acaba=sim""><u>Estatísticas</u></a> &nbsp;&nbsp;&nbsp;&nbsp;<b>Exportar</b>  - <a href=""administrador.asp?link=util&acao=zero&acaba=sim"">Resetar Contadores</a><br><br></FONT><hr size=1 color=#cccccc><FONT face=tahoma color=#000000 style=font-size:10px>"
'########################################################
Response.Buffer = true
'-------------------------------------------------
'------ DECLARANDO AS VARIAVEIS NO SERVIDOR ------
'-------------------------------------------------					
Dim Fso,ArqLog,Caminho,Gravar,Arquivo
'--------------------------------------------------------------------------------
'------ DECLARANDO AS CONSTANTES ------
'--------------------------------------
Const ForReading = 1,ForAppending = 8, tristateTrue = -1, tristateFalse = 0
'--------------------------------------
Set Fso = Server.CreateObject("Scripting.FileSystemObject")
'--------------------------------------
Gravar = Mid(Request.ServerVariables("PATH_TRANSLATED"),1,(Len(Request.ServerVariables("PATH_TRANSLATED"))-17) )
Gravar = Gravar  &"database\estatisticas.dat"
'--------------------------------------
Caminho = Fso.GetAbsolutePathName(Gravar)
Arquivo = Fso.GetFileName(Caminho)
'--------------------------------------
	IF Fso.FileExists(Caminho) Then
		Fso.DeleteFile Arquivo,True
	END IF
'--------------------------------------
Set ArqLog = Fso.CreateTextFile(Gravar,True)
'--------------------------------------
		ArqLog.WriteLine ("#----------------------------------------------#")
		ArqLog.WriteLine ("#    ESTATÍSTICAS DA LOJA VIRTUA STORE         #")
		ArqLog.WriteLine ("# GERADO EM: "&now()&" hs            #")
		ArqLog.WriteLine ("# Copyright: Rogério Silva                     #")
		ArqLog.WriteLine ("# http://worldbily.cjb.net                     #")
		ArqLog.WriteLine ("#----------------------------------------------#")
		ArqLog.WriteBlankLines 1
		'--------------------------------------------------------------------------------------------------------------------
		'##### NAVEGADORES UTILIZADOS
		'--------------------------------------------------------------------------------------------------------------------
		ArqLog.WriteLine ("#------------------------")
		ArqLog.WriteLine ("# Navegadores Utilizados")
		ArqLog.WriteLine ("#------------------------")
		ArqLog.WriteLine ("# Navegadores|Hits       ")
		ArqLog.WriteLine ("#------------------------")
		'--------------------------------------------------------------------------------------------------------------------
		'Recupera informações sobre os browsers
		SQL_Navegador = "select * from browsers"
		Set RS_Navegador = abredb.Execute(SQL_Navegador)
		'--------------------------------------------------------------------------------------------------------------------
		total = 1
		'--------------------------------------------------------------------------------------------------------------------
		Do Until RS_Navegador.EOF
		total = total + RS_Navegador("acessos")
		RS_Navegador.MoveNext
		Loop
		'--------------------------------------------------------------------------------------------------------------------
		RS_Navegador.MoveFirst
		'--------------------------------------------------------------------------------------------------------------------
		Do Until RS_Navegador.EOF
		'--------------------------------------------------------------------------------------------------------------------
		ArqLog.WriteLine ( RS_Navegador("browser")&"|"&RS_Navegador("acessos"))
		'--------------------------------------------------------------------------------------------------------------------
		RS_Navegador.MoveNext
		Loop

		ArqLog.WriteBlankLines 1
		ArqLog.WriteLine ("**************************************************")
		'--------------------------------------------------------------------------------------------------------------------
		'##### HOSTS UTILIZADOS
		'--------------------------------------------------------------------------------------------------------------------
		ArqLog.WriteLine ("#------------------------")
		ArqLog.WriteLine ("# Hosts dos usuários ")
		ArqLog.WriteLine ("#------------------------")
		ArqLog.WriteLine ( "# Origem (Últimos 20 acessos)")
		ArqLog.WriteLine ("#------------------------")
		'--------------------------------------------------------------------------------------------------------------------
		
		if VersaoDb = 1 then
			SQL_Host = "select * from hosts LIMIT 0,20"
		else
			SQL_Host = "select top 20 * from hosts"
		end if
		
		Set RS_Host = abredb.Execute(SQL_Host)
		cont = 1
		'--------------------------------------------------------------------------------------------------------------------
		Do Until RS_Host.EOF
		ArqLog.WriteLine ( right("00"&cont,2)&"|"&RS_Host("host"))
		'--------------------------------------------------------------------------------------------------------------------
		RS_Host.MoveNext
		cont =cont +1
		Loop

		ArqLog.WriteBlankLines 1
		ArqLog.WriteLine ("**************************************************")
		'--------------------------------------------------------------------------------------------------------------------
		'##### REFERENCIAS DE ENTRADA
		'--------------------------------------------------------------------------------------------------------------------
		ArqLog.WriteLine ("#------------------------")
		ArqLog.WriteLine ( "# Referências ao site ")
		ArqLog.WriteLine ("#------------------------")
		ArqLog.WriteLine ( "#Páginas utilizadas como link (Últimos 20 acessos)")
		ArqLog.WriteLine ("#------------------------")
		'--------------------------------------------------------------------------------------------------------------------

		if VersaoDb = 1 then
			SQL_Referencia = "select * from referencias LIMIT 0,20"
		else
			SQL_Referencia = "select top 20 * from referencias"
		end if

		Set RS_Referencia = abredb.Execute(SQL_Referencia)
		'--------------------------------------------------------------------------------------------------------------------
		Do Until RS_Referencia.EOF
		'--------------------------------------------------------------------------------------------------------------------
		ArqLog.WriteLine ( RS_Referencia("referencia"))
		RS_Referencia.MoveNext
		Loop

		ArqLog.WriteBlankLines 1
		ArqLog.WriteLine ("**************************************************")
		'--------------------------------------------------------------------------------------------------------------------
		'##### VISUALIZAÇOES POR MESES
		'--------------------------------------------------------------------------------------------------------------------
		ArqLog.WriteLine ("#------------------------")
		ArqLog.WriteLine ( "# Visualização por Meses ")
		ArqLog.WriteLine ("#------------------------")
		ArqLog.WriteLine ( "# Mês|Hits")
		ArqLog.WriteLine ("#------------------------")
		'--------------------------------------------------------------------------------------------------------------------
		SQL_Mes = "select * from meses"
		Set RS_Mes = abredb.Execute(SQL_Mes)
		'--------------------------------------------------------------------------------------------------------------------
		total = 1
		'--------------------------------------------------------------------------------------------------------------------
		Do Until RS_Mes.EOF
		total = total + RS_Mes("acessos")
		RS_Mes.MoveNext
		Loop
		'--------------------------------------------------------------------------------------------------------------------
		RS_Mes.MoveFirst
		'--------------------------------------------------------------------------------------------------------------------
		Do Until RS_Mes.EOF
		'--------------------------------------------------------------------------------------------------------------------
		ArqLog.WriteLine ( MonthName(RS_Mes("mes"))&"|"&RS_Mes("acessos"))
		'--------------------------------------------------------------------------------------------------------------------
		RS_Mes.MoveNext
		Loop

		ArqLog.WriteBlankLines 1
		ArqLog.WriteLine ("**************************************************")
		'--------------------------------------------------------------------------------------------------------------------
		'##### VISUALIZAÇOES POR SEMANA
		'--------------------------------------------------------------------------------------------------------------------
		ArqLog.WriteLine ("#------------------------")
		ArqLog.WriteLine ( "# Visualização por Dias da Semana")
		ArqLog.WriteLine ("#------------------------")
		ArqLog.WriteLine ( "# Dia da Semana|Hits ")
		ArqLog.WriteLine ("#------------------------")
		'--------------------------------------------------------------------------------------------------------------------
		SQL_Semana = "select * from semana"
		Set RS_Semana = abredb.Execute(SQL_Semana)
		'--------------------------------------------------------------------------------------------------------------------
		total = 1
		'--------------------------------------------------------------------------------------------------------------------
		Do Until RS_Semana.EOF
		total = total + RS_Semana("acessos")
		RS_Semana.MoveNext
		Loop
		'--------------------------------------------------------------------------------------------------------------------
		RS_Semana.MoveFirst
		'--------------------------------------------------------------------------------------------------------------------
		Do Until RS_Semana.EOF

		ArqLog.WriteLine ( WeekdayName(Weekday(RS_Semana("dia_semana"),1))&"|"&RS_Semana("acessos"))
		'--------------------------------------------------------------------------------------------------------------------
		RS_Semana.MoveNext
		Loop

		ArqLog.WriteBlankLines 1
		ArqLog.WriteLine ("**************************************************")
		'--------------------------------------------------------------------------------------------------------------------
		'##### VISUALIZAÇOES POR HORA
		'--------------------------------------------------------------------------------------------------------------------
		ArqLog.WriteLine ("#------------------------")
		ArqLog.WriteLine ( "# Visualização por Horários")
		ArqLog.WriteLine ("#------------------------")
		ArqLog.WriteLine ( "# Horários|Hits ")
		ArqLog.WriteLine ("#------------------------")
		'--------------------------------------------------------------------------------------------------------------------
		SQL_Hora = "select * from horas"
		Set RS_Hora = abredb.Execute(SQL_Hora)
		'--------------------------------------------------------------------------------------------------------------------
		total = 1
		'--------------------------------------------------------------------------------------------------------------------
		Do Until RS_Hora.EOF
		total = total + RS_Hora("acessos")
		RS_Hora.MoveNext
		Loop
		'--------------------------------------------------------------------------------------------------------------------
		RS_Hora.MoveFirst
		'--------------------------------------------------------------------------------------------------------------------
		Do Until RS_Hora.EOF
		'--------------------------------------------------------------------------------------------------------------------
		ArqLog.WriteLine ( RS_Hora("hora")&"|"&RS_Hora("acessos"))
		'--------------------------------------------------------------------------------------------------------------------
		RS_Hora.MoveNext
		Loop
		'--------------------------------------------------------------------------------------------------------------------
		ArqLog.WriteBlankLines 1
		ArqLog.WriteLine ("**************************************************")
		ArqLog.WriteLine ("http://worldbily.cjb.net - © Rogério Silva")
		ArqLog.WriteLine ("**************************************************")
'--------------------------------------
ArqLog.close
IF Fso.FileExists(Caminho) Then
	strTextoHtml = strTextoHtml & "<script language=""javascript"" src=""layer.js""></script>"
	strTextoHtml = strTextoHtml & "<script language=""javascript"">x = 5;function t(){ if(x==0){generico('administrador.asp?link=util&acao=down&acaba=sim','down',20,20,0,0,'no','no')}else{x= x -1;setTimeout('t()',1000);}}t()</script>"
	strTextoHtml = strTextoHtml & "<P><center>Arquivo gerado com sucesso, aguarde 5 segundos para iniciar o download.<P>Caso o download não inicie, <a href='administrador.asp?link=util&acao=down&acaba=sim'>clique aqui para iniciar o download.</a>"
END IF

strTextoHtml = strTextoHtml & "</center></FONT>"

Response.Clear
Response.Flush
'########################################################
case "down"
		Response.Buffer = true
'########################################################
strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/conf_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Utilitários (Estatísticas de acesso - Exportação)</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#000000 style=font-size:10px>&nbsp;<a href=""administrador.asp?link=util&acao=stats&acaba=sim"">Estatísticas</a> - <b>Exportar</b>  - <a href=""administrador.asp?link=util&acao=zero&acaba=sim"">Resetar Contadores</a></FONT><hr size=1 color=#cccccc>"
'########################################################

		response.AddHeader "Content-Type","application/x-msdownload"
		response.AddHeader "Content-Disposition","attachment; filename=estatisticas.dat"
		Response.Flush
		Const adTypeBinary = 1
		Dim strFilePath

		Set objStream = Server.CreateObject("ADODB.Stream")
		objStream.Open
		objStream.Type = adTypeBinary

		objStream.LoadFromFile Server.MapPath("database/estatisticas.dat")
		Response.BinaryWrite objStream.Read
		objStream.Close
		Set objStream = Nothing
		Response.Flush
		Response.Clear
'########################################################
case "zero"
'########################################################
strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/conf_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Utilitários (Estatísticas de acesso - Resetar contadores)</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#000000 style=font-size:10px>&nbsp;<a href=""administrador.asp?link=util&acao=stats&acaba=sim"">Estatísticas</a> - <a href=""administrador.asp?link=util&acao=export&acaba=sim"">Exportar</a>  - <b>Resetar Contadores</b></FONT><hr size=1 color=#cccccc>"
'########################################################
strTextoHtml = strTextoHtml & "<iframe name=status width=100% height=400 frameborder=0 scrolling=auto src=adm_zera.asp></iframe>"

'########################################################
case "vendas"
'########################################################
Set zera_vendas = conexao.Execute("UPDATE produtos SET vendas = 0;")
response.redirect "administrador.asp?link=produtos&acao=estoque&acaba=sim"

'########################################################
case "contador"
'########################################################
strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/conf_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Utilitários (Zerar Contador)</B></FONT><hr size=1 color=#cccccc>"
'########################################################
'--------------------------------------
Set Fso = Server.CreateObject("Scripting.FileSystemObject")
'--------------------------------------
Arquivo = Mid(Request.ServerVariables("PATH_TRANSLATED"),1,(Len(Request.ServerVariables("PATH_TRANSLATED"))-17) )
Arquivo = Arquivo &"contador.log"
Caminho = Fso.GetAbsolutePathName(Arquivo)
'--------------------------------------
	IF Fso.FileExists(Caminho) Then
		Fso.DeleteFile Arquivo,True
	END IF
'--------------------------------------
strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#000000 style=font-size:10px>&nbsp;<li>Contador zerado com sucesso!</li></font>"

'########################################################
case "banner"
response.redirect "banner/admin"
case "manut"
response.redirect "manutencao/index.asp"
end select

'End Sub
%>