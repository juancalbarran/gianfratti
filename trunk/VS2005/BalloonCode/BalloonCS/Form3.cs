using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace BalloonCS
{
	/// <summary>
	/// Summary description for Form3.
	/// </summary>
	public class Form3 : System.Windows.Forms.Form
	{
		private System.Windows.Forms.TextBox textBox1;
		private System.Windows.Forms.Label label1;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;
		private System.Windows.Forms.Button button1;

		private EditBalloon m_eb = new EditBalloon();

		public Form3()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			m_eb.Title = "Order Warning";
			m_eb.TitleIcon = TooltipIcon.Warning;
			m_eb.Text = "This character is invalid. \r\nNo |, ~ are allowed.\r\n'Place Order' may or may not work correctly.";
			m_eb.Parent = this.textBox1;
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
			this.textBox1 = new System.Windows.Forms.TextBox();
			this.label1 = new System.Windows.Forms.Label();
			this.button1 = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// textBox1
			// 
			this.textBox1.Location = new System.Drawing.Point(16, 56);
			this.textBox1.Name = "textBox1";
			this.textBox1.Size = new System.Drawing.Size(112, 20);
			this.textBox1.TabIndex = 0;
			this.textBox1.Text = "20";
			this.textBox1.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.textBox1_KeyPress);
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(16, 8);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(216, 40);
			this.label1.TabIndex = 1;
			this.label1.Text = "Place Quantity below:                                    ( Try entering invalid c" +
				"haracters |, ~ in the textbox below . )";
			// 
			// button1
			// 
			this.button1.Location = new System.Drawing.Point(136, 56);
			this.button1.Name = "button1";
			this.button1.Size = new System.Drawing.Size(96, 23);
			this.button1.TabIndex = 2;
			this.button1.Text = "Place Order";
			this.button1.Click += new System.EventHandler(this.button1_Click);
			// 
			// Form3
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(240, 94);
			this.Controls.Add(this.button1);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.textBox1);
			this.Name = "Form3";
			this.Text = "Form3";
			this.ResumeLayout(false);

		}
		#endregion

		private void textBox1_KeyPress(object sender, System.Windows.Forms.KeyPressEventArgs e)
		{
			// TODO : handle similar logic for Ctrl+C, Ctrl+V

			if(e.KeyChar=='|' || e.KeyChar=='~')
			{
				m_eb.Show();
			}
		}

		private void button1_Click(object sender, System.EventArgs e)
		{
		
		}


	

	}
}
