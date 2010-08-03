using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Net;
using System.IO;
using System.Web;
using System.Collections;
using System.Xml;

namespace Translator
{
    public partial class frmTranslator : Form
    {
        public int ProxyAtivado =0;
        public string Usuario;
        public string Senha;
        public string Endereco;
        public string Porta;
        public string Dominio;

        public frmTranslator()
        {
            InitializeComponent();
        }
        //Evento do botao traduzir de portugues para ingles
        private void btnTraduzirPortugues_Click(object sender, EventArgs e)
        {
            lbResultado.Text = "";
            //Chama o metodo responsavel pela traducao
            GoogleTranslate("pt|en");
        }
        //Evento do botao traduzir de ingles para portugues
        private void btnTraduzirIngles_Click(object sender, EventArgs e)
        {
            lbResultado.Text = "";
            //Chama a metodo responsavel pela traducao
            GoogleTranslate("en|pt");
        }
        //Metodo responsavel por carregar as configuracoes do arquivo xml na memoria
        private void CarregaXml()
        {
            if (File.Exists("Config.xml"))
            {
                DataSet ds = new DataSet();

                ds.ReadXml("config.xml");
                //Percorre o xml
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    ProxyAtivado = Convert.ToInt32(dr["ProxyAtivado"]);
                    Usuario = dr["Usuario"].ToString();
                    Senha = dr["Senha"].ToString();
                    Endereco = dr["Endereco"].ToString();
                    Porta = dr["Porta"].ToString();
                    Dominio = dr["Dominio"].ToString();
                }
            }
            else
            {
                ProxyAtivado = 0;
            }

        }
        //Metodo responsavel pela traducao do texto
        private void GoogleTranslate(string idioma)
        {
            //Verifica se o campo texto esta vazio
            if (tbTexto.Text == string.Empty)
            {
                MessageBox.Show("Digite o texto a ser traduzido e clique sobre o idioma desejado");
                return;
            }
            //Seta as classes como null
            WebProxy proxy = null;
            Stream resStream = null;
            Stream reqStream = null;
            WebResponse res = null;
            StreamReader sr = null;
            //Inicia o tratamento de erro
            try
            {
                //Chama o metodo que carrega as configuracoes na memoria
                CarregaXml();
                //Chama o metodo que incrementa o ProgressBar
                ProgressBar();
                //Seta o Enconding para ISO
                Encoding enc = Encoding.GetEncoding("ISO-8859-1");
                //Coloca texto digitado minisculo para nao ter problemas de traducao
                string input = tbTexto.Text.ToLower();
                //Seta o endereco do traduto do google
                string url = "http://translate.google.com/translate_t";
                string param = "";
                //Estancia um HashTable onde iremos armazenar os parametros
                Hashtable ht = new Hashtable();
                ht["text"] = HttpUtility.UrlEncode(input, enc);//Passamos o texto digitado e o encoding
                ht["langpair"] = idioma; //Informa o idioma. Ingles Portuges "en|pt" - Portugues Ingles "pt|en"
                ht["hl"] = "en";
                ht["ie"] = "ISO-8859-1"; //Passmo o Iso novamentro como parametro na pagina
                //Chama a função que incrementa o ProgressBar
                ProgressBar();
                //Percore os itens armazenados no HashTable
                foreach (string k in ht.Keys)
                {
                    param += String.Format("{0}={1}&", k, ht[k]);
                }
                //Cria um array de bytes
                byte[] data = Encoding.ASCII.GetBytes(param);
                //Chama a função que incrementa o ProgressBar
                ProgressBar();
                //Instancia o HttpWebRequest que ira fazer a requisicao na pagina do google
                HttpWebRequest req = (HttpWebRequest)WebRequest.Create(url);
                //Verifica se o usuario esta usando as configuracoes de proxy
                if (ProxyAtivado == 1)
                {
                    proxy = new WebProxy(Endereco + ":" + Porta, true);
                    proxy.Credentials = new NetworkCredential(Usuario, Senha, Dominio);
                    //Caso estiver usando o proxy entao pede autenticacao
                    req.Proxy = proxy;
                }
                else
                {
                    //Pega as configuracoes de proxy automaticas do IE
                    proxy = new WebProxy();
                    proxy.BypassProxyOnLocal = true;
                }
                //Declara que ira ser feito um Post na pagina do google
                req.Method = "POST";
                //Informama o ContentType
                req.ContentType = "application/x-www-form-urlencoded";
                //Informa o ContentLength e passa a variavel data com o array de bytes 
                req.ContentLength = data.Length;

                reqStream = req.GetRequestStream();
                reqStream.Write(data, 0, data.Length);
                reqStream.Close();

                //Chama a função que incrementa o ProgressBar
                ProgressBar();

                res = req.GetResponse();
                resStream = res.GetResponseStream();
                sr = new StreamReader(resStream, enc);
                string html = sr.ReadToEnd();
                sr.Close();
                resStream.Close();
                //Chama o metodo ExtractTranslation e passamos o HTML todo, esse metodo é responsavel por extrair apenas a traducao do texto, limpando o html
                string result = ExtractTranslation(html);
                //Envia para o usuario o resultado da traducao solicitada
                lbResultado.Text = result.Replace("<br> ", Environment.NewLine).Replace("&#39;","'").Replace("&amp;","&").Replace(@""">","");
                //Chama a função que incrementa o ProgressBar
                ProgressBar();
                //Limpa o ProgressBar
                progressBar1.Value = 0;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                if (e.Message == "A conexão subjacente estava fechada: Uma conexão que deveria ser mantida ativa foi fechada pelo servidor.")
                {
                    //Caso ocorra algum Exeception entao chama a mesma funcao e passa o idioma
                    //Isso foi feito pq sempre acontecia erro de conexao entao foi uma forma que fiz e deu certo
                    GoogleTranslate(idioma);
                }
                else
                {
                    MessageBox.Show(e.Message);
                }
            }
            finally
            {
                //Limpa o ProgressBar
                progressBar1.Value = 0;
                //Fecha os objetos criados
                if (resStream != null) resStream.Close();
                if (reqStream != null) reqStream.Close();
                if (res != null) res.Close();
                if (sr != null) sr.Close();
            }
        }
        //Funcao responsavel por recever o cosigo HTML completo e rastrear as tags confome abaixo
        private string ExtractTranslation(string text)
        {
            //Procura por indexador fixo. Nome do campo onde se encontra o resultato
            int i = text.LastIndexOf("id=result_box");
            //Incrementa deslocamento
            i += 22;
            //Captura o texto
            int j = text.LastIndexOf("</div></td>");
            return text.Substring(i, j - i);
        }
        //Função responsavel pela barra de progresso
        private void ProgressBar()
        {
            // Setando o mínimo para a barra de progress.
            progressBar1.Minimum = 0;
            // Setando o valor de número máximo representado
            progressBar1.Maximum = 100;
            // Setando a propriedade passo a passo para poder
            // incrementar o montante para cada gomo.
            progressBar1.Step = 20;
            //Vai encrementando conforme configurado o propriedade Step
            progressBar1.PerformStep();
        }
        //Evento do botao copiar texto
        private void btnCopiar_Click(object sender, EventArgs e)
        {
            if (lbResultado.Text != "")
            {
                Clipboard.SetText(lbResultado.Text);
            }
        }
        //Evento de resize do form
        private void frmTranslator_Resize(object sender, EventArgs e)
        {
            //Caso minimizar a janela entao ira colocar no System Tray
            if (FormWindowState.Minimized == WindowState)
                Hide();
        }
        //Controle para colocar icone no System Tray e restaurar
        private void notifyIcon1_DoubleClick(object sender, EventArgs e)
        {
            Show();
            WindowState = FormWindowState.Normal;
        }
        //Evento do botao do menu About
        private void aboutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //Exibe o form about
            frmAbout mForm = new frmAbout();
            mForm.ShowDialog(this);
        }
        //Evento do botao do menu Config -> Proxy
        private void proxyToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            //Exibe o form de configuracao do proxy
            FrmProxy mForm = new FrmProxy();
            mForm.ShowDialog(this);
        }
    }
}