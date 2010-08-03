namespace Palantir
{
    partial class frmNewRemoteDesktopConnection
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lblSaveSettings = new System.Windows.Forms.Label();
            this.chkSaveSettings = new System.Windows.Forms.CheckBox();
            this.btnConnect = new System.Windows.Forms.Button();
            this.txtRemoteDesktopConnectionName = new System.Windows.Forms.TextBox();
            this.lblSettingName = new System.Windows.Forms.Label();
            this.btnCancel = new System.Windows.Forms.Button();
            this.uctRemoteConnectionSettings1 = new Palantir.uctRemoteConnectionSettings();
            this.SuspendLayout();
            // 
            // lblSaveSettings
            // 
            this.lblSaveSettings.AutoSize = true;
            this.lblSaveSettings.Location = new System.Drawing.Point(9, 245);
            this.lblSaveSettings.Name = "lblSaveSettings";
            this.lblSaveSettings.Size = new System.Drawing.Size(73, 13);
            this.lblSaveSettings.TabIndex = 1;
            this.lblSaveSettings.Text = "Save Settings";
            // 
            // chkSaveSettings
            // 
            this.chkSaveSettings.AutoSize = true;
            this.chkSaveSettings.Location = new System.Drawing.Point(105, 244);
            this.chkSaveSettings.Name = "chkSaveSettings";
            this.chkSaveSettings.Size = new System.Drawing.Size(15, 14);
            this.chkSaveSettings.TabIndex = 2;
            this.chkSaveSettings.UseVisualStyleBackColor = true;
            this.chkSaveSettings.CheckedChanged += new System.EventHandler(this.chkSaveSettings_CheckedChanged);
            // 
            // btnConnect
            // 
            this.btnConnect.Location = new System.Drawing.Point(120, 300);
            this.btnConnect.Name = "btnConnect";
            this.btnConnect.Size = new System.Drawing.Size(75, 23);
            this.btnConnect.TabIndex = 3;
            this.btnConnect.Text = "Connect";
            this.btnConnect.UseVisualStyleBackColor = true;
            this.btnConnect.Click += new System.EventHandler(this.btnConnect_Click);
            // 
            // txtRemoteDesktopConnectionName
            // 
            this.txtRemoteDesktopConnectionName.Enabled = false;
            this.txtRemoteDesktopConnectionName.Location = new System.Drawing.Point(105, 264);
            this.txtRemoteDesktopConnectionName.Name = "txtRemoteDesktopConnectionName";
            this.txtRemoteDesktopConnectionName.Size = new System.Drawing.Size(170, 20);
            this.txtRemoteDesktopConnectionName.TabIndex = 38;
            // 
            // lblSettingName
            // 
            this.lblSettingName.AutoSize = true;
            this.lblSettingName.Location = new System.Drawing.Point(9, 267);
            this.lblSettingName.Name = "lblSettingName";
            this.lblSettingName.Size = new System.Drawing.Size(71, 13);
            this.lblSettingName.TabIndex = 39;
            this.lblSettingName.Text = "Setting Name";
            // 
            // btnCancel
            // 
            this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnCancel.Location = new System.Drawing.Point(200, 300);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 40;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // uctRemoteConnectionSettings1
            // 
            this.uctRemoteConnectionSettings1.Location = new System.Drawing.Point(3, 3);
            this.uctRemoteConnectionSettings1.Name = "uctRemoteConnectionSettings1";
            this.uctRemoteConnectionSettings1.Size = new System.Drawing.Size(282, 228);
            this.uctRemoteConnectionSettings1.TabIndex = 0;
            // 
            // frmNewRemoteDesktopConnection
            // 
            this.AcceptButton = this.btnConnect;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.btnCancel;
            this.ClientSize = new System.Drawing.Size(292, 335);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.txtRemoteDesktopConnectionName);
            this.Controls.Add(this.lblSettingName);
            this.Controls.Add(this.btnConnect);
            this.Controls.Add(this.chkSaveSettings);
            this.Controls.Add(this.lblSaveSettings);
            this.Controls.Add(this.uctRemoteConnectionSettings1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.MaximizeBox = false;
            this.Name = "frmNewRemoteDesktopConnection";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "New Remote Desktop Connection";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private uctRemoteConnectionSettings uctRemoteConnectionSettings1;
        private System.Windows.Forms.Label lblSaveSettings;
        private System.Windows.Forms.CheckBox chkSaveSettings;
        private System.Windows.Forms.Button btnConnect;
        private System.Windows.Forms.TextBox txtRemoteDesktopConnectionName;
        private System.Windows.Forms.Label lblSettingName;
        private System.Windows.Forms.Button btnCancel;
    }
}