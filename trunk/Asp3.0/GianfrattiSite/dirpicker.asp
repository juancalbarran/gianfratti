<%@ LANGUAGE = "VBScript" %>
<%
	Option Explicit
	With Response
		.Buffer = true
		.Expires = -1000
		.AddHeader "pragma", "no-cache"
	End With
%>
<!-- #include file="Engine/CFullXMLEngine.asp" -->
<%		
	Dim oFullXMLEngine
	
	set oFullXMLEngine = new CFullXMLEngine		
		Response.Write oFullXMLEngine.GrantAccess("editor")	
	set oFullXMLEngine = nothing
%>
<html>
<head>
	<style>
		body {background:buttonface; border: 0px; margin: 0px; font: 10px tahoma}
		td {font: 10px tahoma}
	</style>
</head>
<body>
<%
	ProccessCommands
%>
	<script language=javascript>
		//external
		function insert_dir() {
			eval(parent).opener.onDirectory(document.all.Directory.value, document.all.baseURL.value);
			val = close();
		}
	</script>
	<table width="100%" border=0 cellpadding=0 cellspacing=0 height="100%">
		<tr>

			<td width=50% bgcolor=white valign=top style="border: 1px inset; font: 10px tahoma">				
				<font face=tahoma size=1>
				<%DirList()%>
				</font>
			</td>
			<td width=50% bgcolor=white valign=top style="border: 1px inset; font: 10px tahoma">				
				<font face=tahoma size=1>
				<%FilesList()%>
				</font>
			</td>
		</tr>
<tr>
			<td colspan=2 align=center valign=middle>
				
					<%DirAction()%>
					
				</form>
			</td>
</tr>
		<tr>
			<td colspan=2 align=center valign=middle>
				<form name="imgfrm">

				<input type=button name=btn_OK onclick="javascript:insert_dir()" value="OK">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type=button onclick="javascript:parent.close()" value="Cancel">
				</FORM>
			</td>
</tr>
	</table>	
</body>
</html>
<%
	sub ProccessCommands()
		Dim sAction : sAction = request("action")
		Dim sType : sType = request("type")
		Dim sDirName : sDirName = request("directory")
		Dim sNewFolder : sNewFolder = request("folder")
		Dim objFSO		

		select case sType
			case "folder":
				if sAction="new" then
					Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
					objFSO.CreateFolder(sDirName & "\" & sNewFolder)
					Set objFSO = Nothing
				end if
				if sAction="drop" then
					Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
					if objFSO.FolderExists(sDirName) then
						objFSO.DeleteFolder(sDirName)
					end if
					Set objFSO = Nothing
				end if
		end select
	end sub

	sub DirAction()
		Dim sDirName : sDirName = request("dirname")
		dim strPath
		
		if lenb(sDirName)>0 then
			strPath = UPLOAD_PATH & sDirName
		else
			strPath = UPLOAD_PATH
		end if
		Response.Write "<form name=""dirdel"">"
			Response.Write "<input type=""hidden"" name=""directory"" value=""" & strPath & """>"
			Response.Write "<input type=""hidden"" name=""action"" value=""drop"">"
			Response.Write "<input type=""hidden"" name=""type"" value=""folder"">"
			Response.Write "<input type=""submit"" value=""Delete current folder""/>"
		Response.Write "</form>"
		Response.Write "<form name=""diradd"">"
			Response.Write "<input type=""hidden"" name=""directory"" value=""" & strPath & """>"
			Response.Write "<input type=""hidden"" name=""action"" value=""new"">"
			Response.Write "<input type=""hidden"" name=""type"" value=""folder"">"
			Response.Write "Name of new folder:"
			Response.Write "<input type=""text"" name=""folder"">"
			Response.Write "<input type=""submit"" value=""Create new folder""/>"
		Response.Write "</form>"
	end sub

	sub DirList()
		Dim objFSO, objFolder, objItem, strPath
		Dim sDirName : sDirName = request("dirname")
		
		Set objFSO = Server.CreateObject("Scripting.FileSystemObject")	
		
		if lenb(request("dirname"))>0 then
			strPath = UPLOAD_PATH & sDirName
		else
			strPath = UPLOAD_PATH
		end if

		Response.Write "<input type=""hidden"" name=""Directory"" value=""" & strPath & """>"
		Response.Write "<input type=""hidden"" name=""baseURL"" value=""" & UPLOAD_VIRTUAL_PATH & sDirName & """>"
		
		Response.Write "<b>" & Replace(strPath, ROOT_PATH, "") & "</b><br>"
		
		Set objFolder = objFSO.GetFolder(strPath)
				
		if lenb(request("dirname"))>0 then 
			Response.Write "<a href='dirpicker.asp?dirname='><img src='admin/editor2/media/parent.gif' border='0'>..</a><br/>"
		end if
		
		
		''' display the list of subfolders
		For Each objItem In objFolder.SubFolders
			Response.Write "<a href=""dirpicker.asp?dirname=" 
			if lenb(sDirName)>0 then 
				Response.Write sDirName & "\" 
			end if
			Response.Write objItem.name & """>"
			Response.Write "<img src=admin/editor2/media/folder.gif border=0 align=absmiddle width=18 height=15>" & objItem.Name & "</a><br>"
		Next		
		
		Set objFolder = nothing
		set objFSO = nothing
	end sub

	sub FilesList()
		Dim objFSO, objFolder, objItem, strPath
		Dim sDirName : sDirName = request("dirname")
		
		Set objFSO = Server.CreateObject("Scripting.FileSystemObject")	
		
		if lenb(request("dirname"))>0 then
			strPath = UPLOAD_PATH & sDirName
		else
			strPath = UPLOAD_PATH
		end if
		
		Set objFolder = objFSO.GetFolder(strPath)
				
		Dim imgParam
		
		For Each objItem In objFolder.Files
			if lenb(request("dirname"))>0 then
				imgParam = replace(UPLOAD_VIRTUAL_PATH & sDirName, "\", "\\") & "\\" & objItem.name
			else
				imgParam = replace(UPLOAD_VIRTUAL_PATH, "\", "\\") & objItem.name
			end if
			Response.Write "<img src=admin/editor2/media/imgicon.gif border=""0"" align=""absmiddle"" width=""18"" height=""16"">" & objItem.name & "<br>"
		Next
		
		Set objFolder = nothing
		set objFSO = nothing
	end sub
%>