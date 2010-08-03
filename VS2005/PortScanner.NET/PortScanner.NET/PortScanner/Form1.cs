using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Net.Sockets;
using System.Windows.Forms;

namespace PortScanner
{
	public partial class frmMain : Form
	{
		protected int StartPort;
		protected int EndPort;

		public frmMain()
		{
			InitializeComponent();
		}

		private void btnScan_Click(object sender, EventArgs e)
		{
			// Store values from the NumericUpDown to variables
			StartPort = Convert.ToInt32(numStart.Value);
			EndPort = Convert.ToInt32(numEnd.Value);
			// Reset the progress bar
			prgScanning.Value = 0;
			// Set the max value of the progress bar
			prgScanning.Maximum = EndPort - StartPort + 1;
			// Let the user know the application is busy
			Cursor.Current = Cursors.WaitCursor;
			// Loop through the ports between start port and end port
			for (int CurrPort = StartPort; CurrPort <= EndPort; CurrPort++)
			{
				TcpClient TcpScan = new TcpClient();
				try
				{
					// Try to connect
					TcpScan.Connect(txtIP.Text, CurrPort);
					// If there's no exception, we can say the port is open
					txtLog.AppendText("Port " + CurrPort + " open\r\n");
				}
				catch
				{
					// An exception occured, thus the port is probably closed
					txtLog.AppendText("Port " + CurrPort + " closed\r\n");
				}
				// Increase the progress on the progress bar
				prgScanning.PerformStep();
			}
			// Set the cursor back to normal
			Cursor.Current = Cursors.Arrow;
		}
	}
}