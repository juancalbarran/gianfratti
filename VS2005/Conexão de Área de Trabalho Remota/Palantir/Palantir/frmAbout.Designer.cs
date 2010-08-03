namespace Palantir
{
    partial class frmAbout
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmAbout));
            this.lnk = new System.Windows.Forms.LinkLabel();
            this.lblThanks = new System.Windows.Forms.Label();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.label1 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // lnk
            // 
            this.lnk.ActiveLinkColor = System.Drawing.Color.FromArgb(((int)(((byte)(175)))), ((int)(((byte)(117)))), ((int)(((byte)(105)))));
            this.lnk.AutoSize = true;
            this.lnk.BackColor = System.Drawing.Color.Transparent;
            this.lnk.Font = new System.Drawing.Font("Arial", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.lnk.LinkColor = System.Drawing.Color.FromArgb(((int)(((byte)(175)))), ((int)(((byte)(117)))), ((int)(((byte)(105)))));
            this.lnk.Location = new System.Drawing.Point(116, 126);
            this.lnk.Name = "lnk";
            this.lnk.Size = new System.Drawing.Size(171, 14);
            this.lnk.TabIndex = 0;
            this.lnk.TabStop = true;
            this.lnk.Text = "http://www.isilorhanel.net/palantir";
            this.lnk.VisitedLinkColor = System.Drawing.Color.FromArgb(((int)(((byte)(175)))), ((int)(((byte)(117)))), ((int)(((byte)(105)))));
            this.lnk.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.lnk_LinkClicked);
            // 
            // lblThanks
            // 
            this.lblThanks.AutoSize = true;
            this.lblThanks.BackColor = System.Drawing.Color.Transparent;
            this.lblThanks.Font = new System.Drawing.Font("Arial", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.lblThanks.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(175)))), ((int)(((byte)(117)))), ((int)(((byte)(105)))));
            this.lblThanks.Location = new System.Drawing.Point(109, 32);
            this.lblThanks.Name = "lblThanks";
            this.lblThanks.Size = new System.Drawing.Size(0, 14);
            this.lblThanks.TabIndex = 1;
            this.lblThanks.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.lblThanks.Visible = false;
            this.lblThanks.Click += new System.EventHandler(this.lblThanks_Click);
            // 
            // timer1
            // 
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.Color.Transparent;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.label1.Location = new System.Drawing.Point(3, -1);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(294, 26);
            this.label1.TabIndex = 2;
            this.label1.Text = "                                               ";
            // 
            // frmAbout
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("$this.BackgroundImage")));
            this.ClientSize = new System.Drawing.Size(299, 165);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.lblThanks);
            this.Controls.Add(this.lnk);
            this.DoubleBuffered = true;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.KeyPreview = true;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frmAbout";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Palantir";
            this.Click += new System.EventHandler(this.frmAbout_Click);
            this.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.frmAbout_KeyPress);
            this.Load += new System.EventHandler(this.frmAbout_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.LinkLabel lnk;
        private System.Windows.Forms.Label lblThanks;
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.Label label1;
    }
}