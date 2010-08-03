namespace Palantir
{
    partial class frmMain
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
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmMain));
            this.tcMain = new System.Windows.Forms.TabControl();
            this.msMain = new System.Windows.Forms.MenuStrip();
            this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.connectAllToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.disconnectAllToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.connectToToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.connectViaConsoleToToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.disconnectFromToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.settingsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.saveSettingsToAFToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.loadSettingsFromFileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.exitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.aboutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.aboutPalantirToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.subscribeForUpdatesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.cmsClose = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.closeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.msMain.SuspendLayout();
            this.cmsClose.SuspendLayout();
            this.SuspendLayout();
            // 
            // tcMain
            // 
            this.tcMain.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tcMain.Location = new System.Drawing.Point(0, 24);
            this.tcMain.Name = "tcMain";
            this.tcMain.SelectedIndex = 0;
            this.tcMain.Size = new System.Drawing.Size(1021, 553);
            this.tcMain.TabIndex = 0;
            // 
            // msMain
            // 
            this.msMain.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem,
            this.aboutToolStripMenuItem});
            this.msMain.Location = new System.Drawing.Point(0, 0);
            this.msMain.Name = "msMain";
            this.msMain.Size = new System.Drawing.Size(1021, 24);
            this.msMain.TabIndex = 1;
            this.msMain.Text = "menuStrip1";
            // 
            // fileToolStripMenuItem
            // 
            this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.connectAllToolStripMenuItem,
            this.disconnectAllToolStripMenuItem,
            this.connectToToolStripMenuItem,
            this.connectViaConsoleToToolStripMenuItem,
            this.disconnectFromToolStripMenuItem,
            this.toolStripSeparator1,
            this.settingsToolStripMenuItem,
            this.toolStripMenuItem1,
            this.toolStripSeparator2,
            this.exitToolStripMenuItem});
            this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
            this.fileToolStripMenuItem.Size = new System.Drawing.Size(35, 20);
            this.fileToolStripMenuItem.Text = "File";
            // 
            // connectAllToolStripMenuItem
            // 
            this.connectAllToolStripMenuItem.Name = "connectAllToolStripMenuItem";
            this.connectAllToolStripMenuItem.Size = new System.Drawing.Size(213, 22);
            this.connectAllToolStripMenuItem.Text = "Connect All";
            this.connectAllToolStripMenuItem.Click += new System.EventHandler(this.connectAllToolStripMenuItem_Click);
            // 
            // disconnectAllToolStripMenuItem
            // 
            this.disconnectAllToolStripMenuItem.Name = "disconnectAllToolStripMenuItem";
            this.disconnectAllToolStripMenuItem.Size = new System.Drawing.Size(213, 22);
            this.disconnectAllToolStripMenuItem.Text = "Disconnect All";
            this.disconnectAllToolStripMenuItem.Click += new System.EventHandler(this.disconnectAllToolStripMenuItem_Click);
            // 
            // connectToToolStripMenuItem
            // 
            this.connectToToolStripMenuItem.Name = "connectToToolStripMenuItem";
            this.connectToToolStripMenuItem.Size = new System.Drawing.Size(213, 22);
            this.connectToToolStripMenuItem.Text = "Connect To...";
            // 
            // connectViaConsoleToToolStripMenuItem
            // 
            this.connectViaConsoleToToolStripMenuItem.Name = "connectViaConsoleToToolStripMenuItem";
            this.connectViaConsoleToToolStripMenuItem.Size = new System.Drawing.Size(213, 22);
            this.connectViaConsoleToToolStripMenuItem.Text = "Connect via Console To ...";
            // 
            // disconnectFromToolStripMenuItem
            // 
            this.disconnectFromToolStripMenuItem.Name = "disconnectFromToolStripMenuItem";
            this.disconnectFromToolStripMenuItem.Size = new System.Drawing.Size(213, 22);
            this.disconnectFromToolStripMenuItem.Text = "Disconnect From...";
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(210, 6);
            // 
            // settingsToolStripMenuItem
            // 
            this.settingsToolStripMenuItem.Name = "settingsToolStripMenuItem";
            this.settingsToolStripMenuItem.Size = new System.Drawing.Size(213, 22);
            this.settingsToolStripMenuItem.Text = "Settings";
            this.settingsToolStripMenuItem.Click += new System.EventHandler(this.settingsToolStripMenuItem_Click);
            // 
            // toolStripMenuItem1
            // 
            this.toolStripMenuItem1.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.saveSettingsToAFToolStripMenuItem,
            this.loadSettingsFromFileToolStripMenuItem});
            this.toolStripMenuItem1.Name = "toolStripMenuItem1";
            this.toolStripMenuItem1.Size = new System.Drawing.Size(213, 22);
            this.toolStripMenuItem1.Text = "Import && Export";
            // 
            // saveSettingsToAFToolStripMenuItem
            // 
            this.saveSettingsToAFToolStripMenuItem.Name = "saveSettingsToAFToolStripMenuItem";
            this.saveSettingsToAFToolStripMenuItem.Size = new System.Drawing.Size(205, 22);
            this.saveSettingsToAFToolStripMenuItem.Text = "Export Settings To File";
            this.saveSettingsToAFToolStripMenuItem.Click += new System.EventHandler(this.saveSettingsToAFToolStripMenuItem_Click);
            // 
            // loadSettingsFromFileToolStripMenuItem
            // 
            this.loadSettingsFromFileToolStripMenuItem.Name = "loadSettingsFromFileToolStripMenuItem";
            this.loadSettingsFromFileToolStripMenuItem.Size = new System.Drawing.Size(205, 22);
            this.loadSettingsFromFileToolStripMenuItem.Text = "Import Settings From File";
            this.loadSettingsFromFileToolStripMenuItem.Click += new System.EventHandler(this.loadSettingsFromFileToolStripMenuItem_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(210, 6);
            // 
            // exitToolStripMenuItem
            // 
            this.exitToolStripMenuItem.Name = "exitToolStripMenuItem";
            this.exitToolStripMenuItem.Size = new System.Drawing.Size(213, 22);
            this.exitToolStripMenuItem.Text = "Exit";
            this.exitToolStripMenuItem.Click += new System.EventHandler(this.exitToolStripMenuItem_Click);
            // 
            // aboutToolStripMenuItem
            // 
            this.aboutToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.aboutPalantirToolStripMenuItem,
            this.subscribeForUpdatesToolStripMenuItem});
            this.aboutToolStripMenuItem.Name = "aboutToolStripMenuItem";
            this.aboutToolStripMenuItem.Size = new System.Drawing.Size(48, 20);
            this.aboutToolStripMenuItem.Text = "About";
            // 
            // aboutPalantirToolStripMenuItem
            // 
            this.aboutPalantirToolStripMenuItem.Name = "aboutPalantirToolStripMenuItem";
            this.aboutPalantirToolStripMenuItem.Size = new System.Drawing.Size(193, 22);
            this.aboutPalantirToolStripMenuItem.Text = "About Palantir";
            this.aboutPalantirToolStripMenuItem.Click += new System.EventHandler(this.aboutPalantirToolStripMenuItem_Click);
            // 
            // subscribeForUpdatesToolStripMenuItem
            // 
            this.subscribeForUpdatesToolStripMenuItem.Name = "subscribeForUpdatesToolStripMenuItem";
            this.subscribeForUpdatesToolStripMenuItem.Size = new System.Drawing.Size(193, 22);
            this.subscribeForUpdatesToolStripMenuItem.Text = "Subscribe For Updates";
            this.subscribeForUpdatesToolStripMenuItem.Click += new System.EventHandler(this.subscribeForUpdatesToolStripMenuItem_Click);
            // 
            // cmsClose
            // 
            this.cmsClose.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.closeToolStripMenuItem});
            this.cmsClose.Name = "cmsClose";
            this.cmsClose.Size = new System.Drawing.Size(112, 26);
            // 
            // closeToolStripMenuItem
            // 
            this.closeToolStripMenuItem.Name = "closeToolStripMenuItem";
            this.closeToolStripMenuItem.Size = new System.Drawing.Size(111, 22);
            this.closeToolStripMenuItem.Text = "Close";
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1021, 577);
            this.Controls.Add(this.tcMain);
            this.Controls.Add(this.msMain);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MainMenuStrip = this.msMain;
            this.Name = "frmMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Palantir";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.frmMain_Load);
            this.msMain.ResumeLayout(false);
            this.msMain.PerformLayout();
            this.cmsClose.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TabControl tcMain;
        private System.Windows.Forms.MenuStrip msMain;
        private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem connectAllToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem disconnectAllToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem connectToToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem settingsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem exitToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem disconnectFromToolStripMenuItem;
        private System.Windows.Forms.ContextMenuStrip cmsClose;
        private System.Windows.Forms.ToolStripMenuItem closeToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem aboutToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem aboutPalantirToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem subscribeForUpdatesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem toolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem saveSettingsToAFToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripMenuItem loadSettingsFromFileToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripMenuItem connectViaConsoleToToolStripMenuItem;

    }
}

