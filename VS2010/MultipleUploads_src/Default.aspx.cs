﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

public partial class _Default : System.Web.UI.Page
{
    public ArrayList files = new ArrayList();
    static public ArrayList hif = new ArrayList();
    public int filesUploaded = 0;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    /// <summary>
    /// AddFile will add the path of the client side file that is currently in the PostedFile
    /// property of the HttpInputFile control to the listbox.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void AddFile_Click(object sender, System.EventArgs e)
    {
        if (Page.IsPostBack == true)
        {
            hif.Add(FindFile);
            ListBox1.Items.Add(FindFile.PostedFile.FileName);

        }
        else
        {

        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Page.IsPostBack == true)
        {
            hif.Add(FindFile);
            ListBox1.Items.Add(FindFile.PostedFile.FileName);

        }
        else
        {

        }
    }

    /// <summary>
    /// RemvFile will remove the currently selected file from the listbox.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void RemvFile_Click(object sender, System.EventArgs e)
    {
        if (ListBox1.Items.Count != 0)
        {

            hif.RemoveAt(ListBox1.SelectedIndex);
            ListBox1.Items.Remove(ListBox1.SelectedItem.Text);
        }

    }

    /// <summary>
    /// Upload_ServerClick is the server side script that will upload the files to the web server
    /// by looping through the files in the listbox.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    public void Upload_ServerClick(object sender, System.EventArgs e)
    {
        string baseLocation = "C:\\temp\\";
        string status = "";


        if ((ListBox1.Items.Count == 0) && (filesUploaded == 0))
        {
            Label1.Text = "Error - a file name must be specified.";
            return;

        }
        else
        {
            foreach (System.Web.UI.HtmlControls.HtmlInputFile HIF in hif)
            {
                try
                {
                    string fn = System.IO.Path.GetFileName(HIF.PostedFile.FileName);
                    HIF.PostedFile.SaveAs(baseLocation + fn);
                    filesUploaded++;
                    status += fn + "<br>";
                }
                catch (Exception err)
                {
                    Label1.Text = "Error saving file " + baseLocation + "<br>" + err.ToString();
                }
            }

            if (filesUploaded == hif.Count)
            {
                Label1.Text = "These " + filesUploaded + " file(s) were uploaded:<br>" + status;
            }
            hif.Clear();
            ListBox1.Items.Clear();
        }

    }
}