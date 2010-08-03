using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

using System.Collections;
using Palantir.Properties;
using BusinessObjects;
using Helper;

namespace Palantir
{
    public partial class frmMain : frmBase
    {
        public frmMain()
        {
            InitializeComponent();
        }
        private void frmMain_Load(object sender, EventArgs e)
        {
            LoadConnectToMenuItems();
            LoadAutoConnectRemoteDesktops();
            LoadConnectViaConsoleRemoteDesktops();
        }
        private void LoadConnectToMenuItems()
        {
            connectToToolStripMenuItem.DropDownItems.Clear();
            foreach (Machine m in GetRemoteDesktops())
            {
                ToolStripMenuItem tsmi = new ToolStripMenuItem(m.RemoteDesktopConnectionName);
                tsmi.Tag = m.MachineName;
                connectToToolStripMenuItem.DropDownItems.Add(tsmi);
                tsmi.Click += new EventHandler(tsmi_Click);
            }
            ToolStripMenuItem tsmiNew = new ToolStripMenuItem("New...");
            connectToToolStripMenuItem.DropDownItems.Add(tsmiNew);
            tsmiNew.Click += new EventHandler(tsmiNew_Click);
        }
        private void LoadAutoConnectRemoteDesktops()
        {
            Machine insMachine = new Machine();
            List<Machine> listAutoConnectRemoteDesktops = this.GetAutoConnectRemoteDesktops();
            foreach (Machine e in listAutoConnectRemoteDesktops)
            {
                LoadRemoteConnection(e, false);
            }
        }

        void tsmi_Click(object sender, EventArgs e)
        {
            Machine insMachine = null;
            insMachine = this.GetRemoteDesktop(((ToolStripMenuItem)sender).Text);
            LoadRemoteConnection(insMachine, false);
        }

        void tsmiNew_Click(object sender, EventArgs e)
        {
            frmNewRemoteDesktopConnection insFrmNewRemoteDesktopConnection = new frmNewRemoteDesktopConnection();
            insFrmNewRemoteDesktopConnection.ShowDialog();
            LoadConnectToMenuItems();
            LoadConnectViaConsoleRemoteDesktops();
            if (insFrmNewRemoteDesktopConnection.Entity != null)
            {
                LoadRemoteConnection(insFrmNewRemoteDesktopConnection.Entity, false);
            }
        }

        private void settingsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmRemoteDesktopMachines frmRDM = new frmRemoteDesktopMachines();
            frmRDM.ShowDialog();
            LoadConnectToMenuItems();
            LoadConnectViaConsoleRemoteDesktops();
        }

        public void LoadRemoteConnection(Machine parEntMachine, bool isConsole)
        {
            RemoteDesktopControllerTabPage insRdpTp = new RemoteDesktopControllerTabPage();
            insRdpTp.Text = parEntMachine.RemoteDesktopConnectionName;
            foreach (TabPage tp in tcMain.TabPages)
            {
                if (tp.Text == insRdpTp.Text)
                {
                    tcMain.SelectTab(tp);
                    return;
                }
            }

            tcMain.TabPages.Add(insRdpTp);
            if (isConsole)
            {
                insRdpTp.ConnectViaConsole(parEntMachine);
            }
            else
            {
                insRdpTp.Connect(parEntMachine);
            }
            tcMain.SelectTab(insRdpTp);

            ToolStripMenuItem tsmiDisconnect = new ToolStripMenuItem(parEntMachine.RemoteDesktopConnectionName);
            tsmiDisconnect.Tag = parEntMachine.MachineName;
            disconnectFromToolStripMenuItem.DropDownItems.Add(tsmiDisconnect);
            tsmiDisconnect.Click += new EventHandler(tsmiDisconnect_Click);
        }

        void tsmiDisconnect_Click(object sender, EventArgs e)
        {
            ToolStripMenuItem tsmiDisconnect = (ToolStripMenuItem)sender;
            RemoteDesktopControllerTabPage insRdpTp = null;
            foreach (TabPage tp in tcMain.TabPages)
            {
                if (tp.Text == tsmiDisconnect.Text)
                {
                    tcMain.TabPages.Remove(tp);
                    insRdpTp = (RemoteDesktopControllerTabPage)tp;
                    break;
                }
            }
            if (insRdpTp != null)
            {
                insRdpTp.Disconnect();
            }
            disconnectFromToolStripMenuItem.DropDownItems.Remove(tsmiDisconnect);
        }

        private void connectAllToolStripMenuItem_Click(object sender, EventArgs e)
        {
            tcMain.TabPages.Clear();

            foreach (Machine m in GetRemoteDesktops())
            {
                RemoteDesktopControllerTabPage insRdpTp = new RemoteDesktopControllerTabPage();
                tcMain.TabPages.Add(insRdpTp);
                insRdpTp.Text = m.RemoteDesktopConnectionName;
                insRdpTp.Connect(m);
            }
        }

        private void disconnectAllToolStripMenuItem_Click(object sender, EventArgs e)
        {
            foreach (RemoteDesktopControllerTabPage tp in tcMain.TabPages)
            {
                tp.Disconnect();
                tcMain.TabPages.Remove(tp);
            }
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
        public void DisconnectConnection(string parRemoteSettingName)
        {
            ToolStripMenuItem tsmiDisconnect = null;
            foreach (ToolStripMenuItem tsmi in disconnectFromToolStripMenuItem.DropDownItems)
            {
                if (tsmi.Text == parRemoteSettingName)
                {
                    tsmiDisconnect = tsmi;
                    break;
                }
            }
            disconnectFromToolStripMenuItem.DropDownItems.Remove(tsmiDisconnect);
        }

        private void aboutPalantirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmAbout insFrmAbout = new frmAbout();
            insFrmAbout.ShowDialog();
        }

        private void subscribeForUpdatesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmRegister insFrmRegister = new frmRegister();
            insFrmRegister.ShowDialog();
        }

        private void saveSettingsToAFToolStripMenuItem_Click(object sender, EventArgs e)
        {

            frmEnterPassword insFrmEnterPassword = new frmEnterPassword();
            insFrmEnterPassword.ShowDialog();

            SaveSettings(insFrmEnterPassword.password);
        }

        private void loadSettingsFromFileToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("By loading settings from a file, all of your current settings will be erased. Do you want to continue?", "Load Settings", MessageBoxButtons.YesNo, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1) != DialogResult.No)
            {
                try
                {
                    OpenFileDialog ofd = new OpenFileDialog();
                    ofd.Filter = "Palantir Setting Files (*.pln)|*.pln|All files (*.*)|*.*";

                    ofd.ShowDialog();
                    if (ofd.FileName != "")
                    {
                        frmEnterPassword insFrmEnterPassword = new frmEnterPassword();
                        insFrmEnterPassword.ShowDialog();
                        LoadSettings(insFrmEnterPassword.password, ofd.FileName);
                        LoadConnectToMenuItems();
                        LoadConnectViaConsoleRemoteDesktops();
                        MessageBox.Show("Remote desktop connections have been successfully imported.");
                    }
                }
                catch (Exception)
                {
                    MessageBox.Show("The password you have entered is incorrect.");
                    return;
                }
            }
        }

        private void LoadConnectViaConsoleRemoteDesktops()
        {
            connectViaConsoleToToolStripMenuItem.DropDownItems.Clear();
            foreach (Machine m in GetRemoteDesktops())
            {
                ToolStripMenuItem tsmiConsole = new ToolStripMenuItem(m.RemoteDesktopConnectionName);
                tsmiConsole.Tag = m.MachineName;
                connectViaConsoleToToolStripMenuItem.DropDownItems.Add(tsmiConsole);
                tsmiConsole.Click += new EventHandler(tsmiConsole_Click);
            }
        }

        void tsmiConsole_Click(object sender, EventArgs e)
        {
            Machine insMachine = null;
            insMachine = this.GetRemoteDesktop(((ToolStripMenuItem)sender).Text);
            LoadRemoteConnection(insMachine, true);
        }
    }
}