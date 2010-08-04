using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using ICWTelematicsSDKLib;

public partial class ICW_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //1. Create a new Platform
        Platform platform = new PlatformClass();

        //2. Jump as User3 into its own record
        HealthRecordManager healthRecord = platform.GetHealthRecordManager(icwLoginType.icwLoginType_User_Pwd, "user6", "user6", "USERNAME", "fraukefrey");

        //3. Write a Document
        //String docId = writeDocument(healthRecord);
        //Console.WriteLine("Wrote document with ID: " + docId);

        //Create a Document
        Document doc = (Document)healthRecord.NewEntry(icwEntryType.icwEntryType_Document);
        doc.BinaryData.LoadFromFile("C:\\nr_32.pdf");
        doc.Type.Value = "generalfinding";
        doc.Note = "Criado no Brasil!";
        doc.Encoding.Value = "UTF-8";
        doc.MimeType.Value = "application/pdf";
        doc.Language.Value = "en";
        doc.FileName = "ExamplePDFBrasil.pdf";

        //saves the document            
        Document resultDoc = (Document)healthRecord.SaveAs((Entry)doc);
        Response.Write(doc.EntryId);
    }
}

