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
using JomaBE;
using JomaDAL;

public partial class Forms_AgendamentoSessoes : System.Web.UI.Page
{
    public Int32 TotalRegistros = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            MontaComboConvenio();
            MontaComboProfissionais();
            MontaComboStatus();
            GridView();
        }
    }

    public void MontaComboConvenio()
    {
        ConvenioDAL convenioDAL = new ConvenioDAL();
        ddlConvenio.DataSource = convenioDAL.Listar(null);
        ddlConvenio.DataTextField = "Nome";
        ddlConvenio.DataValueField = "ID";
        ddlConvenio.DataBind();
        ddlConvenio.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }

    public void MontaComboProfissionais()
    {
        ProfissionaisDAL profissionaisDAL = new ProfissionaisDAL();
        ddlProfissionais.DataSource = profissionaisDAL.ListarByIdPerfil(2);
        ddlProfissionais.DataTextField = "Nome";
        ddlProfissionais.DataValueField = "ID";
        ddlProfissionais.DataBind();
        ddlProfissionais.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }

    public void MontaComboEspecialidades()
    {
        EspecialidadeDAL especialidadeDAL = new EspecialidadeDAL();
        ddlEspecialidades.DataSource = especialidadeDAL.ListarByIdProfissionalEspecialidade(Convert.ToInt32(ddlProfissionais.SelectedValue));
        ddlEspecialidades.DataTextField = "Nome";
        ddlEspecialidades.DataValueField = "ID";
        ddlEspecialidades.DataBind();
        ddlEspecialidades.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }

    public void MontaComboStatus()
    {
        SessoesStatusDAL sessoesStatusDAL = new SessoesStatusDAL();
        ddlStatusAgendamento.DataSource = sessoesStatusDAL.Listar();
        ddlStatusAgendamento.DataTextField = "Nome";
        ddlStatusAgendamento.DataValueField = "ID";
        ddlStatusAgendamento.DataBind();
        ddlStatusAgendamento.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }

    protected void ddlProfissionais_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(ddlProfissionais.SelectedValue != string.Empty)
        MontaComboEspecialidades();
    }

    public void GridView()
    {
        AgendamentoSessoesDAL agendamentoSessoesDAL = new AgendamentoSessoesDAL();
        GridView1.DataSource = agendamentoSessoesDAL.Listar(string.Empty, txtNome.Text, txtRG.Text, txtCPF.Text, ddlConvenio.SelectedValue, txtNumeroConvenio.Text, txtDataInicio.Text, txtDataFim.Text,ddlProfissionais.SelectedValue,ddlEspecialidades.SelectedValue,ddlStatusAgendamento.SelectedValue);
        GridView1.DataBind();
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            SessoesStatusDAL sessoesStatusDAL = new SessoesStatusDAL();
            DropDownList ddlStatus = (DropDownList)e.Row.FindControl("ddlStatus");
            ddlStatus.DataSource = sessoesStatusDAL.Listar();
            ddlStatus.DataTextField = "Nome";
            ddlStatus.DataValueField = "ID";
            ddlStatus.AutoPostBack = true;
            ddlStatus.DataBind();
            ddlStatus.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo

            //Insere as imagens referente a cada status
            Image ImgStatus = (Image)e.Row.FindControl("ImgStatus");
            if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "idSessoesStatus")) == "1")
                ImgStatus.ImageUrl = "~/Template/Img/Flg_azul.gif";
            if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "idSessoesStatus")) == "2")
                ImgStatus.ImageUrl = "~/Template/Img/Flg_verde.gif";
            if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "idSessoesStatus")) == "3")
                ImgStatus.ImageUrl = "~/Template/Img/Flg_amerelo_Escuro.gif";
            if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "idSessoesStatus")) == "4")
                ImgStatus.ImageUrl = "~/Template/Img/Flg_vermelho.gif";
        }
    }

    protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
    {
        //Total de registos do footer do GridView
        TotalRegistros = Convert.ToInt32(GridView1.Rows.Count.ToString());

        //Insere as imagens referente a cada status
        //Image ImgStatus = (Image)e.Row.FindControl("ImgStatus");
        //if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "idSessoesStatus")) == "1")
        //    ImgStatus.ImageUrl = "~/Template/Img/Flg_azul.gif";
        //if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "idSessoesStatus")) == "2")
        //    ImgStatus.ImageUrl = "~/Template/Img/Flg_verde.gif";
        //if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "idSessoesStatus")) == "3")
        //    ImgStatus.ImageUrl = "~/Template/Img/Flg_amerelo_Escuro.gif";
        //if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "idSessoesStatus")) == "4")
        //    ImgStatus.ImageUrl = "~/Template/Img/Flg_vermelho.gif";

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //Insere atributo JavaScript ao passar o mouse sobre o Grid
            e.Row.Attributes["onmouseover"] = "javascript:setMouseOverColor(this);";
            e.Row.Attributes["onmouseout"] = "javascript:setMouseOutColor(this);";
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "BtnAlterarStatus")
        {
            AgendamentoSessoesDAL agendamentoSessoesDAL = new AgendamentoSessoesDAL();
            agendamentoSessoesDAL.AlteraStatus(Convert.ToInt32(e.CommandArgument), Convert.ToInt32(Session["idStatus"]));
            Session["idStatus"] = string.Empty;
            Response.Redirect("AgendamentoSessoes.aspx");
        }
    }

    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        GridView();
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Cast
        DropDownList ddlStatus = sender as DropDownList;
        if (sender != null)
            Session["idStatus"] = ddlStatus.SelectedValue.ToString();
    }
}
