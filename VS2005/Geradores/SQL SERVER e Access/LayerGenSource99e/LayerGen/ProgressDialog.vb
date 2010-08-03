Imports System.Windows.Forms

Public Class ProgressDialog

    Public Property Progress() As Integer
        Get
            Return pbProgress.Value
        End Get
        Set(ByVal value As Integer)
            If value <= pbProgress.Maximum Then
                pbProgress.Value = value
            End If
            Me.Refresh()
        End Set
    End Property

    Public Property ProgressMax() As Integer
        Get
            Return pbProgress.Maximum
        End Get
        Set(ByVal value As Integer)
            pbProgress.Maximum = value
        End Set
    End Property

    Public Property ProgressMin() As Integer
        Get
            Return pbProgress.Minimum
        End Get
        Set(ByVal value As Integer)
            pbProgress.Minimum = value
        End Set
    End Property

    Public Property TableName() As String
        Get
            Return Me.lblTableLabel.Text
        End Get
        Set(ByVal value As String)
            Me.lblTableLabel.Text = value
            Me.Refresh()
        End Set
    End Property

    Public Property FunctionName() As String
        Get
            Return Me.lblFunctionLabel.Text
        End Get
        Set(ByVal value As String)
            Me.lblFunctionLabel.Text = value
            Me.Refresh()
        End Set
    End Property

    Private Sub ProgressDialog_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Me.pbProgress.Value = 0
    End Sub

    Private Sub ProgressDialog_Paint(ByVal sender As Object, ByVal e As System.Windows.Forms.PaintEventArgs) Handles Me.Paint
        Dim g As Graphics

        g = e.Graphics

        g.DrawRectangle(Pens.Black, 1, 1, Me.Width - 5, Me.Height - 5)
    End Sub
End Class
