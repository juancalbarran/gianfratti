using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Configuration;
using PortalMTL.Classes;

namespace PortalMTL.Forms
{
    public partial class Documentos : System.Web.UI.Page
    {
        //Lista de Documentos PDF
        List<Documento> ListaDocumentos;
        //Contador de registros do GridView
        public Int32 TotalRegistros = 0;

        //Pega o Caminho setado no Web.Config

        //Pega o Caminho setado no Web.Config
        string URLDocumentos = ConfigurationManager.AppSettings["URLDocumentos"];

        string PathDocumentos = ConfigurationManager.AppSettings["PathDocumentos"];
        //string PathDocumentos;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //PathDocumentos = System.Web.Hosting.HostingEnvironment.MapPath(URLDocumentos);    
                PercorrerDiretorio();
                //Monta o GridView
                MontaGridView();
            }
        }

        /// <summary>
        /// Monta o GridView
        /// </summary>
        public void MontaGridView()
        {
            GridView1.DataSource = ListaDocumentos;
            GridView1.DataBind();

            //Caso nao retorno nenhum registro
            if (GridView1.Rows.Count == 0)
            {
                Response.Write("<script>alert('Nenhum registro encontrado')</script>");   
            }
        }

        /// <summary>
        /// Percorre o diretorio em busca dos arquivos PDF
        /// </summary>
        public void PercorrerDiretorio()
        {
            System.Threading.Thread.Sleep(3000);

            ListaDocumentos = new List<Documento>();

            // Busca os arquivos com extensão .pdf em todo o diretorio e sub-diretorio
            // SearchOption.AllDirectories = Todos os sub-diretorios entram na busca
            // SearchOption.TopDirectoryOnly = Somente o diretorio atual entra na busca
            string[] arquivos = Directory.GetFiles(@PathDocumentos, "*.pdf", SearchOption.AllDirectories);
            string data;
            for (int i = arquivos.Length - 1; i >= 0; --i)
            {
                Documento doc = new Documento();
                // Caminho do arquivo .pdf encontrado
                //Response.Write(arquivos[i] + "<br>");
                string[] caminho = arquivos[i].Split('\\');
                if ((caminho != null) && (caminho.Length > 3))
                {
                    doc.NumEmpresa = caminho[caminho.Length - 4];
                    doc.NumProcesso = caminho[caminho.Length - 3];
                    data = caminho[caminho.Length - 2];
                    if ((data != null) && (data.Length >= 8))
                    {
                        //data para exibição - formatada
                        doc.Data = data.Substring(6, 2) + "\\" + data.Substring(4, 2) + "\\" + data.Substring(0, 4);
                        //data para compor o path do link do pdf
                        doc.DataCaminho = data;
                    }
                    
                    doc.ArquivoPDF = caminho[caminho.Length - 1];
                    //Adiciono na Lista
                    ListaDocumentos.Add(doc);
                }
            }
            System.Threading.Thread.EndCriticalRegion();
        }

        /// <summary>
        /// Apaga a pasta do processo
        /// Atencao: caso aparece a mensagem de permissao negada compartilhe a pasta do projeto
        /// </summary>
        public void ApagarPasta(string pasta)
        {
            //Apaga o arquivo
            string[] arquivos = Directory.GetFiles(@pasta, "*.pdf", SearchOption.AllDirectories);
            File.Delete(arquivos[0]);
            //Apaga a pasta
            Directory.Delete(@pasta, true);

            MontaGridView();
        }

        public void LimparPasta(DirectoryInfo pasta)
        {
            // Obtém as subspastas da pasta atual
            var subpastas = pasta.GetDirectories();

            // Percorre a lista de subpastas
            foreach (var p in subpastas)
            {
                // Obtém a lista de arquivos dessa subpasta
                var arquivos = p.GetFiles();

                // Percorre a lista de arquivos da subpasta
                foreach (var a in arquivos)
                {
                    // O arquivo está marcado como ReadOnly?
                    if ((a.Attributes & FileAttributes.ReadOnly) == FileAttributes.ReadOnly)
                    {
                        // Sim! Então remove esse atributo...
                        a.Attributes ^= FileAttributes.ReadOnly;
                    }

                    // Apaga o arquivo
                    a.Delete();
                }

                // Limpa as subpastas da subpasta atual
                LimparPasta(p);

                // A subpasta está marcada como ReadOnly?
                if ((p.Attributes & FileAttributes.ReadOnly) == FileAttributes.ReadOnly)
                {
                    // Sim! Então remove esse atributo...
                    p.Attributes ^= FileAttributes.ReadOnly;
                }

                // Finalmente, apaga a subpasta
                p.Delete();
            }
        }


        protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
        {
            //Total de registos do footer do GridView
            TotalRegistros = Convert.ToInt32(GridView1.Rows.Count.ToString());

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //Inserei o JavaScrit no Botao para abrir a PopUp
                ImageButton ImgBtnPdf = (ImageButton)e.Row.FindControl("ImgBtnPdf");
                ImgBtnPdf.Attributes.Add("onclick", "javascript:window.open ('" + URLDocumentos + DataBinder.Eval(e.Row.DataItem, "NumEmpresa") + "/" + DataBinder.Eval(e.Row.DataItem, "NumProcesso") + "/" + DataBinder.Eval(e.Row.DataItem, "DataCaminho") + "/" + DataBinder.Eval(e.Row.DataItem, "ArquivoPDF") + "', 'Janela', 'status=yes,Resizable=yes, width=800, height=600')");

                //Insere JavaScript de Confirmação de Exclusão
                ImageButton ImageButton = (ImageButton)e.Row.FindControl("ImgBtnApagar");
                ImageButton.Attributes.Add("onclick", "javascript:return confirm('Processo nº: " + DataBinder.Eval(e.Row.DataItem, "NumProcesso") + "\\n\\nConfirma a exclusão?');");
                
                //Insere atributo JavaScript ao passar o mouse sobre o Grid
                e.Row.Attributes["onmouseover"] = "javascript:setMouseOverColor(this);";
                e.Row.Attributes["onmouseout"] = "javascript:setMouseOutColor(this);";
            }
        }

        /// <summary>
        /// Busca realizada via FileSystem em busca da pasta que contem o numero do processo digitado
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void BtnBuscar_Click(object sender, EventArgs e)
        {
            //Verifico se foi digitado alguma coisa.
            //Verificacao importante pois estou usando *.* Directory.GetDirectories 
            if (txtNumProcesso.Text.Length == 0)
                return;

            System.Threading.Thread.Sleep(3000);

            //Crio nova lista
            ListaDocumentos = new List<Documento>();

            // SearchOption.AllDirectories = Todos os sub-diretorios entram na busca
            // SearchOption.TopDirectoryOnly = Somente o diretorio atual entra na busca
            string[] Diretorio = Directory.GetDirectories(@PathDocumentos, "*" + txtNumProcesso.Text + "*" , SearchOption.AllDirectories);
            string data;
            //Percorre o diretorio com o numero do processo
            for (int i = Diretorio.Length - 1; i >= 0; --i)
            {
                string[] Arquivos = Directory.GetFiles(@Diretorio[i], "*.pdf", SearchOption.AllDirectories);
                //Percorre o diretorio de processo em busca de arquivos PDF's
                for (int x = Arquivos.Length - 1; x >= 0; --x)
                {
                    Documento doc = new Documento();
                    // Caminho do arquivo .pdf encontrado
                    string[] caminho = Arquivos[x].Split('\\');
                    if ((caminho != null) && (caminho.Length > 3))
                    {
                        doc.NumEmpresa = caminho[caminho.Length - 4];
                        doc.NumProcesso = caminho[caminho.Length - 3];
                        data = caminho[caminho.Length - 2];
                        if ((data != null) && (data.Length >= 8))
                        {
                            //data para exibição - formatada
                            doc.Data = data.Substring(6, 2) + "\\" + data.Substring(4, 2) + "\\" + data.Substring(0, 4);
                            //data para compor o path do link do pdf
                            doc.DataCaminho = data;
                        }

                        doc.ArquivoPDF = caminho[caminho.Length - 1];
                        //Adiciono na Lista
                        ListaDocumentos.Add(doc);
                    }
                }
            }

            MontaGridView();
            System.Threading.Thread.EndCriticalRegion();
        }
 

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Apagar")
            {
                string[] arg = (string[])e.CommandArgument.ToString().Split(':');
                string data = arg[2].Substring(6, 4) + arg[2].Substring(3, 2) + arg[2].Substring(0, 2) ;
                //ApagarPasta(arg[0], arg[1], teste);
                var pasta = new DirectoryInfo(@PathDocumentos + "\\" + arg[0] + "\\" + arg[1] + "\\" + data);
                //LimparPasta(pasta);
                ApagarPasta(@PathDocumentos + "\\" + arg[0] + "\\" + arg[1] + "\\" + data);
            }

            if (e.CommandName == "Download")
            {
                string[] arg = (string[])e.CommandArgument.ToString().Split(':');
                string data = arg[2].Substring(6, 4) + arg[2].Substring(3, 2) + arg[2].Substring(0, 2);
                Response.Redirect("download.aspx?NumEmpresa=" + arg[0] + "&NumProcesso=" + arg[1] + "&Data=" + data + "&ArquivoPDF=" + arg[3]);
            }
        }

        /// <summary>
        /// Paginação
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            MontaGridView();
        }

    }
}
