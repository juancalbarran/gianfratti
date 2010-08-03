Public Class Form3
    Inherits System.Windows.Forms.Form

    Private m_eb As EditBalloon = New EditBalloon

#Region " Windows Form Designer generated code "

    Public Sub New()
        MyBase.New()

        Application.EnableVisualStyles()

        'This call is required by the Windows Form Designer.
        InitializeComponent()

        'Add any initialization after the InitializeComponent() call
        m_eb.Title = "FMS Edit tip Warning"
        m_eb.TitleIcon = TooltipIcon.Warning
        m_eb.Text = "This character is invalid. " + vbCrLf + "No |, ~ are allowed." + vbCrLf + "'Do Something' may or may not work correctly."
        m_eb.Parent = Me.textBox1

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
    Friend WithEvents button1 As System.Windows.Forms.Button
    Friend WithEvents label1 As System.Windows.Forms.Label
    Friend WithEvents textBox1 As System.Windows.Forms.TextBox
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.button1 = New System.Windows.Forms.Button
        Me.label1 = New System.Windows.Forms.Label
        Me.textBox1 = New System.Windows.Forms.TextBox
        Me.SuspendLayout()
        '
        'button1
        '
        Me.button1.Location = New System.Drawing.Point(128, 56)
        Me.button1.Name = "button1"
        Me.button1.Size = New System.Drawing.Size(96, 23)
        Me.button1.TabIndex = 5
        Me.button1.Text = "Do Something"
        '
        'label1
        '
        Me.label1.Location = New System.Drawing.Point(8, 8)
        Me.label1.Name = "label1"
        Me.label1.Size = New System.Drawing.Size(160, 40)
        Me.label1.TabIndex = 4
        Me.label1.Text = "Try entering invalid characters |, ~ in the textbox below ."
        '
        'textBox1
        '
        Me.textBox1.Location = New System.Drawing.Point(8, 56)
        Me.textBox1.Name = "textBox1"
        Me.textBox1.Size = New System.Drawing.Size(112, 20)
        Me.textBox1.TabIndex = 3
        Me.textBox1.Text = "textBox1"
        '
        'Form3
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.ClientSize = New System.Drawing.Size(240, 94)
        Me.Controls.Add(Me.button1)
        Me.Controls.Add(Me.label1)
        Me.Controls.Add(Me.textBox1)
        Me.Name = "Form3"
        Me.Text = "Form3"
        Me.ResumeLayout(False)

    End Sub

#End Region

    Private Sub textBox1_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles textBox1.KeyPress
        '' TODO : handle similar logic for Ctrl+C, Ctrl+V

        If (e.KeyChar = "|"c Or e.KeyChar = "~"c) Then
            m_eb.Show()
        End If

    End Sub
End Class
