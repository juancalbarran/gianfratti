Public Class Form2
    Inherits System.Windows.Forms.Form

#Region " Windows Form Designer generated code "

    Public Sub New()
        MyBase.New()

        'This call is required by the Windows Form Designer.
        InitializeComponent()

        'Add any initialization after the InitializeComponent() call
        ' load combo
        Dim names() As String = [Enum].GetNames(GetType(FMSMessageTip.BalloonAlignment))
        For Each name As String In names
            comboBox1.Items.Add(name)
        Next
        comboBox1.SelectedItem = names(0)


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
    Friend WithEvents checkBox2 As System.Windows.Forms.CheckBox
    Friend WithEvents checkBox1 As System.Windows.Forms.CheckBox
    Friend WithEvents label1 As System.Windows.Forms.Label
    Friend WithEvents comboBox1 As System.Windows.Forms.ComboBox
    Friend WithEvents groupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents button1 As System.Windows.Forms.Button
    Friend m_mb As FMSMessageTip.MessageBalloon
    Friend WithEvents Button2 As System.Windows.Forms.Button
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.checkBox2 = New System.Windows.Forms.CheckBox
        Me.checkBox1 = New System.Windows.Forms.CheckBox
        Me.label1 = New System.Windows.Forms.Label
        Me.comboBox1 = New System.Windows.Forms.ComboBox
        Me.groupBox1 = New System.Windows.Forms.GroupBox
        Me.button1 = New System.Windows.Forms.Button
        Me.Button2 = New System.Windows.Forms.Button
        Me.SuspendLayout()
        '
        'checkBox2
        '
        Me.checkBox2.Location = New System.Drawing.Point(216, 80)
        Me.checkBox2.Name = "checkBox2"
        Me.checkBox2.TabIndex = 15
        Me.checkBox2.Text = "use abs posn"
        '
        'checkBox1
        '
        Me.checkBox1.Location = New System.Drawing.Point(216, 56)
        Me.checkBox1.Name = "checkBox1"
        Me.checkBox1.TabIndex = 14
        Me.checkBox1.Text = "center Stem"
        '
        'label1
        '
        Me.label1.Location = New System.Drawing.Point(216, 8)
        Me.label1.Name = "label1"
        Me.label1.Size = New System.Drawing.Size(106, 16)
        Me.label1.TabIndex = 13
        Me.label1.Text = "Align:"
        '
        'comboBox1
        '
        Me.comboBox1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.comboBox1.Location = New System.Drawing.Point(216, 24)
        Me.comboBox1.Name = "comboBox1"
        Me.comboBox1.Size = New System.Drawing.Size(106, 21)
        Me.comboBox1.TabIndex = 12
        '
        'groupBox1
        '
        Me.groupBox1.Location = New System.Drawing.Point(8, 8)
        Me.groupBox1.Name = "groupBox1"
        Me.groupBox1.Size = New System.Drawing.Size(180, 166)
        Me.groupBox1.TabIndex = 11
        Me.groupBox1.TabStop = False
        Me.groupBox1.Text = "groupBox1"
        '
        'button1
        '
        Me.button1.Location = New System.Drawing.Point(216, 120)
        Me.button1.Name = "button1"
        Me.button1.Size = New System.Drawing.Size(112, 23)
        Me.button1.TabIndex = 10
        Me.button1.Text = "Show Tip"
        '
        'Button2
        '
        Me.Button2.Location = New System.Drawing.Point(216, 152)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(112, 23)
        Me.Button2.TabIndex = 16
        Me.Button2.Text = "Hide Tip"
        '
        'Form2
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.ClientSize = New System.Drawing.Size(336, 182)
        Me.Controls.Add(Me.Button2)
        Me.Controls.Add(Me.checkBox2)
        Me.Controls.Add(Me.checkBox1)
        Me.Controls.Add(Me.label1)
        Me.Controls.Add(Me.comboBox1)
        Me.Controls.Add(Me.groupBox1)
        Me.Controls.Add(Me.button1)
        Me.Name = "Form2"
        Me.Text = "Form2"
        Me.ResumeLayout(False)

    End Sub

#End Region

    Private Sub button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button1.Click

        m_mb = New FMSMessageTip.MessageBalloon
        m_mb.Parent = groupBox1
        m_mb.Title = "Traders corp. Inc"
        m_mb.TitleIcon = TooltipIcon.Info

        Dim ba As FMSMessageTip.BalloonAlignment
        ba = CType([Enum].Parse(GetType(FMSMessageTip.BalloonAlignment), comboBox1.Text), FMSMessageTip.BalloonAlignment)
        m_mb.Align = ba
        m_mb.CenterStem = checkBox1.Checked
        m_mb.UseAbsolutePositioning = checkBox2.Checked
        m_mb.Show()

    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        m_mb.Dispose()
    End Sub
End Class
