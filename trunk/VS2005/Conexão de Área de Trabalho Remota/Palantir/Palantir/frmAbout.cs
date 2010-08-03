using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Diagnostics;
using System.Resources;

namespace Palantir
{
    public partial class frmAbout : Form
    {
        public frmAbout()
        {
            InitializeComponent();
        }

        private void frmAbout_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void frmAbout_Load(object sender, EventArgs e)
        {

        }

        private void lnk_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            using (Process pieProcess = new Process())
            {

                ProcessStartInfo startInfo = new ProcessStartInfo(lnk.Text, "");

                pieProcess.StartInfo = startInfo;

                try
                {

                    pieProcess.Start();

                }

                catch (Exception)
                {

                    MessageBox.Show("Failed to launch web browser", "Error");

                }

            }

        }

        private void frmAbout_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.I)
            {

                lblThanks.Text = "Nurten \r\n Merih \r\n Beril \r\n Paþa \r\n thank you \r\n for your love and support.. \r\n and \r\n Tamer Öz \r\n thank you VERY VERY much \r\n for your patience and faith..:) ";
                lblThanks.Visible = true;
                lnk.Visible = false;
                ResourceManager rm = new ResourceManager("Palantir.Properties.Resources", System.Reflection.Assembly.GetExecutingAssembly());
                Image imgThanks = rm.GetObject("PalantirThanks") as Image;
                
                this.BackgroundImage = imgThanks;
                timer1.Start();
            }
        }

        private void lblThanks_Click(object sender, EventArgs e)
        {

            Close();
        }

        int x = 109;
        double y = 32;
        private void timer1_Tick(object sender, EventArgs e)
        {
            y -= 0.5;

            Point p = new Point(x, Convert.ToInt32(y));
            lblThanks.Location = p;


            if (p.Y == -115)
            {
                timer1.Stop();
                Close();
            }
        }
    }
}