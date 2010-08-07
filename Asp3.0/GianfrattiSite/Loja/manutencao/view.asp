<!-- #include file="includetop.asp" -->
<%

view = Request.QueryString("view")
action = Request.QueryString("action")

SELECT CASE action
	CASE "addview"
		AddView
	Case "insertview"
		InsertView
	CASE "editview"
		EditView
	CASE "updateview"
		UpdateView
	CASE "dropview"
		DropView
END SELECT

'//  Routine to update a view
Sub UpdateView
	'// Create ADODB command object
	Set objCommand = Server.CreateObject("ADODB.Command")
	
	'// Set active connection
	Set objCommand.ActiveConnection = db.objConn
	
	'// Set CommandType
	objCommand.CommandType = adCmdText
	'// Set CommandText	
	objCommand.CommandText = Request.Form("sql")
	
	
	'// Set Command of ADOX object
	'// Also turn on error trapping
	On Error Resume Next
	db.objADOX.Views(view).Command = objCommand
	
	'// Check for errors
	If Err.number <> 0 Then
		SQLError Err.number, Err.Description, Err.Source, HTMLSafe(Request.Form("sql"))
			
		IncludeBottom
		Response.End
	End If
	
	'// Resume errors
	On Error GoTo 0
	
	'// Set Name of the View (if not blank)
	If Not IsBlank(Request.Form("name")) Then
		db.objADOX.Tables(view).Name = Request.Form("name")
	End If
	
	'// Redirect to index (to refresh everything)
	Response.Redirect "index.asp"
End Sub

Sub InsertView
	'// Check if a view with this name doesn't already exist
	If ViewExists(Request.Form("name")) = True Then
		'Already exists, display error
		strError = "Esse nome já existe, Voltar" & _
		" and fill in another name."
		ErrorMessage "Duplicidade", strError
		
		'// Finish off page
		IncludeBottom
		
		JSGoBack(5)
		Exit Sub
	End If
	
	'// Check if every field has been filled in
	If IsBlank(Request.Form("name")) _
	Or IsBlank(Request.Form("sql")) _
	Then '// Display error
		strError = "O campo precisar ser configurado. Please go back" & _
		" complete a operação."
		ErrorMessage "Campo com ERRO", strError
		
		'// Finish off page
		IncludeBottom
		
		JSGoBack(5)
		Exit Sub
	End If	


	'// Create ADODB command object
	Set objCommand = Server.CreateObject("ADODB.Command")
	
	'// Set active connection
	Set objCommand.ActiveConnection = db.objConn
	
	'// Set CommandType
	objCommand.CommandType = adCmdText
	'// Set CommandText	
	objCommand.CommandText = Request.Form("sql")
	
	'// Add it to the database
	'// Also use error trapping
	On Error Resume Next
	db.objADOX.Views.Append Request.Form("name"), objCommand
	
	'// Check for errors
	If Err.number <> 0 Then
		SQLError Err.number, Err.Description, Err.Source, HTMLSafe(Request.Form("sql"))
			
		IncludeBottom
		Response.End
	End If
	
	'// Resume errors
	On Error GoTo 0
	
	'// Redirect to index (to refresh everything)
	Response.Redirect "index.asp"
End Sub

Sub DropView
	'// Drop the view
	db.Query("DROP VIEW " & view)
	
	'// Redirect to index, to refresh everything
	Response.Redirect("index.asp")
End Sub


'// Routine to display edit html form
Sub EditView 
	'// Check if this view really exists
	If ViewExists(view) = False Or IsNumeric(view) = True Then
		'Invalid View
		strError = "Nome inválido. " & _
		"Volte, caso o erro continue, contate o administrador."

		'Display error
		ErrorMessage "Nome Inválido", strError
	
		'Finish off ending tasks
		IncludeBottom
	
		'Redirect to index
		JSRedirect "index.asp", 5
	
		'End this page
		Response.End
	End If


	'// Set strQuery (for the records list)
	strQuery= db.objADOX.views(view).command.commandtext
	%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" dir="ltr">

	<head>
		<title>aspAccessEditor</title>
		
		<link rel="stylesheet" type="text/css" href="extern/style.css">
		<script src="extern/jscript.js" type="text/javascript"></script>
		
		<script type="text/javascript" language="javascript">
			<!--
			// Updates the title of the frameset if possible (ns4 does not allow this)
			changetitle('<%= view %> Ativo - EDITOR MDB');
			//-->
		</script>

    
	</head>


	<body bgcolor="#F3F3F3">
		<div id="large">Dados <i><%= view %></i> Ativo em: <i>Servidor</i></div>

		<form action="view.asp?action=updateview&view=<%= view %>" id="editview" name="editview" method="POST">
		<table border="0" id="memgroup" width="98%">
			<tr id="tdrow1" align="center">
				<td width="25%">		
				<b>Nome</b>
				</td>
				<td width="75%">
					<b>SQL Command</b>
				</td>
			</tr>
			<tr id="tdrow2" align="center">
				<td width="25%">		
				<input type="text" name="name" value="<%= view %>">
				</td>
				<td width="75%">
					<textarea cols="80" rows="10" name="sql" style="width:98%"><% = db.objADOX.Views(view).Command.CommandText %></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" id="tdrow2" align="center">
					<input id="button" type="submit" value="  Salvar  " style="vertical-align: middle" />				
				</td>
			</tr>
		</table>
		</form>
		<a href="view.asp?action=dropview&view=<% = view %>">Visualizar DROP</a>
		<br>
		<%
		'// Check if it's a SELECT query
		If UCase(Left(strQuery, 6)) = "SELECT" Then '// yes!
			Response.Write _
			"<a href=""record.asp?sql=" & strQuery & """" & _
			" target=""_blank"">Lista de registros</a>"
			'//DisplayList	'// You can remove the beginning '//
							'// if you want to display records on this
							'// page		
		End If
		%>
		<br /><br />
			
	</body>
	</html>
	<%
End Sub


'// Routine to display add html form
Sub AddView 
	%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" dir="ltr">

	<head>
		<title>EDIT MDB</title>
		
		<link rel="stylesheet" type="text/css" href="extern/style.css">
		<script src="extern/jscript.js" type="text/javascript"></script>
		
		<script type="text/javascript" language="javascript">
			<!--
			// Updates the title of the frameset if possible (ns4 does not allow this)
			changetitle('<%= view %> Ativo em Servidor - EDITOR MDB');
			//-->
		</script> 
	</head>


	<body bgcolor="#FFFFD9">
		<div id="large">Banco de dados ativo no <i>Servidor</i></div>

		<form action="view.asp?action=insertview" id="addview" name="addview" method="POST">
		<table border="0" id="memgroup" width="98%">
			<tr id="tdrow1" align="center">
				<td width="25%">		
				<b>Name</b>
				</td>
				<td width="75%">
					<b>SQL Command</b>
				</td>
			</tr>
			<tr id="tdrow2" align="center">
				<td width="25%">		
				<input type="text" name="name">
				</td>
				<td width="75%">
					<textarea cols="80" rows="10" name="sql" style="width:98%"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" id="tdrow2" align="center">
					<input id="button" type="submit" value="  Add View  " style="vertical-align: middle" />				
				</td>
			</tr>
		</table>
		</form>

	</body>
	</html>
	<%
End Sub
Sub DisplayList
	If UCase(Left(strQuery, 6)) <> "SELECT" Then
		Exit Sub
	End If
	db.Query(strQuery)
	For Each field in db.objRS.Fields
		fieldloop = fieldloop & Replace(field.Name, ",", ":comma:") & ","
	Next
	
	'- Cut off final comma
	fieldloop = Left(fieldloop, Len(fieldloop)-1)
	
	'- Add all to array again
	field = Split(fieldloop, ",")
	intCurrentPage = Request.QueryString("page")
	
	If IsBlank(intCurrentPage) = True or IsNumeric(intCurrentPage) = False Or intCurrentPage < 1 Then
		intCurrentPage = 1
	End If
	
	'- Arrange page size
	intPageSize = Request.QueryString("recordsperpage")

	If IsBlank(intPageSize) Or IsNumeric(intPageSize) = False Then
		intPageSize = 30
	End If

	If db.objRS.EOF = False Then
		'- Tell RecordSet to use these values
		db.objRS.PageSize = intPageSize

		db.objRS.AbsolutePage = intCurrentPage

		'- Retrieve total pages count
		intTotalPages = db.objRS.PageCount
	
		'- Retrieve recordcount
		intRecordCount = db.objRS.RecordCount
	
		'- Retrieve records and put them in an array
		records = db.objRS.GetRows
	End If
	db.QueryClose

	%>
	<div id="large"><i>Lista de registro</i></div>
	<br>
	
	
	<%
	If intRecordCount < 1 Then
		'No records
		Exit Sub	
	End If
	%>
	<!-- Results table -->
	<table border="0" cellpadding="5" id="memgroup" width="100%">
        
	<!-- Results table headers -->
	<tr>
		<%
		For Each fieldloop In field
			%>
		    <th id="tdrow1">
			<%= fieldloop %>
		    </th>
			<%
		Next
		%>                   
	</tr>
	
	<!-- Results table body -->
	<%
	If UBound(records, 2) <= intPageSize Then
		recordloop = UBound(records, 2)
	Else
		recordloop = intPageSize
	End If
		
	For record = 0 To recordloop
		%>
		<tr>
		<%
		i = 0
		For Each fieldloop In field
			Response.Write "<td align=""left"" valign=""top"" id=""tdrow2"">"
			
			Response.Write HTMLSafe(Left(records(i, record), 350))
			
									
			Response.Write "</td>"
			i = i + 1
		Next
		%>
		</tr>
		<%
	Next
	%>
	</table>
	<br />

	<!-- Paging Code -->
	<%
	strPagingLink = "view.asp?table=" & Table

	If db.Paging("previous", 2, intCurrentPage, intTotalPages) = True Then
		Response.Write "<a href=""" & strPagingLink & "&page=1"" title=""Primeira pagina"">« Primeira</a>&nbsp;"
		
		Response.Write "<a href=""" & strPagingLink & "&page=" & intCurrentPage - 1 & """ title=""Anterior"">«</a>&nbsp;"

		Response.Write "<a href=""" & strPagingLink & "&page=" & intCurrentPage - 2 & """>" & intCurrentPage - 2  & "</a>&nbsp;"

		Response.Write "<a href=""" & strPagingLink & "&page=" & intCurrentPage - 1 & """>" & intCurrentPage - 1  & "</a>&nbsp;"
	ElseIf db.Paging("previous", 1, intCurrentPage, intTotalPages) = True Then
		Response.Write "<a href=""" & strPagingLink & "&page=" & intCurrentPage - 1 & """ title=""PAnterior"">«</a>&nbsp;"

		Response.Write "<a href=""" & strPagingLink & "&page=" & intCurrentPage - 1 & """>" & intCurrentPage - 1 & "</a>&nbsp;"
	End If

	If db.Paging("previous", 1, intCurrentPage, intTotalPages) = True _
	Or db.Paging("next", 1, intCurrentPage, intTotalPages) = True Then
		Response.Write "<b>[" & intCurrentPage & "]&nbsp;</b>"
	End If


	If db.Paging("next", 2, intCurrentPage, intTotalPages) = True Then
		Response.Write "<a href=""" & strPagingLink & "&page=" & intCurrentPage + 1 & """>" & intCurrentPage + 1 & "</a>&nbsp;"

		Response.Write "<a href=""" & strPagingLink & "&page=" & intCurrentPage + 2 & """>" & intCurrentPage + 2 & "</a>&nbsp;"

		Response.Write "<a href=""" & strPagingLink & "&page=" & intCurrentPage + 1 & """ title=""Próxima"">»</a>&nbsp;"

		Response.Write "<a href=""" & strPagingLink & "&page=" & intTotalPages & """ title=""Ultima"">Last »</a>&nbsp;"

	ElseIf db.Paging("next", 1, intCurrentPage, intTotalPages) = True Then
	Response.Write "<a href=""" & strPagingLink & "&page=" & intCurrentPage + 1 & """>" & intCurrentPage + 1 & "</a>&nbsp;"

	Response.Write "<a href=""" & strPagingLink & "&page=" & intCurrentPage + 1 & """ title=""Próxima"">»</a>&nbsp;"
	End If
End Sub
IncludeBottom
%>