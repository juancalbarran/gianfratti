Public Class Startup
    Inherits System.Windows.Forms.Form

#Region " Windows Form Designer generated code "

    Public Sub New()
        MyBase.New()

        'This call is required by the Windows Form Designer.
        InitializeComponent()

        'Add any initialization after the InitializeComponent() call

    End Sub

    'Form overrides dispose to clean up the component list.
    Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    Friend WithEvents button3 As System.Windows.Forms.Button
    Friend WithEvents button2 As System.Windows.Forms.Button
    Friend WithEvents button1 As System.Windows.Forms.Button
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.button3 = New System.Windows.Forms.Button
        Me.button2 = New System.Windows.Forms.Button
        Me.button1 = New System.Windows.Forms.Button
        Me.SuspendLayout()
        '
        'button3
        '
        Me.button3.Location = New System.Drawing.Point(48, 120)
        Me.button3.Name = "button3"
        Me.button3.Size = New System.Drawing.Size(200, 23)
        Me.button3.TabIndex = 5
        Me.button3.Text = "Edit Balloon"
        '
        'button2
        '
        Me.button2.Location = New System.Drawing.Point(48, 72)
        Me.button2.Name = "button2"
        Me.button2.Size = New System.Drawing.Size(200, 23)
        Me.button2.TabIndex = 4
        Me.button2.Text = "Message Balloon"
        '
        'button1
        '
        Me.button1.Location = New System.Drawing.Point(48, 24)
        Me.button1.Name = "button1"
        Me.button1.Size = New System.Drawing.Size(200, 23)
        Me.button1.TabIndex = 3
        Me.button1.Text = "Hover Balloon"
        '
        'Startup
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.ClientSize = New System.Drawing.Size(292, 182)
        Me.Controls.Add(Me.button3)
        Me.Controls.Add(Me.button2)
        Me.Controls.Add(Me.button1)
        Me.Name = "Startup"
        Me.Text = "Startup"
        Me.ResumeLayout(False)

    End Sub

#End Region

    Private Sub button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button1.Click
        Dim f As New Form1
        f.Show()
    End Sub


    Private Sub button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button2.Click
        Dim f As New Form2
        f.Show()
    End Sub


    Private Sub button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button3.Click
        Dim f As New Form3
        f.Show()
    End Sub

End Class
