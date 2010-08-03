using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

using System.Collections;
using Palantir.Properties;
using Helper;
using BusinessObjects;

namespace Palantir
{
    public partial class frmRemoteDesktopMachines : frmBase
    {
        public frmRemoteDesktopMachines()
        {
            InitializeComponent();
            dgrRemoteDesktops.AutoGenerateColumns = false;
        }

        private void frmRemoteDesktopMachines_Load(object sender, EventArgs e)
        {
            LoadGridData();
        }

        public void LoadGridData()
        {
            dgrRemoteDesktops.DataSource = GetRemoteDesktopsDataTable();
        }

        private void dgrRemoteDesktops_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex != -1)
            {
                if (e.ColumnIndex == 0)
                {
                    Machine insMachine = new Machine();
                    insMachine = GetRemoteDesktop(dgrRemoteDesktops.Rows[e.RowIndex].Cells["clmnRemoteDesktopConnectionName"].Value.ToString());
                    frmSettings frmS = new frmSettings(insMachine);
                    frmS.openedForEdit = true;
                    frmS.ShowDialog();
                    LoadGridData();

                }
                else if (e.ColumnIndex == 1)
                {
                    if (MessageBox.Show("Are you sure that you want to delete this connection setting?", "Delete Remote Desktop Connection Setting", MessageBoxButtons.YesNo, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1) != DialogResult.No)
                    {
                        DeleteRemoteDesktop(dgrRemoteDesktops.Rows[e.RowIndex].Cells["clmnRemoteDesktopConnectionName"].Value.ToString());
                        LoadGridData();
                    }

                }
            }
        }
        private void btnNew_Click(object sender, EventArgs e)
        {
            frmSettings frmS = new frmSettings();
            frmS.ShowDialog();
            LoadGridData();
        }
    }
}