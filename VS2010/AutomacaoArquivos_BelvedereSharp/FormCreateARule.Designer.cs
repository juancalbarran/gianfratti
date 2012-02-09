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

namespace BelvedereSharp
{
    partial class FormCreateARule
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormCreateARule));
            this.label1 = new System.Windows.Forms.Label();
            this.labelFolder = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.textBoxDescription = new System.Windows.Forms.TextBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.checkBoxRecursive = new System.Windows.Forms.CheckBox();
            this.checkBoxConfirmAction = new System.Windows.Forms.CheckBox();
            this.checkBoxEnabled = new System.Windows.Forms.CheckBox();
            this.label3 = new System.Windows.Forms.Label();
            this.comboBoxAllOrAny = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.comboBoxElement = new System.Windows.Forms.ComboBox();
            this.comboBoxCondition = new System.Windows.Forms.ComboBox();
            this.textBoxParameter = new System.Windows.Forms.TextBox();
            this.buttonConditionAdd = new System.Windows.Forms.Button();
            this.listViewConditions = new System.Windows.Forms.ListView();
            this.columnProperty = new System.Windows.Forms.ColumnHeader();
            this.columnCondition = new System.Windows.Forms.ColumnHeader();
            this.columnArgument = new System.Windows.Forms.ColumnHeader();
            this.label5 = new System.Windows.Forms.Label();
            this.comboBoxAction = new System.Windows.Forms.ComboBox();
            this.labelToFolder = new System.Windows.Forms.Label();
            this.textBoxDestination = new System.Windows.Forms.TextBox();
            this.buttonFolderBrowser = new System.Windows.Forms.Button();
            this.checkBoxOverwrite = new System.Windows.Forms.CheckBox();
            this.button3 = new System.Windows.Forms.Button();
            this.buttonOK = new System.Windows.Forms.Button();
            this.button5 = new System.Windows.Forms.Button();
            this.buttonConditionRemove = new System.Windows.Forms.Button();
            this.folderBrowserDialog = new System.Windows.Forms.FolderBrowserDialog();
            this.label7 = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(36, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(39, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Folder:";
            // 
            // labelFolder
            // 
            this.labelFolder.Location = new System.Drawing.Point(78, 9);
            this.labelFolder.Name = "labelFolder";
            this.labelFolder.Size = new System.Drawing.Size(400, 13);
            this.labelFolder.TabIndex = 1;
            this.labelFolder.Text = "Folder";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 37);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(63, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "Description:";
            // 
            // textBoxDescription
            // 
            this.textBoxDescription.Location = new System.Drawing.Point(81, 34);
            this.textBoxDescription.Multiline = true;
            this.textBoxDescription.Name = "textBoxDescription";
            this.textBoxDescription.Size = new System.Drawing.Size(380, 60);
            this.textBoxDescription.TabIndex = 3;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.checkBoxRecursive);
            this.groupBox1.Controls.Add(this.checkBoxConfirmAction);
            this.groupBox1.Controls.Add(this.checkBoxEnabled);
            this.groupBox1.Location = new System.Drawing.Point(484, 9);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(112, 93);
            this.groupBox1.TabIndex = 4;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Rule Options";
            // 
            // checkBoxRecursive
            // 
            this.checkBoxRecursive.AutoSize = true;
            this.checkBoxRecursive.Enabled = false;
            this.checkBoxRecursive.Location = new System.Drawing.Point(7, 68);
            this.checkBoxRecursive.Name = "checkBoxRecursive";
            this.checkBoxRecursive.Size = new System.Drawing.Size(74, 17);
            this.checkBoxRecursive.TabIndex = 2;
            this.checkBoxRecursive.Text = "Recursive";
            this.checkBoxRecursive.UseVisualStyleBackColor = true;
            // 
            // checkBoxConfirmAction
            // 
            this.checkBoxConfirmAction.AutoSize = true;
            this.checkBoxConfirmAction.Enabled = false;
            this.checkBoxConfirmAction.Location = new System.Drawing.Point(7, 44);
            this.checkBoxConfirmAction.Name = "checkBoxConfirmAction";
            this.checkBoxConfirmAction.Size = new System.Drawing.Size(94, 17);
            this.checkBoxConfirmAction.TabIndex = 1;
            this.checkBoxConfirmAction.Text = "Confirm Action";
            this.checkBoxConfirmAction.UseVisualStyleBackColor = true;
            // 
            // checkBoxEnabled
            // 
            this.checkBoxEnabled.AutoSize = true;
            this.checkBoxEnabled.Location = new System.Drawing.Point(7, 20);
            this.checkBoxEnabled.Name = "checkBoxEnabled";
            this.checkBoxEnabled.Size = new System.Drawing.Size(65, 17);
            this.checkBoxEnabled.TabIndex = 0;
            this.checkBoxEnabled.Text = "Enabled";
            this.checkBoxEnabled.UseVisualStyleBackColor = true;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(12, 124);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(16, 13);
            this.label3.TabIndex = 6;
            this.label3.Text = "If ";
            // 
            // comboBoxAllOrAny
            // 
            this.comboBoxAllOrAny.FormattingEnabled = true;
            this.comboBoxAllOrAny.Items.AddRange(new object[] {
            "ALL",
            "ANY"});
            this.comboBoxAllOrAny.Location = new System.Drawing.Point(30, 121);
            this.comboBoxAllOrAny.Name = "comboBoxAllOrAny";
            this.comboBoxAllOrAny.Size = new System.Drawing.Size(70, 21);
            this.comboBoxAllOrAny.TabIndex = 7;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(107, 123);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(170, 13);
            this.label4.TabIndex = 8;
            this.label4.Text = "of the following conditions are met:";
            // 
            // comboBoxElement
            // 
            this.comboBoxElement.Items.AddRange(new object[] {
            "Extension",
            "Name"});
            this.comboBoxElement.Location = new System.Drawing.Point(15, 149);
            this.comboBoxElement.Name = "comboBoxElement";
            this.comboBoxElement.Size = new System.Drawing.Size(121, 21);
            this.comboBoxElement.TabIndex = 9;
            // 
            // comboBoxCondition
            // 
            this.comboBoxCondition.Items.AddRange(new object[] {
            "is"});
            this.comboBoxCondition.Location = new System.Drawing.Point(143, 149);
            this.comboBoxCondition.Name = "comboBoxCondition";
            this.comboBoxCondition.Size = new System.Drawing.Size(121, 21);
            this.comboBoxCondition.TabIndex = 10;
            // 
            // textBoxParameter
            // 
            this.textBoxParameter.Location = new System.Drawing.Point(271, 149);
            this.textBoxParameter.Name = "textBoxParameter";
            this.textBoxParameter.Size = new System.Drawing.Size(270, 20);
            this.textBoxParameter.TabIndex = 11;
            // 
            // buttonConditionAdd
            // 
            this.buttonConditionAdd.Location = new System.Drawing.Point(543, 149);
            this.buttonConditionAdd.Name = "buttonConditionAdd";
            this.buttonConditionAdd.Size = new System.Drawing.Size(22, 23);
            this.buttonConditionAdd.TabIndex = 12;
            this.buttonConditionAdd.Text = "+";
            this.buttonConditionAdd.TextAlign = System.Drawing.ContentAlignment.TopRight;
            this.buttonConditionAdd.UseVisualStyleBackColor = true;
            this.buttonConditionAdd.Click += new System.EventHandler(this.buttonConditionAdd_Click);
            // 
            // listViewConditions
            // 
            this.listViewConditions.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnProperty,
            this.columnCondition,
            this.columnArgument});
            this.listViewConditions.FullRowSelect = true;
            this.listViewConditions.Location = new System.Drawing.Point(15, 178);
            this.listViewConditions.MultiSelect = false;
            this.listViewConditions.Name = "listViewConditions";
            this.listViewConditions.Size = new System.Drawing.Size(573, 143);
            this.listViewConditions.TabIndex = 13;
            this.listViewConditions.UseCompatibleStateImageBehavior = false;
            this.listViewConditions.View = System.Windows.Forms.View.Details;
            // 
            // columnProperty
            // 
            this.columnProperty.Text = "Property";
            this.columnProperty.Width = 119;
            // 
            // columnCondition
            // 
            this.columnCondition.Text = "Condition";
            this.columnCondition.Width = 65;
            // 
            // columnArgument
            // 
            this.columnArgument.Text = "Argument";
            this.columnArgument.Width = 385;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(12, 334);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(86, 13);
            this.label5.TabIndex = 14;
            this.label5.Text = "Do the following:";
            // 
            // comboBoxAction
            // 
            this.comboBoxAction.FormattingEnabled = true;
            this.comboBoxAction.Items.AddRange(new object[] {
            "Move file",
            "Copy file",
            "Send file to Recycle Bin",
            "Custom command"});
            this.comboBoxAction.Location = new System.Drawing.Point(15, 351);
            this.comboBoxAction.Name = "comboBoxAction";
            this.comboBoxAction.Size = new System.Drawing.Size(121, 21);
            this.comboBoxAction.TabIndex = 15;
            this.comboBoxAction.SelectedIndexChanged += new System.EventHandler(this.comboBoxAction_SelectedIndexChanged);
            // 
            // labelToFolder
            // 
            this.labelToFolder.AutoSize = true;
            this.labelToFolder.Location = new System.Drawing.Point(143, 355);
            this.labelToFolder.Name = "labelToFolder";
            this.labelToFolder.Size = new System.Drawing.Size(48, 13);
            this.labelToFolder.TabIndex = 16;
            this.labelToFolder.Text = "to folder:";
            // 
            // textBoxDestination
            // 
            this.textBoxDestination.Location = new System.Drawing.Point(198, 351);
            this.textBoxDestination.Name = "textBoxDestination";
            this.textBoxDestination.Size = new System.Drawing.Size(293, 20);
            this.textBoxDestination.TabIndex = 17;
            // 
            // buttonFolderBrowser
            // 
            this.buttonFolderBrowser.Location = new System.Drawing.Point(498, 351);
            this.buttonFolderBrowser.Name = "buttonFolderBrowser";
            this.buttonFolderBrowser.Size = new System.Drawing.Size(24, 23);
            this.buttonFolderBrowser.TabIndex = 18;
            this.buttonFolderBrowser.Text = "...";
            this.buttonFolderBrowser.UseVisualStyleBackColor = true;
            this.buttonFolderBrowser.Click += new System.EventHandler(this.buttonFolderBrowser_Click);
            // 
            // checkBoxOverwrite
            // 
            this.checkBoxOverwrite.AutoSize = true;
            this.checkBoxOverwrite.Enabled = false;
            this.checkBoxOverwrite.Location = new System.Drawing.Point(529, 354);
            this.checkBoxOverwrite.Name = "checkBoxOverwrite";
            this.checkBoxOverwrite.Size = new System.Drawing.Size(77, 17);
            this.checkBoxOverwrite.TabIndex = 19;
            this.checkBoxOverwrite.Text = "Overwrite?";
            this.checkBoxOverwrite.UseVisualStyleBackColor = true;
            // 
            // button3
            // 
            this.button3.Enabled = false;
            this.button3.Location = new System.Drawing.Point(15, 392);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(75, 23);
            this.button3.TabIndex = 20;
            this.button3.Text = "Test";
            this.button3.UseVisualStyleBackColor = true;
            // 
            // buttonOK
            // 
            this.buttonOK.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.buttonOK.Location = new System.Drawing.Point(429, 391);
            this.buttonOK.Name = "buttonOK";
            this.buttonOK.Size = new System.Drawing.Size(75, 23);
            this.buttonOK.TabIndex = 21;
            this.buttonOK.Text = "OK";
            this.buttonOK.UseVisualStyleBackColor = true;
            // 
            // button5
            // 
            this.button5.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.button5.Location = new System.Drawing.Point(510, 391);
            this.button5.Name = "button5";
            this.button5.Size = new System.Drawing.Size(75, 23);
            this.button5.TabIndex = 22;
            this.button5.Text = "Cancel";
            this.button5.UseVisualStyleBackColor = true;
            // 
            // buttonConditionRemove
            // 
            this.buttonConditionRemove.Location = new System.Drawing.Point(566, 149);
            this.buttonConditionRemove.Name = "buttonConditionRemove";
            this.buttonConditionRemove.Size = new System.Drawing.Size(22, 23);
            this.buttonConditionRemove.TabIndex = 23;
            this.buttonConditionRemove.Text = "-";
            this.buttonConditionRemove.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.buttonConditionRemove.UseVisualStyleBackColor = true;
            this.buttonConditionRemove.Click += new System.EventHandler(this.buttonConditionRemove_Click);
            // 
            // folderBrowserDialog
            // 
            this.folderBrowserDialog.Description = "Select a folder...";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(11, 98);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(589, 13);
            this.label7.TabIndex = 24;
            this.label7.Text = "_________________________________________________________________________________" +
                "________________";
            // 
            // FormCreateARule
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(611, 426);
            this.Controls.Add(this.buttonConditionRemove);
            this.Controls.Add(this.button5);
            this.Controls.Add(this.buttonOK);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.checkBoxOverwrite);
            this.Controls.Add(this.buttonFolderBrowser);
            this.Controls.Add(this.textBoxDestination);
            this.Controls.Add(this.labelToFolder);
            this.Controls.Add(this.comboBoxAction);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.listViewConditions);
            this.Controls.Add(this.buttonConditionAdd);
            this.Controls.Add(this.textBoxParameter);
            this.Controls.Add(this.comboBoxCondition);
            this.Controls.Add(this.comboBoxElement);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.comboBoxAllOrAny);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.textBoxDescription);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.labelFolder);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.label7);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "FormCreateARule";
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide;
            this.Text = "Create a rule...";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.FormCreateARule_FormClosing);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label labelFolder;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox textBoxDescription;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.CheckBox checkBoxRecursive;
        private System.Windows.Forms.CheckBox checkBoxConfirmAction;
        private System.Windows.Forms.CheckBox checkBoxEnabled;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.ComboBox comboBoxAllOrAny;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ComboBox comboBoxElement;
        private System.Windows.Forms.ComboBox comboBoxCondition;
        private System.Windows.Forms.TextBox textBoxParameter;
        private System.Windows.Forms.Button buttonConditionAdd;
        private System.Windows.Forms.ListView listViewConditions;
        private System.Windows.Forms.ColumnHeader columnProperty;
        private System.Windows.Forms.ColumnHeader columnCondition;
        private System.Windows.Forms.ColumnHeader columnArgument;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.ComboBox comboBoxAction;
        private System.Windows.Forms.Label labelToFolder;
        private System.Windows.Forms.TextBox textBoxDestination;
        private System.Windows.Forms.Button buttonFolderBrowser;
        private System.Windows.Forms.CheckBox checkBoxOverwrite;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.Button buttonOK;
        private System.Windows.Forms.Button button5;
        private System.Windows.Forms.Button buttonConditionRemove;
        private System.Windows.Forms.FolderBrowserDialog folderBrowserDialog;
        private System.Windows.Forms.Label label7;
    }
}