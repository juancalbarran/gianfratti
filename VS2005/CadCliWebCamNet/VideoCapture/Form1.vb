Imports System.Runtime.InteropServices

Public Class Form1

    Const WM_CAP_START = &H400S
    Const WS_CHILD = &H40000000
    Const WS_VISIBLE = &H10000000

    Const WM_CAP_DRIVER_CONNECT = WM_CAP_START + 10
    Const WM_CAP_DRIVER_DISCONNECT = WM_CAP_START + 11
    Const WM_CAP_EDIT_COPY = WM_CAP_START + 30
    Const WM_CAP_SEQUENCE = WM_CAP_START + 62
    Const WM_CAP_FILE_SAVEAS = WM_CAP_START + 23

    Const WM_CAP_SET_SCALE = WM_CAP_START + 53
    Const WM_CAP_SET_PREVIEWRATE = WM_CAP_START + 52
    Const WM_CAP_SET_PREVIEW = WM_CAP_START + 50

    Const SWP_NOMOVE = &H2S
    Const SWP_NOSIZE = 1
    Const SWP_NOZORDER = &H4S
    Const HWND_BOTTOM = 1

    '--A função capGetDriverDescription retorna a versão do driver de captura
    Declare Function capGetDriverDescriptionA Lib "avicap32.dll" _
       (ByVal wDriverIndex As Short, _
        ByVal lpszName As String, ByVal cbName As Integer, ByVal lpszVer As String, _
        ByVal cbVer As Integer) As Boolean

    '--A função capCreateCaptureWindow cria uma janela de captura
    Declare Function capCreateCaptureWindowA Lib "avicap32.dll" _
       (ByVal lpszWindowName As String, ByVal dwStyle As Integer, _
        ByVal x As Integer, ByVal y As Integer, ByVal nWidth As Integer, _
        ByVal nHeight As Short, ByVal hWnd As Integer, _
        ByVal nID As Integer) As Integer

    '--Envia uma mensagem especifica para a janela ou para o Windows
    Declare Function SendMessage Lib "user32" Alias "SendMessageA" _
       (ByVal hwnd As Integer, ByVal Msg As Integer, ByVal wParam As Integer, _
       <MarshalAs(UnmanagedType.AsAny)> ByVal lParam As Object) As Integer

    '--Define a posição da janela relativa ao buffer de tela
    Declare Function SetWindowPos Lib "user32" Alias "SetWindowPos" _
       (ByVal hwnd As Integer, _
        ByVal hWndInsertAfter As Integer, ByVal x As Integer, ByVal y As Integer, _
        ByVal cx As Integer, ByVal cy As Integer, ByVal wFlags As Integer) As Integer

    '--Destroi a janela especificada
    Declare Function DestroyWindow Lib "user32" (ByVal hndw As Integer) As Boolean

    Dim FonteVideo As Integer
    Dim hWnd As Integer

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Carrega os daados na tabela 'NorthwindDataSet.Employees'
        Me.EmployeesTableAdapter.Fill(Me.NorthwindDataSet.Employees)
        btnIniciaGravacao.Enabled = True
        btnParaGravacao.Enabled = False
        '---lista todos os dispositivos de video instalados
        ListaFontesVideo()
    End Sub

    '--desconecta da fonte de video
    Private Sub paraJanelaVisualizacao()
        SendMessage(hWnd, WM_CAP_DRIVER_DISCONNECT, FonteVideo, 0)
        DestroyWindow(hWnd)
    End Sub

    '---lista todas as fontes de video
    Private Sub ListaFontesVideo()
        Dim nomeDriver As String = Space(80)
        Dim versaoDriver As String = Space(80)
        For i As Integer = 0 To 9
            If capGetDriverDescriptionA(i, nomeDriver, 80, versaoDriver, 80) Then
                lstFontesVideos.Items.Add(nomeDriver.Trim)
            End If
        Next
    End Sub

    '---salva a imagem---
    Private Sub CapturaImagem()
        Dim data As IDataObject
        Dim bmap As Image

        '---copia a imagem para o clipboard---
        SendMessage(hWnd, WM_CAP_EDIT_COPY, 0, 0)

        '---retorna a imagem do clipboard e a converte para o formato bitmap
        data = Clipboard.GetDataObject()
        If data.GetDataPresent(GetType(System.Drawing.Bitmap)) Then
            bmap = CType(data.GetData(GetType(System.Drawing.Bitmap)), Image)
            picFoto.Image = bmap
            paraJanelaVisualizacao()
        End If
    End Sub


    '---visualiza a fonte de video selecionada
    Private Sub VisualizaVideo(ByVal pbCtrl As PictureBox)
        hWnd = capCreateCaptureWindowA(FonteVideo, WS_VISIBLE Or WS_CHILD, 0, 0, 0, 0, pbCtrl.Handle.ToInt32, 0)
        If SendMessage(hWnd, WM_CAP_DRIVER_CONNECT, FonteVideo, 0) Then
            '---define a escala
            SendMessage(hWnd, WM_CAP_SET_SCALE, True, 0)
            '---define a taxa de visualização (ms)
            SendMessage(hWnd, WM_CAP_SET_PREVIEWRATE, 30, 0)
            '---inicia visualização da imagem
            SendMessage(hWnd, WM_CAP_SET_PREVIEW, True, 0)
            '---redimensiona a janela para se ajustar ao controle picturebox
            SetWindowPos(hWnd, HWND_BOTTOM, 0, 0, pbCtrl.Width, pbCtrl.Height, SWP_NOMOVE Or SWP_NOZORDER)
        Else
            '--erro ao conectar com o video
            DestroyWindow(hWnd)
        End If
    End Sub


    Private Sub lstVideoSources_SelectedIndexChanged( _
       ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lstFontesVideos.SelectedIndexChanged

        '---para o video se estiver ativo
        paraJanelaVisualizacao()
        '---verifica qual fonte de video foi selecionada
        FonteVideo = lstFontesVideos.SelectedIndex
        '---visualiza a fonte de video selecionada
        VisualizaVideo(picImagem)
    End Sub

    Private Sub btnParaCamera_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnParaCamera.Click
        paraJanelaVisualizacao()
    End Sub

    Private Sub btnIniciaGravacao_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnIniciaGravacao.Click
        If lstFontesVideos.SelectedIndex <> -1 Then
            btnIniciaGravacao.Enabled = False
            btnParaGravacao.Enabled = True
            '---inicia a gravação
            SendMessage(hWnd, WM_CAP_SEQUENCE, 0, 0)
        Else
            MsgBox("Selecione uma fonte de Vídeo...")
        End If
    End Sub

    Private Sub btnParaGravacao_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnParaGravacao.Click
        btnIniciaGravacao.Enabled = True
        btnParaGravacao.Enabled = False
        '---salva a gravação para o arquivo na pasta da aplicação
        SendMessage(hWnd, WM_CAP_FILE_SAVEAS, 0, Application.StartupPath & "\VideoMac.avi")
    End Sub
    Private Sub EmployeesBindingNavigatorSaveItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Salva os dados
        Me.Validate()
        Me.EmployeesBindingSource.EndEdit()
        Me.EmployeesTableAdapter.Update(Me.NorthwindDataSet.Employees)
    End Sub

    Private Sub EmployeesBindingNavigatorSaveItem_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles EmployeesBindingNavigatorSaveItem.Click
        Me.Validate()
        Me.EmployeesBindingSource.EndEdit()
        Me.EmployeesTableAdapter.Update(Me.NorthwindDataSet.Employees)
    End Sub

    Private Sub BindingNavigatorAddNewItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BindingNavigatorAddNewItem.Click
        'incluir um novo item 
        paraJanelaVisualizacao()
        VisualizaVideo(picFoto)
    End Sub

    Private Sub btnCapturePhoto_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCapturaFoto.Click
        'captura a imagem
        CapturaImagem()
    End Sub
End Class
