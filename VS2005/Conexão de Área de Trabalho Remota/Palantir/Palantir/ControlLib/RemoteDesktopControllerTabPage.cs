using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using BusinessObjects;

namespace Palantir
{
    public class RemoteDesktopControllerTabPage : TabPage
    {
        private AxMSTSCLib.AxMsRdpClient4 rdpc = null;

        protected override void OnCreateControl()
        {
            rdpc = new AxMSTSCLib.AxMsRdpClient4();
            rdpc.OnDisconnected += new AxMSTSCLib.IMsTscAxEvents_OnDisconnectedEventHandler(rdpc_OnDisconnected);
            this.Controls.Add(rdpc);
            rdpc.Dock = DockStyle.Fill;
            base.OnCreateControl();
        }

        void rdpc_OnDisconnected(object sender, AxMSTSCLib.IMsTscAxEvents_OnDisconnectedEvent e)
        {     
            ((frmMain)this.FindForm()).DisconnectConnection(this.Text);
            ((TabControl)this.Parent).TabPages.Remove(this);
       
        }


        public void Disconnect()
        {
            try
            {
                if (rdpc.Connected == 1)
                {
                    rdpc.Disconnect();
                }
            }
            catch (Exception)
            {

            }

        }

        private void SetRdpClientProperties(Machine parMachine)
        {
            rdpc.Server = parMachine.MachineName;
            rdpc.UserName = parMachine.UserName;
            rdpc.Domain = parMachine.DomainName;
            if (parMachine.Password != "")
            {
                rdpc.AdvancedSettings5.ClearTextPassword = parMachine.Password;
            }
            rdpc.AdvancedSettings5.RedirectDrives = parMachine.ShareDiskDrives;
            rdpc.AdvancedSettings5.RedirectPrinters = parMachine.SharePrinters;
            rdpc.ColorDepth = (int)parMachine.ColorDepth;
            rdpc.Dock = DockStyle.Fill;

        }

        public void Connect(Machine parMachine)
        {
            SetRdpClientProperties(parMachine);
            rdpc.Connect();
        }

        public void ConnectViaConsole(Machine parMachine)
        {
            rdpc.AdvancedSettings5.ConnectToServerConsole = true;
            SetRdpClientProperties(parMachine);

            rdpc.Connect();
        }

    }
}
