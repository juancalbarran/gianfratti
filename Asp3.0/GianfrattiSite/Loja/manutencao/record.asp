<!-- #include file="includetop.asp" -->
<%

strQuery = Request.QueryString("sql")

If IsBlank(strQuery) = True Or IsNumeric(strQuery) = True Then
	'Invalid SQL
	strError = "Erro na instrução SQL. " & _
	"Voltar. caso o erro continue, contate o administrador."

	'Display error
	ErrorMessage "SQL inválido", strError
	
	
	IncludeBottom
	
	
	JSRedirect "index.asp", 5
	
	
	Response.End
End If

action = Request.QueryString("action")

SELECT CASE action
	CASE "addrecord"
		AddRecord
	CASE "insertrecord"
		InsertRecord
	CASE "editrecord"
		EditRecord
	CASE "updaterecord"
		UpdateRecord
	CASE "deleterecord"
		DeleteRecord
	CASE Else
		DisplayList
END SELECT


Sub DisplayList

	If UCase(Left(strQuery, 6)) <> "SELECT" Then
		SQLError 1, "SELECT inválido. Atenção nas queries permitidas nesta pagina.", name, strQuery
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
	

	intPageSize = Request.QueryString("recordsperpage")

	If IsBlank(intPageSize) Or IsNumeric(intPageSize) = False Then
		intPageSize = 30
	End If

	If db.objRS.EOF = False Then

		db.objRS.PageSize = intPageSize

		db.objRS.AbsolutePage = intCurrentPage


		intTotalPages = db.objRS.PageCount
	

		intRecordCount = db.objRS.RecordCount
	

		records = db.objRS.GetRows
	End If
	db.QueryClose

	%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" dir="ltr">

	<head>
		<title><%= name %></title>
		
		<link rel="stylesheet" type="text/css" href="extern/style.css">
		<script src="extern/jscript.js" type="text/javascript"></script>
		
		<script type="text/javascript" language="javascript">
			<!--
			// Updates the title of the frameset if possible (ns4 does not allow this)
			changetitle('SQL record list Ativo em <%= Request.ServerVariables("SERVER_NAME") %> - <%= name & " " & version %>');
			//-->
		</script>

    
	</head>


	<body bgcolor="#F3F3F3">
	<div id="large"><i>SQL record list</i> ativo em <i><%= Request.ServerVariables("SERVER_NAME") %></i></div>
	<br>
	
	<div align="left">
    <table border="0" cellpadding="5" id="memgroup" width="100%">
    <tr>
        <td id="tdrow1">
            <b>Showing rows (<%= intRecordCount %> total)</b><br />
        </td>
    </tr>
    
    <tr>
        <td id="tdrow2">
            
            SQL-query&nbsp;:&nbsp;<a href="table.asp?table=<%= GetTableFromSQL(strQuery) %>&sql=<%= strQuery %>#sql">Editar</a><br />
            <%= strQuery %>
        </td>
    </tr>
           
    </table>
	</div><br />
	
	<%
	
	If intRecordCount < 1 Then
		'No records
		Exit Sub	
	End If
	%>
	<!-- Resultados da tabela -->
	<table border="0" cellpadding="5" id="memgroup" width="100%">
        
	<!-- Results table headers -->
	<tr>
		<td id="tdrow1"></td>
		<td id="tdrow1"></td>
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
			<td id="tdrow2">
				<a href="javascript:document.editrecord_<%= record %>.submit();">Editar</a>
		        <form name="editrecord_<%= record %>" method="post" action="record.asp?action=editrecord&table=<%= GetTableFromSQL(strQuery) %>&sql=bypassfilter">
		        <%
		        i = 0
		        For Each fieldloop in field
					Response.Write "<input type=""hidden"" name=""" & fieldloop & """ value=""" & HTMLSafe(records(i, record)) & """>" & vbCrlf
					i = i + 1
		        Next
		        %>	
		        </form>
		    </td>
              
			<td id="tdrow2">
				<a href="javascript:document.deleterecord_<%= record %>.submit();">Deletar</a>
		        <form name="deleterecord_<%= record %>" method="post" action="record.asp?action=deleterecord&table=<%= GetTableFromSQL(strQuery) %>&sql=bypassfilter">
				<%
		        i = 0
		        For Each fieldloop in field
					Response.Write "<input type=""hidden"" name=""" & fieldloop & """ value=""" & HTMLSafe(records(i, record)) & """>" & vbCrlf
					i = i + 1
		        Next
		        %>		        
		        </form>
			</td>
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
	strPagingLink = "record.asp?sql=" & strQuery

	If db.Paging("previous", 2, intCurrentPage, intTotalPages) = True Then
		Response.Write "<a href=""" & strPagingLink & "&page=1"" title=""Primeira página"">« Início</a>&nbsp;"
		
		Response.Write "<a href=""" & strPagingLink & "&page=" & intCurrentPage - 1 & """ title=""Anterior"">«</a>&nbsp;"

		Response.Write "<a href=""" & strPagingLink & "&page=" & intCurrentPage - 2 & """>" & intCurrentPage - 2  & "</a>&nbsp;"

		Response.Write "<a href=""" & strPagingLink & "&page=" & intCurrentPage - 1 & """>" & intCurrentPage - 1  & "</a>&nbsp;"
	ElseIf db.Paging("previous", 1, intCurrentPage, intTotalPages) = True Then
		Response.Write "<a href=""" & strPagingLink & "&page=" & intCurrentPage - 1 & """ title=""Anterior"">«</a>&nbsp;"

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

		Response.Write "<a href=""" & strPagingLink & "&page=" & intTotalPages & """ title=""Ultima pagina"">Final »</a>&nbsp;"

	ElseIf db.Paging("next", 1, intCurrentPage, intTotalPages) = True Then
	Response.Write "<a href=""" & strPagingLink & "&page=" & intCurrentPage + 1 & """>" & intCurrentPage + 1 & "</a>&nbsp;"

	Response.Write "<a href=""" & strPagingLink & "&page=" & intCurrentPage + 1 & """ title=""Próxima pagina"">»</a>&nbsp;"
	End If
	%>
  
	<!-- Insert a new row -->
	<p>
		<a href="record.asp?action=addrecord&sql=bypassfilter&table=<%= GetTableFromSQL(strQuery) %>">
			Insert New Row
		</a>
	</p>
	

	</body>

	</html>
	<%
End Sub

Sub AddRecord
	
	table = Request.QueryString("table")
	
	
	If Right(table, 1) = ";" Then table = Replace(table, ";", Empty)
	
	If TableExists(table) = False Or IsNumeric(table) = True Then
		
		strError = "Tabela inválida. " & _
		"Voltar. Se o erro persistir, contate o administrador."

		'Display error
		ErrorMessage "Tabela Inválida", strError
	
		'Redirect to index
		JSRedirect "index.asp", 5
	
		'End this procedure
		Exit Sub
	End If
	
	If db.objADOX.Tables(table).Columns.Count < 1 Then
		'No fields
		strError = "Tabela não contém campos, não é possível adicionar registro. " & _
		"Volte e adicione um campo."


		ErrorMessage "No fields", strError
	

		JSRedirect "table.asp?table=" & table, 5
	

		Exit Sub
	End If
	%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" dir="ltr">

	<head>
		<title><%= name %></title>
		
		<link rel="stylesheet" type="text/css" href="extern/style.css">
		<script src="extern/jscript.js" type="text/javascript"></script>
		
		<script type="text/javascript" language="javascript">
			<!--
			// Updates the title of the frameset if possible (ns4 does not allow this)
			changetitle('<%= db.objADOX.Tables(table).Name %> running on <%= Request.ServerVariables("SERVER_NAME") %> - <%= name & " " & version %>');
			//-->
		</script>

    
	</head>


	<body bgcolor="#FFFFD9">
	<div id="large">table <i><%= db.objADOX.Tables(table).Name %></i> Ativo em: <i><%= Request.ServerVariables("SERVER_NAME") %></i></div>
	
	<!-- Add record field properties form -->
	<form method="post" action="record.asp?action=insertrecord&table=<%= table %>&sql=bypassfilter" name="insertrecord">
		<table border="0" id="memgroup" width="100%">
			<tr id="tdrow1">
				<th>Campo</th>
				<th>Tipo</th>
				<th>Vazio</th>
				<th>Valor</th>
			</tr>
	<%
	For Each field In db.objADOX.Tables(table).Columns
	%>
		<tr>
			<td align="center" id="tdrow2"><%= field.Name %></td>
    
			<td align="center" id="tdrow2" nowrap="nowrap">
				<%

				Response.Write column.ColumnName(field.Type)
				%>
			</td>
			<td align="center" id="tdrow2">
				<%
				If field.Properties("Jet OLEDB:Allow Zero Length") = True Then
					Response.Write "Permitido"
				Else
					Response.Write "&nbsp;"
				End If
				%>
			</td>
			<td align="center" id="tdrow2">
				<%
				If field.Properties("AutoIncrement") = True Then
					Response.Write "[autoincrement]"
				Else
					SELECT CASE column.ColumnType(field.Type)
						CASE "textinput"
							%><input id="textinput" type="text" name="<%= field.Name %>" size="15" tabindex="1" /><%
						CASE "textarea"
							%><textarea tabindex="1" id="multitext" cols="30" rows="7" name="<%= field.Name %>"></textarea><%
						CASE "yesno"
							Response.Write "<input tabindex=""1"" type=""radio"" name=""" & field.Name & """ value=""True"">True" & vbCrlf
							Response.Write "<input tabindex=""1"" type=""radio"" name=""" & field.Name & """ value=""False"">False" & vbCrlf
						CASE Else
							Response.Write "[" & column.ColumnName(field.Type) & "]"
					END	SELECT
				End If
				%>
			</td>
        
		</tr>
		<%	
	Next
	%>
			<tr>
				<td colspan="4" align="center" valign="middle">
					<input id="button" type="submit" value="Go" tabindex="29" />
				</td>
			</tr>
		</table>
	</form>
	
	</body>

	</html>
	<%
End Sub

Sub InsertRecord
	table = Request.QueryString("table")
	
	If Right(table, 1) = ";" Then table = Replace(table, ";", Empty)
	
	If TableExists(table) = False Or IsNumeric(table) = True Then

		strError = "Tabela Inválida. " & _
		"Volte, caso o erro continue, contate o administrador."

		'Display error
		ErrorMessage "Tabela Inválida", strError
	

		JSRedirect "index.asp", 5

		Exit Sub
	End If
	
	If db.objADOX.Tables(table).Columns.Count < 1 Then
		'No fields
		strError = "Essa tabela não contém campos, você não pode adicionar registros. " & _
		"Volte e crie um campo."

		'Display error
		ErrorMessage "Sem campos definidos", strError
	

		JSRedirect "table.asp?table=" & table, 5
	

		Exit Sub
	End If
	
	strQuery = "INSERT INTO [" & table & "]"
	
	first = True
	For Each field in db.objADOX.Tables(table).Columns
		If field.Properties("Jet OLEDB:Allow Zero Length") = False _
		And IsBlank(Request.Form(field.Name)) = True _
		And field.Properties("AutoIncrement") = False _
		Then
			'Empty field
			strError = "Verifique se nos campos o valor NULL foi definido. " & _
			"Tente novamente."


			ErrorMessage "Empty field(s)", strError
	

			JSGoBack(5)
	
			Exit Sub
		End If
		If field.Properties("AutoIncrement") = False _
		And column.ColumnQuotes(field.Type) <> "no" Then
			If first = True Then
				strQuery = strQuery & " ("
				first = False
			Else
				strQuery = strQuery & ", "
			End If
		
			strQuery = strQuery & "[" & field.Name & "]"
		End If
	Next
	strQuery = strQuery & ") VALUES "
	
	first = True
	For Each field in db.objADOX.Tables(table).Columns

		If field.Properties("AutoIncrement") = False _
		And column.ColumnQuotes(field.Type) <> "no" Then
			If first = True Then
				strQuery = strQuery & " ("
			Else
				strQuery = strQuery & ", "
			End If
		
			SELECT CASE column.ColumnQuotes(field.Type)
				CASE ""
					strQuery = strQuery & ReplaceQuery(Request.Form(field.Name))
				CASE "quotes"
					strQuery = strQuery & "'" & ReplaceQuery(Request.Form(field.Name)) & "'"
				CASE "date"
					strQuery = strQuery & "#" & ReplaceQuery(Request.Form(field.Name)) & "#"
				CASE Else
					'// Invalid field, delete ( or ,
					If first = True Then
						strQuery = Left(strQuery, Len(strQuery) - Len(" ("))
					Else
						strQuery = Left(strQuery, Len(strQuery) - Len(", "))
					End If
			END	SELECT
			
			first = False
		End If
	Next
	
	strQuery = strQuery & ")"
			
	db.Query(strQuery)
	
	Response.Redirect "record.asp?sql=SELECT * FROM [" & table & "]"
End Sub
Sub EditRecord
	'****************************************************
	'* Check if a valid table name has been passed		*
	'****************************************************
	table = Request.QueryString("table")
	
	If Right(table, 1) = ";" Then table = Replace(table, ";", Empty)
	
	If TableExists(table) = False Or IsNumeric(table) = True Then
		'Invalid Table
		strError = "Tabela Inválida. " & _
		"Volte, caso o erro continue, contate o administrador."


		ErrorMessage "Invalid Table", strError
	

		JSRedirect "index.asp", 5
	

		Exit Sub
	End If
	
	strQuery = "SELECT * FROM [" & table & "]"
	
	For Each index In db.objADOX.Tables(table).Indexes
		If index.PrimaryKey = True Then
			strQuery = strQuery & " WHERE [" & _
			index.Columns(0) & "] = "
				

			SELECT CASE column.ColumnQuotes(db.objADOX.Tables(table).Columns(CStr(index.Columns(0))).Type)
				CASE ""
					strQuery = strQuery & ReplaceQuery(Request.Form(CStr(index.Columns(0))))
					valid = True
				CASE "quotes"
					strQuery = strQuery & "'" & ReplaceQuery(Request.Form(CStr(index.Columns(0)))) & "'"
					valid = True
				CASE Else

					strQuery = "SELECT * FROM [" & table & "]"
			END SELECT
		End If
	Next
		

	If valid = False Then 
		first = True
		For Each field in db.objADOX.Tables(table).Columns
			If IsBlank(Request.Form(field)) = False Then

				If InStr(1, LCase(strQuery), "where") > 0 Then
					strQuery = strQuery & " AND "
				Else
					strQuery = strQuery & " WHERE "	
				End If
					

				SELECT CASE column.ColumnQuotes(field.Type)
					CASE ""
						strQuery = strQuery & "[" & field.Name & "] = " & ReplaceQuery(Request.Form(field.Name))
					CASE "quotes"
						strQuery = strQuery & "[" & field.Name & "] = " & "'" & ReplaceQuery(Request.Form(field.Name)) & "'"
					CASE Else

						If InStr(1, LCase(strQuery), "where") > 0 Then
							strQuery = Left(strQuery, Len(strQuery) - Len(" AND "))
						Else
							strQuery = Left(strQuery, Len(strQuery) - Len(" WHERE "))
						End If
				END	SELECT
			End If
		Next
	End If
	
	db.Query(strQuery)
			
	If db.objRS.EOF = True Then
		'Invalid record, display error
		strError = "Registro Inválido " & _
		"Volte, caso o erro continue, contate o administrador."

		
		ErrorMessage "Registro Inválido", strError
	
		JSRedirect "record.asp?sql=SELECT * FROM [" & table & "]", 5
	
		Exit Sub
	End If
	
	%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" dir="ltr">

	<head>
		<title><%= name %></title>
		
		<link rel="stylesheet" type="text/css" href="extern/style.css">
		<script src="extern/jscript.js" type="text/javascript"></script>
		
		<script type="text/javascript" language="javascript">
			<!--
			
			changetitle('<%= db.objADOX.Tables(table).Name %> Ativo em: <%= Request.ServerVariables("SERVER_NAME") %> - <%= name & " " & version %>');
			//-->
		</script>

    
	</head>


	<body bgcolor="#FFFFD9">
	<div id="large">table <i><%= db.objADOX.Tables(table).Name %></i> Ativo em: <i><%= Request.ServerVariables("SERVER_NAME") %></i></div>
	
	
	<!-- Edit record field properties form -->
	<form method="post" action="record.asp?action=updaterecord&table=<%= table %>&sql=bypassfilter" name="updaterecord">
	<input type="hidden" name="where" value="<%= HTMLSafe(Replace(strQuery, "SELECT * FROM [" & table & "] ", "")) %>">
		<table border="0" id="memgroup" width="100%">
			<tr id="tdrow1">
				<th>Campo</th>
				<th>Tipo</th>
				<th>Nulo</th>
				<th>Valor</th>
			</tr>
	<%

	For Each field In db.objADOX.Tables(table).Columns
	%>
		<tr>
			<td align="center" id="tdrow2"><%= field.Name %></td>
    
			<td align="center" id="tdrow2" nowrap="nowrap">
				<%

				Response.Write column.ColumnName(field.Type)
				%>
			</td>
			<td align="center" id="tdrow2">
				<%
				If field.Properties("Jet OLEDB:Allow Zero Length") = True Then
					Response.Write "Permitido"
				Else
					Response.Write "&nbsp;"
				End If
				%>
			</td>
			<td align="center" id="tdrow2">
				<%

				If field.Properties("AutoIncrement") = True Then
					Response.Write "[autoincrement]"
				Else
					SELECT CASE column.ColumnType(field.Type)
						CASE "textinput"
							%><input value="<%= db.objRS(field.Name) %>" id="textinput" type="text" name="<%= field.Name %>" size="15" tabindex="1" /><%
						CASE "textarea"
							%><textarea tabindex="1" id="multitext" cols="30" rows="7" name="<%= field.Name %>"><%= db.objRS(field.Name) %></textarea><%
						CASE "yesno"
							Response.Write "<input tabindex=""1"" type=""radio"" name=""" & field.Name & """ value=""True""" & CheckedData(db.objRS(field.Name), "True") & ">True" & vbCrlf
							Response.Write "<input tabindex=""1"" type=""radio"" name=""" & field.Name & """ value=""False""" & CheckedData(db.objRS(field.Name), "False") & ">False" & vbCrlf
						CASE Else
							Response.Write "[" & field.Type & "]"
					END	SELECT
				End If
				%>
			</td>
        
		</tr>
		<%
	Next

	db.QueryClose
	%>
			<tr>
				<td colspan="4" align="center" valign="middle">
					<input id="button" type="submit" value="Go" tabindex="29" />
				</td>
			</tr>
		</table>
	</form>
	
	</body>

	</html>
	<%
End Sub

Sub UpdateRecord
	table = Request.QueryString("table")
	

	If Right(table, 1) = ";" Then table = Replace(table, ";", Empty)
	
	If TableExists(table) = False Or IsNumeric(table) = True Then
		'Invalid Table
		strError = "Tabela Inválida, " & _
		"Volte, caso o erro continue, contate o administrador."

		'Display error
		ErrorMessage "Tabela Inválida", strError
	

		JSRedirect "index.asp", 5
	

		Exit Sub
	End If
	
	strQuery = "UPDATE [" & table & "]"
	
	first = True
	For Each field in db.objADOX.Tables(table).Columns
		'// Check if the non-NULL fields haven been entered		
		If field.Properties("Jet OLEDB:Allow Zero Length") = False _
		And IsBlank(Request.Form(field.Name)) = True _
		And field.Properties("AutoIncrement") = False _
		Then
			'Empty field
			strError = "Verifique, se os campos permitem valor NULL " & _
			"Voltar."


			ErrorMessage "Empty field(s)", strError

			JSGoBack(5)
			Exit Sub
		End If
	
		If field.Properties("AutoIncrement") = False _
		And column.ColumnQuotes(field.Type) <> "no" Then
			'// Check if this is the first field
			If first = True Then
				strQuery = strQuery & " SET "
				first = False
			Else
				strQuery = strQuery & ", "
			End If
		
			'// Add field value to SQL query
			SELECT CASE column.ColumnQuotes(field.Type)
				CASE ""
					strQuery = strQuery & "[" & field.Name & "] = " & ReplaceQuery(Request.Form(field.Name))
				CASE "quotes"
					strQuery = strQuery & "[" & field.Name & "] = " & "'" & ReplaceQuery(Request.Form(field.Name)) & "'"
				CASE "date"
					strQuery = strQuery & "[" & field.Name & "] = " & "#" & ReplaceQuery(Request.Form(field.Name)) & "#"
				CASE Else
					'// Remove SET or ,					
					If first = True Then
						strQuery = Left(strQuery, Len(strQuery) - Len(" SET "))
					Else
						strQuery = Left(strQuery, Len(strQuery) - Len(", "))
					End If
			END	SELECT
		End If	
	Next
	
	
	whereclause = Request.Form("where")
	
	If IsBlank(whereclause) = True _
	Or Len(whereclause) < 5 Then
		'Invalid Where Clause
		strError = "Cláusula Inválida. " & _
		"Volte, caso o erro continue, contate o administrador."


		ErrorMessage "Invalid Where Clause", strError
	

		JSGoBack 5
	

		Exit Sub
	End If

	strQuery = strQuery & " " & whereclause

	db.Query(strQuery)

	Response.Redirect "record.asp?sql=SELECT * FROM [" & table & "]"
End Sub

Sub DeleteRecord

	table = Request.QueryString("table")
	

	If Right(table, 1) = ";" Then table = Replace(table, ";", Empty)
	
	If TableExists(table) = False Or IsNumeric(table) = True Then
		'Invalid Table
		strError = "Tabela Inválida. " & _
		"Volte, caso o erro continue, contate o administrador."

		'Display error
		ErrorMessage "Tabela Inválida", strError
	

		JSRedirect "index.asp", 5
	

		Exit Sub
	End If
	
	strQuery = "DELETE FROM [" & table & "]"
	
	For Each index In db.objADOX.Tables(table).Indexes
		If index.PrimaryKey = True Then
			strQuery = strQuery & " WHERE [" & _
			index.Columns(0) & "] = "
				

			SELECT CASE column.ColumnQuotes(db.objADOX.Tables(table).Columns(CStr(index.Columns(0))).Type)
				CASE ""
					strQuery = strQuery & ReplaceQuery(Request.Form(CStr(index.Columns(0))))
					valid = True
				CASE "quotes"
					strQuery = strQuery & "'" & ReplaceQuery(Request.Form(CStr(index.Columns(0)))) & "'"
					valid = True
				CASE Else
					'// Delete where bit again
					strQuery = "SELECT * FROM [" & table & "]"
			END SELECT
		End If
	Next
		
	'// Check if there is already a whereclause
	If valid = False Then '// Build alternate WHERE clause
		first = True
		For Each field in db.objADOX.Tables(table).Columns
			If IsBlank(Request.Form(field)) = False Then
				'// Check if this is the first field
				If InStr(1, LCase(strQuery), "where") > 0 Then
					strQuery = strQuery & " AND "
				Else
					strQuery = strQuery & " WHERE "	
				End If
					
				'// Add field value to SQL query			
				SELECT CASE column.ColumnQuotes(field.Type)
					CASE ""
						strQuery = strQuery & "[" & field.Name & "] = " & ReplaceQuery(Request.Form(field.Name))
					CASE "quotes"
						strQuery = strQuery & "[" & field.Name & "] = " & "'" & ReplaceQuery(Request.Form(field.Name)) & "'"
					CASE Else
						'// Invalid field, delete WHERE or AND
						If InStr(1, LCase(strQuery), "where") > 0 Then
							strQuery = Left(strQuery, Len(strQuery) - Len(" AND "))
						Else
							strQuery = Left(strQuery, Len(strQuery) - Len(" WHERE "))
						End If
				END	SELECT
			End If
		Next
	End If
	
	db.Query(strQuery)
	
	Response.Redirect "record.asp?sql=SELECT * FROM [" & table & "]"
End Sub


IncludeBottom
%>
