namespace Palantir
{
    partial class frmRemoteDesktopMachines
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
            this.dgrRemoteDesktops = new System.Windows.Forms.DataGridView();
            this.clmnEdit = new System.Windows.Forms.DataGridViewButtonColumn();
            this.clmnDelete = new System.Windows.Forms.DataGridViewButtonColumn();
            this.clmnRemoteDesktopConnectionName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.clmnMachineName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.clmnUserName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.btnNew = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgrRemoteDesktops)).BeginInit();
            this.SuspendLayout();
            // 
            // dgrRemoteDesktops
            // 
            this.dgrRemoteDesktops.AllowUserToAddRows = false;
            this.dgrRemoteDesktops.AllowUserToDeleteRows = false;
            this.dgrRemoteDesktops.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgrRemoteDesktops.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.clmnEdit,
            this.clmnDelete,
            this.clmnRemoteDesktopConnectionName,
            this.clmnMachineName,
            this.clmnUserName});
            this.dgrRemoteDesktops.Dock = System.Windows.Forms.DockStyle.Top;
            this.dgrRemoteDesktops.Location = new System.Drawing.Point(0, 0);
            this.dgrRemoteDesktops.Name = "dgrRemoteDesktops";
            this.dgrRemoteDesktops.Size = new System.Drawing.Size(546, 351);
            this.dgrRemoteDesktops.TabIndex = 0;
            this.dgrRemoteDesktops.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgrRemoteDesktops_CellClick);
            // 
            // clmnEdit
            // 
            this.clmnEdit.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.clmnEdit.Frozen = true;
            this.clmnEdit.HeaderText = "Edit";
            this.clmnEdit.Name = "clmnEdit";
            this.clmnEdit.Text = "Edit";
            this.clmnEdit.UseColumnTextForButtonValue = true;
            // 
            // clmnDelete
            // 
            this.clmnDelete.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.clmnDelete.Frozen = true;
            this.clmnDelete.HeaderText = "Delete";
            this.clmnDelete.Name = "clmnDelete";
            this.clmnDelete.Text = "Delete";
            this.clmnDelete.UseColumnTextForButtonValue = true;
            // 
            // clmnRemoteDesktopConnectionName
            // 
            this.clmnRemoteDesktopConnectionName.DataPropertyName = "RemoteDesktopConnectionName";
            this.clmnRemoteDesktopConnectionName.Frozen = true;
            this.clmnRemoteDesktopConnectionName.HeaderText = "Connection Name";
            this.clmnRemoteDesktopConnectionName.Name = "clmnRemoteDesktopConnectionName";
            this.clmnRemoteDesktopConnectionName.ReadOnly = true;
            // 
            // clmnMachineName
            // 
            this.clmnMachineName.DataPropertyName = "MachineName";
            this.clmnMachineName.Frozen = true;
            this.clmnMachineName.HeaderText = "Machine Name";
            this.clmnMachineName.Name = "clmnMachineName";
            this.clmnMachineName.ReadOnly = true;
            // 
            // clmnUserName
            // 
            this.clmnUserName.DataPropertyName = "UserName";
            this.clmnUserName.Frozen = true;
            this.clmnUserName.HeaderText = "User Name";
            this.clmnUserName.Name = "clmnUserName";
            this.clmnUserName.ReadOnly = true;
            // 
            // btnNew
            // 
            this.btnNew.Location = new System.Drawing.Point(0, 357);
            this.btnNew.Name = "btnNew";
            this.btnNew.Size = new System.Drawing.Size(75, 23);
            this.btnNew.TabIndex = 1;
            this.btnNew.Text = "New";
            this.btnNew.UseVisualStyleBackColor = true;
            this.btnNew.Click += new System.EventHandler(this.btnNew_Click);
            // 
            // frmRemoteDesktopMachines
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(546, 381);
            this.Controls.Add(this.btnNew);
            this.Controls.Add(this.dgrRemoteDesktops);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.MaximizeBox = false;
            this.Name = "frmRemoteDesktopMachines";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Remote Desktops";
            this.Load += new System.EventHandler(this.frmRemoteDesktopMachines_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgrRemoteDesktops)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView dgrRemoteDesktops;
        private System.Windows.Forms.Button btnNew;
        private System.Windows.Forms.DataGridViewButtonColumn clmnEdit;
        private System.Windows.Forms.DataGridViewButtonColumn clmnDelete;
        private System.Windows.Forms.DataGridViewTextBoxColumn clmnRemoteDesktopConnectionName;
        private System.Windows.Forms.DataGridViewTextBoxColumn clmnMachineName;
        private System.Windows.Forms.DataGridViewTextBoxColumn clmnUserName;
    }
}