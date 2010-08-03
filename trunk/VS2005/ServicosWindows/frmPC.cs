using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace HowTo.ServiceMgr
{
    public partial class frmPC : Form
    {
        public String computador;

        public frmPC()
        {
            InitializeComponent();
        }

        public void BtnOK_Click(object sender, EventArgs e)
        {
            computador = txtPC.Text;
            frmMain frm = new frmMain();
            frm.EnumServices();
            this.Close();
        }

        public string teste()
        {
            computador = txtPC.Text;
            return computador;
        }
    }
}