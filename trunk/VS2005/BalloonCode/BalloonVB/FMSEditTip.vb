Imports System
Imports System.Windows.Forms
Imports System.Runtime.InteropServices

'*
'* 
'* NOTE : These classes and logic will work only and only if the
'* following key in the registry is set
'* HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\EnableToolTips\
'* 
'* VSNET ver1 : Provide a manifest file in the executable output firectory;
'* VSNET ver2 : CAll Application.EnableVisualStyles(), before InitializeComponent()
'* 

Public Enum TooltipIcon
    None
    Info
    Warning
    [Error]
End Enum

''' <summary>
''' A sample class to manipulate ballon tooltips.
''' Windows XP balloon-tips if used properly can 
''' be very helpful.
''' This class creates a balloon tooltip in the form of a message.
''' This becomes useful for showing important information 
''' quickly to the user.
''' Ever so often we need to avoid certain invalid characters in 
''' input textboxes. Though we do a good job of filtering the characters,
''' we dont necessarily do a good job of informing the user.
''' This class helps immensely under such scenarios.
''' This also helps in a shorter learning cycle of the 
''' application.
''' NOTE: The difference between this and other balloon classes is 
''' that this is made specifically for the edit control and 
''' displays the balloon at the caret position within the textbox.
''' </summary>
Public Class EditBalloon

    Private m_parent As Control

    Private m_text As String = "FMS Balloon Tooltip Control Display Message"
    Private m_title As String = "FMS Balloon Tooltip Message"
    Private m_titleIcon As TooltipIcon = TooltipIcon.None

    Private Const ECM_FIRST As Integer = &H1500
    Private Const EM_SHOWBALLOONTIP As Integer = ECM_FIRST + 3

    <DllImport("User32", SetLastError:=True)> _
    Private Shared Function SendMessage( _
        ByVal hWnd As IntPtr, _
        ByVal Msg As Integer, _
        ByVal wParam As Integer, _
        ByVal lParam As IntPtr) As Integer

    End Function

    <StructLayout(LayoutKind.Sequential, CharSet:=CharSet.Unicode)> _
    Private Structure EDITBALLOONTIP
        Public cbStruct As Integer
        Public pszTitle As String
        Public pszText As String
        Public ttiIcon As Integer
    End Structure

    Public Sub New()

    End Sub

    Public Sub New(ByVal parent As Control)
        m_parent = parent
    End Sub

    ''' <summary>
    ''' Show a balloon tooltip for edit control.
    ''' </summary>
    Public Sub Show()
        Dim ebt As EDITBALLOONTIP = New EDITBALLOONTIP

        ebt.cbStruct = Marshal.SizeOf(ebt)
        ebt.pszText = m_text
        ebt.pszTitle = m_title
        ebt.ttiIcon = CType(m_titleIcon, Integer)

        Dim ptrStruct As IntPtr = Marshal.AllocHGlobal(Marshal.SizeOf(ebt))
        Marshal.StructureToPtr(ebt, ptrStruct, True)

        System.Diagnostics.Debug.Assert(Not m_parent Is Nothing, "Parent control is null", "Set parent before calling Show")

        Dim ret As Integer = SendMessage(m_parent.Handle, _
            EM_SHOWBALLOONTIP, _
            0, ptrStruct)

        Marshal.FreeHGlobal(ptrStruct)

    End Sub

    ''' <summary>
    ''' Sets or gets the Title.
    ''' </summary>
    Public Property Title() As String
        Get
            Return m_title
        End Get
        Set(ByVal Value As String)
            m_title = Value
        End Set
    End Property

    ''' <summary>
    ''' Sets or gets the display icon.
    ''' </summary>
    Public Property TitleIcon() As TooltipIcon
        Get
            Return m_titleIcon
        End Get
        Set(ByVal Value As TooltipIcon)
            m_titleIcon = Value
        End Set
    End Property

    ''' <summary>
    ''' Sets or gets the display text.
    ''' </summary>
    Public Property Text() As String
        Get
            Return m_text
        End Get
        Set(ByVal Value As String)
            m_text = Value
        End Set
    End Property

    ''' <summary>
    ''' Sets or gets the parent.
    ''' </summary>
    Public Property Parent() As Control
        Get
            Return m_parent
        End Get
        Set(ByVal Value As Control)
            m_parent = Value
        End Set
    End Property

End Class
