using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Net;

namespace Palantir
{
    public partial class frmRegister : Form
    {
        public frmRegister()
        {
            InitializeComponent();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            string errorMessage = "";
            if (txtName.Text.Trim() == "")
            {
                errorMessage += "Name can not be left blank.\r\n";
            }
            if (txtSurname.Text.Trim() == "")
            {
                errorMessage += "Surname can not be left blank.\r\n";
            }
            if (txtEmail.Text.Trim() == "")
            {
                errorMessage += "Email can not be left blank.\r\n";
            }
            if (errorMessage != "")
            {
                MessageBox.Show(errorMessage, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            reg.Register r = new Palantir.reg.Register();
            r.Proxy = WebProxy.GetDefaultProxy();
            r.Proxy.Credentials = CredentialCache.DefaultCredentials;
            try
            {
                r.RegisterUser(txtName.Text, txtSurname.Text, txtEmail.Text);
            }
            catch (Exception ex)
            {
                MessageBox.Show("An Error Occured. Please Try Again Later.","Error",MessageBoxButtons.OK,MessageBoxIcon.Error);
                return;
            }
            MessageBox.Show("Registration Successful");
            this.Close();

        }
    }
}