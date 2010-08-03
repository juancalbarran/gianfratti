using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.IO;
using System.Security.Cryptography;
using System.IO.IsolatedStorage;
using System.Runtime.InteropServices;
namespace CryptoSafe
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		byte [] cryptoKey = null;
		byte [] cryptoIV = null;
		string workingDirectory = null;
        string password = null;

		CryptoManager crm = null;

		private System.Windows.Forms.ListView listView1;
		private System.Windows.Forms.ColumnHeader columnHeader1;
		private System.Windows.Forms.ListView listView2;
		private System.Windows.Forms.ColumnHeader columnHeader2;
		private System.Windows.Forms.RichTextBox richTextBox1;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Button button1;
		private System.Windows.Forms.Button btnLeft;
		private System.Windows.Forms.Button btnRight;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.ComboBox comboBox1;
		private System.Windows.Forms.TabControl tabControl1;
		private System.Windows.Forms.TabPage tabPage1;
		private System.Windows.Forms.TabPage tabPage2;
		private System.Windows.Forms.Button btnAddDir;
		private System.Windows.Forms.Button btnRemoveDir;
		private System.Windows.Forms.ColumnHeader columnHeader3;
		private System.Windows.Forms.ColumnHeader columnHeader4;
		private System.Windows.Forms.ImageList imageList2;
		private System.Windows.Forms.ImageList imageList1;
		private System.Windows.Forms.ProgressBar progressBar1;
		private System.Windows.Forms.ListBox lbFolders;
        private Label label4;
        private TextBox txtSenha;
        private TabPage tabPage3;
        private PictureBox pictureBox1;
        private Label label5;
        private TextBox txtSenhaConfirma;
		private System.ComponentModel.IContainer components;

		public Form1()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			crm = new CryptoManager();
			crm.progressMessage += new cryptoEventHandler(crm_progressMessage);
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if (components != null) 
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.listView1 = new System.Windows.Forms.ListView();
            this.columnHeader1 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader3 = new System.Windows.Forms.ColumnHeader();
            this.imageList1 = new System.Windows.Forms.ImageList(this.components);
            this.listView2 = new System.Windows.Forms.ListView();
            this.columnHeader2 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader4 = new System.Windows.Forms.ColumnHeader();
            this.imageList2 = new System.Windows.Forms.ImageList(this.components);
            this.richTextBox1 = new System.Windows.Forms.RichTextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.btnLeft = new System.Windows.Forms.Button();
            this.btnRight = new System.Windows.Forms.Button();
            this.label3 = new System.Windows.Forms.Label();
            this.comboBox1 = new System.Windows.Forms.ComboBox();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.txtSenha = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.progressBar1 = new System.Windows.Forms.ProgressBar();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.btnRemoveDir = new System.Windows.Forms.Button();
            this.btnAddDir = new System.Windows.Forms.Button();
            this.lbFolders = new System.Windows.Forms.ListBox();
            this.tabPage3 = new System.Windows.Forms.TabPage();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.label5 = new System.Windows.Forms.Label();
            this.txtSenhaConfirma = new System.Windows.Forms.TextBox();
            this.tabControl1.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.tabPage2.SuspendLayout();
            this.tabPage3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // listView1
            // 
            this.listView1.AllowDrop = true;
            this.listView1.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1,
            this.columnHeader3});
            this.listView1.FullRowSelect = true;
            this.listView1.GridLines = true;
            this.listView1.Location = new System.Drawing.Point(8, 64);
            this.listView1.Name = "listView1";
            this.listView1.Size = new System.Drawing.Size(240, 224);
            this.listView1.SmallImageList = this.imageList1;
            this.listView1.Sorting = System.Windows.Forms.SortOrder.Ascending;
            this.listView1.TabIndex = 0;
            this.listView1.UseCompatibleStateImageBehavior = false;
            this.listView1.View = System.Windows.Forms.View.Details;
            this.listView1.ItemActivate += new System.EventHandler(this.listView1_ItemActivate);
            this.listView1.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this.listView1_ColumnClick);
            // 
            // columnHeader1
            // 
            this.columnHeader1.Text = "Nome";
            this.columnHeader1.Width = 140;
            // 
            // columnHeader3
            // 
            this.columnHeader3.Text = "Tamanho";
            // 
            // imageList1
            // 
            this.imageList1.ColorDepth = System.Windows.Forms.ColorDepth.Depth8Bit;
            this.imageList1.ImageSize = new System.Drawing.Size(16, 16);
            this.imageList1.TransparentColor = System.Drawing.Color.Transparent;
            // 
            // listView2
            // 
            this.listView2.AllowDrop = true;
            this.listView2.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader2,
            this.columnHeader4});
            this.listView2.FullRowSelect = true;
            this.listView2.GridLines = true;
            this.listView2.Location = new System.Drawing.Point(296, 64);
            this.listView2.Name = "listView2";
            this.listView2.Size = new System.Drawing.Size(240, 224);
            this.listView2.SmallImageList = this.imageList2;
            this.listView2.Sorting = System.Windows.Forms.SortOrder.Ascending;
            this.listView2.TabIndex = 0;
            this.listView2.UseCompatibleStateImageBehavior = false;
            this.listView2.View = System.Windows.Forms.View.Details;
            this.listView2.ItemActivate += new System.EventHandler(this.listView2_ItemActivate);
            this.listView2.ColumnClick += new System.Windows.Forms.ColumnClickEventHandler(this.listView2_ColumnClick);
            // 
            // columnHeader2
            // 
            this.columnHeader2.Text = "Nome";
            this.columnHeader2.Width = 140;
            // 
            // columnHeader4
            // 
            this.columnHeader4.Text = "Tamanho";
            // 
            // imageList2
            // 
            this.imageList2.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imageList2.ImageStream")));
            this.imageList2.TransparentColor = System.Drawing.Color.Transparent;
            this.imageList2.Images.SetKeyName(0, "");
            // 
            // richTextBox1
            // 
            this.richTextBox1.Location = new System.Drawing.Point(8, 296);
            this.richTextBox1.Name = "richTextBox1";
            this.richTextBox1.Size = new System.Drawing.Size(528, 88);
            this.richTextBox1.TabIndex = 1;
            this.richTextBox1.Text = "";
            // 
            // label1
            // 
            this.label1.Location = new System.Drawing.Point(8, 48);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(200, 16);
            this.label1.TabIndex = 2;
            this.label1.Text = "Arquivos Originais";
            // 
            // label2
            // 
            this.label2.Location = new System.Drawing.Point(296, 48);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(216, 16);
            this.label2.TabIndex = 2;
            this.label2.Text = "Arquivos Criptografados";
            // 
            // button1
            // 
            this.button1.BackgroundImage = global::CryptoSafe.Properties.Resources.refresh;
            this.button1.Location = new System.Drawing.Point(261, 168);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(22, 23);
            this.button1.TabIndex = 3;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // btnLeft
            // 
            this.btnLeft.Location = new System.Drawing.Point(256, 216);
            this.btnLeft.Name = "btnLeft";
            this.btnLeft.Size = new System.Drawing.Size(32, 23);
            this.btnLeft.TabIndex = 4;
            this.btnLeft.Text = "<<";
            this.btnLeft.Click += new System.EventHandler(this.btnLeft_Click);
            // 
            // btnRight
            // 
            this.btnRight.Location = new System.Drawing.Point(256, 112);
            this.btnRight.Name = "btnRight";
            this.btnRight.Size = new System.Drawing.Size(32, 23);
            this.btnRight.TabIndex = 4;
            this.btnRight.Text = ">>";
            this.btnRight.Click += new System.EventHandler(this.btnRight_Click);
            // 
            // label3
            // 
            this.label3.Location = new System.Drawing.Point(8, 5);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(96, 23);
            this.label3.TabIndex = 5;
            this.label3.Text = "Pasta Atual:";
            // 
            // comboBox1
            // 
            this.comboBox1.Location = new System.Drawing.Point(81, 5);
            this.comboBox1.Name = "comboBox1";
            this.comboBox1.Size = new System.Drawing.Size(455, 21);
            this.comboBox1.TabIndex = 6;
            this.comboBox1.SelectedIndexChanged += new System.EventHandler(this.comboBox1_SelectedIndexChanged);
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tabPage1);
            this.tabControl1.Controls.Add(this.tabPage2);
            this.tabControl1.Controls.Add(this.tabPage3);
            this.tabControl1.Location = new System.Drawing.Point(0, 0);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(552, 432);
            this.tabControl1.TabIndex = 8;
            this.tabControl1.SelectedIndexChanged += new System.EventHandler(this.tabControl1_SelectedIndexChanged);
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.txtSenhaConfirma);
            this.tabPage1.Controls.Add(this.label5);
            this.tabPage1.Controls.Add(this.txtSenha);
            this.tabPage1.Controls.Add(this.label4);
            this.tabPage1.Controls.Add(this.progressBar1);
            this.tabPage1.Controls.Add(this.btnRight);
            this.tabPage1.Controls.Add(this.listView2);
            this.tabPage1.Controls.Add(this.comboBox1);
            this.tabPage1.Controls.Add(this.listView1);
            this.tabPage1.Controls.Add(this.label3);
            this.tabPage1.Controls.Add(this.btnLeft);
            this.tabPage1.Controls.Add(this.label2);
            this.tabPage1.Controls.Add(this.label1);
            this.tabPage1.Controls.Add(this.richTextBox1);
            this.tabPage1.Controls.Add(this.button1);
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Size = new System.Drawing.Size(544, 406);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Arquivos";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // txtSenha
            // 
            this.txtSenha.Location = new System.Drawing.Point(81, 31);
            this.txtSenha.MaxLength = 20;
            this.txtSenha.Name = "txtSenha";
            this.txtSenha.PasswordChar = '*';
            this.txtSenha.Size = new System.Drawing.Size(167, 20);
            this.txtSenha.TabIndex = 9;
            // 
            // label4
            // 
            this.label4.Location = new System.Drawing.Point(8, 31);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(96, 17);
            this.label4.TabIndex = 8;
            this.label4.Text = "Senha:";
            // 
            // progressBar1
            // 
            this.progressBar1.Location = new System.Drawing.Point(16, 392);
            this.progressBar1.Name = "progressBar1";
            this.progressBar1.Size = new System.Drawing.Size(504, 8);
            this.progressBar1.TabIndex = 7;
            // 
            // tabPage2
            // 
            this.tabPage2.Controls.Add(this.btnRemoveDir);
            this.tabPage2.Controls.Add(this.btnAddDir);
            this.tabPage2.Controls.Add(this.lbFolders);
            this.tabPage2.Location = new System.Drawing.Point(4, 22);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Size = new System.Drawing.Size(544, 406);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "Pastas";
            this.tabPage2.UseVisualStyleBackColor = true;
            // 
            // btnRemoveDir
            // 
            this.btnRemoveDir.Location = new System.Drawing.Point(74, 376);
            this.btnRemoveDir.Name = "btnRemoveDir";
            this.btnRemoveDir.Size = new System.Drawing.Size(62, 23);
            this.btnRemoveDir.TabIndex = 9;
            this.btnRemoveDir.Text = "Remover";
            this.btnRemoveDir.Click += new System.EventHandler(this.btnRemoveDir_Click_1);
            // 
            // btnAddDir
            // 
            this.btnAddDir.Location = new System.Drawing.Point(8, 376);
            this.btnAddDir.Name = "btnAddDir";
            this.btnAddDir.Size = new System.Drawing.Size(60, 23);
            this.btnAddDir.TabIndex = 8;
            this.btnAddDir.Text = "Adicionar";
            this.btnAddDir.Click += new System.EventHandler(this.btnAddDir_Click_1);
            // 
            // lbFolders
            // 
            this.lbFolders.Location = new System.Drawing.Point(0, 8);
            this.lbFolders.Name = "lbFolders";
            this.lbFolders.Size = new System.Drawing.Size(536, 355);
            this.lbFolders.TabIndex = 0;
            // 
            // tabPage3
            // 
            this.tabPage3.Controls.Add(this.pictureBox1);
            this.tabPage3.Location = new System.Drawing.Point(4, 22);
            this.tabPage3.Name = "tabPage3";
            this.tabPage3.Size = new System.Drawing.Size(544, 406);
            this.tabPage3.TabIndex = 2;
            this.tabPage3.Text = "About";
            this.tabPage3.UseVisualStyleBackColor = true;
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.InitialImage = null;
            this.pictureBox1.Location = new System.Drawing.Point(17, 140);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(507, 89);
            this.pictureBox1.TabIndex = 0;
            this.pictureBox1.TabStop = false;
            // 
            // label5
            // 
            this.label5.Location = new System.Drawing.Point(295, 31);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(96, 17);
            this.label5.TabIndex = 10;
            this.label5.Text = "Confirma Senha:";
            // 
            // txtSenhaConfirma
            // 
            this.txtSenhaConfirma.Location = new System.Drawing.Point(390, 31);
            this.txtSenhaConfirma.MaxLength = 20;
            this.txtSenhaConfirma.Name = "txtSenhaConfirma";
            this.txtSenhaConfirma.PasswordChar = '*';
            this.txtSenhaConfirma.Size = new System.Drawing.Size(146, 20);
            this.txtSenhaConfirma.TabIndex = 11;
            // 
            // Form1
            // 
            this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
            this.ClientSize = new System.Drawing.Size(554, 439);
            this.Controls.Add(this.tabControl1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Criptografia de Arquivos";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.tabControl1.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.tabPage1.PerformLayout();
            this.tabPage2.ResumeLayout(false);
            this.tabPage3.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);

		}
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.Run(new Form1());
		}

		private void Form1_Load(object sender, System.EventArgs e)
		{
            loadSettings();
            updateCombo();
            refreshFileList();
		}

		private void listView1_ItemActivate(object sender, System.EventArgs e)
		{
			if (listView1.SelectedItems.Count == 0)
				return;

			this.Cursor = Cursors.WaitCursor;

			ListViewItem lvi = listView1.SelectedItems[0];
			string filename = lvi.Tag.ToString();

			System.Diagnostics.Process.Start(filename);
			this.Cursor = Cursors.Arrow;
		}

		private void listView2_ItemActivate(object sender, System.EventArgs e)
		{
			moveLeft();
		}

		void refreshFileList()
		{
			listView1.Items.Clear();
			listView2.Items.Clear();

			if (workingDirectory == null || workingDirectory.Length == 0)
				return;
			this.Cursor = Cursors.WaitCursor;
			try
			{
				string[] files = Directory.GetFiles(workingDirectory);
				int imageIndex = 0;
				imageList1.Images.Clear();
				SHFILEINFO shinfo = new SHFILEINFO();
				listView1.BeginUpdate();
				listView2.BeginUpdate();
				foreach (string s in files)
				{
					FileInfo fi = new FileInfo(s);
					if (fi.Extension.ToLower() == ".enc")
					{
						ListViewItem lvi = new ListViewItem(fi.Name);
						lvi.SubItems.Add(fi.Length.ToString());
						lvi.Tag = fi.FullName;
						lvi.ImageIndex = 0;
						listView2.Items.Add(lvi);
					}
					else
					{
						//extract file icon
						IntPtr hImgSmall = MyShell.SHGetFileInfo(s, 0, ref shinfo,(uint)Marshal.SizeOf(shinfo),
							MyShell.SHGFI_ICON |
							MyShell.SHGFI_SMALLICON);
						//The icon is returned in the hIcon member of the shinfo
						//struct
						System.Drawing.Icon myIcon = System.Drawing.Icon.FromHandle(shinfo.hIcon);
						imageList1.Images.Add(myIcon);

						ListViewItem lvi = new ListViewItem(fi.Name);
						lvi.ImageIndex = imageIndex++;
						lvi.SubItems.Add(fi.Length.ToString());
						lvi.Tag = fi.FullName;
						listView1.Items.Add(lvi);
					}
				}
				listView1.EndUpdate();
				listView2.EndUpdate();
			}
			catch(IOException ex)
			{
				MessageBox.Show("Erro ao atualizar lista de arquivos: "+ex.Message);
			}
			finally
			{
				this.Cursor = Cursors.Arrow;
			}
		}

		private void btnLeft_Click(object sender, System.EventArgs e)
		{
			moveLeft();
		}

		private void btnRight_Click(object sender, System.EventArgs e)
		{
			moveRight();
		}

		private void button1_Click(object sender, System.EventArgs e)
		{
			refreshFileList();
		}

        /// <summary>
        /// Gera os passwords para criptografia dos arquivos
        /// </summary>
        private void Senha()
        {
            if (password != txtSenha.Text)
            {
                try
                {
                    //get keys from password
                    byte[] rk = null;
                    byte[] riv = null;

                    password = txtSenha.Text;
                    crm.getKeysFromPassword(password, out rk, out riv);
                    cryptoKey = rk;
                    cryptoIV = riv;
                }
                catch (FormatException ex)
                {
                    MessageBox.Show(ex.Message);
                    this.Close();
                    return;
                }
                catch (CryptographicException ex)
                {
                    MessageBox.Show(ex.Message);
                    this.Close();
                    return;
                }
            }
        }

        /// <summary>
        /// Valida a senha que o usuario digitar
        /// </summary>
        /// <returns></returns>
        private bool validaSenha()
        {
            if (txtSenha.Text.Trim() == null || txtSenha.Text.Trim() == string.Empty)
            {
                MessageBox.Show("Obrigatório o preenchimento da senha.");
                txtSenha.Focus();
                return false;
            }
            else if (txtSenha.Text.Trim().Length < 6)
            {
                MessageBox.Show("Senha deve conter mínimo de 6 caracteres");
                txtSenha.Text = string.Empty;
                txtSenha.Focus();
                return false;
            }
            else if (txtSenhaConfirma.Text.Trim() == null || txtSenhaConfirma.Text.Trim() == string.Empty)
            {
                MessageBox.Show("Digite a confirmação da senha.");
                txtSenhaConfirma.Focus();
                return false;
            }
            else if (txtSenha.Text.Trim() != txtSenhaConfirma.Text.Trim())
            {
                MessageBox.Show("As senhas digitadas não conhecidem.");
                txtSenhaConfirma.Text = string.Empty;
                txtSenhaConfirma.Focus();
                return false;
            }
            else
            {
                return true;
            }
        }

		void moveRight()
		{
            if(validaSenha())
            {
                Senha();

                richTextBox1.Clear();
                if (listView1.SelectedItems.Count == 0)
                    return;

                this.Cursor = Cursors.WaitCursor;

                foreach (ListViewItem lvi in listView1.SelectedItems)
                {
                    string origName = lvi.Tag.ToString();
                    string encName = origName + ".enc";

                    try
                    {
                        crm.EncryptData(origName, encName, cryptoKey, cryptoIV);
                        FileInfo fi = new FileInfo(origName);
                        FileInfo fi2 = new FileInfo(encName);
                        //remove readonly attribute
                        if ((fi.Attributes & FileAttributes.ReadOnly) == FileAttributes.ReadOnly)
                        {
                            fi.Attributes &= ~FileAttributes.ReadOnly;
                        }

                        //copy creation and modification time
                        fi2.CreationTime = fi.CreationTime;
                        fi2.LastWriteTime = fi.LastWriteTime;
                        fi2.Attributes = FileAttributes.ReadOnly | FileAttributes.Archive;

                        //delete original file
                        File.Delete(origName);

                    }
                    catch (CryptographicException ex)
                    {
                        MessageBox.Show(ex.Message);
                    }
                    catch (IOException ex)
                    {
                        MessageBox.Show(ex.Message);
                    }
                    catch (UnauthorizedAccessException ex)
                    {
                        //i.e. readonly
                        MessageBox.Show(ex.Message);
                    }
                }

                refreshFileList();
                this.Cursor = Cursors.Arrow;
            }
		}

		void moveLeft()
		{
            if (validaSenha())
            {
                Senha();

                richTextBox1.Clear();
                if (listView2.SelectedItems.Count == 0)
                    return;

                this.Cursor = Cursors.WaitCursor;

                foreach (ListViewItem lvi in listView2.SelectedItems)
                {
                    string encName = lvi.Tag.ToString();
                    string ext = Path.GetExtension(encName).ToLower();
                    if (ext != ".enc")
                        return;

                    string origName = Path.GetDirectoryName(encName) + "\\" + Path.GetFileNameWithoutExtension(encName);

                    try
                    {
                        if (crm.DecryptData(encName, origName, cryptoKey, cryptoIV))
                        {
                            FileInfo fi = new FileInfo(encName);
                            FileInfo fi2 = new FileInfo(origName);
                            if ((fi.Attributes & FileAttributes.ReadOnly) == FileAttributes.ReadOnly)
                            {
                                fi.Attributes &= ~FileAttributes.ReadOnly;
                            }
                            //copy creation and modification time
                            fi2.CreationTime = fi.CreationTime;
                            fi2.LastWriteTime = fi.LastWriteTime;
                            //delete encrypted file
                            File.Delete(encName);
                        }
                        else
                        {
                            MessageBox.Show("O arquivo nao pode ser descriptografado, provavelmente password errado");
                        }
                    }
                    catch (CryptographicException ex)
                    {
                        MessageBox.Show(ex.Message);
                    }
                    catch (IOException ex)
                    {
                        MessageBox.Show(ex.Message);
                    }
                    catch (UnauthorizedAccessException ex)
                    {
                        //i.e. readonly
                        MessageBox.Show(ex.Message);
                    }
                }
                refreshFileList();
                this.Cursor = Cursors.Arrow;
            }
		}

		private void comboBox1_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			workingDirectory = comboBox1.SelectedItem.ToString();
			refreshFileList();
		}

		private void btnAddDir_Click_1(object sender, System.EventArgs e)
		{
			using(FolderBrowserDialog fd = new FolderBrowserDialog())
			{
				if (fd.ShowDialog() == DialogResult.OK)
				{
					if (lbFolders.Items.Contains(fd.SelectedPath))
					{
						MessageBox.Show("Pasta já selecionada");
					}
					else
					{
						lbFolders.Items.Add(fd.SelectedPath);
						saveSettings();
					}
				}
			}
		
		}

		private void btnRemoveDir_Click_1(object sender, System.EventArgs e)
		{
			lbFolders.Items.Remove(lbFolders.SelectedItem);
			saveSettings();
		}

		void updateCombo()
		{
			comboBox1.Items.Clear();
			comboBox1.Text = "";
			foreach (string s in lbFolders.Items)
			{
				comboBox1.Items.Add(s);
			}
			if (comboBox1.Items.Count > 0)
				comboBox1.SelectedIndex = 0;
			else
			{
				workingDirectory = "";
				refreshFileList();
			}
		}

		void saveSettings()
		{
			// Retrieve an IsolatedStorageFile for the current Domain and Assembly.
			try
			{
				IsolatedStorageFile isoFile = IsolatedStorageFile.GetStore(IsolatedStorageScope.User |
					IsolatedStorageScope.Assembly |
					IsolatedStorageScope.Domain , null,null);

				IsolatedStorageFileStream fs = new IsolatedStorageFileStream("cryptoSettings.txt",FileMode.Create,FileAccess.Write);
				StreamWriter sw = new StreamWriter(fs);
				foreach (string fname in lbFolders.Items)
					sw.WriteLine(fname);
				sw.Close();
				isoFile.Close();
				
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show(ex.Message);
			}
			catch (IOException ex)
			{
				MessageBox.Show(ex.Message);
			}
		}

		void loadSettings()
		{
			// Retrieve an IsolatedStorageFile for the current Domain and Assembly.
			try
			{
				lbFolders.Items.Clear();
				IsolatedStorageFile isoFile = IsolatedStorageFile.GetStore(IsolatedStorageScope.User |
					IsolatedStorageScope.Assembly |
					IsolatedStorageScope.Domain , null,null);

				IsolatedStorageFileStream fs = new IsolatedStorageFileStream("cryptoSettings.txt",FileMode.Open,FileAccess.Read);
				StreamReader sr = new StreamReader(fs);
				while (true)
				{
					string l = sr.ReadLine();
					if (l == null)
						break;
					lbFolders.Items.Add(l);
				}

				sr.Close();
				isoFile.Close();
				
			}
			catch (FileNotFoundException)
			{
				//MessageBox.Show("application settings file not found - please set working folders");
			}
			catch (IsolatedStorageException ex)
			{
				MessageBox.Show(ex.Message);
			}
			catch (IOException ex)
			{
				MessageBox.Show(ex.Message);
			}
		}

		private void tabControl1_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			if (tabControl1.SelectedIndex == 0)
			{
				updateCombo();
			}
		}

		#region list sorting
		private int lastClickedColumn = -1;
		private void listView1_ColumnClick(object sender, System.Windows.Forms.ColumnClickEventArgs e)
		{
			if (e.Column == lastClickedColumn)
			{
				if (listView1.Sorting == SortOrder.Ascending)
					listView1.Sorting = SortOrder.Descending;
				else
					listView1.Sorting = SortOrder.Ascending;
			}
			else
			{
				lastClickedColumn = e.Column;
				listView1.Sorting = SortOrder.Ascending;
			}
			listView1.ListViewItemSorter = new ListViewItemComparer(e.Column, (listView1.Sorting==SortOrder.Ascending));
			listView1.Sort();
		
		}

		private void listView2_ColumnClick(object sender, System.Windows.Forms.ColumnClickEventArgs e)
		{
			if (e.Column == lastClickedColumn)
			{
				if (listView2.Sorting == SortOrder.Ascending)
					listView2.Sorting = SortOrder.Descending;
				else
					listView2.Sorting = SortOrder.Ascending;
			}
			else
			{
				listView2.Sorting = SortOrder.Ascending;
				lastClickedColumn = e.Column;
			}
			listView2.ListViewItemSorter = new ListViewItemComparer(e.Column,(listView2.Sorting==SortOrder.Ascending));
			listView2.Sort();
			
		}

		class ListViewItemComparer : IComparer 
		{
			private int col;
			bool ascending = true;
			public ListViewItemComparer() 
			{
				col=0;
			}
			public ListViewItemComparer(int column, bool ascending) 
			{
				col=column;
				this.ascending = ascending;
			}
			public int Compare(object x, object y) 
			{
				if (col == 0)
				{
					if (ascending)
						return String.Compare(((ListViewItem)x).SubItems[col].Text, ((ListViewItem)y).SubItems[col].Text);
					else
						return -String.Compare(((ListViewItem)x).SubItems[col].Text, ((ListViewItem)y).SubItems[col].Text);
				}
				else if (col == 1)
				{
					int i1 = int.Parse(((ListViewItem)x).SubItems[col].Text);
					int i2 = int.Parse(((ListViewItem)y).SubItems[col].Text);
					if (ascending)
						return i1-i2;
					else
						return i2-i1;
				}
				return 0;
			}
		}
		#endregion

		void crm_progressMessage(object sender, CryptoEventArgs e)
		{
			if (e.Type == CryptoEventType.FileProgress)
			{
				if (progressBar1.Maximum != e.FileLength)
					progressBar1.Maximum = e.FileLength;
				progressBar1.Value = e.FilePosition;
			}
			else //message
			{
				richTextBox1.AppendText(e.Message);
				richTextBox1.AppendText("\r\n");
				richTextBox1.Update();
			}
		}

	}
}
