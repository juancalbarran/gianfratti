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
using System.Xml.Serialization;
using System.Threading;
using log4net;

namespace BelvedereSharp
{
    public partial class FormMain : Form
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(FormMain));

        private BelvedereSharp _belvedere;
        private List<BFolder> _folders;
        private int _selectedFolderIndex = -1;
        private int _selectedRuleIndex = -1;

        private FormProgress _formProgress;
        private NotifyIcon _notifyIcon;

        public FormMain()
        {
            InitializeComponent();

            LoadConfig();
            _formProgress = new FormProgress();
            _formProgress.Visible = false;

            SetNotifyIcon();

            //sleepTime
            textBoxSleeptime.Text = _belvedere.SleepTime.ToString();
        }

        private void LoadConfig()
        {
            bool loaded = false;
            if (File.Exists("config.xml"))
            {
                try
                {
                    XmlSerializer s = new XmlSerializer(typeof(BelvedereSharp));
                    TextReader r = new StreamReader("config.xml");
                    _belvedere = (BelvedereSharp)s.Deserialize(r);
                    r.Close();
                    loaded = true;
                }
                catch (Exception)
                {
                    Log.Error("Invalid config.xml, creating new config file.");
                    if (File.Exists("config.xml.err"))
                        File.Delete("config.xml.err");
                    File.Move("config.xml", "config.xml.err");
                }
            }
            if (!loaded)
                _belvedere = new BelvedereSharp();

            //listViewFolders
            _folders = _belvedere.Folders;

            if (_folders.Count > 0)
            {
                List<ListViewItem> l = new List<ListViewItem>();
                foreach (BFolder folder in _folders)
                    l.Add(new ListViewItem(new string[] { Path.GetFileName(folder.Path), folder.Path }));
                listViewFolders.BeginUpdate();
                listViewFolders.Items.AddRange(l.ToArray());
                listViewFolders.EndUpdate();
                listViewFolders.Items[0].Selected = true;
                _selectedFolderIndex = 0;

                UpdateListViewRules();
            }
        }


        private void FormMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            System.Diagnostics.Debug.WriteLine(sender.ToString());
            _belvedere.Serialize();
            if (_notifyIcon != null)
                _notifyIcon.Visible = false;
        }

        //TODO: Add Save, Reload toolStripMenuItem

        private void toolStripMenuItemRunNow_Click(object sender, EventArgs e)
        {
            Log.Info("File management initialized by user.");
            this.Run();
        }

        private void toolStripMenuItemExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        #region NotifyIcon
        private void SetNotifyIcon()
        {
            //Disable NotifyIcon for MacOSX to avoid crash
            if (Program.Platform == PlatformID.Win32NT || Program.Platform == PlatformID.Unix)
            {
                _notifyIcon = new NotifyIcon();
                _notifyIcon.Text = "Belvedere#";
                _notifyIcon.Icon = ((System.Drawing.Icon)((new System.ComponentModel.ComponentResourceManager(typeof(FormMain))).GetObject("$this.Icon")));
                _notifyIcon.Visible = true;                
                //Cannot direct link to fileToolStripMenuItem, it will take over the ownership...
                _notifyIcon.ContextMenuStrip = contextMenuStripNotifyIcon;
                _notifyIcon.Click += new EventHandler(notifyIcon_Click);
            }
        }

        private void notifyIcon_Click(object sender, EventArgs e)
        {
            MouseEventArgs a = (MouseEventArgs)e;
            if (a.Button != MouseButtons.Left)
                return;
            if (!this.Visible)
                this.Show();
            else
                this.Hide();
        }

        private void FormMain_Resize(object sender, EventArgs e)
        {
            if (this.WindowState == FormWindowState.Minimized)
                this.Hide();
        }
        #endregion

        #region Folder List
        //TODO Sychronization: Folders
        private void buttonFolderAdd_Click(object sender, EventArgs e)
        {
            DialogResult d = folderBrowserDialog.ShowDialog();
            if (d != DialogResult.OK)
                return;

            foreach (BFolder f in _belvedere.Folders)
            {
                if (f.Path != folderBrowserDialog.SelectedPath)
                    continue;
                MessageBox.Show("Selected folder has already been added.");
                return;
            }

            BFolder nf = new BFolder(folderBrowserDialog.SelectedPath);
            _folders.Add(nf);
            listViewFolders.BeginUpdate();
            listViewFolders_Add(nf.Path);
            listViewFolders.EndUpdate();
        }

        private void buttonFolderRemove_Click(object sender, EventArgs e)
        {
            if (listViewFolders.SelectedIndices.Count == 0)
                return;
            int i = listViewFolders.SelectedIndices[0];

            _folders.RemoveAt(i);
            listViewFolders_RemoveAt(i);

            UpdateListViewRules();
        }

        private void listViewFolders_Add(string path)
        {
            listViewFolders.BeginUpdate();
            listViewFolders.Items.Add(new ListViewItem(new string[] { Path.GetFileName(path), path }));
            listViewFolders.Items[listViewFolders.Items.Count - 1].Selected = true;
            listViewFolders.EndUpdate();
        }

        private void listViewFolders_RemoveAt(int i)
        {
            listViewFolders.BeginUpdate();
            listViewFolders.Items.RemoveAt(i);
            if (i - 1 >= 0)
                listViewFolders.Items[i - 1].Selected = true;
            listViewFolders.EndUpdate();
        }

        private void listViewFolders_ItemSelectionChanged(object sender, EventArgs e)
        {
            if (listViewFolders.SelectedIndices.Count == 0)
            {
                _selectedFolderIndex = -1;
                return;
            }
            _selectedFolderIndex = listViewFolders.SelectedIndices[0];

            UpdateListViewRules();
        }

        #endregion

        //TODO: Sortable rule list
        #region Rules
        private void UpdateListViewRules()
        {
            if (_selectedFolderIndex == -1)
            {
                listViewRules.BeginUpdate();
                listViewRules.Items.Clear();
                listViewRules.EndUpdate();
                return;
            }

            List<ListViewItem> l = new List<ListViewItem>();
            BFolder f = _folders[_selectedFolderIndex];
            foreach (BRule rule in f.Rules)
            {
                ListViewItem i = new ListViewItem(rule.Description);
                i.Checked = rule.Enabled;
                l.Add(i);
            }

            listViewRules.BeginUpdate();
            listViewRules.Items.Clear();
            listViewRules.Items.AddRange(l.ToArray());
            listViewRules.EndUpdate();
        }

        private void buttonRuleAdd_Click(object sender, EventArgs e)
        {
            if (_selectedFolderIndex < 0)
            {
                MessageBox.Show("Please select a folder.");
                return;
            }
            BFolder folder = _folders[_selectedFolderIndex];
            FormCreateARule form = new FormCreateARule();
            form.Path = folder.Path;
            DialogResult dr = form.ShowDialog();
            if (dr != DialogResult.OK)
                return;

            BRule r = new BRule();
            r.Description = form.Description;
            r.Enabled = form.IsEnabled;
            r.ConfirmAction = form.ConfirmAction;
            r.Recursive = form.Recursive;
            r.AllOrAny = form.AllOrAny;
            r.Conditions = form.Conditions;
            r.Action = form.Action;

            folder.Rules.Add(r);
            listViewRules.BeginUpdate();
            ListViewItem l = new ListViewItem(r.Description);
            l.Checked = r.Enabled;
            listViewRules.Items.Add(l);
            listViewRules.EndUpdate();
        }

        //TODO: Disable remove button when the rule list is empty
        private void buttonRuleRemove_Click(object sender, EventArgs e)
        {
            if (_selectedFolderIndex < 0)
            {
                MessageBox.Show("Please select a folder.");
                return;
            }
            if (_selectedRuleIndex < 0)
            {
                MessageBox.Show("Please select a rule.");
                return;
            }
            _folders[_selectedFolderIndex].Rules.RemoveAt(_selectedRuleIndex);
            listViewRules.BeginUpdate();
            listViewRules.Items.RemoveAt(_selectedRuleIndex);
            if (_selectedRuleIndex - 1 >= 0)
            {
                _selectedRuleIndex = _selectedRuleIndex - 1;
                listViewFolders.Items[_selectedRuleIndex].Selected = true;
            }
            listViewRules.EndUpdate();
        }

        private void buttonRuleEdit_Click(object sender, EventArgs e)
        {
            if (_selectedFolderIndex < 0)
            {
                MessageBox.Show("Please select a folder.");
                return;
            }
            if (_selectedRuleIndex < 0)
            {
                MessageBox.Show("Please select a rule.");
                return;
            }
            FormCreateARule form = new FormCreateARule();

            BRule r = _folders[_selectedFolderIndex].Rules[_selectedRuleIndex];
            form.Description = r.Description;
            form.IsEnabled = r.Enabled;
            form.ConfirmAction = r.ConfirmAction;
            form.Recursive = r.Recursive;
            form.AllOrAny = r.AllOrAny;
            form.Conditions = r.Conditions;
            form.Action = r.Action;

            DialogResult dr = form.ShowDialog();
            if (dr != DialogResult.OK)
                return;

            r.Description = form.Description;
            r.Enabled = form.IsEnabled;
            r.ConfirmAction = form.ConfirmAction;
            r.Recursive = form.Recursive;
            r.AllOrAny = form.AllOrAny;
            r.Conditions = form.Conditions;
            r.Action = form.Action;

            listViewRules.BeginUpdate();
            ListViewItem l = listViewRules.Items[_selectedRuleIndex];
            l.Text = r.Description;
            l.Checked = r.Enabled;
            listViewRules.EndUpdate();
        }

        private void listViewRules_ItemChecked(object sender, ItemCheckedEventArgs e)
        {
            BFolder f = _folders[_selectedFolderIndex];
            f.Rules[e.Item.Index].Enabled = e.Item.Checked;
        }

        private void listViewRules_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listViewRules.SelectedIndices.Count == 0)
            {
                _selectedRuleIndex = -1;
                return;
            }
            _selectedRuleIndex = listViewRules.SelectedIndices[0];
        }
        #endregion

        #region About
        private void toolStripMenuItemAbout_Click(object sender, EventArgs e)
        {
            FormAbout a = new FormAbout();
            a.ShowDialog();
        }
        #endregion

        #region Run
        private object _runLock = new object();
        private void Run()
        {
            lock (_runLock)
            {
                if (backgroundWorker.IsBusy)
                    return;

                if (this.WindowState != FormWindowState.Minimized) //Do not show main window when minimized
                    _formProgress.Show();
                else
                    this.Enabled = false;

                backgroundWorker.RunWorkerAsync();
            }
        }

        //TODO: Support cancel during run
        private void backgroundWorker_DoWork(object sender, DoWorkEventArgs e)
        {
            e.Result = true;
            if (!_belvedere.Run())
                e.Result = false;
        }

        //TODO: Show progress
        private void backgroundWorker_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {

        }

        private void backgroundWorker_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            _formProgress.Hide();
            this.Enabled = true;

            //TODO: Show balloon tip after run completed
            //if (_notifyIcon != null && this.WindowState == FormWindowState.Minimized)
            //    _notifyIcon.ShowBalloonTip(1000);

            if (!((bool)e.Result))
                MessageBox.Show("Error occured during execution. Please check log.txt for details.");
        }
        #endregion

        #region Preference
        private void textBoxSleeptime_Validating(object sender, CancelEventArgs e)
        {
            try
            {
                int.Parse(textBoxSleeptime.Text);
            }
            catch (Exception)
            {
                MessageBox.Show("Please enter numeric number only. (0...9)");
                textBoxSleeptime.Undo();
                e.Cancel = true;
            }
        }

        private void buttonSavePreference_Click(object sender, EventArgs e)
        {
            try
            {
                _belvedere.SleepTime = int.Parse(textBoxSleeptime.Text);
            }
            catch (Exception ex)
            {
                Log.Error("Error occured during save preference", ex);
            }
        }
        #endregion

        #region Timer
        private int _currentTime = 0;
        private void toolStripMenuItemStartTimer_Click(object sender, EventArgs e)
        {
            EnableStartNotStopMenuItems(false);      

            if (!timerBgWorker.IsBusy)
                timerBgWorker.RunWorkerAsync();
            Log.Info("Timer started");
        }

        private void toolStripMenuItemStopTimer_Click(object sender, EventArgs e)
        {
            timerBgWorker.CancelAsync();
        }

        private void timerBgWorker_DoWork(object sender, DoWorkEventArgs e)
        {
            while (!timerBgWorker.CancellationPending)
            {
                Thread.Sleep(500);
                _currentTime += 500;
                double currentMin = _currentTime / 60000.0;
                timerBgWorker.ReportProgress(currentMin > _belvedere.SleepTime ? 100 : (int)currentMin / _belvedere.SleepTime, _belvedere.SleepTime - currentMin);
            }
            e.Cancel = true;
        }

        private void timerBgWorker_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            double remain = (double)e.UserState;
            if (this.WindowState != FormWindowState.Minimized)
            {
                statusLabelTime.Text = string.Format("{0:f2} mins", remain);
                if (_notifyIcon != null)
                    _notifyIcon.Text = string.Format("Run in {0:f2}", remain);
                    //_notifyIcon.BalloonTipText = string.Format("Run in {0:f2}", remain);
            }

            if (remain <= 0)
            {
                Log.Info("File management initialized by timer.");
                this.Run();
                _currentTime = 0;
            }
        }

        private void timerBgWorker_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            statusLabelTime.Text = "Stopped";
            if (_notifyIcon != null)
                _notifyIcon.Text = "Timer stopped";
                //_notifyIcon.BalloonTipText = "Timer stopped";
            _currentTime = 0;

            EnableStartNotStopMenuItems(true);
            Log.Info("Timer stopped");
        }

        private void EnableStartNotStopMenuItems(bool f)
        {
            toolStripMenuItemStartTimer.Enabled = f;
            toolStripMenuItemStopTimer.Enabled = !f;
            startToolStripMenuItem.Enabled = f;
            stopToolStripMenuItem.Enabled = !f;
        }
        #endregion

        #region Log
        private void tabControlMain_Selected(object sender, TabControlEventArgs e)
        {
            if (tabControlMain.SelectedIndex == 2)
                LoadLog();
        }

        private void buttonLogRefresh_Click(object sender, EventArgs e)
        {
            LoadLog();
        }

        private void LoadLog()
        {
            try
            {
                using (FileStream fs = File.Open("log.txt", FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
                {
                    textBoxLog.Text = (new StreamReader(fs)).ReadToEnd();
                }
            }
            catch { }
        }
        #endregion
    }
}
