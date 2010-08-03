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

public partial class Forms_Recibos : System.Web.UI.Page
{
    public double ValorTotal = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            MontaGridView();
            MontaComboPacientes();
            MontaComboProfissionais();
            MontaComboConvenio();
            //btnGerar.Visible = false;
        }
    }

    //Monta o GridView
    public void MontaGridView()
    {
        try
        {
            //somente mostro o GridView se tiver selecionado um paciente no combobox
            if (Convert.ToString(ddlPaciente.SelectedValue) == "")
                return;

            ReciboDAL reciboDAL = new ReciboDAL();
            GridView1.DataSource = reciboDAL.ObterAgendamentos(Convert.ToString(ddlPaciente.SelectedValue), Convert.ToString(ddlConvenio.SelectedValue), Convert.ToString(ddlProfissional.SelectedValue));
            GridView1.DataBind();
            //Chamo o metodo que atualiza o valor total
            CalculaTotal();
            //if (GridView1.Rows.Count != 0)
            //{
            //    btnGerar.Visible = true;
            //    btnGerar.Attributes.Add("onclick", "javascript:AbrePopUp('ReciboSalvar.aspx','800','600')");
            //}
            //else
            //{
            //    btnGerar.Attributes.Remove("onclick");
            //}
        }
        catch (Exception ex)
        {
            Label lblErro = (Label)Master.FindControl("lblErro");
            lblErro.Text = ex.ToString();
        }
    }

    protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //Insere atributo JavaScript ao passar o mouse sobre o Grid
            e.Row.Attributes["onmouseover"] = "javascript:setMouseOverColor(this);";
            e.Row.Attributes["onmouseout"] = "javascript:setMouseOutColor(this);";
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //Vou somando os valores das colunas para mostrar no FooterTemplate
            //Variavel usada no metodo CalculaTotal()
            //ValorTotal += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "Valor"));

            //insere o valor das sessoes no label
            Label lblValor = (Label)e.Row.FindControl("lblValor");
            //Irei converter em moeda para usar a formatação correta
            double ValorTemp = 0;
            ValorTemp = Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "Valor"));
            lblValor.Text = String.Format("{0:C2}", ValorTemp);
        }
    }

    public void MontaComboPacientes()
    {
        PacienteDAL pacienteDAL = new PacienteDAL();
        ddlPaciente.DataSource = pacienteDAL.Listar(string.Empty, string.Empty, string.Empty);
        ddlPaciente.DataTextField = "Nome";
        ddlPaciente.DataValueField = "ID";
        ddlPaciente.DataBind();
        ddlPaciente.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
    }

    public void MontaComboProfissionais()
    {
        ProfissionaisDAL profissionalDAL = new ProfissionaisDAL();
        ddlProfissional.DataSource = profissionalDAL.Listar(string.Empty, string.Empty, string.Empty,string.Empty);
        ddlProfissional.DataTextField = "Nome";
        ddlProfissional.DataValueField = "ID";
        ddlProfissional.DataBind();
        ddlProfissional.Items.Insert(0, new ListItem("<--Selecione-->", string.Empty)); //Texto Inicial do combo
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

    protected void btnBusar_Click(object sender, EventArgs e)
    {
        if (Convert.ToString(ddlProfissional.SelectedValue) == string.Empty)
        {
            Response.Write("<script>alert('Selecione um profissional');</script>");
            return;
        }

        MontaGridView();
    }

    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        //Caso nao existam registros no gridview
        if (GridView1.Rows.Count == 0)
            return;

        ReciboBE recibo = new ReciboBE();
        //Percorro as linhas do GridView
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            //Defino um index para a linha
            GridViewRow dgItem = GridView1.Rows[i];

            //Procuro o controle Label dentro do GridView onde esta o ID do registro
            Label Label1 = (Label)dgItem.FindControl("Label1");
            //Procuro o controle CheckBox dentro do GridView
            CheckBox CheckBox1 = (CheckBox)dgItem.FindControl("CheckBox1");
            //Verifico se o CheckBox esta selecionado para somar apenas as linhas selecionadas
            if (CheckBox1.Checked)
            {
                //Vou somando os valores das colunas para mostrar no FooterTemplate
                //Variavel ValorTotal usada no metodo CalculaTotal()
                Label lblValor = (Label)dgItem.FindControl("lblValor");
                ValorTotal += Convert.ToDouble(lblValor.Text.Replace("R$", ""));
            }
        }
        //Chamo o metodo que vai calcular o valor
        CalculaTotal();
    }

    protected void btnGerar_Click(object sender, EventArgs e)
    {
        if (Convert.ToString(ddlPaciente.SelectedValue) == "")
        {
            Response.Write("<script>alert('Selecione um paciente')</script>");
            return;
        }
        //Caso nao existam registros no gridview
        if (GridView1.Rows.Count == 0)
            return;

        ReciboBE reciboBE = new ReciboBE();
        //Percorro as linhas do GridView
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            //Defino um index para a linha
            GridViewRow dgItem = GridView1.Rows[i];

            //Procuro o controle Label dentro do GridView onde esta o ID das sessoes agendadas
            Label Label1 = (Label)dgItem.FindControl("Label1");
            //Procuro o controle CheckBox dentro do GridView
            CheckBox CheckBox1 = (CheckBox)dgItem.FindControl("CheckBox1");
            //Verifico se o CheckBox esta selecionado.
            if (CheckBox1.Checked)
            {
                //Response.Write(GridView1.Rows[i].Cells[7].Text);
                reciboBE.Data = Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy"));
                reciboBE.Desconto = Convert.ToDecimal(txtPorcentagem.Text);
                reciboBE.idPaciente = Convert.ToInt32(ddlPaciente.SelectedValue);
                reciboBE.PacienteNome = Convert.ToString(ddlPaciente.SelectedItem);
                reciboBE.RefProfissionalBE.id = Convert.ToInt32(ddlProfissional.SelectedValue);
                //Pego o valor total que esta no footer do gridView
                Label lblValorTotal = (Label)GridView1.FooterRow.FindControl("lblValorTotal");
                reciboBE.ValorTotal = Convert.ToDouble(lblValorTotal.Text.Replace("R$", ""));

                //Crio a lista de sessoes
                ReciboAgendamentoSessoesBE reciboAgendamentoSessoesBE = new ReciboAgendamentoSessoesBE();
                reciboAgendamentoSessoesBE.idAgendamentoSessoes = Convert.ToInt32(Label1.Text);
                reciboAgendamentoSessoesBE.Data = Convert.ToDateTime(GridView1.Rows[i].Cells[1].Text);
                Label lblValor = (Label)dgItem.FindControl("lblValor");
                reciboAgendamentoSessoesBE.Valor = Convert.ToDouble(lblValor.Text.Replace("R$", ""));
                //Coloco a lista de id das sessioes selecinados na lista do recido
                reciboBE.RefReciboAgendamentoSessoesBE.Add(reciboAgendamentoSessoesBE);
            }
        }

        ReciboDAL reciboDAL = new ReciboDAL();
        reciboBE = reciboDAL.Incluir(reciboBE);

        //Abro a Janela PopUp com o recibo
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "", "javascript:AbrePopUp('ReciboSalvar.aspx','800','600')", true);

        if (Session["ReciboBE"] != null)
        {
            Session["ReciboBE"] = null;
        }

        Session["ReciboBE"] = reciboBE;

    }

    protected void btnReCalcular_Click(object sender, EventArgs e)
    {
        //MontaGridView();
        //Chamo o evento responsavel por recalcular os valores com o desconto
        CheckBox1_CheckedChanged(null, null);
    }

    //Calcula o valor total
    public void CalculaTotal()
    {
        int x = 0;
        Label lblValorTotal = (Label)GridView1.FooterRow.FindControl("lblValorTotal");
        //Valido apenas para numero
        if (int.TryParse(txtPorcentagem.Text, out x))
        {
            //Verifico se o desconto nao sera maior que 100%
            if (x <= 100)
            {
                //Calculo o desconto no recibo
                //return ValorTotal - (ValorTotal * (Convert.ToDouble(txtPorcentagem.Text) / 100d));
                lblValorTotal.Text = String.Format("{0:C2}", ValorTotal - (ValorTotal * (Convert.ToDouble(txtPorcentagem.Text) / 100d)));
            }
        }
        else
        {
            lblValorTotal.Text = String.Format("{0:C2}", ValorTotal);
        }
    }
}
