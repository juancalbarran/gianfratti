using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace BalloonCS
{
	/// <summary>
	/// Summary description for Form4.
	/// </summary>
	public class Form4 : System.Windows.Forms.Form
	{
		private System.Windows.Forms.ListBox listBox1;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		InPlaceBalloon i = new InPlaceBalloon();
		public Form4()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
			
			Rectangle rect = new Rectangle(1,1,listBox1.Width,listBox1.ItemHeight);
			i.SetToolTip(listBox1, 
				rect,
				"long long long\n long piece of\nText");

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
			this.listBox1 = new System.Windows.Forms.ListBox();
			this.SuspendLayout();
			// 
			// listBox1
			// 
			this.listBox1.Items.AddRange(new object[] {
														  "The quick brown fox jumped over the rocks",
														  "The slow silver greyhound jumped over the rocks behind him"});
			this.listBox1.Location = new System.Drawing.Point(16, 16);
			this.listBox1.Name = "listBox1";
			this.listBox1.Size = new System.Drawing.Size(168, 199);
			this.listBox1.TabIndex = 0;
			// 
			// Form4
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(292, 266);
			this.Controls.Add(this.listBox1);
			this.Name = "Form4";
			this.Text = "Form4";
			this.ResumeLayout(false);

		}
		#endregion

	}
}
