using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace BalloonCS
{
	/// <summary>
	/// Summary description for Form2.
	/// </summary>
	public class Form2 : System.Windows.Forms.Form
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;
		private System.Windows.Forms.Button button1;
		private System.Windows.Forms.GroupBox groupBox1;
		private System.Windows.Forms.ComboBox comboBox1;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.CheckBox checkBox1;
		private System.Windows.Forms.CheckBox checkBox2;
		private System.Windows.Forms.Button button2;

		private MessageBalloon m_mb;

		public Form2()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			// load combo
			string []names = Enum.GetNames(typeof(BalloonCS.BalloonAlignment));
			foreach(string name in names)
			{
				comboBox1.Items.Add(name);
			}
			comboBox1.SelectedItem = names[0];


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
			this.button1 = new System.Windows.Forms.Button();
			this.groupBox1 = new System.Windows.Forms.GroupBox();
			this.comboBox1 = new System.Windows.Forms.ComboBox();
			this.label1 = new System.Windows.Forms.Label();
			this.checkBox1 = new System.Windows.Forms.CheckBox();
			this.checkBox2 = new System.Windows.Forms.CheckBox();
			this.button2 = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// button1
			// 
			this.button1.Location = new System.Drawing.Point(218, 130);
			this.button1.Name = "button1";
			this.button1.Size = new System.Drawing.Size(112, 23);
			this.button1.TabIndex = 3;
			this.button1.Text = "Show Tip";
			this.button1.Click += new System.EventHandler(this.button1_Click);
			// 
			// groupBox1
			// 
			this.groupBox1.Location = new System.Drawing.Point(10, 10);
			this.groupBox1.Name = "groupBox1";
			this.groupBox1.Size = new System.Drawing.Size(180, 166);
			this.groupBox1.TabIndex = 4;
			this.groupBox1.TabStop = false;
			this.groupBox1.Text = "groupBox1";
			// 
			// comboBox1
			// 
			this.comboBox1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.comboBox1.Location = new System.Drawing.Point(216, 28);
			this.comboBox1.Name = "comboBox1";
			this.comboBox1.Size = new System.Drawing.Size(106, 21);
			this.comboBox1.TabIndex = 5;
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(216, 10);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(106, 16);
			this.label1.TabIndex = 6;
			this.label1.Text = "Align:";
			// 
			// checkBox1
			// 
			this.checkBox1.Location = new System.Drawing.Point(218, 54);
			this.checkBox1.Name = "checkBox1";
			this.checkBox1.TabIndex = 8;
			this.checkBox1.Text = "center Stem";
			// 
			// checkBox2
			// 
			this.checkBox2.Location = new System.Drawing.Point(218, 84);
			this.checkBox2.Name = "checkBox2";
			this.checkBox2.TabIndex = 9;
			this.checkBox2.Text = "use abs posn";
			// 
			// button2
			// 
			this.button2.Location = new System.Drawing.Point(220, 156);
			this.button2.Name = "button2";
			this.button2.Size = new System.Drawing.Size(112, 23);
			this.button2.TabIndex = 10;
			this.button2.Text = "Hide Tip";
			this.button2.Click += new System.EventHandler(this.button2_Click);
			// 
			// Form2
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(338, 214);
			this.Controls.Add(this.button2);
			this.Controls.Add(this.checkBox2);
			this.Controls.Add(this.checkBox1);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.comboBox1);
			this.Controls.Add(this.groupBox1);
			this.Controls.Add(this.button1);
			this.Name = "Form2";
			this.Text = "Form2";
			this.ResumeLayout(false);

		}
		#endregion

		private void button1_Click(object sender, System.EventArgs e)
		{
			m_mb = new MessageBalloon();
			m_mb.Parent = groupBox1;
			m_mb.Title = "Traders corp. Inc";
			m_mb.TitleIcon = TooltipIcon.Info;
			m_mb.Text = "This control helps group all inventory items.";

			BalloonAlignment ba = (BalloonAlignment)Enum.Parse(typeof(BalloonAlignment), (string)comboBox1.SelectedItem);
			m_mb.Align = ba;
			m_mb.CenterStem = checkBox1.Checked ? true : false;
			m_mb.UseAbsolutePositioning = checkBox2.Checked ? true : false;
			m_mb.Show();
	
		}

		private void button2_Click(object sender, System.EventArgs e)
		{
			m_mb.Dispose();
		}
	}
}
