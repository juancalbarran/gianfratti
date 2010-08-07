Dim oConn, g_Admentor_strConnect
Set oConn = Server.CreateObject("ADODB.Connection")
g_Admentor_strConnect = "DBQ="& server.mappath("../adk2.mdb")caminho & ";Driver={Microsoft Access Driver (*.mdb)}"
oConn.Open g_Admentor_strConnect
