<%
'''''''''''  (C) Stefan Holmberg 1999  
'''''''''''  Free to use if these sourcecode lines is not deleted 
'''''''''''  Contact me at webmaster@sqlexperts.com
'''''''''''  http://www.sqlexperts.com
'''''''''''  AdMentor homepage at http://www.create-a-webshop.com



''''''''''''''''Config - global variables
Dim g_AdMentor_AdMentorRedirPath '
Dim g_AdMentor_Demo '
Dim g_Admentor_strConnect ' Connect string
Dim g_AdMentor_MaxRecords
Dim g_AdMentor_PathToAdServe ' HTTP path to adserve.asp and adclick.asp, like http://www.sqlexperts.com/ads
Dim g_AdMentor_DatabaseType ' SQLServer or Access


Dim strAdmentor_strAlreadyOnPage 'Internal - you should not set it yourself



g_AdMentor_DatabaseType = "Access"
'g_AdMentor_DatabaseType = "SQLServer"


'--------------------------------------------------------------------------
'##########################################################################
' CONFIGURAR O CAMINHO DO SITE AKI..ATE A PASTA BANNER
'##########################################################################
'--------------------------------------------------------------------------
g_AdMentor_PathToAdServe = "http://backup/Testes/VSOpen_Grupo/banner/"



If Right(g_AdMentor_PathToAdServe,1) <> "/" Then
	g_AdMentor_PathToAdServe = g_AdMentor_PathToAdServe & "/"
End If

''''''''''''''''TODO: You might need to change
g_Admentor_strConnect = "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=C:\Inetpub\wwwroot\banner\ad2k.mdb"

''''''''''''''''Variables for optimizing
g_AdMentor_MaxRecords = 50 'Set this to the maximum number of banners in a single farm

''''''''''''''''These variables you have to change
g_AdMentor_AdMentorRedirPath = g_AdMentor_PathToAdServe & "admentorredir.asp" ' inclua o caminho do arquivo admentorredir.asp


g_AdMentor_Demo = False ' If true then you can really update/add/delete stuff

''''''''''''''''Config - Maximin sizes etc
Dim g_MaxLongInt, g_MaxEndDate 

g_MaxLongInt = 2147483647 ' Virtually forever, max for a long integer in Access
g_MaxEndDate = "2020-01-01" ' This date means forever...
%>
