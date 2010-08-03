namespace Zip
{
    partial class Form1
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
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.txtDiretorioZipSenha = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.lblMsg = new System.Windows.Forms.Label();
            this.btnCompactarDiretorio = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.btnDiretorioDestino = new System.Windows.Forms.Button();
            this.txtDiretorioDestino = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.btnDiretorioOrigem = new System.Windows.Forms.Button();
            this.txtDiretorioOrigem = new System.Windows.Forms.TextBox();
            this.progressBar1 = new System.Windows.Forms.ProgressBar();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.tabPage3 = new System.Windows.Forms.TabPage();
            this.tabPage4 = new System.Windows.Forms.TabPage();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.tabControl1.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.pictureBox1);
            this.groupBox1.Controls.Add(this.txtDiretorioZipSenha);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.lblMsg);
            this.groupBox1.Controls.Add(this.btnCompactarDiretorio);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.btnDiretorioDestino);
            this.groupBox1.Controls.Add(this.txtDiretorioDestino);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Controls.Add(this.btnDiretorioOrigem);
            this.groupBox1.Controls.Add(this.txtDiretorioOrigem);
            this.groupBox1.Location = new System.Drawing.Point(6, 6);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(238, 176);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Compactar Pasta";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::Zip.Properties.Resources.Cadeado;
            this.pictureBox1.Location = new System.Drawing.Point(198, 112);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(18, 20);
            this.pictureBox1.TabIndex = 11;
            this.pictureBox1.TabStop = false;
            // 
            // txtDiretorioZipSenha
            // 
            this.txtDiretorioZipSenha.Location = new System.Drawing.Point(6, 110);
            this.txtDiretorioZipSenha.Name = "txtDiretorioZipSenha";
            this.txtDiretorioZipSenha.PasswordChar = '*';
            this.txtDiretorioZipSenha.Size = new System.Drawing.Size(183, 20);
            this.txtDiretorioZipSenha.TabIndex = 10;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(6, 94);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(102, 13);
            this.label4.TabIndex = 9;
            this.label4.Text = "Senha de Proteção:";
            // 
            // lblMsg
            // 
            this.lblMsg.AutoSize = true;
            this.lblMsg.Location = new System.Drawing.Point(3, 160);
            this.lblMsg.Name = "lblMsg";
            this.lblMsg.Size = new System.Drawing.Size(30, 13);
            this.lblMsg.TabIndex = 8;
            this.lblMsg.Text = "Msg:";
            // 
            // btnCompactarDiretorio
            // 
            this.btnCompactarDiretorio.Location = new System.Drawing.Point(6, 136);
            this.btnCompactarDiretorio.Name = "btnCompactarDiretorio";
            this.btnCompactarDiretorio.Size = new System.Drawing.Size(180, 23);
            this.btnCompactarDiretorio.TabIndex = 6;
            this.btnCompactarDiretorio.Text = "Compactar Diretório";
            this.btnCompactarDiretorio.UseVisualStyleBackColor = true;
            this.btnCompactarDiretorio.Click += new System.EventHandler(this.btnCompactarDiretorio_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(6, 55);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(46, 13);
            this.label2.TabIndex = 5;
            this.label2.Text = "Destino:";
            // 
            // btnDiretorioDestino
            // 
            this.btnDiretorioDestino.Location = new System.Drawing.Point(195, 68);
            this.btnDiretorioDestino.Name = "btnDiretorioDestino";
            this.btnDiretorioDestino.Size = new System.Drawing.Size(35, 23);
            this.btnDiretorioDestino.TabIndex = 4;
            this.btnDiretorioDestino.Text = "...";
            this.btnDiretorioDestino.UseVisualStyleBackColor = true;
            this.btnDiretorioDestino.Click += new System.EventHandler(this.btnDiretorioDestino_Click);
            // 
            // txtDiretorioDestino
            // 
            this.txtDiretorioDestino.Location = new System.Drawing.Point(6, 71);
            this.txtDiretorioDestino.Name = "txtDiretorioDestino";
            this.txtDiretorioDestino.Size = new System.Drawing.Size(183, 20);
            this.txtDiretorioDestino.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(6, 18);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(43, 13);
            this.label1.TabIndex = 2;
            this.label1.Text = "Origem:";
            // 
            // btnDiretorioOrigem
            // 
            this.btnDiretorioOrigem.Location = new System.Drawing.Point(195, 31);
            this.btnDiretorioOrigem.Name = "btnDiretorioOrigem";
            this.btnDiretorioOrigem.Size = new System.Drawing.Size(35, 23);
            this.btnDiretorioOrigem.TabIndex = 1;
            this.btnDiretorioOrigem.Tag = "";
            this.btnDiretorioOrigem.Text = "...";
            this.btnDiretorioOrigem.UseVisualStyleBackColor = true;
            this.btnDiretorioOrigem.Click += new System.EventHandler(this.btnDiretorioOrigem_Click);
            // 
            // txtDiretorioOrigem
            // 
            this.txtDiretorioOrigem.Location = new System.Drawing.Point(6, 34);
            this.txtDiretorioOrigem.Name = "txtDiretorioOrigem";
            this.txtDiretorioOrigem.Size = new System.Drawing.Size(183, 20);
            this.txtDiretorioOrigem.TabIndex = 0;
            // 
            // progressBar1
            // 
            this.progressBar1.Location = new System.Drawing.Point(5, 224);
            this.progressBar1.Name = "progressBar1";
            this.progressBar1.Size = new System.Drawing.Size(260, 22);
            this.progressBar1.TabIndex = 7;
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tabPage1);
            this.tabControl1.Controls.Add(this.tabPage2);
            this.tabControl1.Controls.Add(this.tabPage3);
            this.tabControl1.Controls.Add(this.tabPage4);
            this.tabControl1.Location = new System.Drawing.Point(5, 5);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(260, 214);
            this.tabControl1.TabIndex = 1;
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.groupBox1);
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(252, 188);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Pasta";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // tabPage2
            // 
            this.tabPage2.Location = new System.Drawing.Point(4, 22);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage2.Size = new System.Drawing.Size(252, 188);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "Arquivo";
            this.tabPage2.UseVisualStyleBackColor = true;
            // 
            // tabPage3
            // 
            this.tabPage3.Location = new System.Drawing.Point(4, 22);
            this.tabPage3.Name = "tabPage3";
            this.tabPage3.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage3.Size = new System.Drawing.Size(252, 188);
            this.tabPage3.TabIndex = 2;
            this.tabPage3.Text = "Descompactar";
            this.tabPage3.UseVisualStyleBackColor = true;
            // 
            // tabPage4
            // 
            this.tabPage4.Location = new System.Drawing.Point(4, 22);
            this.tabPage4.Name = "tabPage4";
            this.tabPage4.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage4.Size = new System.Drawing.Size(252, 188);
            this.tabPage4.TabIndex = 3;
            this.tabPage4.Text = "About";
            this.tabPage4.UseVisualStyleBackColor = true;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(268, 252);
            this.Controls.Add(this.tabControl1);
            this.Controls.Add(this.progressBar1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Compactador";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_FormClosing);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.tabControl1.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button btnDiretorioOrigem;
        private System.Windows.Forms.TextBox txtDiretorioOrigem;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button btnDiretorioDestino;
        private System.Windows.Forms.TextBox txtDiretorioDestino;
        private System.Windows.Forms.Button btnCompactarDiretorio;
        private System.Windows.Forms.ProgressBar progressBar1;
        private System.Windows.Forms.Label lblMsg;
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.TabPage tabPage2;
        private System.Windows.Forms.TabPage tabPage3;
        private System.Windows.Forms.TextBox txtDiretorioZipSenha;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TabPage tabPage4;
        private System.Windows.Forms.PictureBox pictureBox1;
    }
}

