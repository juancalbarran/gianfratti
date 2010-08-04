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

public partial class Tabelas_CBO_PopUp_Detalhes : System.Web.UI.Page
{
    string CodOcupSinonimo;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            Visualizar(Convert.ToInt32(Request.QueryString["CBO"]));
        }
        GridViewSinonimos();
    }
    //ToDo Terminar Método
    public void Visualizar(int CBO)
    {
        CBO ObjCBO = new CBO();
        CBODAL ObjCBODAL = new CBODAL();
        ObjCBO = ObjCBODAL.SelectByID(CBO);
        lblCBO.Text = Convert.ToString(ObjCBO.COD_CBO);
        labelFuncao.Text = Convert.ToString(ObjCBO.FUNCAO);
        txtResumida.Text = Convert.ToString(ObjCBO.Descr_Familia);
        txtDetalhada.Text = Convert.ToString(ObjCBO.Cond_Exerc);
        txtFormacaoExperiencia.Text = Convert.ToString(ObjCBO.Form_Exp);
        txtExcecao.Text = Convert.ToString(ObjCBO.Descr_Excecao);
        CodOcupSinonimo = ObjCBO.Cod_Int_Ocup;
    }

    public void GridViewSinonimos()
    {
        CBODAL ObjCboDAL = new CBODAL();
        GridView1.DataSource = ObjCboDAL.CarregaSinonimosByCod(CodOcupSinonimo);
        GridView1.DataBind();
    }

}
