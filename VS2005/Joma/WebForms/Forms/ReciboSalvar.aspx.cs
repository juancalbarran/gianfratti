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
using System.Text;
using JomaBE;
using JomaDAL;
using System.Globalization;

public partial class Forms_ReciboSalvar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ReciboBE reciboBE;

        //if (Session["ReciboBE"] != null)
        //{
        reciboBE = Session["ReciboBE"] as ReciboBE;
        //}

        CarregaProfissional(Convert.ToInt32(reciboBE.RefProfissionalBE.id));
        lblReciboNumero.Text = Convert.ToString(reciboBE.id);
        lblValorTotalCabecalho.Text = String.Format("{0:C2}", reciboBE.ValorTotal);
        lblValorTotal.Text = String.Format("{0:C2}", reciboBE.ValorTotal);
        lblSessoesQtd.Text = Convert.ToString(reciboBE.RefReciboAgendamentoSessoesBE.Count.ToString("00"));
        lblPacienteNome.Text = Convert.ToString(reciboBE.PacienteNome);
        //Pego a possicao zero da lista de sessooes
        lblValorSessao.Text = String.Format("{0:C2}", reciboBE.RefReciboAgendamentoSessoesBE[0].Valor);

        StringBuilder sb = new System.Text.StringBuilder();
        for (int i = 0; i < reciboBE.RefReciboAgendamentoSessoesBE.Count; i++)
        {
            if (i > 0)
                sb.Append(", ");

            sb.Append(reciboBE.RefReciboAgendamentoSessoesBE[i].Data.ToString("dd/MM/yyyy"));
        }

        lblDatas.Text = Convert.ToString(sb);

        DataExtenso();

    }

    public void CarregaProfissional(Int32 idProfissional)
    {
        ProfissionaisDAL profissionaisDAL = new ProfissionaisDAL();
        ProfissionaisBE profissionaisBE = new ProfissionaisBE();
        profissionaisBE = profissionaisDAL.Obter(idProfissional);
        lblProfissionalNome.Text = Convert.ToString(profissionaisBE.Nome);
        lblProfissionalCrefito.Text = Convert.ToString(profissionaisBE.Registro);
        lblProfissionalCPF.Text = Convert.ToString(profissionaisBE.CPF);
    }

    public void DataExtenso()
    {
        CultureInfo culture = new CultureInfo("pt-BR"); 
        DateTimeFormatInfo dtfi = culture.DateTimeFormat; 
        int dia = DateTime.Now.Day; 
        int ano = DateTime.Now.Year; 
        string mes = culture.TextInfo.ToTitleCase(dtfi.GetMonthName(DateTime.Now.Month)); 
        string diasemana = culture.TextInfo.ToTitleCase(dtfi.GetDayName(DateTime.Now.DayOfWeek)); 
        string data = diasemana + ", " + dia + " de " + mes + " de " + ano;
        lblDataExtenso.Text = data;
    }
}
