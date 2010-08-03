namespace Palantir
{
    partial class frmSettings
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
            this.gbSettings = new System.Windows.Forms.GroupBox();
            this.txtRemoteDesktopConnectionName = new System.Windows.Forms.TextBox();
            this.lblSettingName = new System.Windows.Forms.Label();
            this.uctRemoteConnectionSettings1 = new Palantir.uctRemoteConnectionSettings();
            this.btnSave = new System.Windows.Forms.Button();
            this.btnCancel = new System.Windows.Forms.Button();
            this.gbSettings.SuspendLayout();
            this.SuspendLayout();
            // 
            // gbSettings
            // 
            this.gbSettings.Controls.Add(this.txtRemoteDesktopConnectionName);
            this.gbSettings.Controls.Add(this.lblSettingName);
            this.gbSettings.Controls.Add(this.uctRemoteConnectionSettings1);
            this.gbSettings.Controls.Add(this.btnSave);
            this.gbSettings.Controls.Add(this.btnCancel);
            this.gbSettings.Dock = System.Windows.Forms.DockStyle.Fill;
            this.gbSettings.Location = new System.Drawing.Point(0, 0);
            this.gbSettings.Name = "gbSettings";
            this.gbSettings.Size = new System.Drawing.Size(294, 309);
            this.gbSettings.TabIndex = 1;
            this.gbSettings.TabStop = false;
            this.gbSettings.Text = "Settings";
            // 
            // txtRemoteDesktopConnectionName
            // 
            this.txtRemoteDesktopConnectionName.Location = new System.Drawing.Point(108, 242);
            this.txtRemoteDesktopConnectionName.Name = "txtRemoteDesktopConnectionName";
            this.txtRemoteDesktopConnectionName.Size = new System.Drawing.Size(170, 20);
            this.txtRemoteDesktopConnectionName.TabIndex = 36;
            // 
            // lblSettingName
            // 
            this.lblSettingName.AutoSize = true;
            this.lblSettingName.Location = new System.Drawing.Point(12, 245);
            this.lblSettingName.Name = "lblSettingName";
            this.lblSettingName.Size = new System.Drawing.Size(71, 13);
            this.lblSettingName.TabIndex = 37;
            this.lblSettingName.Text = "Setting Name";
            // 
            // uctRemoteConnectionSettings1
            // 
            this.uctRemoteConnectionSettings1.Location = new System.Drawing.Point(6, 15);
            this.uctRemoteConnectionSettings1.Name = "uctRemoteConnectionSettings1";
            this.uctRemoteConnectionSettings1.Size = new System.Drawing.Size(282, 227);
            this.uctRemoteConnectionSettings1.TabIndex = 11;
            // 
            // btnSave
            // 
            this.btnSave.Location = new System.Drawing.Point(122, 281);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(75, 23);
            this.btnSave.TabIndex = 9;
            this.btnSave.Text = "Save";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // btnCancel
            // 
            this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnCancel.Location = new System.Drawing.Point(203, 281);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 10;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // frmSettings
            // 
            this.AcceptButton = this.btnSave;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.btnCancel;
            this.ClientSize = new System.Drawing.Size(294, 309);
            this.Controls.Add(this.gbSettings);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.MaximizeBox = false;
            this.Name = "frmSettings";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Settings";
            this.gbSettings.ResumeLayout(false);
            this.gbSettings.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox gbSettings;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Button btnCancel;
        private uctRemoteConnectionSettings uctRemoteConnectionSettings1;
        private System.Windows.Forms.TextBox txtRemoteDesktopConnectionName;
        private System.Windows.Forms.Label lblSettingName;
    }
}