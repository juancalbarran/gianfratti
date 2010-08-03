<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class TableSelector
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(TableSelector))
        Me.clbTables = New System.Windows.Forms.CheckedListBox
        Me.btnSelectAll = New System.Windows.Forms.Button
        Me.btnUnselectAll = New System.Windows.Forms.Button
        Me.lblInstructions = New System.Windows.Forms.Label
        Me.btnOk = New System.Windows.Forms.Button
        Me.btnCancel = New System.Windows.Forms.Button
        Me.btnDependencies = New System.Windows.Forms.Button
        Me.btnSelectDependents = New System.Windows.Forms.Button
        Me.SuspendLayout()
        '
        'clbTables
        '
        Me.clbTables.CheckOnClick = True
        Me.clbTables.FormattingEnabled = True
        Me.clbTables.Location = New System.Drawing.Point(15, 25)
        Me.clbTables.Name = "clbTables"
        Me.clbTables.Size = New System.Drawing.Size(167, 139)
        Me.clbTables.TabIndex = 0
        Me.clbTables.ThreeDCheckBoxes = True
        '
        'btnSelectAll
        '
        Me.btnSelectAll.Location = New System.Drawing.Point(188, 25)
        Me.btnSelectAll.Name = "btnSelectAll"
        Me.btnSelectAll.Size = New System.Drawing.Size(114, 23)
        Me.btnSelectAll.TabIndex = 1
        Me.btnSelectAll.Text = "Select &All"
        Me.btnSelectAll.UseVisualStyleBackColor = True
        '
        'btnUnselectAll
        '
        Me.btnUnselectAll.Location = New System.Drawing.Point(188, 54)
        Me.btnUnselectAll.Name = "btnUnselectAll"
        Me.btnUnselectAll.Size = New System.Drawing.Size(114, 23)
        Me.btnUnselectAll.TabIndex = 2
        Me.btnUnselectAll.Text = "&Unselect All"
        Me.btnUnselectAll.UseVisualStyleBackColor = True
        '
        'lblInstructions
        '
        Me.lblInstructions.AutoSize = True
        Me.lblInstructions.Location = New System.Drawing.Point(12, 9)
        Me.lblInstructions.Name = "lblInstructions"
        Me.lblInstructions.Size = New System.Drawing.Size(230, 13)
        Me.lblInstructions.TabIndex = 3
        Me.lblInstructions.Text = "Select which tables layers will be generated for:"
        '
        'btnOk
        '
        Me.btnOk.Location = New System.Drawing.Point(15, 170)
        Me.btnOk.Name = "btnOk"
        Me.btnOk.Size = New System.Drawing.Size(287, 23)
        Me.btnOk.TabIndex = 4
        Me.btnOk.Text = "&OK"
        Me.btnOk.UseVisualStyleBackColor = True
        '
        'btnCancel
        '
        Me.btnCancel.Location = New System.Drawing.Point(188, 141)
        Me.btnCancel.Name = "btnCancel"
        Me.btnCancel.Size = New System.Drawing.Size(114, 23)
        Me.btnCancel.TabIndex = 5
        Me.btnCancel.Text = "&Cancel"
        Me.btnCancel.UseVisualStyleBackColor = True
        '
        'btnDependencies
        '
        Me.btnDependencies.Location = New System.Drawing.Point(189, 112)
        Me.btnDependencies.Name = "btnDependencies"
        Me.btnDependencies.Size = New System.Drawing.Size(113, 23)
        Me.btnDependencies.TabIndex = 6
        Me.btnDependencies.Text = "Dependencies..."
        Me.btnDependencies.UseVisualStyleBackColor = True
        Me.btnDependencies.Visible = False
        '
        'btnSelectDependents
        '
        Me.btnSelectDependents.Location = New System.Drawing.Point(188, 83)
        Me.btnSelectDependents.Name = "btnSelectDependents"
        Me.btnSelectDependents.Size = New System.Drawing.Size(114, 23)
        Me.btnSelectDependents.TabIndex = 7
        Me.btnSelectDependents.Text = "Select Dependents"
        Me.btnSelectDependents.UseVisualStyleBackColor = True
        '
        'TableSelector
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(314, 207)
        Me.Controls.Add(Me.btnSelectDependents)
        Me.Controls.Add(Me.btnDependencies)
        Me.Controls.Add(Me.btnCancel)
        Me.Controls.Add(Me.btnOk)
        Me.Controls.Add(Me.lblInstructions)
        Me.Controls.Add(Me.btnUnselectAll)
        Me.Controls.Add(Me.btnSelectAll)
        Me.Controls.Add(Me.clbTables)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "TableSelector"
        Me.ShowInTaskbar = False
        Me.Text = "Table Selection"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents clbTables As System.Windows.Forms.CheckedListBox
    Friend WithEvents btnSelectAll As System.Windows.Forms.Button
    Friend WithEvents btnUnselectAll As System.Windows.Forms.Button
    Friend WithEvents lblInstructions As System.Windows.Forms.Label
    Friend WithEvents btnOk As System.Windows.Forms.Button
    Friend WithEvents btnCancel As System.Windows.Forms.Button
    Friend WithEvents btnDependencies As System.Windows.Forms.Button
    Friend WithEvents btnSelectDependents As System.Windows.Forms.Button
End Class
