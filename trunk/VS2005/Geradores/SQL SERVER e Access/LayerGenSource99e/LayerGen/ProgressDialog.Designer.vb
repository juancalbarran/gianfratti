<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class ProgressDialog
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing AndAlso components IsNot Nothing Then
            components.Dispose()
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.Label1 = New System.Windows.Forms.Label
        Me.pbProgress = New System.Windows.Forms.ProgressBar
        Me.lblTableLabel = New System.Windows.Forms.Label
        Me.lblFunctionLabel = New System.Windows.Forms.Label
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(13, 14)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(190, 13)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Please be patient. Generating Layers..."
        '
        'pbProgress
        '
        Me.pbProgress.Location = New System.Drawing.Point(56, 93)
        Me.pbProgress.Name = "pbProgress"
        Me.pbProgress.Size = New System.Drawing.Size(100, 23)
        Me.pbProgress.TabIndex = 1
        '
        'lblTableLabel
        '
        Me.lblTableLabel.Location = New System.Drawing.Point(13, 39)
        Me.lblTableLabel.Name = "lblTableLabel"
        Me.lblTableLabel.Size = New System.Drawing.Size(175, 13)
        Me.lblTableLabel.TabIndex = 2
        Me.lblTableLabel.Text = "Table:"
        '
        'lblFunctionLabel
        '
        Me.lblFunctionLabel.Location = New System.Drawing.Point(12, 64)
        Me.lblFunctionLabel.Name = "lblFunctionLabel"
        Me.lblFunctionLabel.Size = New System.Drawing.Size(155, 13)
        Me.lblFunctionLabel.TabIndex = 3
        Me.lblFunctionLabel.Text = "Function:"
        '
        'ProgressDialog
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(213, 134)
        Me.ControlBox = False
        Me.Controls.Add(Me.lblFunctionLabel)
        Me.Controls.Add(Me.lblTableLabel)
        Me.Controls.Add(Me.pbProgress)
        Me.Controls.Add(Me.Label1)
        Me.DoubleBuffered = True
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "ProgressDialog"
        Me.ShowInTaskbar = False
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
        Me.Text = "ProgressDialog"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents pbProgress As System.Windows.Forms.ProgressBar
    Friend WithEvents lblTableLabel As System.Windows.Forms.Label
    Friend WithEvents lblFunctionLabel As System.Windows.Forms.Label

End Class
