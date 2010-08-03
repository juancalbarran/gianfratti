using System;
using System.Collections;
using System.ComponentModel;
using System.Drawing;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Threading;
using System.Windows.Forms;

using Org.Mentalis.Utilities;

namespace TimerComputerShutdown
{
	/// <summary>
	/// Summary description for TimerComputerShutdown.
	/// </summary>
	public class TimerComputerShutdown : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Label labelWhatDoYouWantTheComputerToDo;
		private System.Windows.Forms.ComboBox comboBox;
		private System.Windows.Forms.Label labelSelectDateTimeToShutdownComputer;
		private System.Windows.Forms.DateTimePicker dateTimePicker;
		private System.Windows.Forms.Label labelDateTimeNow;
		private System.Windows.Forms.Label labelDateTimeShutdown;
		private System.Windows.Forms.Label labelNow;
		private System.Windows.Forms.Label labelShutdown;
		private System.Windows.Forms.Panel panelParent;
		private System.Windows.Forms.Panel panelChild;
		private System.Windows.Forms.CheckBox checkBox;
		private System.Windows.Forms.Button buttonAbout; 
		private System.Windows.Forms.Button buttonCancel;
		private System.Windows.Forms.Button buttonInvoke;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;
		
		private System.Threading.ThreadStart threadStart;
		private System.Threading.Thread thread;

		[DllImport("user32.dll")] private static extern 
			bool SetForegroundWindow(IntPtr hWnd);
		[DllImport("user32.dll")] private static extern 
			bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
		[DllImport("user32.dll")] private static extern 
			bool IsIconic(IntPtr hWnd);

		private const int SW_HIDE = 0;
		private const int SW_SHOWNORMAL = 1;
		private const int SW_SHOWMINIMIZED = 2;
		private const int SW_SHOWMAXIMIZED = 3;
		private const int SW_SHOWNOACTIVATE = 4;
		private const int SW_RESTORE = 9;
		private const int SW_SHOWDEFAULT = 10;
		
		public TimerComputerShutdown()
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
				if (components != null) 
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(TimerComputerShutdown));
            this.labelWhatDoYouWantTheComputerToDo = new System.Windows.Forms.Label();
            this.comboBox = new System.Windows.Forms.ComboBox();
            this.labelSelectDateTimeToShutdownComputer = new System.Windows.Forms.Label();
            this.dateTimePicker = new System.Windows.Forms.DateTimePicker();
            this.labelDateTimeNow = new System.Windows.Forms.Label();
            this.labelDateTimeShutdown = new System.Windows.Forms.Label();
            this.labelNow = new System.Windows.Forms.Label();
            this.labelShutdown = new System.Windows.Forms.Label();
            this.panelParent = new System.Windows.Forms.Panel();
            this.panelChild = new System.Windows.Forms.Panel();
            this.buttonAbout = new System.Windows.Forms.Button();
            this.buttonCancel = new System.Windows.Forms.Button();
            this.buttonInvoke = new System.Windows.Forms.Button();
            this.checkBox = new System.Windows.Forms.CheckBox();
            this.panelParent.SuspendLayout();
            this.panelChild.SuspendLayout();
            this.SuspendLayout();
            // 
            // labelWhatDoYouWantTheComputerToDo
            // 
            this.labelWhatDoYouWantTheComputerToDo.Location = new System.Drawing.Point(8, 8);
            this.labelWhatDoYouWantTheComputerToDo.Name = "labelWhatDoYouWantTheComputerToDo";
            this.labelWhatDoYouWantTheComputerToDo.Size = new System.Drawing.Size(216, 16);
            this.labelWhatDoYouWantTheComputerToDo.TabIndex = 9;
            this.labelWhatDoYouWantTheComputerToDo.Text = "O que você deseja fazer?";
            this.labelWhatDoYouWantTheComputerToDo.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // comboBox
            // 
            this.comboBox.Items.AddRange(new object[] {
            "Desligar",
            "Reiniciar",
            "Em espera",
            "Hibernate",
            "Log Off"});
            this.comboBox.Location = new System.Drawing.Point(216, 8);
            this.comboBox.Name = "comboBox";
            this.comboBox.Size = new System.Drawing.Size(80, 21);
            this.comboBox.TabIndex = 0;
            this.comboBox.Text = "Desligar";
            this.comboBox.SelectedIndexChanged += new System.EventHandler(this.comboBox_SelectedIndexChanged);
            // 
            // labelSelectDateTimeToShutdownComputer
            // 
            this.labelSelectDateTimeToShutdownComputer.Location = new System.Drawing.Point(8, 32);
            this.labelSelectDateTimeToShutdownComputer.Name = "labelSelectDateTimeToShutdownComputer";
            this.labelSelectDateTimeToShutdownComputer.Size = new System.Drawing.Size(216, 16);
            this.labelSelectDateTimeToShutdownComputer.TabIndex = 7;
            this.labelSelectDateTimeToShutdownComputer.Text = "Selecione uma data e hora: ";
            this.labelSelectDateTimeToShutdownComputer.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // dateTimePicker
            // 
            this.dateTimePicker.CalendarFont = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dateTimePicker.Cursor = System.Windows.Forms.Cursors.Arrow;
            this.dateTimePicker.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dateTimePicker.Format = System.Windows.Forms.DateTimePickerFormat.Time;
            this.dateTimePicker.Location = new System.Drawing.Point(216, 32);
            this.dateTimePicker.Name = "dateTimePicker";
            this.dateTimePicker.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.dateTimePicker.Size = new System.Drawing.Size(80, 21);
            this.dateTimePicker.TabIndex = 1;
            this.dateTimePicker.Value = new System.DateTime(2002, 9, 27, 0, 0, 0, 0);
            this.dateTimePicker.ValueChanged += new System.EventHandler(this.dateTimePicker_ValueChanged);
            // 
            // labelDateTimeNow
            // 
            this.labelDateTimeNow.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelDateTimeNow.Location = new System.Drawing.Point(8, 8);
            this.labelDateTimeNow.Name = "labelDateTimeNow";
            this.labelDateTimeNow.Size = new System.Drawing.Size(120, 16);
            this.labelDateTimeNow.TabIndex = 4;
            this.labelDateTimeNow.Text = "Date/Hora atual:";
            this.labelDateTimeNow.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // labelDateTimeShutdown
            // 
            this.labelDateTimeShutdown.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelDateTimeShutdown.Location = new System.Drawing.Point(8, 32);
            this.labelDateTimeShutdown.Name = "labelDateTimeShutdown";
            this.labelDateTimeShutdown.Size = new System.Drawing.Size(120, 16);
            this.labelDateTimeShutdown.TabIndex = 5;
            this.labelDateTimeShutdown.Text = "Date/Hora Desligar:";
            this.labelDateTimeShutdown.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // labelNow
            // 
            this.labelNow.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelNow.ForeColor = System.Drawing.SystemColors.ControlText;
            this.labelNow.Location = new System.Drawing.Point(136, 8);
            this.labelNow.Name = "labelNow";
            this.labelNow.Size = new System.Drawing.Size(136, 16);
            this.labelNow.TabIndex = 1;
            this.labelNow.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // labelShutdown
            // 
            this.labelShutdown.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelShutdown.ForeColor = System.Drawing.SystemColors.ControlText;
            this.labelShutdown.Location = new System.Drawing.Point(136, 32);
            this.labelShutdown.Name = "labelShutdown";
            this.labelShutdown.Size = new System.Drawing.Size(136, 16);
            this.labelShutdown.TabIndex = 8;
            this.labelShutdown.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // panelParent
            // 
            this.panelParent.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panelParent.Controls.Add(this.panelChild);
            this.panelParent.Location = new System.Drawing.Point(8, 60);
            this.panelParent.Name = "panelParent";
            this.panelParent.Size = new System.Drawing.Size(288, 60);
            this.panelParent.TabIndex = 6;
            // 
            // panelChild
            // 
            this.panelChild.Controls.Add(this.labelNow);
            this.panelChild.Controls.Add(this.labelShutdown);
            this.panelChild.Controls.Add(this.labelDateTimeShutdown);
            this.panelChild.Controls.Add(this.labelDateTimeNow);
            this.panelChild.Location = new System.Drawing.Point(0, 0);
            this.panelChild.Name = "panelChild";
            this.panelChild.Size = new System.Drawing.Size(280, 56);
            this.panelChild.TabIndex = 8;
            // 
            // buttonAbout
            // 
            this.buttonAbout.Cursor = System.Windows.Forms.Cursors.Hand;
            this.buttonAbout.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonAbout.Location = new System.Drawing.Point(8, 128);
            this.buttonAbout.Name = "buttonAbout";
            this.buttonAbout.Size = new System.Drawing.Size(56, 23);
            this.buttonAbout.TabIndex = 5;
            this.buttonAbout.Text = "&About";
            this.buttonAbout.Click += new System.EventHandler(this.buttonAbout_Click);
            // 
            // buttonCancel
            // 
            this.buttonCancel.Cursor = System.Windows.Forms.Cursors.Hand;
            this.buttonCancel.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonCancel.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.buttonCancel.Location = new System.Drawing.Point(176, 128);
            this.buttonCancel.Name = "buttonCancel";
            this.buttonCancel.Size = new System.Drawing.Size(56, 23);
            this.buttonCancel.TabIndex = 4;
            this.buttonCancel.Text = "&Cancel";
            this.buttonCancel.Click += new System.EventHandler(this.buttonCancel_Click);
            // 
            // buttonInvoke
            // 
            this.buttonInvoke.Cursor = System.Windows.Forms.Cursors.Hand;
            this.buttonInvoke.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonInvoke.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.buttonInvoke.Location = new System.Drawing.Point(240, 128);
            this.buttonInvoke.Name = "buttonInvoke";
            this.buttonInvoke.Size = new System.Drawing.Size(56, 23);
            this.buttonInvoke.TabIndex = 3;
            this.buttonInvoke.Text = "&Invoke";
            this.buttonInvoke.Click += new System.EventHandler(this.buttonInvoke_Click);
            // 
            // checkBox
            // 
            this.checkBox.Cursor = System.Windows.Forms.Cursors.Hand;
            this.checkBox.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.checkBox.Location = new System.Drawing.Point(126, 128);
            this.checkBox.Name = "checkBox";
            this.checkBox.Size = new System.Drawing.Size(49, 24);
            this.checkBox.TabIndex = 2;
            this.checkBox.Text = "&Brute";
            this.checkBox.CheckedChanged += new System.EventHandler(this.checkBox_CheckedChanged);
            // 
            // TimerComputerShutdown
            // 
            this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
            this.BackColor = System.Drawing.Color.GhostWhite;
            this.ClientSize = new System.Drawing.Size(306, 159);
            this.Controls.Add(this.checkBox);
            this.Controls.Add(this.comboBox);
            this.Controls.Add(this.labelWhatDoYouWantTheComputerToDo);
            this.Controls.Add(this.buttonAbout);
            this.Controls.Add(this.panelParent);
            this.Controls.Add(this.buttonCancel);
            this.Controls.Add(this.buttonInvoke);
            this.Controls.Add(this.dateTimePicker);
            this.Controls.Add(this.labelSelectDateTimeToShutdownComputer);
            this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "TimerComputerShutdown";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Desligamento Automático";
            this.TopMost = true;
            this.Load += new System.EventHandler(this.TimerComputerShutdown_Load);
            this.panelParent.ResumeLayout(false);
            this.panelChild.ResumeLayout(false);
            this.ResumeLayout(false);

		}
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.Run(new TimerComputerShutdown());
		}

		private void TimerComputerShutdown_Load(object sender, System.EventArgs e)
		{
			this.threadStart = new System.Threading.ThreadStart(Application_Tick);
			this.thread = new System.Threading.Thread(threadStart);
			
			this.panelChild.Visible = false;

			this.dateTimePicker.Value = System.DateTime.Now;
		}

		protected override void OnClosing(CancelEventArgs e)
		{
			try
			{
				if (this.thread.IsAlive)
				{
					this.thread.Abort();
					this.thread.Join();
				}
			}
			catch (System.Threading.ThreadAbortException threadAbortException)
			{
				System.Threading.Thread.ResetAbort();
			}
			catch (System.Exception exception)
			{
				
			}
			finally
			{
				System.Windows.Forms.Application.Exit();
			}

			base.OnClosing(e);
		}

		public void Computer_Shutdown()
		{
			if (this.checkBox.Checked)
			{
				System.Diagnostics.Process[] processes = System.Diagnostics.Process.GetProcesses();

				foreach (System.Diagnostics.Process processParent in processes)
				{
					System.Diagnostics.Process[] processNames = System.Diagnostics.Process.GetProcessesByName(processParent.ProcessName);
	
					foreach (System.Diagnostics.Process processChild in processNames)
					{
						try
						{
							System.IntPtr hWnd = processChild.MainWindowHandle;
							
							if (IsIconic(hWnd))
							{
								ShowWindowAsync(hWnd, SW_RESTORE);
							}
					
							SetForegroundWindow(hWnd);
							
							if (!(processChild.MainWindowTitle.Equals(this.Text)))
							{
								processChild.CloseMainWindow();
								processChild.Kill();
								processChild.WaitForExit();
							}
						}
						catch (System.Exception exception)
						{

						}
					}
				}
			}

			System.Windows.Forms.Application.Exit();

			switch (this.comboBox.SelectedIndex)
			{
				case 0:
					Org.Mentalis.Utilities.WindowsController.ExitWindows(RestartOptions.PowerOff, false);
					break;
				case 1:
					Org.Mentalis.Utilities.WindowsController.ExitWindows(RestartOptions.Reboot, false);
					break;
				case 2:
					Org.Mentalis.Utilities.WindowsController.ExitWindows(RestartOptions.Suspend, false);
					break;
				case 3:
					Org.Mentalis.Utilities.WindowsController.ExitWindows(RestartOptions.Hibernate, false);
					break;
				case 4:
					Org.Mentalis.Utilities.WindowsController.ExitWindows(RestartOptions.LogOff, false);
					break;
			}
		}
		
		private void comboBox_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			this.labelSelectDateTimeToShutdownComputer.Text = "Selecione Data/Hora para" + " " + this.comboBox.SelectedItem.ToString() + " " + "computador:";
            this.labelDateTimeShutdown.Text = "Data/Hora" + " " + this.comboBox.SelectedItem.ToString() + ":";
		}

		private void checkBox_CheckedChanged(object sender, System.EventArgs e)
		{
			if (this.checkBox.Checked)
			{
				Warning warning = new Warning();
				warning.ShowDialog();
			}
		}

		public bool dateTimePicker_Validated()
		{
			if (this.dateTimePicker.Value.CompareTo(System.DateTime.Now) < 0)
			{
				Error error = new Error();
				error.ShowDialog();

				this.dateTimePicker.Value = System.DateTime.Now;

				return false;
			}
			else
			{
				return true;
			}
		}

		private void dateTimePicker_ValueChanged(object sender, System.EventArgs e)
		{
			this.labelShutdown.Text = this.dateTimePicker.Value.ToString();
		}

		public void Application_Tick()
		{
			while (!(this.labelNow.Text.ToString().Equals(this.dateTimePicker.Value.ToString())))
			{
				this.labelNow.Text = System.DateTime.Now.ToString();
			}

			this.Computer_Shutdown();
		}

		private void buttonAbout_Click(object sender, System.EventArgs e)
		{
			About about = new About();

			about.ShowDialog();
		}

		private void buttonCancel_Click(object sender, System.EventArgs e)
		{
			try
			{
				if (this.thread.IsAlive)
				{
					this.thread.Abort();
					this.thread.Join();
				}
			}
			catch (System.Threading.ThreadStateException threadStateException)
			{
				System.Threading.Thread.ResetAbort();
			}
			catch (System.Exception exception)
			{
				
			}
			finally
			{
				System.Windows.Forms.Application.Exit();
			}
		}
		
		private void buttonInvoke_Click(object sender, System.EventArgs e)
		{
			if (this.dateTimePicker_Validated())
			{
				this.thread.Start();

				this.comboBox.Enabled = false;
				this.dateTimePicker.Enabled = false;
				this.panelChild.Visible = true;
				this.buttonInvoke.Enabled = false;
			}
        }

	}
}
