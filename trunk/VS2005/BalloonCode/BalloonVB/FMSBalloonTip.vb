Imports System
Imports System.Drawing
Imports System.Windows.Forms
Imports System.Runtime.InteropServices

'*
'* 
'* NOTE : These classes and logic will work only and only if the
'* following key in the registry is set
'* HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\EnableToolTips\
'* 
'*

'Public Enum TooltipIcon
'    None
'    Info
'    Warning
'    [Error]
'End Enum


Class BalloonTool
    Inherits NativeWindow
End Class

' A sample class to manipulate ballon tooltips.
' Windows XP balloon-tips if used properly can 
' be very helpful.
' This class creates a balloon tooltip.
' This becomes useful for showing important information 
' quickly to the user.
' For example in a data-entry form full of 
' controls the most important
' and used control is the Order Placement button.
' Guide the user by using this hover balloon on it.
' This helps in a shorter learning cycle of the 
' application.
Public Class HoverBalloon
    Implements IDisposable

    Private m_tool As BalloonTool

    Private m_maxWidth As Integer = 250
    Private m_displayText As String = "FMS HoverBalloon Tooltip Control Display text"
    Private m_title As String = "FMS HoverBalloon"
    Private m_titleIcon As TooltipIcon = TooltipIcon.None

    Private Const TOOLTIPS_CLASS As String = "tooltips_class32"
    Private Const WS_POPUP As Integer = &H80000000
    Private Const SWP_NOSIZE As Integer = &H1
    Private Const SWP_NOMOVE As Integer = &H2
    Private Const SWP_NOACTIVATE As Integer = &H10
    Private Const WM_USER As Integer = &H400
    Private Shared ReadOnly HWND_TOPMOST As IntPtr = New IntPtr(-1)

    <StructLayout(LayoutKind.Sequential)> _
    Private Structure TOOLINFO
        Public cbSize As Integer
        Public uFlags As Integer
        Public hwnd As IntPtr
        Public uId As IntPtr
        Public rect As Rectangle
        Public hinst As IntPtr
        <MarshalAs(UnmanagedType.LPTStr)> _
        Public lpszText As String
        Public lParam As Integer
    End Structure

    Private Const TTS_ALWAYSTIP As Integer = &H1
    Private Const TTS_NOPREFIX As Integer = &H2
    Private Const TTS_BALLOON As Integer = &H40
    Private Const TTF_SUBCLASS As Integer = &H10
    Private Const TTF_TRANSPARENT As Integer = &H100
    Private Const TTM_ADDTOOL As Integer = WM_USER + 50
    Private Const TTM_SETMAXTIPWIDTH As Integer = WM_USER + 24
    Private Const TTM_SETTITLE As Integer = WM_USER + 33

    <DllImport("User32", SetLastError:=True)> _
    Private Shared Function SetWindowPos( _
    ByVal hWnd As IntPtr, _
    ByVal hWndInsertAfter As IntPtr, _
    ByVal X As Integer, _
    ByVal Y As Integer, _
    ByVal cx As Integer, _
    ByVal cy As Integer, _
    ByVal uFlags As Integer) As Boolean

    End Function

    <DllImport("User32", SetLastError:=True)> _
    Private Shared Function GetClientRect( _
    ByVal hWnd As IntPtr, _
    ByRef lpRect As Rectangle) As Integer

    End Function

    <DllImport("User32", SetLastError:=True)> _
    Private Shared Function SendMessage( _
    ByVal hWnd As IntPtr, _
    ByVal Msg As Integer, _
    ByVal wParam As Integer, _
    ByVal lParam As IntPtr) As Integer

    End Function

    Public Sub New()
        m_tool = New BalloonTool
    End Sub

    Private disposed As Boolean = False
    Public Overloads Sub Dispose() Implements IDisposable.Dispose
        Dispose(True)
        ' Take yourself off of the finalization queue
        ' to prevent finalization code for this object
        ' from executing a second time.
        GC.SuppressFinalize(Me)
    End Sub
    Protected Overridable Overloads Sub Dispose(ByVal disposing As Boolean)
        ' Check to see if Dispose has already been called.
        If Not (Me.disposed) Then
            ' If disposing equals true, dispose all managed 
            ' and unmanaged resources.
            If (disposing) Then
                ' Dispose managed resources if any
            End If

            ' Release unmanaged resources. 
            m_tool.DestroyHandle()

            ' Note that this is not thread safe.
            ' Another thread could start disposing the object
            ' after the managed resources are disposed,
            ' but before the disposed flag is set to true.
            ' If thread safety is necessary, it must be
            ' implemented by the client.
        End If
        Me.disposed = True
    End Sub

    ' This Finalize method will run only if the 
    ' Dispose method does not get called.
    ' By default, methods are NotOverridable. 
    ' This prevents a derived class from overriding this method.
    Protected Overrides Sub Finalize()
        ' Do not re-create Dispose clean-up code here.
        ' Calling Dispose(false) is optimal in terms of
        ' readability and maintainability.
        Dispose(False)
    End Sub


    Public Sub SetToolTip(ByVal parent As Control, ByVal tipText As String)

        'System.Diagnostics.Debug.Assert(parent.Handle <> IntPtr.Zero, "parent hwnd is null", "SetToolTip")

        m_displayText = tipText

        Dim cp As CreateParams = New CreateParams
        cp.ClassName = TOOLTIPS_CLASS
        cp.Style = WS_POPUP Or TTS_BALLOON Or TTS_NOPREFIX Or TTS_ALWAYSTIP

        cp.Parent = parent.Handle

        ' create the tool
        m_tool.CreateHandle(cp)

        ' make sure we make it the top level window
        SetWindowPos( _
         m_tool.Handle, _
         HWND_TOPMOST, _
         0, 0, 0, 0, _
         SWP_NOACTIVATE Or SWP_NOMOVE Or SWP_NOSIZE)

        ' create and fill in the tool tip info
        Dim ti As TOOLINFO = New TOOLINFO
        ti.cbSize = Marshal.SizeOf(ti)
        ti.uFlags = TTF_TRANSPARENT Or TTF_SUBCLASS
        ti.hwnd = parent.Handle
        ti.lpszText = m_displayText

        ' get the display co-ordinates
        GetClientRect(parent.Handle, ti.rect)

        ' add the tool tip
        Dim ptrStruct As IntPtr = Marshal.AllocHGlobal(Marshal.SizeOf(ti))
        Marshal.StructureToPtr(ti, ptrStruct, True)

        SendMessage( _
         m_tool.Handle, _
         TTM_ADDTOOL, _
         0, _
         ptrStruct)

        ti = CType( _
            Marshal.PtrToStructure(ptrStruct, ti.GetType()), TOOLINFO)

        Marshal.FreeHGlobal(ptrStruct)

        SendMessage( _
         m_tool.Handle, _
         TTM_SETMAXTIPWIDTH, _
         0, _
         New IntPtr(m_maxWidth))


        If m_title <> Nothing Or m_title <> String.Empty Then

            Dim ptrTitle As IntPtr = Marshal.StringToHGlobalAuto(m_title)

            SendMessage( _
             m_tool.Handle, TTM_SETTITLE, _
             CType(m_titleIcon, Integer), ptrTitle)

            Marshal.FreeHGlobal(ptrTitle)
        End If


    End Sub



    ' Sets the maximum text width of the tooltip text.
    ' At that length the tooltip will start wrapping text 
    ' over to the next line. 
    Public Property MaximumTextWidth() As Integer
        Get
            Return m_maxWidth
        End Get
        Set(ByVal Value As Integer)
            m_maxWidth = Value
        End Set
    End Property

    Public Property Title() As String
        Get
            Return m_title
        End Get
        Set(ByVal Value As String)
            m_title = Value
        End Set
    End Property

    Public Property TitleIcon() As TooltipIcon
        Get
            Return m_titleIcon
        End Get
        Set(ByVal Value As TooltipIcon)
            m_titleIcon = Value
        End Set
    End Property

End Class

