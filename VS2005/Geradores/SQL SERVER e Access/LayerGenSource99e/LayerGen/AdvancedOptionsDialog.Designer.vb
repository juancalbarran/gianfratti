<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class AdvancedOptionsDialog
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(AdvancedOptionsDialog))
        Me.txtBusinessName = New System.Windows.Forms.TextBox
        Me.lblBusinessName = New System.Windows.Forms.Label
        Me.lblDataName = New System.Windows.Forms.Label
        Me.txtDataName = New System.Windows.Forms.TextBox
        Me.btnOk = New System.Windows.Forms.Button
        Me.btnCancel = New System.Windows.Forms.Button
        Me.chkAutoInsert = New System.Windows.Forms.CheckBox
        Me.chkGenerateSQLFile = New System.Windows.Forms.CheckBox
        Me.chkDataEncryption = New System.Windows.Forms.CheckBox
        Me.lblEncryptionKeyLabel = New System.Windows.Forms.Label
        Me.txtEncryptionKey = New System.Windows.Forms.TextBox
        Me.chkSorting = New System.Windows.Forms.CheckBox
        Me.SuspendLayout()
        '
        'txtBusinessName
        '
        Me.txtBusinessName.Location = New System.Drawing.Point(130, 18)
        Me.txtBusinessName.Name = "txtBusinessName"
        Me.txtBusinessName.Size = New System.Drawing.Size(137, 20)
        Me.txtBusinessName.TabIndex = 0
        '
        'lblBusinessName
        '
        Me.lblBusinessName.AutoSize = True
        Me.lblBusinessName.Location = New System.Drawing.Point(12, 21)
        Me.lblBusinessName.Name = "lblBusinessName"
        Me.lblBusinessName.Size = New System.Drawing.Size(112, 13)
        Me.lblBusinessName.TabIndex = 1
        Me.lblBusinessName.Text = "Business Layer Name:"
        '
        'lblDataName
        '
        Me.lblDataName.AutoSize = True
        Me.lblDataName.Location = New System.Drawing.Point(31, 44)
        Me.lblDataName.Name = "lblDataName"
        Me.lblDataName.Size = New System.Drawing.Size(93, 13)
        Me.lblDataName.TabIndex = 2
        Me.lblDataName.Text = "Data Layer Name:"
        '
        'txtDataName
        '
        Me.txtDataName.Location = New System.Drawing.Point(130, 44)
        Me.txtDataName.Name = "txtDataName"
        Me.txtDataName.Size = New System.Drawing.Size(137, 20)
        Me.txtDataName.TabIndex = 3
        '
        'btnOk
        '
        Me.btnOk.Location = New System.Drawing.Point(13, 193)
        Me.btnOk.Name = "btnOk"
        Me.btnOk.Size = New System.Drawing.Size(75, 23)
        Me.btnOk.TabIndex = 6
        Me.btnOk.Text = "&OK"
        Me.btnOk.UseVisualStyleBackColor = True
        '
        'btnCancel
        '
        Me.btnCancel.Location = New System.Drawing.Point(193, 193)
        Me.btnCancel.Name = "btnCancel"
        Me.btnCancel.Size = New System.Drawing.Size(75, 23)
        Me.btnCancel.TabIndex = 7
        Me.btnCancel.Text = "&Cancel"
        Me.btnCancel.UseVisualStyleBackColor = True
        '
        'chkAutoInsert
        '
        Me.chkAutoInsert.AutoSize = True
        Me.chkAutoInsert.Location = New System.Drawing.Point(59, 99)
        Me.chkAutoInsert.Name = "chkAutoInsert"
        Me.chkAutoInsert.Size = New System.Drawing.Size(208, 17)
        Me.chkAutoInsert.TabIndex = 4
        Me.chkAutoInsert.Text = "Automatically Insert Stored Procedures"
        Me.chkAutoInsert.UseVisualStyleBackColor = True
        '
        'chkGenerateSQLFile
        '
        Me.chkGenerateSQLFile.AutoSize = True
        Me.chkGenerateSQLFile.Location = New System.Drawing.Point(59, 122)
        Me.chkGenerateSQLFile.Name = "chkGenerateSQLFile"
        Me.chkGenerateSQLFile.Size = New System.Drawing.Size(113, 17)
        Me.chkGenerateSQLFile.TabIndex = 5
        Me.chkGenerateSQLFile.Text = "Generate SQL File"
        Me.chkGenerateSQLFile.UseVisualStyleBackColor = True
        '
        'chkDataEncryption
        '
        Me.chkDataEncryption.AutoSize = True
        Me.chkDataEncryption.Location = New System.Drawing.Point(59, 146)
        Me.chkDataEncryption.Name = "chkDataEncryption"
        Me.chkDataEncryption.Size = New System.Drawing.Size(124, 17)
        Me.chkDataEncryption.TabIndex = 8
        Me.chkDataEncryption.Text = "Use Data Encryption"
        Me.chkDataEncryption.UseVisualStyleBackColor = True
        '
        'lblEncryptionKeyLabel
        '
        Me.lblEncryptionKeyLabel.AutoSize = True
        Me.lblEncryptionKeyLabel.Enabled = False
        Me.lblEncryptionKeyLabel.ForeColor = System.Drawing.Color.FromArgb(CType(CType(160, Byte), Integer), CType(CType(160, Byte), Integer), CType(CType(160, Byte), Integer))
        Me.lblEncryptionKeyLabel.Location = New System.Drawing.Point(80, 170)
        Me.lblEncryptionKeyLabel.Name = "lblEncryptionKeyLabel"
        Me.lblEncryptionKeyLabel.Size = New System.Drawing.Size(81, 13)
        Me.lblEncryptionKeyLabel.TabIndex = 9
        Me.lblEncryptionKeyLabel.Text = "Encryption Key:"
        '
        'txtEncryptionKey
        '
        Me.txtEncryptionKey.Enabled = False
        Me.txtEncryptionKey.Location = New System.Drawing.Point(167, 167)
        Me.txtEncryptionKey.Name = "txtEncryptionKey"
        Me.txtEncryptionKey.Size = New System.Drawing.Size(100, 20)
        Me.txtEncryptionKey.TabIndex = 10
        '
        'chkSorting
        '
        Me.chkSorting.AutoSize = True
        Me.chkSorting.Checked = True
        Me.chkSorting.CheckState = System.Windows.Forms.CheckState.Checked
        Me.chkSorting.Location = New System.Drawing.Point(59, 76)
        Me.chkSorting.Name = "chkSorting"
        Me.chkSorting.Size = New System.Drawing.Size(95, 17)
        Me.chkSorting.TabIndex = 11
        Me.chkSorting.Text = "Enable Sorting"
        Me.chkSorting.UseVisualStyleBackColor = True
        '
        'AdvancedOptionsDialog
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(280, 229)
        Me.Controls.Add(Me.chkSorting)
        Me.Controls.Add(Me.txtEncryptionKey)
        Me.Controls.Add(Me.lblEncryptionKeyLabel)
        Me.Controls.Add(Me.chkDataEncryption)
        Me.Controls.Add(Me.chkGenerateSQLFile)
        Me.Controls.Add(Me.chkAutoInsert)
        Me.Controls.Add(Me.btnCancel)
        Me.Controls.Add(Me.btnOk)
        Me.Controls.Add(Me.txtDataName)
        Me.Controls.Add(Me.lblDataName)
        Me.Controls.Add(Me.lblBusinessName)
        Me.Controls.Add(Me.txtBusinessName)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "AdvancedOptionsDialog"
        Me.ShowInTaskbar = False
        Me.Text = "AdvancedOptionsDialog"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents txtBusinessName As System.Windows.Forms.TextBox
    Friend WithEvents lblBusinessName As System.Windows.Forms.Label
    Friend WithEvents lblDataName As System.Windows.Forms.Label
    Friend WithEvents txtDataName As System.Windows.Forms.TextBox
    Friend WithEvents btnOk As System.Windows.Forms.Button
    Friend WithEvents btnCancel As System.Windows.Forms.Button
    Friend WithEvents chkAutoInsert As System.Windows.Forms.CheckBox
    Friend WithEvents chkGenerateSQLFile As System.Windows.Forms.CheckBox
    Friend WithEvents chkDataEncryption As System.Windows.Forms.CheckBox
    Friend WithEvents lblEncryptionKeyLabel As System.Windows.Forms.Label
    Friend WithEvents txtEncryptionKey As System.Windows.Forms.TextBox
    Friend WithEvents chkSorting As System.Windows.Forms.CheckBox
End Class
