<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<style type="text/css">
	A {
		color : blue;
	}
	A:Hover {
		color : 1d039e;
		text-decoration : underline;
	}
</style> 

<script language="javascript">
function onLoad() {
	this.window.focus();
	if (typeof(upload_onLoad) == "function") {
		upload_onLoad();
	}
}
function select_image(img_name) {

	if (typeof(parent.left.document.ipreview) == 'undefined') {
		parent.left.document.location = "left.asp?imageurl=media&instance=1&img=%2Factivedit%2Fdemo%2Fimages" + img_name;		
	}
	else {
		parent.left.document.ipreview.location = "../../media/" + img_name;
	}
		parent.image_loc = "../../media/" + img_name;
}
</script>
</head>

<body bgcolor="white" onload="onLoad()">
<font face="Tahoma" size="2">
<nobr><b>Available Images</b><nobr><br>
		<font face="arial" size="-2">
			<%
				Dim strPath   'Path of directory to show
				Dim objFSO    'FileSystemObject variable
				Dim objFolder 'Folder variable
				Dim objItem   'Variable used to loop through the contents of the folder
				Dim arrPath
				Dim i
	
				'Construction du chemin vers le repertoire média
				strPath = Server.MapPath(".")
				arrPath = split(strPath, "\")
				strPath = ""
				for i=lbound(arrPath) to ubound(arrPath)-2
					strPath = strPath & arrPath(i) & "\" 
				next	
				strPath = strPath & "media\" & request("dirname")
					
				Response.Write "media\" & request("dirname") & "<br>"
					
				Set objFSO = Server.CreateObject("Scripting.FileSystemObject")	
				Set objFolder = objFSO.GetFolder(strPath)
				
				if lenb(request("dirname"))>0 then 
					Response.Write "<a href='right.asp?dirname='><img src='media/parent.gif' border='0'></a><br/>"
				end if
				
				For Each objItem In objFolder.SubFolders
					Response.Write "<a href=""right.asp?dirname=" & objItem.name & "&instance=1""><img src=""media/folder.gif"" border=""0"" align=""absmiddle"" width=""18"" height=""15"">" & objItem.Name & "</a><br>"
				Next
				
				For Each objItem In objFolder.Files
					Response.Write "<A href=""javascript:select_image('" & request("dirname") & "/" & objItem.name & "')""><img src=""media/imgicon.gif"" border=""0"" align=""absmiddle"" width=""18"" height=""16"">" & objItem.name & "</a><br>"
				Next
				
				Set objFolder = nothing
				set objFSO = nothing
			%>
			<br>
		</font>
</body>
</html>


