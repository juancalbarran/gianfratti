<!-- #include file="FileSystem.asp" -->
<%
id_Paciente = Request("id_Paciente")
id_Atendimento = Request("id_Atendimento")
id_Tipo = Request("id_Tipo")

'Instancia os objetos do componente
Set Upload			= Server.CreateObject("LEAD.Upload")
Set LeadRaster		= Server.CreateObject("LEADRaster.LEADRaster.140")
Set LeadRasterIO	= Server.CreateObject("LEADRasterIO.LEADRasterIO.140")

Call CriaPastas(id_Paciente,id_Atendimento) 'Chama a função que ira criar a estrutura de pastas. Prametros(id_Paciente,id_Atendimento)

Dim nBits, nQFactor, FileFormat, sSuffix, nSave, DiskPath, URLPath, OutputToClient

'Colocarido colocar - nBits = 24 e nQFactor = 2
'Maiores detalhes do SAVE() e outras configurações no endereço de suporte http://www.leadtools.com/help/leadtools/v14/maincom/Ltcomn.htm#ocx_aspjs/writingandreadingmultipagefilesaspjs.htm
'DiskPath = Caminho 'Variavel definida no arquivo de include "Dim Caminho"
'FileFormat = 10 'Opções --> 8, 12, e 16-bit grayscale e 24-bit color 
'nBits = 8 'Opções --> 8, 12, 16 BPP (Grayscale) 24 BPP
'nQFactor = 10 'Opções --> Qualidade de imagem 2 até 255 , onde 2 é a melhor qualidade e 255 o maior nivel de compreenção
'nSave = 0 'Opções --> SAVE_OVERWRITE = 0 , SAVE_APPEND = 1 ou -1 , SAVE_REPLACE = 2 , SAVE_INSERT = 3
'sSuffix = "jpg" 'Extenção que ira ser concatenado com o nome da imagem

'Maiores detalhes do SAVE() e outras configurações no endereço de suporte http://www.leadtools.com/help/leadtools/v14/maincom/Ltcomn.htm#ocx_aspjs/writingandreadingmultipagefilesaspjs.htm
DiskPath = Caminho 'Variavel definida no arquivo de include "Dim Caminho"
FileFormat = 10 'Opções --> 8, 12, e 16-bit grayscale e 24-bit color 
nBits = 24 'Opções --> 8, 12, 16 BPP (Grayscale) 24 BPP
nQFactor = 2 'Opções --> Qualidade de imagem 2 até 255 , onde 2 é a melhor qualidade e 255 o maior nivel de compreenção
nSave = 0 'Opções --> SAVE_OVERWRITE = 0 , SAVE_APPEND = 1 ou -1 , SAVE_REPLACE = 2 , SAVE_INSERT = 3
sSuffix = "jpg" 'Extenção que ira ser concatenado com o nome da imagem

If Session("Verifica") = "" Then
	Call Grava_Documento(id_Paciente,id_Atendimento,Session.SessionID)
	Session("Verifica") = "1"
End if

set files = Upload.Upload

For each file in files
	ImageName = OrganizaNomeImagem(Session("contador"))
	result = LeadRasterIO.LoadArray2(LeadRaster, File.Data, 0, 1, 1, file.size)
	if result = 0 then
            ImageName = ImageName & "." & sSuffix
			result = LeadRasterIO.Save(LeadRaster, DiskPath & ImageName, FileFormat, nBits, nQFactor, nSave)
			Call Grava_Imagem(ImageName,id_Tipo)
            'Response.Write "<html>"&LeadRaster&"</html>"
		If result <> 0 then
			Response.Write "Erro ao salvar no disco: " + CStr(result)
		End if
	Else
			Response.Write "Erro ao ler LoadArray2: " + CStr(result)
	End If
next 

Set Upload = Nothing 'Destroi o objeto criado
Set LeadRaster = Nothing 'Destroi o objeto criado
Set LeadRasterIO = Nothing 'Destroi o objeto criado
%>
