<%
Response.Expires=-1000
%>

<html>
<head>
<title><%=Application("SOS_titulo")%></title>
<style type="text/css">
<!--
.texto{
font-family: Tahoma, Arial;
font-size: 11px;
color: #3E6497;
}
.formulario{
font-family: Tahoma, Arial;
font-size: 11px;
width: 200px;
border: 1px solid silver;
background-color: white;
}
-->
</style>
</head>
<body class="texto" bgcolor="#FFFFFF" leftmargin="0" topmargin="1" bottommargin="0" rightmargin="0">
&nbsp;&nbsp;&nbsp;Atendente<br>
<script language="JavaScript">parent.document.all.atendente.value="<%=Request.QueryString("atendente")%>"</script>
<%
If Request("departamento") <> "" Then

  Set Conexao = Server.CreateObject("ADODB.Connection")
  Conexao.Open Application("SOS_conexao")
  ComandoSQL = " SELECT * FROM atendentes Where id_departamento = " & Request("departamento")
  ComandoSQL = ComandoSQL & " AND Trim(atendente) <> '' AND status = 1 ORDER BY atendente ASC"

  Set objRS_atendentes = Server.CreateObject("ADODB.Recordset")
  objRS_atendentes.CursorLocation = 2
  objRS_atendentes.CursorType = 0
  objRS_atendentes.LockType = 1
  objRS_atendentes.Open ComandoSQL, Conexao,,, &H0001

  If Not objRS_atendentes.EOF Then

    Dim x, total, usuarios, atendentes

	Application.Lock()
%>
&nbsp;&nbsp; 
<select name="atendente" onChange="if(this.value!=''){window.open('exibe_atendentes.asp?departamento=<%=Request("departamento")%>&atendente='+this.value,'_self')}" class="formulario">
<option value="" selected>Escolha um dos atendentes</option>

<%

    While Not objRS_atendentes.EOF
      x = x + 1

      If Not IsEmpty(Application("SOS_usuario")) Then
        If IsArray(Application("SOS_usuario")) Then
          total = 0
          SOS_usuario = Application("SOS_usuario")
          SOS_atendente = Application("SOS_atendente") 
          n = UBound(SOS_usuario)
          For i = 0 To n
            If Int(SOS_atendente(i)) = Int(objRS_atendentes("id")) Then
              total = total + 1
            End If
          Next
          If total > 0  Then
            If total <  objRS_atendentes("total_usuarios")  Then
%>

<option style="color:navy" value="<%=objRS_atendentes("id")%>" <%If Int(Request("atendente")) = objRS_atendentes("id") Then Response.Write "selected"%>><%=objRS_atendentes("atendente")%> (<%=total%> usuários)</option>

<%
            Else
%>

<option style="color:red" value="" <%If Int(Request("atendente")) = objRS_atendentes("id") Then Response.Write "selected"%>><%=objRS_atendentes("atendente")%> (ocupado)</option>

<%
            End If
          Else
%>

<option style="color:blue" value="<%=objRS_atendentes("id")%>" <%If Int(Request("atendente")) = objRS_atendentes("id") Then Response.Write "selected"%>><%=objRS_atendentes("atendente")%> (Livre)</option>

<%
          End If
        End If
      End If
      objRS_atendentes.MoveNext
    Wend

	Application.UnLock()

    Set x = Nothing
    Set total = Nothing
    Set usuarios = Nothing
    Set atendentes = Nothing
  Else
    Response.Write "<font color=red>Nenhum atendente disponível neste departamento</font>"
  End IF

  objRS_atendentes.Close
  Conexao.Close

  Set Conexao = Nothing
  Set ComandoSQL = Nothing
  Set objRS_atendentes = Nothing
%>

</select>
<%
Else
%>
&nbsp;&nbsp; 
<select name="atendente" disabled class="formulario">
<option value="0" selected>Escolha um dos atendentes</option>
</select>

<%
End If
%>

</body>
</html>