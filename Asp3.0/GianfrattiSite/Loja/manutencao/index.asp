<!-- #include file="includetop.asp" -->
<%
action = Request.QueryString("action")

SELECT CASE action
	CASE "main"
		DisplayMain
	CASE "left"
		DisplayLeft
	CASE "deletedb"
		DeleteFile(Session("dbPath"))
		Response.Redirect "loaddb.asp"
	CASE "loaddb"
		Response.Redirect ("loaddb.asp")
	CASE "createtable"
		CreateTable
	CASE "compactdb"
		CompactDatabase
	CASE Else
		DisplayIndex
END SELECT


'****************************************************
'* This procedure is used for the frame of the index*
'****************************************************
Sub DisplayIndex
	%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN"
		"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" dir="ltr">
	<head>
		<title><%= name %></title>
		
		<link rel="stylesheet" type="text/css" href="extern/style.css">
		<script src="extern/jscript.js" type="text/javascript"></script>
		<script language= "JavaScript">
			<!--Break out of frames
			if (top.frames.length!=0)
			top.location=self.document.location;
			//-->
		</script>
	</head>

	<frameset cols="150,*" rows="*">
		<frame src="index.asp?action=left" name="leftside" frameborder="1" />
		<frame src="index.asp?action=main" name="main" />

		<noframes>
			<body bgcolor="#FFFFFF">
				<p><%= name %> is more friendly with a <b>frames-capable</b> browser.</p>
			</body>
		</noframes>
	</frameset>

	</html>
	<%
End Sub

'****************************************************
'* This procedure is used for the left-frame		*
'****************************************************
Sub DisplayLeft
	%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" dir="ltr">

	<head>
		<title><%= name %></title>
		<base target="main" />

		<link rel="stylesheet" type="text/css" href="extern/style.css">
		<script src="extern/jscript.js" type="text/javascript"></script>
    
	</head>

	<body bgcolor="#F3F3F3">
		<!-- Link to main page -->
		<div id="subtitle" style="margin-bottom: 5px">
	        <nobr><a class="item" href="index.asp?action=main">
				<b>Home</b></a></nobr>
		</div>
	
	
	    <!-- Databases and tables list -->
	    <br><div id="large">Tabelas:</div>
	    <hr noshade="noshade" />
	
		<%
		'****************************************************
		'* Get all the tables from the database			*
		'****************************************************
		For Each table in db.objADOX.Tables
			If table.Type = "TABLE" Then
			%>
			<nobr><a target="main" href="table.asp?table=<%= table.Name %>">
				<img src="pictures/browse.gif" width="8" height="8" border="0" alt="Browse: <%= table.Name %>" title="Browse: <%= table.Name %>" /></a><bdo dir="ltr">&nbsp;</bdo>
			<a target="main" href="table.asp?table=<%= table.Name %>"><%= table.Name %></a></span></nobr><br />
			<%
			End If
		Next
		
		%>
		<hr noshade="noshade" /><br>
		
		 <!-- Views list -->
	    <br><div id="large">Nomes:</div>
	    <hr noshade="noshade" />
	
		<%
		'****************************************************
		'* Get all the tables from the database			*
		'****************************************************
		For Each view in db.objADOX.Views
			%>
			<nobr><a target="main" href="view.asp?view=<%= view.Name %>&action=editview">
				<img src="pictures/browse.gif" width="8" height="8" border="0" alt="Browse: <%= view.Name %>" title="Browse: <%= view.Name %>" /></a><bdo dir="ltr">&nbsp;</bdo>
			<a target="main" href="view.asp?view=<%= view.Name %>&action=editview"><%= view.Name %></a></span></nobr><br />
			<%
		Next
		
		%>
	     
			<hr noshade="noshade" />
			<b><%= name & " " & version %></b><br>
		</body>
	</html>
	<%
End Sub

'****************************************************
'* Procedure used to display the main frame			*
'****************************************************
Sub DisplayMain
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
			changetitle('<%= name %> Ativo em: <%= Request.ServerVariables("SERVER_NAME") %> - <%= name & " " & version %>');
			//-->
		</script>

	</head>


	<body bgcolor="#FFFFD9">


	<div id="large">Bem vindo <%= name & " " & version %></div>
	<br>

	<!-- Access -->
	<table>
		<tr>

			<!-- Access related links -->
			<td valign="top" align="left">
		        <table>
			        <tr>
			            <th id="tdrow1" colspan="2">&nbsp;&nbsp;Microsoft Access</th>
					</tr>
        
					<!-- access links -->
					<tr>
						<td valign="baseline"><img src="pictures/item.gif" width="7" height="7" alt="item" /></td>
						<td>
							<a href="createdb.asp">
							Criar um novo banco de dados</a>&nbsp;                
						</td>
					</tr>
					<tr>
						<td valign="baseline"><img src="pictures/item.gif" width="7" height="7" alt="item" /></td>
						<td>
							<a href="view.asp?action=addview">
							Criar um novo campo</a>&nbsp;                
						</td>
					</tr>
					<tr>
						<td valign="baseline"><img src="pictures/item.gif" width="7" height="7" alt="item" /></td>
						<td>
							<a href="index.asp?action=compactdb">
							Compactar base de dados</a>&nbsp;                
						</td>
					</tr>
					<tr>
						<td valign="baseline"><img src="pictures/item.gif" width="7" height="7" alt="item" /></td>
						<td>
							<a href="index.asp?action=loaddb">
							Abrir banco de dados</a>&nbsp;                
						</td>
					</tr>
					<tr>
						<td valign="baseline"><img src="pictures/item.gif" width="7" height="7" alt="item" /></td>
						<td>
							<a href="javascript:ConfirmLink('index.asp?action=deletedb', 'Você deseja deletar?')">
							Deletar base de dados</a>&nbsp;                
						</td>
					</tr>
					<tr>
						<td valign="baseline"><img src="pictures/item.gif" width="7" height="7" alt="item" /></td>
						<td>Tamanho do MDB: 
						<%
						'// Create fso object
						Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
						
						'// Get file
						Set objFile = objFSO.GetFile(Session("dbPath"))
						
						'// Get size
						Response.Write objFile.Size/1024				
						
						'// Destroy file
						Set objFile = Nothing
						%> KB
						</td>
					</tr>
					<tr>
						<td valign="baseline"><img src="pictures/item.gif" width="7" height="7" alt="item" /></td>
						<td>Versão do banco de dados: 
						<%
						'// Get file
						Set objFile = objFSO.OpenTextFile(Session("dbPath"), 1)
						
						'// Get contents of file
						temp = objFile.ReadAll
						
						'// Close and destroy file
						objFile.Close
						Set objFile = Nothing
						'// Destroy fso object
						Set objFSO = Nothing
											
						If InStr(1, temp, "0") <> 0 _
						And InStr(1, temp, "7") <> 0 _
						And InStr(1, temp, ".") <> 0 _
						And InStr(1, temp, "5") <> 0 _
						And InStr(1, temp, "3") <> 0 _
						Then
							'// Access 97 (build 07.53)
							Response.Write "Access 97"
						ElseIf InStr(1, temp, "0") <> 0 _
						And InStr(1, temp, "7") <> 0 _
						And InStr(1, temp, ".") <> 0 _
						And InStr(1, temp, "5") <> 0 _
						Then
							'// Access 2000 (build 07.5)
							Response.Write "Access 2000"
						Else
							'// Unknown version
							Response.Write "Versão não reconhecida"
						End If	
						%>
						</td>
					</tr>
					<tr>
						<td valign="baseline"><img src="pictures/item.gif" width="7" height="7" alt="item" /></td>
						<td>
							<form method="post" action="index.asp?action=createtable" id="createtable" name="createtable">
								Create new table: <input type="text" name="table" id="textinput" />&nbsp;                
								<input type="submit" id="button" value="Go" />
							</form>
						</td>
					</tr>
				</table>
			</td>

			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        

			<!-- aspAccessEditor related links -->
			<td valign="top" align="left">
				<table>
					<tr>
						<th id="tdrow1" colspan="2">&nbsp;&nbsp;<%= name %></th>
					</tr>

			        <!-- Language Selection -->
					<tr>
						<td valign="baseline"><img src="pictures/item.gif" width="7" height="7" alt="item" /></td>
						<td nowrap="nowrap">
						Linguagem: <b>Inglês</b>
						</td>
					</tr>
    
					<!-- aspAccessEditor related urls -->
					<tr>
						<td valign="baseline"><img src="pictures/item.gif" width="7" height="7" alt="item" /></td>
						<td>
							
						</td>
					</tr>
					<!-- aspinfo()-->
					<tr>
						<td valign="baseline"><img src="pictures/item.gif" width="7" height="7" alt="item" /></td>
						<td>
							<a href="aspinfo.asp" target="_new">aspinfo()</a><br />
						</td>
					</tr>
				</table>
			</td>

		</tr>
	</table>


	</body>

	</html>
	<%
End Sub

Sub CreateTable
	'Get name of new table
	table = Request.Form("table")
	If TableExists(table) = True Then
		'Already exists, display error
		strError = "Tabela ou campo já existente. Voltar" & _
		" altere o nome."
		ErrorMessage "Duplicidade", strError
		
		JSGoBack(5)
		Exit Sub
	End If		
	
	'****************************************************
	'* Passed existance check, now create the table		*
	'****************************************************
	strQuery = "CREATE TABLE [" & table & "]"
	db.Query(strQuery)
	
	'****************************************************
	'* Close all database connections					*
	'****************************************************
	IncludeBottom
	
	'****************************************************
	'* Refresh index page to show new table				*
	'****************************************************
	Response.Redirect "index.asp"
End Sub

'// Routine used to compact a database
Sub CompactDatabase
	On Error Resume Next
		
	'// Close database connection
	db.objConn.Close
	
	'// Create Jet Engine object
	Dim objJetEngine
	Set objJetEngine = server.createobject("jro.JetEngine") 
	
	'// Get old database path
	temp = Replace(Session("dbPath"), "/", "\")
	If Right(temp, 1) = "\" Then temp = Left(temp, Len(temp)-1)
	temp = Split(temp, "\")
		
	database = Replace(Session("dbPath"), temp(UBound(temp)), Empty)
	database = Replace(database, "/", "\")
	If Right(database, 1) <> "\" Then database = database & "\"
	
	'// Delete any temporary database
	Set objFSO = Server.CreateObject ("Scripting.FileSystemObject")
	
	If objFSO.FileExists(database & "temp.mdb") = True Then
		'// Delete file
		objFSO.DeleteFile database & "temp.mdb"
	End If
	
	'// Compact database
	objJetEngine.CompactDatabase db.objConn, _
	"Provider=MICROSOFT.JET.OLEDB.4.0; DATA SOURCE=" & database & "temp.mdb;"
	
	'// Delete original database
	objFSO.DeleteFile Session("dbPath")
	
	'// Rename temp database back to original
	objFSO.MoveFile database & "temp.mdb", Session("dbPath")
 
	'// Destroy Jet Engine object
	Set objJetEngine = Nothing 
	'// Destroy FSO object
	Set objFSO = Nothing

	'// Check for any errors
	If Err.number > 0 Then
		SQLError Err.number, Err.Description, Err.Source, "Compactando database..."
		Exit Sub
	End If
	
	On Error GoTo 0
	
	'// Redirect back to index
	Response.Redirect "index.asp?action=main"
End Sub

'****************************************************
'* Call ending tasks procedure						*
'****************************************************
IncludeBottom
%>
