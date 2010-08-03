using System;
using System.Collections.Generic;
using System.Text;
using Downloade;
namespace Downloader
{
    class TestDownload
    {
        static void Main(string[] args)
        {
            FileDownloader downloade = new FileDownloader();
            downloade.DownloadComplete += new EventHandler(downloade_DownloadedComplete);
            downloade.ProgressChanged += new DownloadProgressHandler(downloade_ProgressChanged);
            downloade.Download("http://gianfratti.com/media/downloads/ContratoServicos.doc", "c:\\");            
        }

        static void downloade_ProgressChanged(object sender, DownloadEventArgs e)
        {
            Console.WriteLine("Progress " + e.PercentDone);
        }

        static void downloade_DownloadedComplete(object sender, EventArgs e)
        {
            System.Console.WriteLine("Download complete.");
        }
    }
}
