using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace BelvedereSharp
{
    public partial class FormAbout : Form
    {
        public FormAbout()
        {
            InitializeComponent();
        }

        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            OpenBelvedereOriginal();
        }

        private void linkLabel2_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            OpenGooglePage();
        }

        private void linkLabel3_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            OpenGooglePage();
        }

        private void OpenBelvedereOriginal()
        {
            BShell.Run("start http://github.com/adampash/belvedere/");
        }

        private void OpenGooglePage()
        {
            BShell.Run("start http://code.google.com/p/belvederesharp/");
        }
    }
}
