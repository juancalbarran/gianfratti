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

public partial class Admin_Template_TemplateAdmin : System.Web.UI.MasterPage
{
    //Variavel sera usada para armazenar o caminho onde esta o site
    public string Caminho;

    protected void Page_Load(object sender, EventArgs e)
    {
        Caminho = Page.Request.ApplicationPath;
    }
}
