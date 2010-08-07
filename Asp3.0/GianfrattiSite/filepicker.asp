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
	Dim boolAccess
	
	set oFullXMLEngine = new CFullXMLEngine		
	boolAccess = oFullXMLEngine.GrantAccessEx("member")
	boolAccess = boolAccess or oFullXMLEngine.GrantAccessEx("editor")
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
	<script language=javascript>
		var g_sImagePath;
	
		//internal
		function select_image(sImagePath){			
			
			if (sImagePath.indexOf(".gif")>0 || sImagePath.indexOf(".jpg")>0 || sImagePath.indexOf(".jpeg")>0 || sImagePath.indexOf(".bmp")>0 || sImagePath.indexOf(".ico")>0) 
			{
				document.all.preview.src = sImagePath;				
			}
			else
			{
				sImagePath = "http://" + document.domain + "/" + sImagePath;				
				document.all.preview.src = "admin/media/zip.ico";
			}
			
			g_sImagePath = sImagePath;
			document.all.previewtext.innerText = sImagePath;			
		}
		
		function CheckSize(){
			if (document.all.preview.width>220) document.all.preview.width=220;
		}
				
		
		//external
		function insert_image() {
			var sImg = g_sImagePath;
						
			/*
			var sImg = document.all.preview.src;
			//insert the image into the opener control
			if (sImg.indexOf(".gif")>0 || sImg.indexOf(".jpg")>0) 
				sImg = document.all.preview.src;			
			else
				sImg = document.all.previewtext.innerText;*/
						
			eval(parent).opener.onImage(sImg, 'media' , imgfrm.bdr.value, imgfrm.algn.value, imgfrm.alt.value, 1);
			val = close();
		}
	</script>
	<table width="100%" border=0 cellpadding=0 cellspacing=0 height="100%"><tr>
			<td align=center valign=middle>
				<table width=90% height=70% style="border: 1px black solid; background: white;">
					<tr>
						<td align=center valign=middle>
							<img src=admin/media/dot.gif name=preview id=preview style="1px black solid;"><br>
							<div id=previewtext name=previewtext>
						</td>
					</tr>
				</table>
				<form name="imgfrm">
					<b>Border: </b><input name="bdr" style="BORDER-BOTTOM: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid" value="0" size="2">
					<b>Align: </b><select name="algn">
						<option value="">
							&nbsp;</option>
						<option value="absmiddle">
							absmiddle</option>
						<option value="middle">
							middle</option>
						<option value="bottom">
							bottom</option>
						<option value="top">
							top</option>
						<option value="left" selected>
							left</option>
						<option value="right">
							right</option>
						<option value="baseline">
							baseline</option>
						<option value="texttop">
							texttop</option>
						<option value="absbottom">
							absbottom</option>
					</select>
					<br>
					<b>Alt: </b><input name="alt" style="BORDER-BOTTOM: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid" size="15">
				<br><BR>				
				<input type=button name=btn_OK onclick="javascript:insert_image()" value="Insert">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type=button onclick="javascript:parent.close()" value="Cancel">
				</FORM>
			</td>
			<td width=140 bgcolor=white valign=top style="border: 1px inset; font: 10px tahoma">				
				<font face=tahoma size=1>
				<%FilesList()%>
				</font>
			</td>
		</tr>
	</table>	
</body>
</html>
<%
	sub FilesList()
		Dim objFSO, objFolder, objItem, strPath
		Dim sDirName : sDirName = request("dirname")

		if boolAccess then
		
			Set objFSO = Server.CreateObject("Scripting.FileSystemObject")	
	
			if lenb(request("dirname"))>0 then
				strPath = UPLOAD_PATH & sDirName
			else
				strPath = UPLOAD_PATH
			end if
		
			Response.Write "<b>" & Replace(strPath, ROOT_PATH, "") & "</b><br>"

			Set objFolder = objFSO.GetFolder(strPath)
				
			if lenb(request("dirname"))>0 then 
				Response.Write "<a href='filepicker.asp?dirname='><img src='admin/editor2/media/parent.gif' border='0'>..</a><br/>"
			end if
		
		
			''' display the liste of subfolders
			For Each objItem In objFolder.SubFolders
				Response.Write "<a href=""filepicker.asp?dirname=" 
				if lenb(sDirName)>0 then 
					Response.Write sDirName & "\" 
				end if
				Response.Write objItem.name & """>"
				Response.Write "<img src=admin/editor2/media/folder.gif border=0 align=absmiddle width=18 height=15>" & objItem.Name & "</a><br>"
			Next
				
			Dim imgParam
		
			For Each objItem In objFolder.Files
				if lenb(request("dirname"))>0 then
					imgParam = replace(UPLOAD_VIRTUAL_PATH & sDirName, "\", "\\") & "\\" & objItem.name
				else
					imgParam = replace(UPLOAD_VIRTUAL_PATH, "\", "\\") & objItem.name
				end if
				Response.Write "<A href=""javascript:select_image('" & imgParam & "')""><img src=admin/editor2/media/imgicon.gif border=""0"" align=""absmiddle"" width=""18"" height=""16"">" & objItem.name & "</a><br>"
			Next
		end if
		
		Set objFolder = nothing
		set objFSO = nothing
	end sub
%>