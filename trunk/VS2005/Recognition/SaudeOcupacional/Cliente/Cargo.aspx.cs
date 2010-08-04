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

public partial class Cliente_Cargo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ClienteDepartamento1.SelectedIndexChanged += new EventHandler(ClienteDepartamento1_SelectedIndexChanged);

        if (!Page.IsPostBack)
        {
            ClienteDepartamento1.idCliente = Convert.ToInt32(Request.QueryString["idCliente"]);
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        GridView();
    }

    private void ClienteDepartamento1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ClienteDepartamento1.ValorInformado != string.Empty)
        {
            ClienteSetor1.idClienteDepartamento = Convert.ToInt32(ClienteDepartamento1.ValorInformado);
        }
    }

    protected void btnSalvar_Click(object sender, EventArgs e)
    {
        if (txtCargo.Text != string.Empty || ClienteDepartamento1.ValorInformado != string.Empty || ClienteSetor1.ValorInformado != string.Empty) 
        {
            ClienteCargo ObjClienteCargo = new ClienteCargo();
            ObjClienteCargo.idClienteSetor = Convert.ToInt32(ClienteSetor1.ValorInformado);
            ObjClienteCargo.Nome = txtCargo.Text;
            ClienteCargoDAL ObjClienteCargoDAL = new ClienteCargoDAL();
            ObjClienteCargoDAL.Insert(ObjClienteCargo);
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Mensage", "alert('Todos os Campos devem ser preenchidos Corretamente')", true);
        }

        txtCargo.Text = string.Empty;
    }

    private void GridView()
    {
        ClienteCargoDAL ObjClienteCargoDAL = new ClienteCargoDAL();
        GridView1.DataSource = ObjClienteCargoDAL.SelectAll(Convert.ToInt32(Request.QueryString["idCliente"]));
        GridView1.DataBind();
    }

    private void Deletar(int id)
    {
        try
        {
            ClienteCargoDAL ObjClienteCargoDAL = new ClienteCargoDAL();
            ObjClienteCargoDAL.Delete(id);
        }
        catch (Exception)
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Mensage", "alert('Este Cargo não pode ser apagado')", true);
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Deletar")
        {
            Deletar(Convert.ToInt32(e.CommandArgument));
        }

        GridView();
    }
}

