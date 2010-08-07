<%
'What this page does:
'Creates a connection to a database which will be used globaly
'Sets the pages language and text
'Gets the room id and addpass submitted by query string
'Adds/updates/deletes from the active users table
%>

<%
'Set the script timeout in seconds
Dim u_7_43536_wef
Server.ScriptTimeout = 90

'Set Dimension Variables
Dim fwi353
Dim strDataBasePath						'Holds the path to the database
Dim cString																	'Holds the entire connection string
Dim adoCon																'Holds the ado connection
DIM S45_reg


Set adoCon = Server.CreateObject("ADODB.Connection")
DIM q2345_sds
'------------------------------------------------------------------------------------
'Change this value to the path of the database
strDataBasePath = ""&strDBpathCorrection&"LiveSupport.mdb"
'------------------------------------------------------------------------------------

'Connection string for the database
'If the following line does not work comment it out with a ' at the start of the line and uncomment another string
cString="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(strDataBasePath)

'Uncomment this connection string if you are using Access Database 2000 or 2002
'cString = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & Server.MapPath(strDataBasePath) 

'Uncomment this connection string if you are using a DSN (note:  DSN is slower than the above connection strings)
'cString = "DSN=NAME_OF_DSN"
'Replace the NAME_OF_DSN with the DSN

Dim e43Osg

%>

<%
'Language snippet, change the string values to edit text which appears on the page

'Set Variables
Dim strTxtWelcome 
Dim strTxtLogin
Dim strTxtEnter
Dim bn_B253_gr
Dim strTxtTalkingTo
Dim strTxtGuidelines
Dim strTxtHere
Dim strTxtLiveSupport
Dim StrTxtChatBox
Dim Xwr9
Dim strTxtSend
Dim bln45
Dim strTxtTalkingTo2
Dim StrTxtConvWith
Dim strTxtYouentered
Dim strAtExactly
Dim strTxtTimeandDate
Dim strTxtProvider
Dim er_ERgerg33
Dim strTxtWelcome2
Dim M0934ffR4
Dim strTxtPleaseWait
Dim w43_wlssg
Dim sphwg_3
Dim strTxtAdmin
Dim strTxtControlPannel
Dim strTxtThisPannelAllows
Dim strTxtCurrentusersonyourwebsite
Dim strTxtChatOptions
Dim strTxtAdminRequest
Dim Wtw3_
Dim strTxtRules

bln45 = "N"

' Global
strTxtLiveSupport = " - Atendimento Ao Vivo"
strTxtAdminRequest = " O Operador está lhe chamando para o atendimento!"

' Admin Pages
strTxtAdmin = "Admin"
strTxtControlPannel = "Painel de Controle"
strTxtThisPannelAllows = "Este é o painel de controle, com ele você pode ver os usuários que estão na fila e editar as opções deles somente os que estiverem ativos"
strTxtCurrentusersonyourwebsite = "Usuários atuais em sua loja"
strTxtChatOptions = "Opções do Chat"
strTxtRules = "Regras do chat"

' Text on chat_top.asp
StrTxtChatBox = "Caixa de mensagem"
strTxtSend = "Enviar"

'Text on chat_main.asp
strTxtWelcome2 = "Bem vindo a Loja <NOME>"
strTxtPleaseWait = "por favor aguarde alguns segundo, para o atendimento"

' Text on chat_right.asp
strTxtTalkingTo2 = "Falando com"
StrTxtConvWith = "Agora você está conversando com "
strTxtYouentered = "Você entrou "
strAtExactly = " exatamente as "
strTxtTimeandDate = "Data de acesso"
strTxtProvider = "Provedor"

' Text on default.asp
strTxtWelcome = ", nosso representante já irá lhe atender. Por favor preencha o campo com o seu nome  pressione enter."
strTxtLogin = "Nome"
strTxtEnter = "Entrar"

'Text on chat.asp (not entire chat room just frameset page)
strTxtTalkingTo = "Falando com "
strTxtGuidelines = "Regras e termos de conduta a serem seguidos pelos operadores "
strTxtHere = "aqui"
%>

<%
'Request some variables from the query string

Dim QStrAdminPass					'Holds the password for admin access if there is one in the string
Dim intUserID											'Holds the ID of the room the user is in/being reidrected to

StrAdminPass = Request.querystring("addpass")		'Get the data from query string
e43Osg = "o"
intUserID = Request.querystring("ID")			'Get the data from the query string
M0934ffR4 = "</"
%>

<%
Dim rsSettings												'Record sheet to open the tabel tblSettings
Dim intOnline														'Holds the value in the database field to see if live support is avaliable
Dim strCompanyName				'Holds the name of the company this application is for
Dim strOperatorName					'Holds the name of the operator currently online
Dim strAdminPass								'Holds the admin password
Dim StrSql																	'Holds SQL string
Dim n3446_FDsdf_f
Dim strAdminAutoRefresh			'Holds weather admin pages should be automaticaly refreshed
Dim strAdminAutoPopup				'Holds weather pop up of chat room should go up when a visitor is waiting
Dim rg_235235
Dim strShowAdmins			'Holds whether to show admins on active users table
Dim intRefreshRate	'holds rate at to refresh in
Dim strLinkColour
Dim	strMainTextColour
Dim strHeaderColour
Dim	strFontFace
Dim strColourScheme
er_ERgerg33 = "Support system<BR>Created by"
Dim strExit
Dim strExitColour

'Open the table tblSettings
set rsSettings = server.createobject("ADODB.RecordSet")
StrSql="SELECT * FROM tblSettings "
rsSettings.open StrSql,cString,3,3

'Take the values from the database field and put them in the variables
intOnline	 = rsSettings("Online")
strCompanyName = rsSettings("CompanyName")
strOperatorName = rsSettings("OperatorName")
intRefreshRate = rsSettings("RefreshRate")
strAdminPass = rsSettings("AdminPassword")
strColourScheme = rsSettings("ColourScheme")
strAdminAutoRefresh = rsSettings("Admin_auto_refresh")
strAdminAutoPopup = rsSettings("Admin_auto_popup")
strShowAdmins =  rsSettings("ShowAdmins")
strLinkColour =  rsSettings("linkcolour")
strMainTextColour =  rsSettings("maintextcolour")
strHeaderColour =  rsSettings("HeaderColour")
strFontFace =  rsSettings("Font")
strExitColour = rsSettings("someoneleftcolor")

'Close the record sheet and clean up
rsSettings.Close
Set rsSettings = Nothing
q2345_sds = "BLANK"


%>
<%
S45_reg = "domain"
Xwr9 = "X"
%>

<%
'Set some variables
fwi353 = "i"
u_7_43536_wef = "w."
Dim strIPAddress														'Holds the current users IP address
Dim rs_Active_Users												'Record sheet for the active users table
Wtw3_ = "RE"


'Give the variables some values
strIPAddress = Request.ServerVariables("REMOTE_ADDR") 	'Set the variable to hold the value of IP address

'Open the connection to the database path specified at top of page
adoCon.Open cString

'Open the active users record sheet
Set rs_Active_Users = Server.CreateObject("ADODB.Recordset")

'Create a new SQL statement to select the data from the row where users IP equals IP in database
strSQL = "SELECT tblActiveUsers.* From tblActiveUsers WHERE IP='" & strIPAddress & "';"

'Set the cursor and lock types
rs_Active_Users.CursorType = 2
rs_Active_Users.LockType = 3

'Open the record sheets and execute the SQL statement
rs_Active_Users.Open strSQL, CString

IF strShowAdmins = "Yes" THEN
'Check the database to see if the user whos online has a field in the database, if not create one
If rs_Active_Users.EOF Then
	
'Insert the users IP address into a new row in database
strSQL = "INSERT INTO tblActiveUsers (IP) VALUES ('" & strIPAddress & "');"

'Write data
adoCon.Execute(strSQL)
	
'If there is a record for the current user then update, dont create new
Else

'Set new SQL statement, set the last active field to the current time
strSQL = "UPDATE tblActiveUsers SET tblActiveUsers.LastActive=Now() WHERE IP='" & strIPAddress & "';"

'Write data
adoCon.Execute(strSQL)	
End If
else
end if

'Delete records older than 10 minuites, they are no longer active
strSQL = "DELETE FROM tblActiveUsers WHERE tblActiveUsers.LastActive < Now() - 0.0070;"

'Write data
adoCon.Execute(strSQL)

'Requery the record sheet to get data up to date
rs_Active_Users.Requery

'Close n' clean!
rg_235235 = "rgE"
bn_B253_gr = "<a"
rs_Active_Users.Close
Set rs_Active_Users = Nothing
w43_wlssg = "://w"
adoCon.close
sphwg_3 = "lass"


n3446_FDsdf_f = "TTP"
%>

<%'Load the approproate colour schemes%>
<%
'Set some variables to hold correct image paths
Dim img_bg		'Holds background image
Dim img_top_right_curve			'Holds path to top right curve
Dim img_bottom_right_curve		'holds path to bottom right curve
Dim img_bottom_left_curve		'holds path to bottom left curve
Dim img_top_left_curve					'holds path to top left curve
Dim img_bg_colour					'holds bgcolour for sheets
Dim strFolderName  'holds colours folder name
%>
<%IF strColourScheme = "Red" THEN%>
<!--#include file="colour/red.asp" -->
<%ELSE%>
<%END IF%>
<%IF strColourScheme = "Green" THEN%>
<!--#include file="colour/green.asp" -->
<%ELSE%>
<%END IF%>
<%IF strColourScheme = "Blue" THEN%>
<!--#include file="colour/blue.asp" -->
<%ELSE%>
<%END IF%>
<%IF strColourScheme = "Yellow" THEN%>
<!--#include file="colour/yellow.asp" -->
<%ELSE%>
<%END IF%>
<%IF strColourScheme = "White" THEN%>
<!--#include file="colour/white.asp" -->
<%ELSE%>
<%END IF%>