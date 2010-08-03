Imports System
Imports System.Windows.Forms
Imports System.Runtime.InteropServices

Public Class FMSMessageTip

    Public Enum BalloonAlignment
        TopLeft
        TopMiddle
        TopRight
        LeftMiddle
        RightMiddle
        BottomLeft
        BottomMiddle
        BottomRight
    End Enum

    Public Enum BalloonPosition
        '/// <summary>
        '/// Positions using the exact co-ordinates.
        '/// So if the co-ordinates are outside the screen,
        '/// tip wont be shown.
        '/// </summary>
        Absolute

        '/// <summary>
        '/// Positions using the co-ordinates as a reference.
        '/// Regardless of the co-ordinates, the tip will 
        '/// always be shown on the screen.
        '/// </summary>
        Track

    End Enum



    Public Delegate Sub DeActivateEventHandler()

    Friend Class MessageTool
        Inherits NativeWindow

        Private Const WM_LBUTTONDOWN As Integer = &H201
        Public Event DeActivate As DeActivateEventHandler

        Protected Overrides Sub WndProc(ByRef m As Message)

            If m.Msg = WM_LBUTTONDOWN Then
                System.Diagnostics.Debug.WriteLine(m)
                '// allow the balloon to close if clicked upon

                RaiseEvent DeActivate()

            End If

            MyBase.WndProc(m)

        End Sub

    End Class

    '/// <summary>
    '/// A sample class to manipulate ballon tooltips.
    '/// Windows XP balloon-tips if used properly can 
    '/// be very helpful.
    '/// This class creates a balloon tooltip in the form of a message.
    '/// This becomes useful for showing important information 
    '/// quickly to the user.
    '/// For example in a data-entry form full of 
    '/// controls if an error is made somewhere in entering data
    '/// use this to point the bad control.
    '/// This helps in a shorter learning cycle of the 
    '/// application.
    '/// NOTE: the difference between this and HoverBalloon class
    '/// is that this can be shown on demand.
    '/// </summary>

    Public Class MessageBalloon
        Implements IDisposable

        Private WithEvents m_tool As MessageTool = Nothing
        Private m_parent As Control = Nothing
        Private ti As TOOLINFO

        Private m_maxWidth As Integer = 250
        Private m_text As String = "FMS Balloon Tooltip Control Display Message"
        Private m_title As String = "FMS Balloon Tooltip Message"
        Private m_titleIcon As TooltipIcon = TooltipIcon.None
        Private m_align As BalloonAlignment = BalloonAlignment.TopRight
        Private m_absPosn As Boolean = False
        Private m_centerStem As Boolean = False

        Private Const TOOLTIPS_CLASS As String = "tooltips_class32"
        Private Const WS_POPUP As Integer = &H80000000
        Private Const WM_USER As Integer = &H400
        Private ReadOnly HWND_TOPMOST As IntPtr = New IntPtr(-1)
        Private Const SWP_NOSIZE As Integer = &H1
        Private Const SWP_NOMOVE As Integer = &H2
        Private Const SWP_NOACTIVATE As Integer = &H10
        Private Const SWP_NOZORDER As Integer = &H4

        <DllImport("User32", SetLastError:=True)> _
        Private Shared Function SetWindowPos( _
            ByVal hWnd As IntPtr, _
            ByVal hWndInsertAfter As IntPtr, _
            ByVal X As Integer, _
            ByVal Y As Integer, _
            ByVal cx As Integer, _
            ByVal cy As Integer, _
            ByVal uFlags As Integer) As Integer

        End Function

        <DllImport("User32", SetLastError:=True)> _
        Private Shared Function GetClientRect( _
        ByVal hWnd As IntPtr, _
        ByRef lpRect As RECT) As Integer

        End Function

        <DllImport("User32", SetLastError:=True)> _
        Private Shared Function ClientToScreen( _
        ByVal hWnd As IntPtr, _
        ByRef lpRect As RECT) As Integer

        End Function

        <DllImport("User32", SetLastError:=True)> _
        Private Shared Function SendMessage( _
        ByVal hWnd As IntPtr, _
        ByVal Msg As Integer, _
        ByVal wParam As Integer, _
        ByVal lParam As IntPtr) As Integer

        End Function

        <StructLayout(LayoutKind.Sequential)> _
              Private Structure RECT
            Public left As Integer
            Public top As Integer
            Public right As Integer
            Public bottom As Integer
        End Structure

        Private Const TTS_ALWAYSTIP As Integer = &H1
        Private Const TTS_NOPREFIX As Integer = &H2
        Private Const TTS_BALLOON As Integer = &H40
        Private Const TTS_CLOSE As Integer = &H80

        Private Const TTM_TRACKPOSITION As Integer = WM_USER + 18
        Private Const TTM_SETMAXTIPWIDTH As Integer = WM_USER + 24
        Private Const TTM_TRACKACTIVATE As Integer = WM_USER + 17
        Private Const TTM_ADDTOOL As Integer = WM_USER + 50
        Private Const TTM_SETTITLE As Integer = WM_USER + 33

        Private Const TTF_IDISHWND As Integer = &H1
        Private Const TTF_SUBCLASS As Integer = &H10
        Private Const TTF_TRACK As Integer = &H20
        Private Const TTF_ABSOLUTE As Integer = &H80
        Private Const TTF_TRANSPARENT As Integer = &H100
        Private Const TTF_CENTERTIP As Integer = &H2
        Private Const TTF_PARSELINKS As Integer = &H1000

        <StructLayout(LayoutKind.Sequential)> _
        Private Structure TOOLINFO
            Public cbSize As Integer
            Public uFlags As Integer
            Public hwnd As IntPtr
            Public uId As IntPtr
            Public rect As rect
            Public hinst As IntPtr
            <MarshalAs(UnmanagedType.LPTStr)> _
            Public lpszText As String
            Public lParam As UInt32

        End Structure

        '/// <summary>
        '/// Creates a new instance of the MessageBalloon.
        '/// </summary>
        Public Sub New()
            m_tool = New MessageTool


        End Sub

        '/// <summary>
        '/// Creates a new instance of the MessageBalloon.
        '/// </summary>
        '/// <param name="parent">Set the parent control which will display.</param>
        Public Sub MessageBalloon(ByVal parent As Control)
            m_parent = parent
            m_tool = New MessageTool

        End Sub

        ' This finalizer will run only if the Dispose method 
        ' does not get called.
        ' It gives your base class the opportunity to finalize.
        ' Do not provide finalize methods in types derived from this class.
        Protected Overrides Sub Finalize()
            ' Do not re-create Dispose clean-up code here.
            ' Calling Dispose(false) is optimal in terms of
            ' readability and maintainability.
            Dispose(False)
        End Sub

        Private disposed As Boolean = False
        ' Implement IDisposable.
        ' Do not make this method virtual.
        ' A derived class should not be able to override this method.
        Public Overloads Sub Dispose() Implements IDisposable.Dispose
            Dispose(True)
            '// Take yourself off the Finalization queue 
            '// to prevent finalization code for this object
            '// from executing a second time.
            GC.SuppressFinalize(Me)
        End Sub
        ' Dispose(bool disposing) executes in two distinct scenarios.
        ' If disposing equals true, the method has been called directly
        ' or indirectly by a user's code. Managed and unmanaged resources
        ' can be disposed.
        ' If disposing equals false, the method has been called by the 
        ' runtime from inside the finalizer and you should not reference 
        ' other objects. Only unmanaged resources can be disposed.
        Private Overloads Sub Dispose(ByVal disposing As Boolean)
            ' Check to see if Dispose has already been called.
            If Not Me.disposed Then
                ' If disposing equals true, dispose all managed 
                ' and unmanaged resources.
                If disposing Then
                    ' Dispose managed resources if any
                End If

                '// release unmanaged resource
                Hide()

                '// Note that this is not thread safe.
                '// Another thread could start disposing the object
                '// after the managed resources are disposed,
                '// but before the disposed flag is set to true.
                '// If thread safety is necessary, it must be
                '// implemented by the client.
            End If
            disposed = True
        End Sub


        Private Sub CreateTool()

            System.Diagnostics.Debug.Assert( _
             Not m_parent.Handle.Equals(IntPtr.Zero), _
             "parent hwnd is null", "SetToolTip")

            Dim cp As CreateParams = New CreateParams
            cp.ClassName = TOOLTIPS_CLASS
            cp.Style = _
             WS_POPUP Or _
             TTS_BALLOON Or _
             TTS_NOPREFIX Or _
             TTS_ALWAYSTIP Or _
             TTS_CLOSE

            ' create the tool
            m_tool.CreateHandle(cp)

            ' create and fill in the tool tip info
            ti = New TOOLINFO
            ti.cbSize = Marshal.SizeOf(ti)

            ti.uFlags = TTF_TRACK Or _
             TTF_IDISHWND Or _
             TTF_TRANSPARENT Or _
             TTF_SUBCLASS Or _
             TTF_PARSELINKS

            ' absolute is used tooltip maynot be shown 
            ' if coords exceed the corners of the screen
            If (m_absPosn) Then
                ti.uFlags = ti.uFlags Or TTF_ABSOLUTE
            End If

            If m_centerStem Then
                ti.uFlags = ti.uFlags Or TTF_CENTERTIP
            End If

            ti.uId = m_tool.Handle
            ti.lpszText = m_text
            ti.hwnd = m_parent.Handle

            GetClientRect(m_parent.Handle, ti.rect)
            ClientToScreen(m_parent.Handle, ti.rect)

            '// make sure we make it the top level window
            SetWindowPos( _
             m_tool.Handle, _
             HWND_TOPMOST, _
             0, 0, 0, 0, _
             SWP_NOACTIVATE Or _
             SWP_NOMOVE Or _
             SWP_NOSIZE)

            '// add the tool tip
            Dim ptrStruct As IntPtr = Marshal.AllocHGlobal(Marshal.SizeOf(ti))
            Marshal.StructureToPtr(ti, ptrStruct, True)

            SendMessage( _
             m_tool.Handle, TTM_ADDTOOL, 0, ptrStruct)

            ti = CType(Marshal.PtrToStructure(ptrStruct, GetType(TOOLINFO)), TOOLINFO)

            SendMessage( _
             m_tool.Handle, TTM_SETMAXTIPWIDTH, _
             0, New IntPtr(m_maxWidth))

            Dim ptrTitle As IntPtr = Marshal.StringToHGlobalAuto(m_title)

            SendMessage( _
             m_tool.Handle, TTM_SETTITLE, _
             CType(m_titleIcon, Integer), ptrTitle)

            SetBalloonPosition(ti.rect)

            Marshal.FreeHGlobal(ptrStruct)
            Marshal.FreeHGlobal(ptrTitle)


        End Sub


        Private Sub SetBalloonPosition(ByVal rect As RECT)
            Dim x, y As Integer
            x = y = 0

            '// calculate cordinates depending upon aligment
            Select Case m_align
                Case BalloonAlignment.TopLeft
                    x = rect.left
                    y = rect.top
                Case BalloonAlignment.TopMiddle
                    x = rect.left + (rect.right / 2)
                    y = rect.top
                Case BalloonAlignment.TopRight
                    x = rect.left + rect.right
                    y = rect.top
                Case BalloonAlignment.LeftMiddle
                    x = rect.left
                    y = rect.top + (rect.bottom / 2)
                Case BalloonAlignment.RightMiddle
                    x = rect.left + rect.right
                    y = rect.top + (rect.bottom / 2)
                Case BalloonAlignment.BottomLeft
                    x = rect.left
                    y = rect.top + rect.bottom
                Case BalloonAlignment.BottomMiddle
                    x = rect.left + (rect.right / 2)
                    y = rect.top + rect.bottom
                Case BalloonAlignment.BottomRight
                    x = rect.left + rect.right
                    y = rect.top + rect.bottom
                Case Else
                    System.Diagnostics.Debug.Assert(False, "undefined enum", "default case reached")

            End Select

            Dim pt As Integer = MAKELONG(x, y)
            Dim ptr As IntPtr = New IntPtr(pt)

            SendMessage( _
             m_tool.Handle, TTM_TRACKPOSITION, _
             0, ptr)


        End Sub

        '/// <summary>
        '/// Shows or hides the tool.
        '/// </summary>
        '/// <param name="show">0 to hide, -1 to show</param>
        Private Sub Display(ByVal show As Integer)
            Dim ptrStruct As IntPtr = Marshal.AllocHGlobal(Marshal.SizeOf(ti))
            Marshal.StructureToPtr(ti, ptrStruct, True)

            SendMessage( _
             m_tool.Handle, TTM_TRACKACTIVATE, _
             show, ptrStruct)

            Marshal.FreeHGlobal(ptrStruct)

        End Sub

        '/// <summary>
        '/// Hides the message if visible.
        '/// </summary>
        Public Sub Hide() Handles m_tool.DeActivate

            Display(0)
            m_tool.DestroyHandle()
        End Sub

        ' Applies to VS.NET 2003
        'Private Function MAKELONG(ByVal loWord As Integer, ByVal hiWord As Integer) As Integer
        '    Return (hiWord << 16) Or (loWord And &HFFFF)
        'End Function

        ' Applies to VS.NET 2002
        Private Function MAKELONG(ByVal wLow As Integer, ByVal wHigh As Integer) As Long
            MAKELONG = LoWord(wLow) Or (&H10000 * LoWord(wHigh))
        End Function
        Private Function LoWord(ByVal DWord As Long) As Integer
            If DWord And &H8000& Then ' &H8000& = &H00008000
                LoWord = DWord Or &HFFFF0000
            Else
                LoWord = DWord And &HFFFF&
            End If
        End Function


        '/// <summary>
        '/// Sets or gets the Title.
        '/// </summary>
        Public Property Title() As String
            Get
                Return m_title
            End Get
            Set(ByVal Value As String)
                m_title = Value
            End Set
        End Property

        '/// <summary>
        '/// Sets or gets the display icon.
        '/// </summary>
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



        '/// <summary>
        '/// Show the Message in a balloon tooltip.
        '/// </summary>
        Public Sub Show()
            '// recreate window always
            Hide()

            CreateTool()
            Display(-1)

        End Sub

        '/// <summary>
        '/// Sets or gets the placement of the balloon.
        '/// </summary>
        Public Property Align() As BalloonAlignment
            Get
                Return m_align
            End Get
            Set(ByVal Value As BalloonAlignment)
                m_align = Value
            End Set
        End Property

        '/// <summary>
        '/// Sets or gets the positioning of the balloon.
        '/// TRUE : Positions using the exact co-ordinates,
        '/// if the co-ordinates are outside the screen, tip wont be shown.
        '/// FALSE : Positions using the co-ordinates as a reference.
        '/// Regardless of the co-ordinates, the tip will 
        '/// always be shown on the screen.
        '/// </summary>
        Public Property UseAbsolutePositioning() As Boolean
            Get
                Return m_absPosn
            End Get
            Set(ByVal Value As Boolean)
                m_absPosn = Value
            End Set
        End Property

        '/// <summary>
        '/// Sets or gets the stem position 
        '/// in the tip. 
        '/// TRUE : The stem of the tip is set to center.
        '/// An attempt is made to show the tip with the stem
        '/// centered, if that would make the tip to be 
        '/// hidden partly, stem is not centered.
        '/// FALSE: Stem is not centered.
        '/// </summary>
        Public Property CenterStem() As Boolean
            Get
                Return m_centerStem
            End Get
            Set(ByVal Value As Boolean)
                m_centerStem = Value
            End Set
        End Property


    End Class


End Class
