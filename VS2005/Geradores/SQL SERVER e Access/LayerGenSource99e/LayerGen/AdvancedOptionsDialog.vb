Imports Microsoft.Win32

Public Class AdvancedOptionsDialog
    Private m_WasCancelled As Boolean
    Private m_BusinessName As String
    Private m_DataName As String
    Private m_GenerateSQLFile As Boolean
    Private m_AutoInsert As Boolean
    Private m_DataEncryption As Boolean
    Private m_WasWarned As Boolean
    Private m_EncryptionKey As String
    Private m_Sorting As Boolean

    Dim dn As String
    Dim bn As String

    Public ReadOnly Property Sorting() As Boolean
        Get
            Return m_Sorting
        End Get
    End Property

    Public ReadOnly Property EncryptionKey() As String
        Get
            Return m_EncryptionKey
        End Get
    End Property

    Public ReadOnly Property DataEncryption() As Boolean
        Get
            Return m_DataEncryption
        End Get
    End Property

    Public ReadOnly Property AutoInsert() As Boolean
        Get
            Return m_AutoInsert
        End Get
    End Property

    Public ReadOnly Property GenerateSQLFile() As Boolean
        Get
            Return m_GenerateSQLFile
        End Get
    End Property

    Public ReadOnly Property DataName() As String
        Get
            Return m_DataName
        End Get
    End Property

    Public ReadOnly Property BusinessName() As String
        Get
            Return m_BusinessName
        End Get
    End Property

    Public ReadOnly Property WasCancelled() As Boolean
        Get
            Return m_WasCancelled
        End Get
    End Property

    Private Sub AdvancedOptionsDialog_FormClosed(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles Me.FormClosed
        m_WasCancelled = True

    End Sub

    Private Sub AdvancedOptionsDialog_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim regKey As RegistryKey
        Dim regSubKey As RegistryKey

        regKey = Registry.CurrentUser
        regSubKey = regKey.CreateSubKey("Software\BrassTechnologies\LayerGen")

        dn = regSubKey.GetValue("DataName")
        bn = regSubKey.GetValue("BusinessName")

        Me.chkGenerateSQLFile.Checked = regSubKey.GetValue("GenerateSQL")
        Me.chkAutoInsert.Checked = regSubKey.GetValue("AutoInsert")
        Me.chkSorting.Checked = regSubKey.GetValue("Sort")

        If dn = "" Then dn = "DataLayer"
        If bn = "" Then bn = "BusinessLayer"
        Me.txtBusinessName.Text = bn
        Me.txtDataName.Text = dn
        m_WasCancelled = False
        regSubKey.Close()
        regKey.Close()

        If Not Me.chkGenerateSQLFile.Checked Then
            Me.chkGenerateSQLFile.Enabled = False
            Me.chkGenerateSQLFile.Checked = True
        End If

        m_WasWarned = False
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        m_WasCancelled = True
        'CopyData()
        Me.Hide()
    End Sub

    Private Sub btnOk_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnOk.Click
        Dim regKey As RegistryKey

        If Me.chkDataEncryption.Checked And Me.txtEncryptionKey.Text.Trim() = "" Then
            MessageBox.Show("You must specify an encryption key!", "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error)
            Exit Sub
        End If

        regKey = Registry.CurrentUser.CreateSubKey("Software\BrassTechnologies\LayerGen")
        regKey.SetValue("DataName", Me.txtDataName.Text.Trim())
        regKey.SetValue("BusinessName", Me.txtBusinessName.Text.Trim())
        regKey.SetValue("AutoInsert", Me.chkAutoInsert.Checked)
        regKey.SetValue("GenerateSQL", Me.chkGenerateSQLFile.Checked)
        regKey.SetValue("Sort", Me.chkSorting.Checked)
        regKey.Close()

        m_WasCancelled = False
        CopyData()
        Me.Hide()
    End Sub

    Private Sub CopyData()
        Me.m_DataName = Me.txtDataName.Text
        Me.m_BusinessName = Me.txtBusinessName.Text
        Me.m_GenerateSQLFile = Me.chkGenerateSQLFile.Checked
        Me.m_AutoInsert = Me.chkAutoInsert.Checked
        Me.m_DataEncryption = Me.chkDataEncryption.Checked
        Me.m_EncryptionKey = Me.txtEncryptionKey.Text
        Me.m_Sorting = Me.chkSorting.Checked
    End Sub

    Private Sub chkAutoInsert_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkAutoInsert.CheckedChanged
        If Me.chkAutoInsert.Checked Then
            Me.chkGenerateSQLFile.Enabled = True
        Else
            Me.chkGenerateSQLFile.Enabled = False
            Me.chkGenerateSQLFile.Checked = True
        End If
    End Sub

    Private Sub chkDataEncryption_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkDataEncryption.CheckedChanged
        If Me.chkDataEncryption.Checked And Me.m_WasWarned = False Then
            Dim dr As DialogResult

            dr = MessageBox.Show("Enabling data encryption may overflow maximum allowed text field lengths. " + Chr(13) + "Are you sure you want to enable data encryption?", "Warning: Data Encryption", MessageBoxButtons.YesNo, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button2)
            Me.m_WasWarned = True
            If dr = Windows.Forms.DialogResult.No Then
                Me.chkDataEncryption.Checked = False
                Exit Sub
            End If
        End If

        If Me.chkDataEncryption.Checked Then
            Me.lblEncryptionKeyLabel.Enabled = True
            Me.lblEncryptionKeyLabel.ForeColor = Color.FromArgb(0, 0, 0)
            Me.txtEncryptionKey.Enabled = True
        Else
            Me.lblEncryptionKeyLabel.Enabled = False
            Me.lblEncryptionKeyLabel.ForeColor = Color.FromArgb(160, 160, 160)
            Me.txtEncryptionKey.Enabled = False
        End If
    End Sub
End Class