using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;
using ICSharpCode.SharpZipLib.Checksums;
using ICSharpCode.SharpZipLib.Zip;
using ICSharpCode.SharpZipLib;
using ICSharpCode.SharpZipLib.BZip2;
using System.Threading;

namespace Zip
{
    public partial class Form1 : Form
    {
        //Delegates
        private delegate void ZipaArquivosHandler(string origem, string destino);
        private delegate void FinalizaOperacaoHandler(string mensagem);
        private Thread tParalela;

        public Form1()
        {
            InitializeComponent();
        }

        private void btnDiretorioOrigem_Click(object sender, EventArgs e)
        {
            FolderBrowserDialog fbd = new FolderBrowserDialog();
            if (fbd.ShowDialog(this) == DialogResult.OK)
            {
                txtDiretorioOrigem.Text = fbd.SelectedPath;
                txtDiretorioDestino.Text = fbd.SelectedPath;
            }
        }

        private void btnDiretorioDestino_Click(object sender, EventArgs e)
        {

            FolderBrowserDialog fbd = new FolderBrowserDialog();
            if (fbd.ShowDialog(this) == DialogResult.OK)
            {
                txtDiretorioDestino.Text = fbd.SelectedPath;
            }
        }

        private void btnCompactarDiretorio_Click(object sender, EventArgs e)
        {
            //Verifia se o diretorio de origem existe
            if (!Directory.Exists(txtDiretorioOrigem.Text))
            {
                MessageBox.Show("O Diretório de Origem informado não existe");
                return;
            }
            //Verifia se o diretorio de destino existe      
            if (!Directory.Exists(txtDiretorioDestino.Text))
            {
                MessageBox.Show("O Diretório de Destino informado não existe");
                return;
            }
            btnCompactarDiretorio.Text = "Cancelar";
            lblMsg.Text = "Aguarde enquanto os arquivos são compactados";
            progressBar1.Style = ProgressBarStyle.Marquee;
            ZipaArquivosHandler operacaoZipar = new ZipaArquivosHandler(gerarZipDiretorio);
            operacaoZipar.BeginInvoke(txtDiretorioOrigem.Text, txtDiretorioDestino.Text, new AsyncCallback(RetornoDoZip), null);
        }

        public void gerarZipDiretorio(string sDiretorioOrigem, string sDiretorioDestino)
        {
            FastZip sz = new FastZip();
            try
            {
                string sArquivoZip = string.Empty;
                //Aqui vou criar um nome do arquivo.
                DateTime newDate = DateTime.Now;
                sArquivoZip = "MeuZip_" + Convert.ToString(newDate).Replace("/", "_").Replace(":", "") + ".zip";
                //Só um tratamento para garantir mais estabilidade
                if (sDiretorioOrigem.Substring(sDiretorioOrigem.Length - 2) != "\\" || sDiretorioDestino.Substring(sDiretorioDestino.Length - 2) != "\\")
                {
                    sDiretorioOrigem = sDiretorioOrigem + "\\";
                }
                sz.Password = txtDiretorioZipSenha.Text;
                //Gera o ZIP
                sz.CreateZip(sDiretorioDestino + sArquivoZip, sDiretorioOrigem + "" + "\\", true, "", "");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ocorreu um erro durante o processo de compactação : " + ex);
            }
            finally
            {
                //Limpa o Objeto
                sz = null;
            }
        }
        //Pega o retorno do Callback
        private void RetornoDoZip(IAsyncResult resultado)
        {
            if (resultado.IsCompleted)
                this.Invoke(new FinalizaOperacaoHandler(TerminouOK), "Arquivos Compactados Com sucesso!");
            else
                this.Invoke(new FinalizaOperacaoHandler(TerminouOK), "Deu merda capitão");
        }
        //Envia a mensagem para o usuario e para o ProgressBar
        private void TerminouOK(string mensagem)
        {
            lblMsg.Text = mensagem;
            progressBar1.Style = ProgressBarStyle.Blocks;
            btnCompactarDiretorio.Text = "Compactar Diretório";
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            {
                if (tParalela != null)
                    tParalela.Abort();
            }
        }

    }
}