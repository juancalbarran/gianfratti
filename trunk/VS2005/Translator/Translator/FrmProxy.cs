using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Xml;
using System.IO;

namespace Translator
{
    public partial class FrmProxy : Form
    {
        public FrmProxy()
        {
            InitializeComponent();

            if (File.Exists("Config.xml"))
            {
                CarregaXml();
            }
            else
            {
                txtUsuario.Enabled = false;
                txtSenha.Enabled = false;
                txtEndereco.Enabled = false;
                txtPorta.Enabled = false;
                txtDominio.Enabled = false;
            }
        }

        private void btnSalvar_Click(object sender, EventArgs e)
        {
            if (chkAtivaProxy.Checked)
            {
                XmlTextWriter xmltw = new XmlTextWriter("Config.xml", System.Text.Encoding.UTF8);
                xmltw.WriteStartDocument();
                xmltw.WriteStartElement("Config");
                xmltw.WriteStartElement("Proxy", null);
                xmltw.WriteElementString("ProxyAtivado", "1");
                xmltw.WriteElementString("Usuario", txtUsuario.Text);
                xmltw.WriteElementString("Senha", txtSenha.Text);
                xmltw.WriteElementString("Dominio", txtDominio.Text);
                xmltw.WriteElementString("Endereco", txtEndereco.Text);
                xmltw.WriteElementString("Porta", txtPorta.Text);
                xmltw.WriteEndElement();
                xmltw.WriteEndElement();
                xmltw.Close();
            }
            else
            {
                if (File.Exists("Config.xml"))
                {
                    FileInfo arquivo = new FileInfo("Config.xml");
                    arquivo.Delete();
                }
            }
            //Fecha a janela do form
            Close();
        }

        private void CarregaXml()
        {
            DataSet ds = new DataSet();
            ds.ReadXml("config.xml");
            
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                chkAtivaProxy.Checked = true;
                txtUsuario.Text = dr["Usuario"].ToString();
                txtSenha.Text = dr["Senha"].ToString();
                txtEndereco.Text = dr["Endereco"].ToString();
                txtPorta.Text = dr["Porta"].ToString();
                txtDominio.Text = dr["Dominio"].ToString();
            }
        }

        private void chkAtivaProxy_CheckedChanged(object sender, EventArgs e)
        {
            if (chkAtivaProxy.Checked)
            {
                txtUsuario.Enabled = true;
                txtSenha.Enabled = true;
                txtEndereco.Enabled = true;
                txtPorta.Enabled = true;
                txtDominio.Enabled = true;
            }
            else
            {
                txtUsuario.Enabled = false;
                txtSenha.Enabled = false;
                txtEndereco.Enabled = false;
                txtPorta.Enabled = false;
                txtDominio.Enabled = false;
            }
        }
    }
}