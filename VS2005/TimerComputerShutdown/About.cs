using System;
using System.Collections;
using System.ComponentModel;
using System.Drawing;
using System.Windows.Forms;

namespace TimerComputerShutdown
{
	/// <summary>
	/// Summary description for About.
	/// </summary>
	public class About : System.Windows.Forms.Form
	{
		private System.Windows.Forms.PictureBox pictureBox;
		private System.Windows.Forms.Label labelVSNET;
		private System.Windows.Forms.Label labelStevePuri;
		private System.Windows.Forms.Label labelAllRightsReserved;
		private System.Windows.Forms.LinkLabel linkLabelEmail;
		private System.Windows.Forms.Button buttonOK;
		private System.Windows.Forms.Label labelTimerComputerShutdown;
		private System.Windows.Forms.Panel panel;
		
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public About()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if(components != null)
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(About));
            this.pictureBox = new System.Windows.Forms.PictureBox();
            this.labelTimerComputerShutdown = new System.Windows.Forms.Label();
            this.labelVSNET = new System.Windows.Forms.Label();
            this.labelStevePuri = new System.Windows.Forms.Label();
            this.labelAllRightsReserved = new System.Windows.Forms.Label();
            this.linkLabelEmail = new System.Windows.Forms.LinkLabel();
            this.buttonOK = new System.Windows.Forms.Button();
            this.panel = new System.Windows.Forms.Panel();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox)).BeginInit();
            this.panel.SuspendLayout();
            this.SuspendLayout();
            // 
            // pictureBox
            // 
            this.pictureBox.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox.Image")));
            this.pictureBox.Location = new System.Drawing.Point(8, 8);
            this.pictureBox.Name = "pictureBox";
            this.pictureBox.Size = new System.Drawing.Size(32, 40);
            this.pictureBox.TabIndex = 0;
            this.pictureBox.TabStop = false;
            // 
            // labelTimerComputerShutdown
            // 
            this.labelTimerComputerShutdown.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelTimerComputerShutdown.Location = new System.Drawing.Point(48, 8);
            this.labelTimerComputerShutdown.Name = "labelTimerComputerShutdown";
            this.labelTimerComputerShutdown.Size = new System.Drawing.Size(160, 16);
            this.labelTimerComputerShutdown.TabIndex = 1;
            this.labelTimerComputerShutdown.Text = "Timer Computer Shutdown.";
            // 
            // labelVSNET
            // 
            this.labelVSNET.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelVSNET.Location = new System.Drawing.Point(48, 24);
            this.labelVSNET.Name = "labelVSNET";
            this.labelVSNET.Size = new System.Drawing.Size(160, 16);
            this.labelVSNET.TabIndex = 2;
            this.labelVSNET.Text = "Microsoft Visual C# .NET";
            // 
            // labelStevePuri
            // 
            this.labelStevePuri.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelStevePuri.Location = new System.Drawing.Point(48, 48);
            this.labelStevePuri.Name = "labelStevePuri";
            this.labelStevePuri.Size = new System.Drawing.Size(160, 16);
            this.labelStevePuri.TabIndex = 3;
            this.labelStevePuri.Text = "Copyright © Fabrizio Gianfratti.";
            // 
            // labelAllRightsReserved
            // 
            this.labelAllRightsReserved.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelAllRightsReserved.Location = new System.Drawing.Point(48, 64);
            this.labelAllRightsReserved.Name = "labelAllRightsReserved";
            this.labelAllRightsReserved.Size = new System.Drawing.Size(160, 16);
            this.labelAllRightsReserved.TabIndex = 12;
            this.labelAllRightsReserved.Text = "Todos os direitos reservados";
            // 
            // linkLabelEmail
            // 
            this.linkLabelEmail.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.linkLabelEmail.Location = new System.Drawing.Point(48, 80);
            this.linkLabelEmail.Name = "linkLabelEmail";
            this.linkLabelEmail.Size = new System.Drawing.Size(160, 15);
            this.linkLabelEmail.TabIndex = 11;
            this.linkLabelEmail.TabStop = true;
            this.linkLabelEmail.Text = "www.gianfratti.com";
            // 
            // buttonOK
            // 
            this.buttonOK.BackColor = System.Drawing.Color.GhostWhite;
            this.buttonOK.Cursor = System.Windows.Forms.Cursors.Hand;
            this.buttonOK.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonOK.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.buttonOK.Location = new System.Drawing.Point(160, 120);
            this.buttonOK.Name = "buttonOK";
            this.buttonOK.Size = new System.Drawing.Size(56, 24);
            this.buttonOK.TabIndex = 10;
            this.buttonOK.Text = "&OK";
            this.buttonOK.UseVisualStyleBackColor = false;
            this.buttonOK.Click += new System.EventHandler(this.buttonOK_Click);
            // 
            // panel
            // 
            this.panel.BackColor = System.Drawing.Color.GhostWhite;
            this.panel.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel.Controls.Add(this.labelAllRightsReserved);
            this.panel.Controls.Add(this.linkLabelEmail);
            this.panel.Controls.Add(this.labelVSNET);
            this.panel.Controls.Add(this.labelTimerComputerShutdown);
            this.panel.Controls.Add(this.labelStevePuri);
            this.panel.Controls.Add(this.pictureBox);
            this.panel.Location = new System.Drawing.Point(8, 8);
            this.panel.Name = "panel";
            this.panel.Size = new System.Drawing.Size(208, 104);
            this.panel.TabIndex = 4;
            // 
            // About
            // 
            this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
            this.BackColor = System.Drawing.Color.GhostWhite;
            this.ClientSize = new System.Drawing.Size(226, 151);
            this.Controls.Add(this.buttonOK);
            this.Controls.Add(this.panel);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "About";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Timer Computer Shutdown";
            this.TopMost = true;
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox)).EndInit();
            this.panel.ResumeLayout(false);
            this.ResumeLayout(false);

		}
		#endregion

		private void buttonOK_Click(object sender, System.EventArgs e)
		{
			this.DialogResult = System.Windows.Forms.DialogResult.OK;

			this.Close();
		}
	}
}
