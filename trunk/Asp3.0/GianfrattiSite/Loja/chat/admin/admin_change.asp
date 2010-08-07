<%
Dim strDBpathCorrection					'Variable to hold database path correction
strDBpathCorrection = "../"
%>
<!--#include file="../common.asp" -->
<!--#include file="check_admin.asp" -->
<%
'Set variables
Dim str_function			'Holds what we are changing
Dim strNewComp 'Holds new operator name
Dim rs 'New record sheet
Dim strNewOp 'holds new operator name
Dim strNewPass 'holds new password

str_function = Request.querystring("function")
%>
<% IF str_function = "OP" THEN%>
<%
'Give variables values
strNewOp = Request.Form("opname")

'Open new connection to database
adoCon.Open cString

'Create new SQL string
strsql="SELECT * FROM tblSettings"
set rs=server.CreateObject("ADODB.Recordset")
rs.open strsql,adocon,3,3
	rs.fields("OperatorName")=strNewOp
	rs.Update
Response.redirect("admin_operators.asp?addpass="&addpass&"")
%>
<%ELSE%>
<%END IF%>
<%IF str_function = "COMP" THEN %>
<%
'Give variables values
strNewComp = Request.Form("compname")

'Open new connection to database
adoCon.Open cString

'Create new SQL string
strsql="SELECT * FROM tblSettings"
set rs=server.CreateObject("ADODB.Recordset")
rs.open strsql,adocon,3,3
	rs.fields("CompanyName")=strNewComp
	rs.Update
Response.redirect("admin_company.asp?addpass="&addpass&"")
%>
<%ELSE%>
<%END IF%>
<%IF str_function = "PASS" THEN %>
<%
'Give variables values
strNewPass = Request.Form("password")

'Open new connection to database
adoCon.Open cString

'Create new SQL string
strsql="SELECT * FROM tblSettings"
set rs=server.CreateObject("ADODB.Recordset")
rs.open strsql,adocon,3,3
	rs.fields("AdminPassword")=strNewPass
	rs.Update
Response.redirect("admin_password.asp?addpass="&strNewPass&"")
%>
<%ELSE%>
<%END IF%>
<%IF str_function = "Soff" THEN %>
<%
'Open new connection to database
adoCon.Open cString

'Create new SQL string
strsql="SELECT * FROM tblSettings"
set rs=server.CreateObject("ADODB.Recordset")
rs.open strsql,adocon,3,3
	rs.fields("online")="0"
	rs.Update
Response.redirect("admin_status.asp?addpass="&addpass&"")
%>
<%ELSE%>
<%END IF%>
<%IF str_function = "Son" THEN %>
<%
'Open new connection to database
adoCon.Open cString

'Create new SQL string
strsql="SELECT * FROM tblSettings"
set rs=server.CreateObject("ADODB.Recordset")
rs.open strsql,adocon,3,3
	rs.fields("online")="5"
	rs.Update
Response.redirect("admin_status.asp?addpass="&addpass&"")
%>
<%ELSE%>
<%END IF%>
<%IF str_function = "COLO" THEN %>
<%
'Open new connection to database
adoCon.Open cString

'Create new SQL string
strsql="SELECT * FROM tblSettings"
set rs=server.CreateObject("ADODB.Recordset")
rs.open strsql,adocon,3,3
	rs.fields("ColourScheme")=Request.form("Colour")
	rs.Update
Response.redirect("admin_colours.asp?addpass="&addpass&"")
%>
<%ELSE%>
<%END IF%>
<%IF str_function = "AUTOR" THEN %>
<%
'Open new connection to database
adoCon.Open cString

'Create new SQL string
strsql="SELECT * FROM tblSettings"
set rs=server.CreateObject("ADODB.Recordset")
rs.open strsql,adocon,3,3
	rs.fields("Admin_auto_refresh")=Request.form("AutoRefresh")
	rs.Update
Response.redirect("admin_misc.asp?addpass="&addpass&"")
%>
<%ELSE%>
<%END IF%>
<%IF str_function = "AUTOP" THEN %>
<%
'Open new connection to database
adoCon.Open cString

'Create new SQL string
strsql="SELECT * FROM tblSettings"
set rs=server.CreateObject("ADODB.Recordset")
rs.open strsql,adocon,3,3
	rs.fields("Admin_auto_popup")=Request.form("AutoPopup")
	rs.Update
Response.redirect("admin_misc.asp?addpass="&addpass&"")
%>
<%ELSE%>
<%END IF%>
<%IF str_function = "RERAT" THEN %>
<%
'Open new connection to database
adoCon.Open cString

'Create new SQL string
strsql="SELECT * FROM tblSettings"
set rs=server.CreateObject("ADODB.Recordset")
rs.open strsql,adocon,3,3
	rs.fields("RefreshRate")=Request.form("RefreshRate")
	rs.Update
Response.redirect("admin_misc.asp?addpass="&addpass&"")
%>
<%ELSE%>
<%END IF%>
<%IF str_function = "SHOWAD" THEN %>
<%
'Open new connection to database
adoCon.Open cString

'Create new SQL string
strsql="SELECT * FROM tblSettings"
set rs=server.CreateObject("ADODB.Recordset")
rs.open strsql,adocon,3,3
	rs.fields("ShowAdmins")=Request.form("ShowAdmins")
	rs.Update

'Reset server objects 
rs.Close 
Set rs = Nothing
adoCon.close
%>
<%IF Request.form("ShowAdmins") = "No" THEN%>
<%
Dim strAIP		'Holds IP address of this admin
strAIP = Request.ServerVariables("REMOTE_ADDR")

'Open new connection to database
adoCon.Open cString

'Create new SQL string
strSQL = "SELECT * from tblActiveUsers WHERE IP='" & strAIP & "'"
set rs=server.CreateObject("ADODB.Recordset")
rs.open strsql,adocon,3,3
If rs.EOF Then Response.redirect("admin_visitors.asp?addpass="&addpass&"")
	rs.fields("LastActive")=Now() - 0.0070
	rs.Update

'Reset server objects 
rs.Close 
Set rs = Nothing
adoCon.close
%>
<% Response.redirect("admin_visitors.asp?addpass="&addpass&"") %>
<%ELSE%>
<%END IF%>
<% Response.redirect("admin_visitors.asp?addpass="&addpass&"") %>
<%ELSE%>
<%END IF%>
<%IF str_function = "DeleteBadWord" THEN %>
<%
Dim intBadID
intBadID = Request.querystring("ID")
'Open new connection to database
adoCon.Open cString

'Create new SQL string
strsql="SELECT * FROM tblBadWordFilter WHERE ID="&intBadID&""
set rs=server.CreateObject("ADODB.Recordset")
rs.open strsql,adocon,3,3
	rs.Delete
Response.redirect("admin_badwords.asp?addpass="&addpass&"")
%>
<%ELSE%>
<%END IF%>
<%IF str_function = "AddBadWord" THEN %>
<%
'Open new connection to database
adoCon.Open cString

'Create new SQL string
strsql="SELECT * FROM tblBadWordFilter"
set rs=server.CreateObject("ADODB.Recordset")
rs.open strsql,adocon,3,3
rs.AddNew
	rs.fields("BadWord")=Request.form("badword")
	rs.fields("ReplaceWith")=Request.form("replacewith")
	rs.Update
Response.redirect("admin_badwords.asp?addpass="&addpass&"")
%>
<%ELSE%>
<%END IF%>
<%IF str_function = "style" THEN %>
<%
'Open new connection to database
adoCon.Open cString

'Create new SQL string
strsql="SELECT * FROM tblSettings"
set rs=server.CreateObject("ADODB.Recordset")
rs.open strsql,adocon,3,3
	rs.fields("maintextcolour")=Request.form("TColour")
	rs.fields("LinkColour")=Request.form("LColour")
	rs.fields("Font")=Request.form("Font")
	rs.fields("HeaderColour")=Request.form("HColour")
rs.fields("someoneleftcolor")=Request.form("EColour")
	rs.Update
Response.redirect("admin_colours.asp?addpass="&addpass&"")
%>
<%ELSE%>
<%END IF%>