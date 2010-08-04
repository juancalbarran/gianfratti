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

public partial class PCMSO_PCMSOCadastro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ddlCliente.SelectedIndexChanged += new EventHandler(ddlCliente_SelectedIndexChanged);
        ClienteDepartamento1.SelectedIndexChanged += new EventHandler(ClienteDepartamento1_SelectedIndexChanged);
        ClienteSetor1.SelectedIndexChanged += new EventHandler(ClienteSetor1_SelectedIndexChanged);
        ClienteCargo1.SelectedIndexChanged += new EventHandler(ClienteCargo1_SelectedIndexChanged);
        RiscosOcupacionais1.SelectedIndexChanged += new EventHandler(RiscosOcupacionais1_SelectedIndexChanged);
        RiscosOcupacionais2.SelectedIndexChanged += new EventHandler(RiscosOcupacionais2_SelectedIndexChanged);
        RiscosOcupacionais3.SelectedIndexChanged += new EventHandler(RiscosOcupacionais3_SelectedIndexChanged);
        RiscosOcupacionais4.SelectedIndexChanged += new EventHandler(RiscosOcupacionais4_SelectedIndexChanged);
        RiscosOcupacionais5.SelectedIndexChanged += new EventHandler(RiscosOcupacionais5_SelectedIndexChanged);
        RiscosOcupacionais6.SelectedIndexChanged += new EventHandler(RiscosOcupacionais6_SelectedIndexChanged);
        RiscosOcupacionais7.SelectedIndexChanged += new EventHandler(RiscosOcupacionais7_SelectedIndexChanged);
        RiscosOcupacionais8.SelectedIndexChanged += new EventHandler(RiscosOcupacionais8_SelectedIndexChanged);
        RiscosOcupacionais9.SelectedIndexChanged += new EventHandler(RiscosOcupacionais9_SelectedIndexChanged);
        RiscosOcupacionais10.SelectedIndexChanged += new EventHandler(RiscosOcupacionais10_SelectedIndexChanged);
    }

    private void ddlCliente_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCliente.ValorInformado != string.Empty)
        {

            ClienteDepartamento1.idCliente = Convert.ToInt32(ddlCliente.ValorInformado);
        }

    }

    private void ClienteDepartamento1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ClienteDepartamento1.ValorInformado != string.Empty)
        {
            ClienteSetor1.idClienteDepartamento = Convert.ToInt32(ClienteDepartamento1.ValorInformado);
        }
    }

    private void ClienteSetor1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ClienteSetor1.ValorInformado != string.Empty)
        {
            ClienteCargo1.idClienteSetor = Convert.ToInt32(ClienteSetor1.ValorInformado);
        }
    }

    //Quando selecionado o cargo então carrega os registros pertinentes ao cargo selecionado
    private void ClienteCargo1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ClienteCargo1.ValorInformado != string.Empty)
        {
            Riscos(Convert.ToInt32(Request.QueryString["id"]), Convert.ToInt32(ClienteCargo1.ValorInformado));
            ExameAdmissional(Convert.ToInt32(Request.QueryString["id"]), Convert.ToInt32(ClienteCargo1.ValorInformado), 1);
            ExamePeriodico(Convert.ToInt32(Request.QueryString["id"]), Convert.ToInt32(ClienteCargo1.ValorInformado), 3);
            ExameDemissional(Convert.ToInt32(Request.QueryString["id"]), Convert.ToInt32(ClienteCargo1.ValorInformado), 2);
            MudancaFuncao(Convert.ToInt32(Request.QueryString["id"]), Convert.ToInt32(ClienteCargo1.ValorInformado), 4);
        }
    }

    private void RiscosOcupacionais1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RiscosOcupacionais1.ValorInformado != string.Empty)
        {
            RiscosOcupacionaisItens1.idRiscosOcupacionais = Convert.ToInt32(RiscosOcupacionais1.ValorInformado);
        }
    }

    private void RiscosOcupacionais2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RiscosOcupacionais2.ValorInformado != string.Empty)
        {
            RiscosOcupacionaisItens2.idRiscosOcupacionais = Convert.ToInt32(RiscosOcupacionais2.ValorInformado);

        }
    }

    private void RiscosOcupacionais3_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RiscosOcupacionais3.ValorInformado != string.Empty)
        {
            RiscosOcupacionaisItens3.idRiscosOcupacionais = Convert.ToInt32(RiscosOcupacionais3.ValorInformado);

        }
    }

    private void RiscosOcupacionais4_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RiscosOcupacionais4.ValorInformado != string.Empty)
        {
            RiscosOcupacionaisItens4.idRiscosOcupacionais = Convert.ToInt32(RiscosOcupacionais4.ValorInformado);

        }
    }

    private void RiscosOcupacionais5_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RiscosOcupacionais5.ValorInformado != string.Empty)
        {
            RiscosOcupacionaisItens5.idRiscosOcupacionais = Convert.ToInt32(RiscosOcupacionais5.ValorInformado);

        }
    }

    private void RiscosOcupacionais6_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RiscosOcupacionais6.ValorInformado != string.Empty)
        {
            RiscosOcupacionaisItens6.idRiscosOcupacionais = Convert.ToInt32(RiscosOcupacionais6.ValorInformado);

        }
    }

    private void RiscosOcupacionais7_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RiscosOcupacionais7.ValorInformado != string.Empty)
        {
            RiscosOcupacionaisItens7.idRiscosOcupacionais = Convert.ToInt32(RiscosOcupacionais7.ValorInformado);

        }
    }

    private void RiscosOcupacionais8_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RiscosOcupacionais8.ValorInformado != string.Empty)
        {
            RiscosOcupacionaisItens8.idRiscosOcupacionais = Convert.ToInt32(RiscosOcupacionais8.ValorInformado);

        }
    }

    private void RiscosOcupacionais9_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RiscosOcupacionais9.ValorInformado != string.Empty)
        {
            RiscosOcupacionaisItens9.idRiscosOcupacionais = Convert.ToInt32(RiscosOcupacionais9.ValorInformado);

        }
    }

    private void RiscosOcupacionais10_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RiscosOcupacionais10.ValorInformado != string.Empty)
        {
            RiscosOcupacionaisItens10.idRiscosOcupacionais = Convert.ToInt32(RiscosOcupacionais10.ValorInformado);

        }
    }
    //Salva o PCMSO
    protected void btnSalvar_Click(object sender, EventArgs e)
    {
        try
        {
            Validacoes ObjValidacoes = new Validacoes();
            //Preenche dados referente a tabela PCMSO
            PCMSO ObjPCMSO = new PCMSO();
            ObjPCMSO.id = Convert.ToInt32(Request.QueryString["id"]);
            ObjPCMSO.idCliente = Convert.ToInt32(ddlCliente.ValorInformado);
            //Preenche dados referente a tabela PCMSOXSetor
            ObjPCMSO.RefObjPCMSOXSetor.idSetor = Convert.ToInt32(ClienteSetor1.ValorInformado);
            ObjPCMSO.RefObjPCMSOXSetor.idCargo = Convert.ToInt32(ClienteCargo1.ValorInformado);
            //Preenche dados referente a tabela PCMSOXRiscosOcupacionais em uma lista
            if (RiscosOcupacionais1.ValorInformado != string.Empty && RiscosOcupacionaisItens1.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXRiscosOcupacionais.Add(new PCMSOXRiscosOcupacionais(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), Convert.ToInt32(RiscosOcupacionais1.ValorInformado), Convert.ToInt32(RiscosOcupacionaisItens1.ValorInformado)));
            if (RiscosOcupacionais2.ValorInformado != string.Empty && RiscosOcupacionaisItens2.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXRiscosOcupacionais.Add(new PCMSOXRiscosOcupacionais(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), Convert.ToInt32(RiscosOcupacionais2.ValorInformado), Convert.ToInt32(RiscosOcupacionaisItens2.ValorInformado)));
            if (RiscosOcupacionais3.ValorInformado != string.Empty && RiscosOcupacionaisItens3.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXRiscosOcupacionais.Add(new PCMSOXRiscosOcupacionais(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), Convert.ToInt32(RiscosOcupacionais3.ValorInformado), Convert.ToInt32(RiscosOcupacionaisItens3.ValorInformado)));
            if (RiscosOcupacionais4.ValorInformado != string.Empty && RiscosOcupacionaisItens4.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXRiscosOcupacionais.Add(new PCMSOXRiscosOcupacionais(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), Convert.ToInt32(RiscosOcupacionais4.ValorInformado), Convert.ToInt32(RiscosOcupacionaisItens4.ValorInformado)));
            if (RiscosOcupacionais5.ValorInformado != string.Empty && RiscosOcupacionaisItens5.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXRiscosOcupacionais.Add(new PCMSOXRiscosOcupacionais(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), Convert.ToInt32(RiscosOcupacionais5.ValorInformado), Convert.ToInt32(RiscosOcupacionaisItens5.ValorInformado)));
            if (RiscosOcupacionais6.ValorInformado != string.Empty && RiscosOcupacionaisItens6.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXRiscosOcupacionais.Add(new PCMSOXRiscosOcupacionais(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), Convert.ToInt32(RiscosOcupacionais6.ValorInformado), Convert.ToInt32(RiscosOcupacionaisItens6.ValorInformado)));
            if (RiscosOcupacionais7.ValorInformado != string.Empty && RiscosOcupacionaisItens7.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXRiscosOcupacionais.Add(new PCMSOXRiscosOcupacionais(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), Convert.ToInt32(RiscosOcupacionais7.ValorInformado), Convert.ToInt32(RiscosOcupacionaisItens7.ValorInformado)));
            if (RiscosOcupacionais8.ValorInformado != string.Empty && RiscosOcupacionaisItens8.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXRiscosOcupacionais.Add(new PCMSOXRiscosOcupacionais(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), Convert.ToInt32(RiscosOcupacionais8.ValorInformado), Convert.ToInt32(RiscosOcupacionaisItens8.ValorInformado)));
            if (RiscosOcupacionais9.ValorInformado != string.Empty && RiscosOcupacionaisItens9.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXRiscosOcupacionais.Add(new PCMSOXRiscosOcupacionais(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), Convert.ToInt32(RiscosOcupacionais9.ValorInformado), Convert.ToInt32(RiscosOcupacionaisItens9.ValorInformado)));
            if (RiscosOcupacionais10.ValorInformado != string.Empty && RiscosOcupacionaisItens10.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXRiscosOcupacionais.Add(new PCMSOXRiscosOcupacionais(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), Convert.ToInt32(RiscosOcupacionais10.ValorInformado), Convert.ToInt32(RiscosOcupacionaisItens10.ValorInformado)));
            //Preenche dados referente a tabela PCMSOXExamesComplementares em uma lista
            //Exame Admissional
            if (ddlAdm1.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 1, Convert.ToInt32(ddlAdm1.ValorInformado),null));
            if (ddlAdm2.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 1, Convert.ToInt32(ddlAdm2.ValorInformado), null));
            if (ddlAdm3.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 1, Convert.ToInt32(ddlAdm3.ValorInformado), null));
            if (ddlAdm4.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 1, Convert.ToInt32(ddlAdm4.ValorInformado), null));
            if (ddlAdm5.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 1, Convert.ToInt32(ddlAdm5.ValorInformado), null));
            if (ddlAdm6.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 1, Convert.ToInt32(ddlAdm6.ValorInformado), null));
            if (ddlAdm7.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 1, Convert.ToInt32(ddlAdm7.ValorInformado), null));
            if (ddlAdm8.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 1, Convert.ToInt32(ddlAdm8.ValorInformado), null));
            if (ddlAdm9.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 1, Convert.ToInt32(ddlAdm9.ValorInformado), null));
            if (ddlAdm10.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 1, Convert.ToInt32(ddlAdm10.ValorInformado), null));
            //Exame Periodico
            if (ddlPer1.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 3, Convert.ToInt32(ddlPer1.ValorInformado), Convert.ToString(ddlPeriodicidade1.ValorInformado)));
            if (ddlPer2.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 3, Convert.ToInt32(ddlPer2.ValorInformado), Convert.ToString(ddlPeriodicidade2.ValorInformado)));
            if (ddlPer3.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 3, Convert.ToInt32(ddlPer3.ValorInformado), Convert.ToString(ddlPeriodicidade3.ValorInformado)));
            if (ddlPer4.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 3, Convert.ToInt32(ddlPer4.ValorInformado), Convert.ToString(ddlPeriodicidade4.ValorInformado)));
            if (ddlPer5.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 3, Convert.ToInt32(ddlPer5.ValorInformado), Convert.ToString(ddlPeriodicidade5.ValorInformado)));
            if (ddlPer6.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 3, Convert.ToInt32(ddlPer6.ValorInformado), Convert.ToString(ddlPeriodicidade6.ValorInformado)));
            if (ddlPer7.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 3, Convert.ToInt32(ddlPer7.ValorInformado), Convert.ToString(ddlPeriodicidade7.ValorInformado)));
            if (ddlPer8.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 3, Convert.ToInt32(ddlPer8.ValorInformado), Convert.ToString(ddlPeriodicidade8.ValorInformado)));
            if (ddlPer9.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 3, Convert.ToInt32(ddlPer9.ValorInformado), Convert.ToString(ddlPeriodicidade9.ValorInformado)));
            if (ddlPer10.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 3, Convert.ToInt32(ddlPer10.ValorInformado), Convert.ToString(ddlPeriodicidade10.ValorInformado)));
            //Exame Demissional
            if (ddlDem1.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 2, Convert.ToInt32(ddlDem1.ValorInformado), null));
            if (ddlDem2.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 2, Convert.ToInt32(ddlDem2.ValorInformado), null));
            if (ddlDem3.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 2, Convert.ToInt32(ddlDem3.ValorInformado), null));
            if (ddlDem4.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 2, Convert.ToInt32(ddlDem4.ValorInformado), null));
            if (ddlDem5.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 2, Convert.ToInt32(ddlDem5.ValorInformado), null));
            if (ddlDem6.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 2, Convert.ToInt32(ddlDem6.ValorInformado), null));
            if (ddlDem7.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 2, Convert.ToInt32(ddlDem7.ValorInformado), null));
            if (ddlDem8.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 2, Convert.ToInt32(ddlDem8.ValorInformado), null));
            if (ddlDem9.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 2, Convert.ToInt32(ddlDem9.ValorInformado), null));
            if (ddlDem10.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 2, Convert.ToInt32(ddlDem10.ValorInformado), null));
            //Exame Mudança de Função
            if (ddlMud1.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 4, Convert.ToInt32(ddlMud1.ValorInformado), null));
            if (ddlMud2.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 4, Convert.ToInt32(ddlMud2.ValorInformado), null));
            if (ddlMud3.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 4, Convert.ToInt32(ddlMud3.ValorInformado), null));
            if (ddlMud4.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 4, Convert.ToInt32(ddlMud4.ValorInformado), null));
            if (ddlMud5.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 4, Convert.ToInt32(ddlMud5.ValorInformado), null));
            if (ddlMud6.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 4, Convert.ToInt32(ddlMud6.ValorInformado), null));
            if (ddlMud7.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 4, Convert.ToInt32(ddlMud7.ValorInformado), null));
            if (ddlMud8.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 4, Convert.ToInt32(ddlMud8.ValorInformado), null));
            if (ddlMud9.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 4, Convert.ToInt32(ddlMud9.ValorInformado), null));
            if (ddlMud10.ValorInformado != string.Empty) ObjPCMSO.RefPCMSOXExamesComplementares.Add(new PCMSOXExamesComplementares(ObjPCMSO.id, Convert.ToInt32(ClienteCargo1.ValorInformado), 4, Convert.ToInt32(ddlMud10.ValorInformado), null));

            //Chama o DAL
            PCMSODAL ObjPCMSODAL = new PCMSODAL();
            ObjPCMSODAL.Insert(ObjPCMSO);
        }
        catch (Exception ex)
        {
            Response.Write(ex);
            Response.End();
        }
    }
    //Carrega os combos com os Riscos
    private void Riscos(int idPCMSO,int idCargo)
    {
        PCMSO ObjPCMSO = new PCMSO();
        PCMSOXRiscosOcupacionaisDAL ObjPCMSOXRiscosOcupacionaisDAL = new PCMSOXRiscosOcupacionaisDAL();
        ObjPCMSO = ObjPCMSOXRiscosOcupacionaisDAL.SelectByID(idPCMSO, Convert.ToInt32(ClienteCargo1.ValorInformado));

        if (ObjPCMSO.RefPCMSOXRiscosOcupacionais.Count >= 1)
        {
            RiscosOcupacionais1.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[0].idRiscosOcupacionais);
            RiscosOcupacionais1_SelectedIndexChanged(null, null);
            RiscosOcupacionaisItens1.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[0].idRiscosOcupacionaisItens);
        }
        else
        {
            RiscosOcupacionais1.ValorInformado = null;
            RiscosOcupacionaisItens1.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXRiscosOcupacionais.Count >= 2)
        {
            RiscosOcupacionais2.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[1].idRiscosOcupacionais);
            RiscosOcupacionais2_SelectedIndexChanged(null, null);
            RiscosOcupacionaisItens2.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[1].idRiscosOcupacionaisItens);
        }
        else
        {
            RiscosOcupacionais2.ValorInformado = string.Empty;
            RiscosOcupacionaisItens2.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXRiscosOcupacionais.Count >= 3)
        {
            RiscosOcupacionais3.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[2].idRiscosOcupacionais);
            RiscosOcupacionais3_SelectedIndexChanged(null, null);
            RiscosOcupacionaisItens3.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[2].idRiscosOcupacionaisItens);
        }
        else
        {
            RiscosOcupacionais3.ValorInformado = string.Empty;
            RiscosOcupacionaisItens3.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXRiscosOcupacionais.Count >= 4)
        {
            RiscosOcupacionais4.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[3].idRiscosOcupacionais);
            RiscosOcupacionais4_SelectedIndexChanged(null, null);
            RiscosOcupacionaisItens4.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[3].idRiscosOcupacionaisItens);
        }
        else
        {
            RiscosOcupacionais4.ValorInformado = string.Empty;
            RiscosOcupacionaisItens4.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXRiscosOcupacionais.Count >= 5)
        {
            RiscosOcupacionais5.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[4].idRiscosOcupacionais);
            RiscosOcupacionais5_SelectedIndexChanged(null, null);
            RiscosOcupacionaisItens5.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[4].idRiscosOcupacionaisItens);
        }
        else
        {
            RiscosOcupacionais5.ValorInformado = string.Empty;
            RiscosOcupacionaisItens5.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXRiscosOcupacionais.Count >= 6)
        {
            RiscosOcupacionais6.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[5].idRiscosOcupacionais);
            RiscosOcupacionais6_SelectedIndexChanged(null, null);
            RiscosOcupacionaisItens6.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[5].idRiscosOcupacionaisItens);
        }
        else
        {
            RiscosOcupacionais6.ValorInformado = string.Empty;
            RiscosOcupacionaisItens6.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXRiscosOcupacionais.Count >= 7)
        {
            RiscosOcupacionais7.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[6].idRiscosOcupacionais);
            RiscosOcupacionais7_SelectedIndexChanged(null, null);
            RiscosOcupacionaisItens7.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[6].idRiscosOcupacionaisItens);
        }
        else
        {
            RiscosOcupacionais7.ValorInformado = string.Empty;
            RiscosOcupacionaisItens7.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXRiscosOcupacionais.Count >= 8)
        {
            RiscosOcupacionais8.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[7].idRiscosOcupacionais);
            RiscosOcupacionais8_SelectedIndexChanged(null, null);
            RiscosOcupacionaisItens8.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[7].idRiscosOcupacionaisItens);
        }
        else
        {
            RiscosOcupacionais8.ValorInformado = string.Empty;
            RiscosOcupacionaisItens8.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXRiscosOcupacionais.Count >= 9)
        {
            RiscosOcupacionais9.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[8].idRiscosOcupacionais);
            RiscosOcupacionais9_SelectedIndexChanged(null, null);
            RiscosOcupacionaisItens9.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[8].idRiscosOcupacionaisItens);
        }
        else
        {
            RiscosOcupacionais9.ValorInformado = string.Empty;
            RiscosOcupacionaisItens9.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXRiscosOcupacionais.Count >= 10)
        {
            RiscosOcupacionais10.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[9].idRiscosOcupacionais);
            RiscosOcupacionais10_SelectedIndexChanged(null, null);
            RiscosOcupacionaisItens10.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXRiscosOcupacionais[9].idRiscosOcupacionaisItens);
        }
        else
        {
            RiscosOcupacionais10.ValorInformado = string.Empty;
            RiscosOcupacionaisItens10.ValorInformado = string.Empty;
        }
    }
    //Carrega os combos com os Exames Admissionais
    private void ExameAdmissional(int idPCMSO, int idCargo, int idTipoAtestado)
    {
        PCMSO ObjPCMSO = new PCMSO();
        PCMSOXExamesComplementaresDAL ObjPCMSOXExamesComplementaresDAL = new PCMSOXExamesComplementaresDAL();
        ObjPCMSO = ObjPCMSOXExamesComplementaresDAL.SelectByID(idPCMSO, idCargo, idTipoAtestado);
        //Admissional
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 1)
        {
            ddlAdm1.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[0].idExamesComplementares);
        }
        else
        {
            ddlAdm1.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 2)
        {
            ddlAdm2.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[1].idExamesComplementares);
        }
        else
        {
            ddlAdm2.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 3)
        {
            ddlAdm3.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[2].idExamesComplementares);
        }
        else
        {
            ddlAdm3.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 4)
        {
            ddlAdm4.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[3].idExamesComplementares);
        }
        else
        {
            ddlAdm4.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 5)
        {
            ddlAdm5.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[4].idExamesComplementares);
        }
        else
        {
            ddlAdm5.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 6)
        {
            ddlAdm6.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[5].idExamesComplementares);
        }
        else
        {
            ddlAdm6.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 7)
        {
            ddlAdm7.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[6].idExamesComplementares);
        }
        else
        {
            ddlAdm7.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 8)
        {
            ddlAdm8.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[7].idExamesComplementares);
        }
        else
        {
            ddlAdm8.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 9)
        {
            ddlAdm9.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[8].idExamesComplementares);
        }
        else
        {
            ddlAdm9.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 10)
        {
            ddlAdm10.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[9].idExamesComplementares);
        }
        else
        {
            ddlAdm10.ValorInformado = string.Empty;
        }
    }
    //Carrega os combos com os exames periodicos
    private void ExamePeriodico(int idPCMSO, int idCargo, int idTipoAtestado)
    {
        PCMSO ObjPCMSO = new PCMSO();
        PCMSOXExamesComplementaresDAL ObjPCMSOXExamesComplementaresDAL = new PCMSOXExamesComplementaresDAL();
        ObjPCMSO = ObjPCMSOXExamesComplementaresDAL.SelectByID(idPCMSO, idCargo,idTipoAtestado);
        //Admissional
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 1)
        {
            ddlPer1.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[0].idExamesComplementares);
            ddlPeriodicidade1.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[0].idPeriodicidade);
        }
        else
        {
            ddlPer1.ValorInformado = string.Empty;
            ddlPeriodicidade1.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 2)
        {
            ddlPer2.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[1].idExamesComplementares);
            ddlPeriodicidade2.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[1].idPeriodicidade);
        }
        else
        {
            ddlPer2.ValorInformado = string.Empty;
            ddlPeriodicidade2.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 3)
        {
            ddlPer3.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[2].idExamesComplementares);
            ddlPeriodicidade3.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[2].idPeriodicidade);
        }
        else
        {
            ddlPer3.ValorInformado = string.Empty;
            ddlPeriodicidade3.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 4)
        {
            ddlPer4.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[3].idExamesComplementares);
            ddlPeriodicidade4.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[3].idPeriodicidade);
        }
        else
        {
            ddlPer4.ValorInformado = string.Empty;
            ddlPeriodicidade4.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 5)
        {
            ddlPer5.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[4].idExamesComplementares);
            ddlPeriodicidade5.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[4].idPeriodicidade);
        }
        else
        {
            ddlPer5.ValorInformado = string.Empty;
            ddlPeriodicidade5.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 6)
        {
            ddlPer6.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[5].idExamesComplementares);
            ddlPeriodicidade6.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[5].idPeriodicidade);
        }
        else
        {
            ddlPer6.ValorInformado = string.Empty;
            ddlPeriodicidade6.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 7)
        {
            ddlPer7.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[6].idExamesComplementares);
            ddlPeriodicidade7.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[6].idPeriodicidade);
        }
        else
        {
            ddlPer7.ValorInformado = string.Empty;
            ddlPeriodicidade7.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 8)
        {
            ddlPer8.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[7].idExamesComplementares);
            ddlPeriodicidade8.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[7].idPeriodicidade);
        }
        else
        {
            ddlPer8.ValorInformado = string.Empty;
            ddlPeriodicidade8.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 9)
        {
            ddlPer9.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[8].idExamesComplementares);
            ddlPeriodicidade9.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[8].idPeriodicidade);
        }
        else
        {
            ddlPer9.ValorInformado = string.Empty;
            ddlPeriodicidade9.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 10)
        {
            ddlPer10.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[9].idExamesComplementares);
            ddlPeriodicidade10.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[9].idPeriodicidade);
        }
        else
        {
            ddlPer10.ValorInformado = string.Empty;
            ddlPeriodicidade10.ValorInformado = string.Empty;
        }
    }
    //Carrega os combos com os exames demissionais
    private void ExameDemissional(int idPCMSO, int idCargo, int idTipoAtestado)
    {
        PCMSO ObjPCMSO = new PCMSO();
        PCMSOXExamesComplementaresDAL ObjPCMSOXExamesComplementaresDAL = new PCMSOXExamesComplementaresDAL();
        ObjPCMSO = ObjPCMSOXExamesComplementaresDAL.SelectByID(idPCMSO, idCargo, idTipoAtestado);
        //Admissional
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 1)
        {
            ddlDem1.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[0].idExamesComplementares);
        }
        else
        {
            ddlDem1.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 2)
        {
            ddlDem2.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[1].idExamesComplementares);
        }
        else
        {
            ddlDem2.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 3)
        {
            ddlDem3.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[2].idExamesComplementares);
        }
        else
        {
            ddlDem3.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 4)
        {
            ddlDem4.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[3].idExamesComplementares);
        }
        else
        {
            ddlDem4.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 5)
        {
            ddlDem5.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[4].idExamesComplementares);
        }
        else
        {
            ddlDem5.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 6)
        {
            ddlDem6.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[5].idExamesComplementares);
        }
        else
        {
            ddlDem6.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 7)
        {
            ddlDem7.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[6].idExamesComplementares);
        }
        else
        {
            ddlDem7.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 8)
        {
            ddlDem8.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[7].idExamesComplementares);
        }
        else
        {
            ddlDem8.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 9)
        {
            ddlDem9.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[8].idExamesComplementares);
        }
        else
        {
            ddlDem9.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 10)
        {
            ddlDem10.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[9].idExamesComplementares);
        }
        else
        {
            ddlDem10.ValorInformado = string.Empty;
        }
    }
    //Carrega os combos com os exames de mudança de função
    private void MudancaFuncao(int idPCMSO, int idCargo, int idTipoAtestado)
    {
        PCMSO ObjPCMSO = new PCMSO();
        PCMSOXExamesComplementaresDAL ObjPCMSOXExamesComplementaresDAL = new PCMSOXExamesComplementaresDAL();
        ObjPCMSO = ObjPCMSOXExamesComplementaresDAL.SelectByID(idPCMSO, idCargo,idTipoAtestado);
        //Admissional
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 1)
        {
            ddlMud1.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[0].idExamesComplementares);
        }
        else
        {
            ddlMud1.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 2)
        {
            ddlMud2.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[1].idExamesComplementares);
        }
        else
        {
            ddlMud2.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 3)
        {
            ddlMud3.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[2].idExamesComplementares);
        }
        else
        {
            ddlMud3.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 4)
        {
            ddlMud4.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[3].idExamesComplementares);
        }
        else
        {
            ddlMud4.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 5)
        {
            ddlMud5.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[4].idExamesComplementares);
        }
        else
        {
            ddlMud5.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 6)
        {
            ddlMud6.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[5].idExamesComplementares);
        }
        else
        {
            ddlMud6.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 7)
        {
            ddlMud7.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[6].idExamesComplementares);
        }
        else
        {
            ddlMud7.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 8)
        {
            ddlMud8.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[7].idExamesComplementares);
        }
        else
        {
            ddlMud8.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 9)
        {
            ddlMud9.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[8].idExamesComplementares);
        }
        else
        {
            ddlMud9.ValorInformado = string.Empty;
        }
        if (ObjPCMSO.RefPCMSOXExamesComplementares.Count >= 10)
        {
            ddlMud10.ValorInformado = Convert.ToString(ObjPCMSO.RefPCMSOXExamesComplementares[9].idExamesComplementares);
        }
        else
        {
            ddlMud10.ValorInformado = string.Empty;
        }
    }
}
