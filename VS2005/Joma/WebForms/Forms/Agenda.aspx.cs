using System;
using System.Text;
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

public partial class Forms_Agenda : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //Chama o metodo 
            MontaComboProfissionais(); 
        }
    }


    protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
    {
        AgendamentoSessoesDAL agendamentoSessoesDAL = new AgendamentoSessoesDAL();
        DataTable dataTable = agendamentoSessoesDAL.ListarAgendaMultiProfissionais(ddlProfissionais.SelectedValue);

        StringBuilder Texto = new StringBuilder(""); 
        //if (!e.Day.IsOtherMonth) Caso querira somente percorrer os dias do mes atual
        string Cor1 = "#E3EAEB";
        string Cor = string.Empty;
            foreach (DataRow dr in dataTable.Rows)
            {
                if ((dr["DataInicio"].ToString() != DBNull.Value.ToString()))
                {
                    DateTime dtEvent = Convert.ToDateTime(dr["DataInicio"].ToString());
                    DateTime dtEventFim = Convert.ToDateTime(dr["DataFim"].ToString());
                    if (dtEvent.Equals(e.Day.Date))
                    {
                        if (Cor == Cor1) { Cor = "#E5E5E5"; } else { Cor = "#E3EAEB"; }
                        Texto.Append("<table width='100%'  border='0' cellspacing='0' cellpadding='0'  bgcolor='"+Cor+"'>");
                        Texto.Append("<tr><td align='left'>" + dr["HoraInicio"].ToString() + " - " + dr["HoraFim"].ToString() + "</td></tr>");
                        Texto.Append("<tr><td align='left'>" + dr["ProfissionalNome"].ToString() + "</td></tr>");
                        Texto.Append("<tr><td align='left'>" + dr["PacienteNome"].ToString() + "</td></tr>");
                        Texto.Append("</table>");
                        Texto.Append("<br style='font-size: 5px' >");
                        e.Cell.Controls.Clear();
                        e.Cell.Text = e.Day.DayNumberText + "<br>" + Texto;
                        e.Cell.Font.Size = FontUnit.XXSmall;
                        e.Cell.Font.Bold = true;
                    }
                }
            }
    }

    public void MontaComboProfissionais()
    {
        ProfissionaisDAL profissionaisDAL = new ProfissionaisDAL();
        ddlProfissionais.DataSource = profissionaisDAL.ListarByIdPerfil(2);
        ddlProfissionais.DataTextField = "Nome";
        ddlProfissionais.DataValueField = "ID";
        ddlProfissionais.DataBind();
        ddlProfissionais.Items.Insert(0, new ListItem("<--Todos os Profissionais-->", string.Empty)); //Texto Inicial do combo
    }
    protected void btmBuscar_Click(object sender, EventArgs e)
    {

    }
}
