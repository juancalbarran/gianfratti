Public Class TableControl

    Private strTableName As String
    Private strFontName As String
    Private intFontSize As Integer
    Private strFontStyle As System.Drawing.FontStyle

#Region "Constructor"
    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        Me.strFontName = "Lucida Console"
        Me.strFontStyle = Drawing.FontStyle.Bold
        Me.intFontSize = 10
        Me.strTableName = ""
    End Sub
#End Region

#Region "Properties"
    Public Property TableName() As String
        Get
            Return strTableName
        End Get
        Set(ByVal value As String)
            strTableName = value
            Me.Height = 21
            Me.Width = value.Length * 10 + 4
        End Set
    End Property

    Public Property FontSize() As Integer
        Get
            Return intFontSize
        End Get
        Set(ByVal value As Integer)
            intFontSize = value
        End Set
    End Property

    Public Property FontName() As String
        Get
            Return strFontName
        End Get
        Set(ByVal value As String)
            strFontName = value
        End Set
    End Property

    Public Property FontStyle() As System.Drawing.FontStyle
        Get
            Return strFontStyle
        End Get
        Set(ByVal value As System.Drawing.FontStyle)
            strFontStyle = value
        End Set
    End Property
#End Region

#Region "OnPaint"
    Protected Overrides Sub OnPaint(ByVal pe As System.Windows.Forms.PaintEventArgs)
        Dim ft As New Font(strFontName, intFontSize, strFontStyle, GraphicsUnit.Point)

        MyBase.OnPaint(pe)

        If TableName Is Nothing OrElse TableName = "" Then ft = Nothing : Exit Sub

        pe.Graphics.DrawRectangle(Pens.Black, 0, 0, TableName().Length * intFontSize + 3, 20)
        pe.Graphics.FillRectangle(Brushes.White, 0, 0, TableName().Length() * intFontSize + 3, 20)
        pe.Graphics.DrawString(TableName(), ft, Brushes.Black, 2, 2)
        ft = Nothing
    End Sub
#End Region

End Class
