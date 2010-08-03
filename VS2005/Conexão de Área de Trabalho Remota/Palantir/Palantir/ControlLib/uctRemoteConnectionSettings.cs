using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using BusinessObjects;

namespace Palantir
{
    public partial class uctRemoteConnectionSettings : UserControl
    {
        public uctRemoteConnectionSettings()
        {
            InitializeComponent();
            cmbColorDepth.DataSource = Enum.GetValues(typeof(Machine.Colors));
        }

        public Machine GetMachineSettings()
        {
            Machine insMachine = new Machine();
            if (ValidateMachineSettings())
            {
                insMachine.AutoConnect = chkAutoConnect.Checked;
                insMachine.ColorDepth = (Machine.Colors)cmbColorDepth.SelectedItem;
                insMachine.DomainName = txtDomainName.Text;
                insMachine.MachineName = txtMachineName.Text;
                insMachine.SavePassword = chkSavePassword.Checked;
                insMachine.Password = txtPassword.Text;
                insMachine.ShareDiskDrives = chkShareDiskDrives.Checked;
                insMachine.SharePrinters = chkSharePrinters.Checked;
                insMachine.UserName = txtUserName.Text;
                return insMachine;
            }
            return null;
        }

        public void SetMachineSettings(Machine parMachine)
        {

            chkAutoConnect.Checked = parMachine.AutoConnect;
            cmbColorDepth.SelectedItem = parMachine.ColorDepth;
            txtDomainName.Text = parMachine.DomainName;
            txtMachineName.Text = parMachine.MachineName;
            txtPassword.Text = parMachine.Password;
            chkSavePassword.Checked = parMachine.SavePassword;
            chkShareDiskDrives.Checked = parMachine.ShareDiskDrives;
            chkSharePrinters.Checked = parMachine.SharePrinters;
            txtUserName.Text = parMachine.UserName;
        }

        public bool ValidateMachineSettings()
        {
            string errorMessage = "";
            if (txtMachineName.Text == "")
            {
                errorMessage += "Please fill in the Machine Name.";
                
            }
            if (txtUserName.Text == "")
            {      
                errorMessage += "\r\n Please fill in the User Name.";
                
            }
            if (errorMessage != "")
            {
                MessageBox.Show(errorMessage);
                return false;
            }
            return true;

        }
    }
}
