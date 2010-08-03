namespace PortScanner
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
			this.btnScan = new System.Windows.Forms.Button();
			this.lblIP = new System.Windows.Forms.Label();
			this.txtIP = new System.Windows.Forms.TextBox();
			this.prgScanning = new System.Windows.Forms.ProgressBar();
			this.numStart = new System.Windows.Forms.NumericUpDown();
			this.lblEnd = new System.Windows.Forms.Label();
			this.lblStart = new System.Windows.Forms.Label();
			this.numEnd = new System.Windows.Forms.NumericUpDown();
			this.txtLog = new System.Windows.Forms.TextBox();
			((System.ComponentModel.ISupportInitialize)(this.numStart)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.numEnd)).BeginInit();
			this.SuspendLayout();
			// 
			// btnScan
			// 
			this.btnScan.Location = new System.Drawing.Point(98, 60);
			this.btnScan.Name = "btnScan";
			this.btnScan.Size = new System.Drawing.Size(75, 23);
			this.btnScan.TabIndex = 0;
			this.btnScan.Text = "Start Scan";
			this.btnScan.Click += new System.EventHandler(this.btnScan_Click);
			// 
			// lblIP
			// 
			this.lblIP.AutoSize = true;
			this.lblIP.Location = new System.Drawing.Point(15, 9);
			this.lblIP.Name = "lblIP";
			this.lblIP.Size = new System.Drawing.Size(16, 13);
			this.lblIP.TabIndex = 3;
			this.lblIP.Text = "IP:";
			// 
			// txtIP
			// 
			this.txtIP.Location = new System.Drawing.Point(49, 6);
			this.txtIP.Name = "txtIP";
			this.txtIP.Size = new System.Drawing.Size(124, 20);
			this.txtIP.TabIndex = 2;
			// 
			// prgScanning
			// 
			this.prgScanning.Location = new System.Drawing.Point(208, 161);
			this.prgScanning.Name = "prgScanning";
			this.prgScanning.Size = new System.Drawing.Size(284, 18);
			this.prgScanning.Step = 1;
			this.prgScanning.TabIndex = 6;
			// 
			// numStart
			// 
			this.numStart.Location = new System.Drawing.Point(49, 34);
			this.numStart.Name = "numStart";
			this.numStart.Size = new System.Drawing.Size(50, 20);
			this.numStart.TabIndex = 7;
			// 
			// lblEnd
			// 
			this.lblEnd.AutoSize = true;
			this.lblEnd.Location = new System.Drawing.Point(105, 38);
			this.lblEnd.Name = "lblEnd";
			this.lblEnd.Size = new System.Drawing.Size(12, 13);
			this.lblEnd.TabIndex = 5;
			this.lblEnd.Text = "to";
			// 
			// lblStart
			// 
			this.lblStart.AutoSize = true;
			this.lblStart.Location = new System.Drawing.Point(14, 38);
			this.lblStart.Name = "lblStart";
			this.lblStart.Size = new System.Drawing.Size(29, 13);
			this.lblStart.TabIndex = 4;
			this.lblStart.Text = "From:";
			// 
			// numEnd
			// 
			this.numEnd.Location = new System.Drawing.Point(123, 34);
			this.numEnd.Name = "numEnd";
			this.numEnd.Size = new System.Drawing.Size(50, 20);
			this.numEnd.TabIndex = 8;
			// 
			// txtLog
			// 
			this.txtLog.Location = new System.Drawing.Point(208, 6);
			this.txtLog.Multiline = true;
			this.txtLog.Name = "txtLog";
			this.txtLog.ReadOnly = true;
			this.txtLog.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.txtLog.Size = new System.Drawing.Size(284, 149);
			this.txtLog.TabIndex = 9;
			// 
			// frmMain
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(502, 191);
			this.Controls.Add(this.txtLog);
			this.Controls.Add(this.numEnd);
			this.Controls.Add(this.numStart);
			this.Controls.Add(this.prgScanning);
			this.Controls.Add(this.lblEnd);
			this.Controls.Add(this.lblStart);
			this.Controls.Add(this.lblIP);
			this.Controls.Add(this.txtIP);
			this.Controls.Add(this.btnScan);
			this.Name = "frmMain";
			this.Text = "Port Scanner.NET";
			((System.ComponentModel.ISupportInitialize)(this.numStart)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.numEnd)).EndInit();
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.Button btnScan;
		private System.Windows.Forms.Label lblIP;
		private System.Windows.Forms.TextBox txtIP;
		private System.Windows.Forms.ProgressBar prgScanning;
		private System.Windows.Forms.NumericUpDown numStart;
		private System.Windows.Forms.Label lblEnd;
		private System.Windows.Forms.Label lblStart;
		private System.Windows.Forms.NumericUpDown numEnd;
		private System.Windows.Forms.TextBox txtLog;
	}
}

