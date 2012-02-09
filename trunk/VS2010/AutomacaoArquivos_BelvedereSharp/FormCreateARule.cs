/// Copyright (C) 2009 Matthew Ng 
/// 
/// Based on Belvedere by Adam Pash (http://github.com/adampash/belvedere/tree/)
/// 
/// BelvedereSharp is free software; you can redistribute it and/or
/// modify it under the terms of the GNU General Public License
/// as published by the Free Software Foundation; either version 2
/// of the License, or (at your option) any later version.
/// 
/// BelvedereSharp is distributed in the hope that it will be useful,
/// but WITHOUT ANY WARRANTY; without even the implied warranty of
/// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
/// GNU General Public License for more details.
///
/// You should have received a copy of the GNU General Public License
/// along with this program; if not, write to the Free Software
/// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;

namespace BelvedereSharp
{
    public partial class FormCreateARule : Form
    {
        public FormCreateARule()
        {
            InitializeComponent();

            comboBoxAction.SelectedIndex = 0;
            comboBoxAllOrAny.SelectedIndex = 0;
            comboBoxCondition.SelectedIndex = 0;
            comboBoxElement.SelectedIndex = 0;
        }

        public string Path
        {
            get { return labelFolder.Text; }
            set { labelFolder.Text = value; }
        }

        public string Description
        {
            get { return textBoxDescription.Text; }
            set { textBoxDescription.Text = value; }
        }

        public bool IsEnabled
        {
            get { return checkBoxEnabled.Checked; }
            set { checkBoxEnabled.Checked = value; }
        }

        public bool ConfirmAction
        {
            get { return checkBoxConfirmAction.Checked; }
            set { checkBoxConfirmAction.Checked = value; }
        }

        public bool Recursive
        {
            get { return checkBoxRecursive.Checked; }
            set { checkBoxRecursive.Checked = value; }
        }

        public string AllOrAny
        {
            get { return comboBoxAllOrAny.SelectedItem.ToString(); }
            set { comboBoxAllOrAny.SelectedItem = value; }
        }

        public BCondition[] Conditions
        {
            get
            {
                List<BCondition> c = new List<BCondition>();
                foreach (ListViewItem i in listViewConditions.Items)
                    c.Add(new BCondition(i.SubItems[0].Text,
                                                  i.SubItems[1].Text,
                                                  i.SubItems[2].Text));
                return c.ToArray();
            }
            set
            {
                listViewConditions.BeginUpdate();
                foreach (BCondition b in value)
                    listViewConditions.Items.Add(new ListViewItem(new string[] { b.Element, b.Condition, b.Parameter }));
                listViewConditions.EndUpdate();
            }
        }

        public BAction Action
        {
            get { return new BAction(comboBoxAction.SelectedItem.ToString(), textBoxDestination.Text); }
            set
            {
                comboBoxAction.SelectedItem = value.Action;
                textBoxDestination.Text = value.Destinaton;
            }
        }

        public string Destination
        {
            get { return textBoxDestination.Text; }
            set { textBoxDestination.Text = value; }
        }

        public bool Overwrite
        {
            get { return checkBoxOverwrite.Checked; }
            set { checkBoxOverwrite.Checked = value; }
        }

        private void buttonFolderBrowser_Click(object sender, EventArgs e)
        {
            if (textBoxDestination.Text.Length > 0 && Directory.Exists(textBoxDestination.Text))
                folderBrowserDialog.SelectedPath = textBoxDestination.Text;

            DialogResult r = folderBrowserDialog.ShowDialog();
            if (r != DialogResult.OK)
                return;

            textBoxDestination.Text = folderBrowserDialog.SelectedPath;
        }

        private void buttonConditionAdd_Click(object sender, EventArgs e)
        {
            if (comboBoxElement.SelectedItem == null)
                return;
            if (comboBoxCondition.SelectedItem == null)
                return;
            if (textBoxParameter.Text.Length == 0)
                return;
            listViewConditions.BeginUpdate();
            listViewConditions.Items.Add(new ListViewItem(new string[] { comboBoxElement.SelectedItem.ToString(), 
                                                                         comboBoxCondition.SelectedItem.ToString(),
                                                                         textBoxParameter.Text.ToLower()}));
            listViewConditions.EndUpdate();
        }

        private void buttonConditionRemove_Click(object sender, EventArgs e)
        {
            if (listViewConditions.SelectedItems.Count == 0)
                return;
            listViewConditions.BeginUpdate();
            listViewConditions.Items.Remove(listViewConditions.SelectedItems[0]);
            listViewConditions.EndUpdate();
        }

        private void FormCreateARule_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (this.DialogResult == DialogResult.Cancel)
                return;

            //Checking
            if (textBoxDescription.Text.Length == 0)
            {
                MessageBox.Show("Please enter description.");
                e.Cancel = true;
                return;
            }

            if (listViewConditions.Items.Count == 0)
            {
                MessageBox.Show("Please add condition.");
                e.Cancel = true;
                return;
            }

            if (comboBoxAction.SelectedItem.ToString() == "Move" && textBoxDestination.Text.Length == 0)
            {
                MessageBox.Show("Please enter or select move destination folder.");
                e.Cancel = true;
                return;
            }
        }
        
        private void comboBoxAction_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBoxAction.SelectedItem.ToString() == "Send file to Recycle Bin")
            {
                ToggleActionDestinationVisible(false);
                return;
            }else if (comboBoxAction.SelectedItem.ToString() == "Custom command")
            {
                textBoxDestination.Visible = true;
                labelToFolder.Visible = false;
                buttonFolderBrowser.Visible = false;
                return;
            }
            ToggleActionDestinationVisible(true);
        }

        private void ToggleActionDestinationVisible(bool b)
        {
            labelToFolder.Visible = b;
            textBoxDestination.Visible = b;
            buttonFolderBrowser.Visible = b;
        }
    }
}
