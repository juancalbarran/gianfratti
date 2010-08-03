namespace Translator
{
    partial class frmTranslator
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
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmTranslator));
            this.process1 = new System.Diagnostics.Process();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.progressBar1 = new System.Windows.Forms.ProgressBar();
            this.label3 = new System.Windows.Forms.Label();
            this.btnTraduzirIngles = new System.Windows.Forms.Button();
            this.btnCopiar = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.lbResultado = new System.Windows.Forms.TextBox();
            this.btnTraduzirPortugues = new System.Windows.Forms.Button();
            this.tbTexto = new System.Windows.Forms.TextBox();
            this.lblTexto = new System.Windows.Forms.Label();
            this.notifyIcon1 = new System.Windows.Forms.NotifyIcon(this.components);
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.proxyToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.proxyToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.aboutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.groupBox1.SuspendLayout();
            this.menuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // process1
            // 
            this.process1.StartInfo.Domain = "";
            this.process1.StartInfo.LoadUserProfile = false;
            this.process1.StartInfo.Password = null;
            this.process1.StartInfo.StandardErrorEncoding = null;
            this.process1.StartInfo.StandardOutputEncoding = null;
            this.process1.StartInfo.UserName = "";
            this.process1.SynchronizingObject = this;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.progressBar1);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.btnTraduzirIngles);
            this.groupBox1.Controls.Add(this.btnCopiar);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Controls.Add(this.lbResultado);
            this.groupBox1.Controls.Add(this.btnTraduzirPortugues);
            this.groupBox1.Controls.Add(this.tbTexto);
            this.groupBox1.Controls.Add(this.lblTexto);
            this.groupBox1.Location = new System.Drawing.Point(12, 35);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(261, 339);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Tradutor OnLine";
            // 
            // progressBar1
            // 
            this.progressBar1.Location = new System.Drawing.Point(110, 306);
            this.progressBar1.Name = "progressBar1";
            this.progressBar1.Size = new System.Drawing.Size(141, 23);
            this.progressBar1.TabIndex = 36;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Verdana", 12.5F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(106, 309);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(146, 20);
            this.label3.TabIndex = 35;
            this.label3.Text = "Gianfratti.com";
            this.label3.Visible = false;
            // 
            // btnTraduzirIngles
            // 
            this.btnTraduzirIngles.Location = new System.Drawing.Point(134, 149);
            this.btnTraduzirIngles.Name = "btnTraduzirIngles";
            this.btnTraduzirIngles.Size = new System.Drawing.Size(118, 23);
            this.btnTraduzirIngles.TabIndex = 33;
            this.btnTraduzirIngles.Text = "Inglês / Português";
            this.btnTraduzirIngles.UseVisualStyleBackColor = true;
            this.btnTraduzirIngles.Click += new System.EventHandler(this.btnTraduzirIngles_Click);
            // 
            // btnCopiar
            // 
            this.btnCopiar.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnCopiar.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.btnCopiar.Location = new System.Drawing.Point(10, 306);
            this.btnCopiar.Name = "btnCopiar";
            this.btnCopiar.Size = new System.Drawing.Size(87, 23);
            this.btnCopiar.TabIndex = 5;
            this.btnCopiar.Text = "Copiar Texto";
            this.btnCopiar.UseVisualStyleBackColor = true;
            this.btnCopiar.Click += new System.EventHandler(this.btnCopiar_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.label1.Location = new System.Drawing.Point(10, 184);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(87, 13);
            this.label1.TabIndex = 32;
            this.label1.Text = "Texto Traduzido:";
            // 
            // lbResultado
            // 
            this.lbResultado.Location = new System.Drawing.Point(10, 200);
            this.lbResultado.Multiline = true;
            this.lbResultado.Name = "lbResultado";
            this.lbResultado.ReadOnly = true;
            this.lbResultado.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.lbResultado.Size = new System.Drawing.Size(242, 100);
            this.lbResultado.TabIndex = 4;
            // 
            // btnTraduzirPortugues
            // 
            this.btnTraduzirPortugues.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.btnTraduzirPortugues.Location = new System.Drawing.Point(10, 149);
            this.btnTraduzirPortugues.Name = "btnTraduzirPortugues";
            this.btnTraduzirPortugues.Size = new System.Drawing.Size(118, 23);
            this.btnTraduzirPortugues.TabIndex = 3;
            this.btnTraduzirPortugues.Text = "Português / Inglês";
            this.btnTraduzirPortugues.UseVisualStyleBackColor = true;
            this.btnTraduzirPortugues.Click += new System.EventHandler(this.btnTraduzirPortugues_Click);
            // 
            // tbTexto
            // 
            this.tbTexto.Location = new System.Drawing.Point(9, 34);
            this.tbTexto.Multiline = true;
            this.tbTexto.Name = "tbTexto";
            this.tbTexto.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.tbTexto.Size = new System.Drawing.Size(242, 100);
            this.tbTexto.TabIndex = 2;
            // 
            // lblTexto
            // 
            this.lblTexto.AutoSize = true;
            this.lblTexto.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.lblTexto.Location = new System.Drawing.Point(7, 18);
            this.lblTexto.Name = "lblTexto";
            this.lblTexto.Size = new System.Drawing.Size(75, 13);
            this.lblTexto.TabIndex = 26;
            this.lblTexto.Text = "Texto Original:";
            // 
            // notifyIcon1
            // 
            this.notifyIcon1.Icon = ((System.Drawing.Icon)(resources.GetObject("notifyIcon1.Icon")));
            this.notifyIcon1.Tag = "";
            this.notifyIcon1.Text = "Tradutor OnLine";
            this.notifyIcon1.Visible = true;
            this.notifyIcon1.DoubleClick += new System.EventHandler(this.notifyIcon1_DoubleClick);
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.proxyToolStripMenuItem,
            this.aboutToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(285, 24);
            this.menuStrip1.TabIndex = 1;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // proxyToolStripMenuItem
            // 
            this.proxyToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.proxyToolStripMenuItem1});
            this.proxyToolStripMenuItem.Name = "proxyToolStripMenuItem";
            this.proxyToolStripMenuItem.Size = new System.Drawing.Size(70, 20);
            this.proxyToolStripMenuItem.Text = "Configurar";
            // 
            // proxyToolStripMenuItem1
            // 
            this.proxyToolStripMenuItem1.Image = ((System.Drawing.Image)(resources.GetObject("proxyToolStripMenuItem1.Image")));
            this.proxyToolStripMenuItem1.Name = "proxyToolStripMenuItem1";
            this.proxyToolStripMenuItem1.Size = new System.Drawing.Size(152, 22);
            this.proxyToolStripMenuItem1.Text = "Proxy";
            this.proxyToolStripMenuItem1.Click += new System.EventHandler(this.proxyToolStripMenuItem1_Click);
            // 
            // aboutToolStripMenuItem
            // 
            this.aboutToolStripMenuItem.Name = "aboutToolStripMenuItem";
            this.aboutToolStripMenuItem.Size = new System.Drawing.Size(48, 20);
            this.aboutToolStripMenuItem.Text = "About";
            this.aboutToolStripMenuItem.Click += new System.EventHandler(this.aboutToolStripMenuItem_Click);
            // 
            // frmTranslator
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(285, 385);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.menuStrip1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MainMenuStrip = this.menuStrip1;
            this.MaximizeBox = false;
            this.Name = "frmTranslator";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Tradutor OnLine";
            this.Resize += new System.EventHandler(this.frmTranslator_Resize);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Diagnostics.Process process1;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button btnCopiar;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox lbResultado;
        private System.Windows.Forms.Button btnTraduzirPortugues;
        private System.Windows.Forms.TextBox tbTexto;
        private System.Windows.Forms.Button btnTraduzirIngles;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.NotifyIcon notifyIcon1;
        private System.Windows.Forms.ProgressBar progressBar1;
        private System.Windows.Forms.Label lblTexto;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem proxyToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem proxyToolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem aboutToolStripMenuItem;
    }
}

