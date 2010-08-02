using System;
using System.Text;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using JomaBE;
using JomaDAL;
using Util;

public partial class Forms_AgendamentoSessoesCadastrar : System.Web.UI.Page
{

    List<AgendamentoSessoesBE> Lista;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtNumeroConvenio.Enabled = false;
            ddlConvenio.Enabled = false;
            Session["ObjSession"] = null;
            MontaComboConvenio();
            PacienteDados();
            MontaComboProfissionais();
            GridView();
        }
    }

    public void PacienteDados()
    {
        PacienteBE pacienteBE = new PacienteBE();
        PacienteDAL pacienteDAL = new PacienteDAL();
        pacienteBE = pacienteDAL.Obter(Convert.ToInt32(Request.QueryString["id"]));
        lblNome.Text = pacienteBE.Nome;
        lblRG.Text = pacienteBE.RG;
        lblCPF.Text = pacienteBE.CPF;
        ddlConvenio.SelectedValue = pacienteBE.idConvenio;
        txtNumeroConvenio.Text = pacienteBE.NumeroConvenio;
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

    public void MontaComboConvenio()
    {
        ConvenioDAL convenioDAL = new ConvenioDAL();
        ddlConvenio.DataSource = convenioDAL.Listar(null);
        ddlConvenio.DataTextField = "Nome";
        ddlConvenio.DataValueField = "ID";
        ddlConvenio.DataBind();
        ddlConvenio.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }

    protected void btnInserir_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["ObjSession"] == null)
            {
                Lista = new List<AgendamentoSessoesBE>();
            }
            else
            {
                Lista = Session["ObjSession"] as List<AgendamentoSessoesBE>;
            }

            UtilWeb utilWeb = new UtilWeb();

            //Validação de Data
            if (!utilWeb.ComparaDatas(Convert.ToDateTime(txtDataInicio.Text), Convert.ToDateTime(txtDataFim.Text)))
                return;

            //Validação de Hora
            if (!(utilWeb.ValidaHora(txtHoraInicio.Text) && utilWeb.ValidaHora(txtHoraFim.Text)))
                return;


            DateTime StartingDate = Convert.ToDateTime(txtDataInicio.Text);
            DateTime EndingDate = Convert.ToDateTime(txtDataFim.Text);
            int idSessoesStatus = 1; //Inicio Status cono agendado
            foreach (DateTime Data in GetDateRange(StartingDate, EndingDate))
            {
                AgendamentoSessoesBE agendamentoSessoesBE = new AgendamentoSessoesBE();
                agendamentoSessoesBE.idPaciente = Convert.ToInt32(Request.QueryString["id"]);
                if (chkAcerto.Checked) { idSessoesStatus = 5; }//Verfico se o chekBox de acerto foi selecionado e seto o status como acerto
                agendamentoSessoesBE.idSessoesStatus = idSessoesStatus; //Cadastra as Sessoes com status inicial de agendado ou acerto
                agendamentoSessoesBE.idConvenio = Convert.ToInt32(ddlConvenio.SelectedValue.ToString());
                agendamentoSessoesBE.NumeroConvenio = txtNumeroConvenio.Text;
                agendamentoSessoesBE.idProfissional = Convert.ToInt32(ddlProfissionais.SelectedValue.ToString());
                agendamentoSessoesBE.idEspecialidade = Convert.ToInt32(ddlEspecialidades.SelectedValue.ToString());
                agendamentoSessoesBE.RefprofissionaisBE.Nome = Convert.ToString(ddlProfissionais.SelectedItem);
                agendamentoSessoesBE.DataInicio = Convert.ToDateTime(Data.ToString("dd/MM/yyyy"));
                agendamentoSessoesBE.DataFim = Convert.ToDateTime(Data.ToString("dd/MM/yyyy"));
                agendamentoSessoesBE.HoraInicio = txtHoraInicio.Text;
                agendamentoSessoesBE.HoraFim = txtHoraFim.Text;
                agendamentoSessoesBE.Qtd = Convert.ToInt32(txtQtd.Text);
                agendamentoSessoesBE.Valor = txtValor.Text;
                Lista.Add(agendamentoSessoesBE);
            }
            Session["ObjSession"] = Lista;
            GridViewMontaTratamento();
        }
        catch (Exception ex)
        {
            Label lblErro = (Label)Master.FindControl("lblErro");
            lblErro.Text = ex.ToString();
        }
    }

    //public void ExibirLista()
    //{
    //    StringBuilder html = new StringBuilder();
    //    html.Append("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='texto'>");
    //    //foreach (AgendamentoSessoesBE x in Lista)
    //    for (int i = 0; i < Lista.Count; i++)
    //    {
    //        html.Append("<tr>");
    //        html.Append("<td width='32%'>"+Lista[i].RefprofissionaisBE.Nome+"</td>");
    //        html.Append("<td width='11%'>" + Lista[i].DataInicio.ToString("dd/MM/yyyy") + "</td>");
    //        html.Append("<td width='11%'>" + Lista[i].DataFim.ToString("dd/MM/yyyy") + "</td>");
    //        html.Append("<td width='11%'>" + Lista[i].HoraInicio + "</td>");
    //        html.Append("<td width='11%'>" + Lista[i].HoraFim + "</td>");
    //        html.Append("<td width='7%'>" + Lista[i].Qtd + "</td>");
    //        html.Append("<td width='7%'>" + Lista[i].Valor + "</td>");
    //        html.Append("<td width='6%'><a href='AgendamentoSessoesCadastrar.aspx?idLista=" + i + "'>Apagar</a></td>");
    //        html.Append("</tr>");
    //    }
    //    html.Append("</table>");
    //    html.Append("<br>");

    //    //DivLista.InnerHtml = html.ToString();
    //}

    private List<DateTime> GetDateRange(DateTime StartingDate, DateTime EndingDate)
    {
        if (StartingDate > EndingDate)
        {
            return null;
        }
        List<DateTime> rv = new List<DateTime>();
        DateTime tmpDate = StartingDate;
        do
        {
            rv.Add(tmpDate);
            tmpDate = tmpDate.AddDays(1);
        } while (tmpDate <= EndingDate);
        return rv;
    }

    public void GridView()
    {
        AgendamentoSessoesDAL agendamentoSessoesDAL = new AgendamentoSessoesDAL();
        GridView2.DataSource = agendamentoSessoesDAL.Listar(Request.QueryString["id"], string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty,string.Empty,string.Empty,string.Empty,string.Empty);
        GridView2.DataBind();
    }

    public void GridViewMontaTratamento()
    {
        Lista = Session["ObjSession"] as List<AgendamentoSessoesBE>;
        GridView1.DataSource = Lista;
        GridView1.DataBind();
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Lista = Session["ObjSession"] as List<AgendamentoSessoesBE>;
        Lista.RemoveAt(GridView1.SelectedIndex);
        GridView1.SelectedIndex = -1;
        Session["ObjSession"] = Lista;
        GridViewMontaTratamento();
    }

    protected void btnGravar_Click(object sender, EventArgs e)
    {
        try
        {
            //Verifica se a Session que armazena a lista esta nulo, se estiver não grava na base
            if (Session["ObjSession"] == null)
                return;
                
            AgendamentoSessoesDAL agendamentoSessoesDAL = new AgendamentoSessoesDAL();
            Lista = Session["ObjSession"] as List<AgendamentoSessoesBE>;
            agendamentoSessoesDAL.Incluir(Lista);

            Session["ObjSession"] = null; // Apago a lista apos inserir
            GridViewMontaTratamento(); //Atualizo o GridView de montagem das sessões
            GridView(); //Atualizo o GridView dos agendamentos
            
        }
        catch (Exception ex)
        {
            Label lblErro = (Label)Master.FindControl("lblErro");
            lblErro.Text = ex.ToString();
        }
    }
    protected void ddlProfissionais_SelectedIndexChanged(object sender, EventArgs e)
    {
        MontaComboEspecialidades();
    }

    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
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
        }
    }
    
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {   
        //Cast
        DropDownList ddlStatus = sender as DropDownList;
        if (sender != null)
            //Response.Write(ddlStatus.SelectedValue.ToString());
            Session["idStatus"] = ddlStatus.SelectedValue.ToString();
    }

    protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "BtnAlterarStatus")
        {
            Response.Write(e.CommandArgument);
            Response.Write(Session["idStatus"]);
        }
    }
}