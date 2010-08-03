using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
//Referencia para ler o registro
using Microsoft.Win32;


namespace SqlServerInstancias
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            listBox1.Items.Clear();
            RegistryKey rk = Registry.LocalMachine.OpenSubKey(@"SOFTWARE\Microsoft\Microsoft SQL Server");
            String[] instances = (String[])rk.GetValue("InstalledInstances");
            if (instances.Length > 0)
            {
                foreach (String element in instances)
                {
                    if (element == "MSSQLSERVER")
                        listBox1.Items.Add(System.Environment.MachineName);
                    else
                        listBox1.Items.Add(System.Environment.MachineName + @"\" + element);
                }
            }
        }
    }
}