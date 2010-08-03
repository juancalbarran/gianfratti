using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Collections;
using BusinessObjects;
using Palantir.Properties;
using Helper;


namespace Palantir
{
    public partial class frmNewRemoteDesktopConnection : frmBase
    {
        public frmNewRemoteDesktopConnection()
        {
            InitializeComponent();
        }

        private void chkSaveSettings_CheckedChanged(object sender, EventArgs e)
        {
            txtRemoteDesktopConnectionName.Enabled = chkSaveSettings.Checked;
        }

        private Machine _Entity;
        public Machine Entity
        {
            get { return _Entity; }
            set { _Entity = value; }
        }

        
        private void btnConnect_Click(object sender, EventArgs e)
        {
             
            _Entity = uctRemoteConnectionSettings1.GetMachineSettings();
            if (_Entity != null)
            {
                if (chkSaveSettings.Checked)
                {
                    _Entity.RemoteDesktopConnectionName = txtRemoteDesktopConnectionName.Text;
                    string password = _Entity.Password;
                    SaveRemoteDesktop(_Entity, false);
                    _Entity.Password = password;
                }
                else
                {
                    _Entity.RemoteDesktopConnectionName = "New Remote Connection: " + Entity.MachineName;
                }
                this.Close();
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}