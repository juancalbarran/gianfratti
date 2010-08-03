using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using BusinessObjects;
using Palantir.Properties;
using System.Collections;
using Helper;
using System.Security.Cryptography;
using System.IO;

namespace Palantir
{
    public partial class frmBase : Form
    {
        public frmBase()
        {
            InitializeComponent();
        }
        public Machine GetRemoteDesktop(string parRemoteDesktopConnectionName)
        {
            Machine insMachine = new Machine();
            Hashtable ht = (Hashtable)BinarySerializer.BinaryTo(Settings.Default.MyMachine);
            return (Machine)ht[parRemoteDesktopConnectionName];
        }
        public List<Machine> GetRemoteDesktops()
        {
            List<Machine> lstMachine = new List<Machine>();
            if (Settings.Default.MyMachine != "")
            {
                Hashtable ht = (Hashtable)BinarySerializer.BinaryTo(Settings.Default.MyMachine);
                foreach (DictionaryEntry de in ht)
                {
                    Machine insMachine = (Machine)de.Value;
                    lstMachine.Add(insMachine);
                }
            }

            lstMachine.Sort(delegate(Machine m1, Machine m2) { return m1.RemoteDesktopConnectionName.CompareTo(m2.RemoteDesktopConnectionName); });
            return lstMachine;
        }
        public List<Machine> GetAutoConnectRemoteDesktops()
        {
            List<Machine> lstMachine = new List<Machine>();
            if (Settings.Default.MyMachine != "")
            {
                Hashtable ht = (Hashtable)BinarySerializer.BinaryTo(Settings.Default.MyMachine);
                foreach (DictionaryEntry de in ht)
                {
                    Machine insMachine = (Machine)de.Value;
                    if (insMachine.AutoConnect)
                    {
                        lstMachine.Add(insMachine);
                    }
                }
            }
            return lstMachine;
        }
        public bool SaveRemoteDesktop(Machine parMachine, bool openedForEdit)
        {
            if (Settings.Default.MyMachine == "")
            {
                Hashtable ht = new Hashtable();
                Settings.Default.MyMachine = BinarySerializer.ToBinary(ht);
                Settings.Default.Save();
            }
            Hashtable ht1 = (Hashtable)BinarySerializer.BinaryTo(Settings.Default.MyMachine);
            if (!parMachine.SavePassword)
            {
                parMachine.Password = "";
            }

            if (!openedForEdit)
            {
                foreach (DictionaryEntry de in ht1)
                {
                    if (((Machine)de.Value).RemoteDesktopConnectionName == parMachine.RemoteDesktopConnectionName)
                    {
                        MessageBox.Show("There is already a remote connection with the same name.");
                        return false;
                    }
                }
            }

            ht1[parMachine.RemoteDesktopConnectionName] = parMachine;
            Settings.Default.MyMachine = BinarySerializer.ToBinary(ht1);
            Settings.Default.Save();
            return true;
        }
        public void DeleteRemoteDesktop(string parMachineName)
        {
            Hashtable ht = (Hashtable)BinarySerializer.BinaryTo(Settings.Default.MyMachine);
            ht.Remove(parMachineName);
            Settings.Default.MyMachine = BinarySerializer.ToBinary(ht);
            Settings.Default.Save();
        }
        public DataTable GetRemoteDesktopsDataTable()
        {
            DataTable dtRemoteDesktopMachines = new DataTable();
            if (Settings.Default.MyMachine != "")
            {
                Hashtable ht = (Hashtable)BinarySerializer.BinaryTo(Settings.Default.MyMachine);


                dtRemoteDesktopMachines.Columns.Add("RemoteDesktopConnectionName", typeof(string));
                dtRemoteDesktopMachines.Columns.Add("MachineName", typeof(string));
                dtRemoteDesktopMachines.Columns.Add("DomainName", typeof(string));
                dtRemoteDesktopMachines.Columns.Add("UserName", typeof(string));
                dtRemoteDesktopMachines.Columns.Add("AutoConnect", typeof(bool));
                dtRemoteDesktopMachines.Columns.Add("ShareDiskDrives", typeof(bool));
                dtRemoteDesktopMachines.Columns.Add("SharePrinters", typeof(bool));
                dtRemoteDesktopMachines.Columns.Add("SavePassword", typeof(bool));
                foreach (DictionaryEntry de in ht)
                {
                    DataRow dr = dtRemoteDesktopMachines.NewRow();
                    dr["RemoteDesktopConnectionName"] = ((Machine)de.Value).RemoteDesktopConnectionName;
                    dr["MachineName"] = ((Machine)de.Value).MachineName;
                    dr["DomainName"] = ((Machine)de.Value).DomainName;
                    dr["UserName"] = ((Machine)de.Value).UserName;
                    dr["AutoConnect"] = ((Machine)de.Value).AutoConnect;
                    dr["ShareDiskDrives"] = ((Machine)de.Value).ShareDiskDrives;
                    dr["SharePrinters"] = ((Machine)de.Value).SharePrinters;
                    dr["SavePassword"] = ((Machine)de.Value).SavePassword;
                    dtRemoteDesktopMachines.Rows.Add(dr);
                }
            }
            return dtRemoteDesktopMachines;

        }

        public void SaveSettings(string password)
        {
            if (password != "")
            {
                string savedMachines = Settings.Default.MyMachine;
                string encryptedMachines = Crypto.EncryptString(savedMachines, password);

                SaveFileDialog sfd = new SaveFileDialog();

                sfd.Filter = "Palantir Setting Files (*.pln)|*.pln|All files (*.*)|*.*";

                sfd.ShowDialog();

                if (sfd.FileName != "")
                {
                    StreamWriter sw = new StreamWriter(sfd.FileName, false, Encoding.GetEncoding("iso-8859-9"));
                    sw.Write(encryptedMachines);
                    sw.Close();
                }
            }
        }

        public void LoadSettings(string password, string fileName)
        {
            if (password != "")
            {
                StreamReader sr = new StreamReader(fileName, Encoding.GetEncoding("iso-8859-9")); 
                string settings = sr.ReadToEnd();

                string decryptedMachines = Crypto.DecryptString(settings, password);
                Settings.Default.MyMachine = decryptedMachines;
                Settings.Default.Save();
            }
        }
    }
}