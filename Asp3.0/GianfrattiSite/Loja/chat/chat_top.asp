<!--#include file="common.asp" -->
<%
Dim Username			'Holds logged in username
Dim addpass				'Holds admin password
Dim usrID								'Holds the roomID
Dim rs												'New record sheet

usrID=CLng(Request.querystring("ID"))
username=Request.querystring("username")
addpass=Request.querystring ("addpass")
%>

<HTML>
	<head>
<!--#include file="style/style.asp" -->
	</head>
	
<%
'If the user has just posted then
IF Request.querystring("method") = "post" THEN
%>
<%

Dim strUserText
strUserText = Request.form("text")
%>
<%
'Remove any codes if they were not written by admi
IF addpass <> strAdminPass THEN
'Remove all tags
strUserText = Replace(strUserText, "&", "&amp;") 
strUserText = Replace(strUserText, "<", "&lt;")
strUserText = Replace(strUserText, ">", "&gt;")
strUserText = Replace(strUserText, "'", "''", 1, -1, 1)
%>
<%
Dim rsBadwords		'Record sheet for bad words
Dim badCount		'Holds number of bad words

badCount = 0 	'Set to 0

'Open database
adoCon.Open cString

'Create new record sheet
Set rsBadwords = Server.CreateObject("ADODB.Recordset")

'Create new SQL string
strSQL = "SELECT tblBadwordFilter.BadWord, tblBadwordFilter.ReplaceWith FROM tblBadWordFilter;"

'Open recordsheet and execute SQL
rsBadwords.Open strSQL, adoCon

'Loop through the recordset 
Do While not rsBadwords.EOF 

Dim strBadWord
Dim strBadWordReplace
strBadWord = rsBadwords("BadWord")
strBadWordReplace = rsBadwords("ReplaceWith")

strUserText = Replace(strUserText, ""&strBadWord&"", ""&strBadWordReplace&"", 1, -1, 1)


badCount = badCount +1 'Add one to the usercount

'Move to the next record in the recordset 
rsBadwords.MoveNext

Loop 

'Close and clean up
rsBadwords.Close
set rsBadwords = Nothing
adoCon.close
%>
<%ELSE%>
<%END IF%>
<%
'Open new connection to the database
adoCon.Open cString

'Create new SQL string
strsql= "SELECT tblChat.RoomID, tblChat.Speaker, tblChat.Speach FROM tblChat;"

'Create a new record sheet
set rs=server.CreateObject("ADODB.Recordset")

'Set new cursor and lock types
Rs.CursorType = 2
Rs.LockType = 3

'Open record sheet and connection
rs.open strsql,adoCon,3,3

'Add new record into database
rs.AddNew

'If admin is online then the speaker is the current admins name
IF addpass=strAdminPass THEN
rs.fields("Speaker")=strOperatorName
'If admin is not online the the speaker is the current user who is online
Else
rs.fields("Speaker")=Username
end if
'Set the speach to what was said in input box
rs.fields("Speach")=strUserText
'Set room ID to ID in query string
rs.fields("RoomID")=usrID
'Update
rs.Update

'Close and clean up
rs.Close
Set rs = Nothing
adoCon.close
%>
<%ELSE%>
<%ENd if%>
	
	<body style="margin: 0" topmargin="0" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0" background="<%=img_bg%>">
		<form action="chat_top.asp?method=post&ID=<%=usrID%>&addpass=<%=addpass%>&username=<%=username%>" method="post">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" height="25">
				<tr>
					<td>&nbsp;<input type="text" name="text" size="40" class="textbox">&nbsp;<input type="submit" value="<%=strTxtSend%>" class="button"></td>
				</tr>
			</table>
			<table  border="0" cellspacing="0" cellpadding="0" height="15">
				<tr>
					<td bgcolor="#000000" width="265" class="header">
						<B>
							&nbsp;&nbsp;&nbsp;<%=StrTxtChatBox%>
						</td>
						<td bgcolor="#000000" width="15"><img src="<%=img_top_right_curve%>" width="15" height="15"></td>
					</tr>
				</table>				
			</form>
