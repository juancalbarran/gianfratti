Imports System.Data
Imports System.Data.SqlClient
Imports System.Text


Public Class Calendario
    Inherits System.Web.UI.Page
    'Declaração de Variaveis Globais

    'Faz conexao com a DLL onde contem a string de conexao
    Dim ObjConexao As New Funcoes.Conexao
    Dim MyConnection As SqlConnection 'Define a variavel MyConnection como global
    Dim DS As New DataSet
    Dim MyCommand As SqlDataAdapter 'Define o SqlDataAdapter
    'Private Const SELECT_QUERY_AGENDA As String = "Select id,Descricao,CONVERT(CHAR, Data_Inicio, 103) As Data_Inicio ,CONVERT(CHAR, Data_Final, 103) As Data_Final, CONVERT(char(10), Data_Inicio, 108) AS Hora_Inicio, CONVERT(char(10), Data_Final, 108) AS Hora_Final from Agenda"
    Private Const SELECT_QUERY_AGENDA As String = "SELECT dbo.Agenda.id, dbo.Agenda.Descricao, CONVERT(CHAR, dbo.Agenda.Data_Inicio, 103) AS Data_Inicio, CONVERT(CHAR, dbo.Agenda.Data_Final, 103) " + _
                                                    "AS Data_Final, CONVERT(char(10), dbo.Agenda.Data_Inicio, 108) AS Hora_Inicio, CONVERT(char(10), dbo.Agenda.Data_Final, 108) AS Hora_Final, dbo.Pacientes.nome AS Paciente " + _
                                                    "FROM  dbo.Agenda INNER JOIN " + _
                                                    "dbo.HomeCare_Atendimento ON dbo.Agenda.id_Atendimento = dbo.HomeCare_Atendimento.id INNER JOIN " + _
                                                    "dbo.HomeCare_Solicitacao_Atendimento ON " + _
                                                    "dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id INNER JOIN " + _
                                                    "dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id "

    Protected WithEvents Calendar1 As System.Web.UI.WebControls.Calendar


#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Neste código nao pode ser usado a instrução "If Not Page.IsPostBack Then" pois senao sempre que trocar de mes da erro por causa do DS
        'MyConnection = New SqlConnection(ConfigurationSettings.AppSettings("ConnectionString"))

        Dim Conexao As String = ObjConexao.Conexao

        'Define a String de conexão ao MyConnection.
        'Definimos no Page Load para ser usada em toda a página
        MyConnection = New SqlConnection(Conexao)

        MyCommand = New SqlDataAdapter(SELECT_QUERY_AGENDA, MyConnection) 'Define o SqlDataAdapter para o MyCommand e executa a Query que é uma constante
        MyCommand.Fill(DS, "TabelaTemp")  'Preenche o data set. É passado um nome de uma tabela temporaria que o proprio sistema ira usar

        'DataGrid1.DataSource = DS.Tables("TabelaTemp").DefaultView 'É passado um nome de uma tabela temporaria que o proprio sistema ira usar

        'DataGrid1.DataBind()

    End Sub

    'Ao executar o evento ira verificar se a data que esta do DS é a mesa do calendario
    Private Sub Calendar1_DayRender(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DayRenderEventArgs) Handles Calendar1.DayRender

        Dim minhalinha As DataRow
        Dim dia As String
        Dim dia_feriado As DateTime
        Dim EstiloDia As New Style
        Dim EstiloCelula As New Style
        Dim strEvents = New StringBuilder
        Dim Paciente() As String

        EstiloDia.ForeColor = System.Drawing.Color.Red
        EstiloCelula.BackColor = System.Drawing.Color.WhiteSmoke

        For Each minhalinha In DS.Tables("TabelaTemp").Rows
            dia = minhalinha("Data_Inicio")
            dia_feriado = DateTime.Parse(dia)
            Paciente = Split(minhalinha("Paciente"))

            If e.Day.Date = dia_feriado Then
                e.Cell.ApplyStyle(EstiloDia)
                e.Cell.ApplyStyle(EstiloCelula)
                strEvents.Append("<br><img src='/SmartCare/images/sino.gif' border='0' alt='" + minhalinha("Paciente") + "'><a href=""javascript:AbrePopUp('AgendaDia.aspx?ID=" + Left(minhalinha("ID"), 10) + "','700','500',this,event)""><font color='#000000' size='1' >" + Left(Paciente(0), 8) + "-" + Left(minhalinha("Hora_Inicio"), 5) + "-" + Left(minhalinha("Hora_Final"), 5) + "</font></a>")
            End If
        Next
        e.Cell.Controls.Add(New LiteralControl(strEvents.ToString()))

    End Sub

    'Evento executado ao selecionar uma data no calendario
    Private Sub Calendar1_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Calendar1.SelectionChanged

        Dim sbMessage As New StringBuilder
        Dim js As New StringBuilder
        Dim teste As String

        Dim i As Integer
        For i = 0 To Me.Calendar1.SelectedDates.Count - 1
            sbMessage.Append(Me.Calendar1.SelectedDates(i).ToString("dd/MM/yyyy") & "")
        Next

        js.Append("<script>AbrePopUp('AgendaDia.aspx?Data=" + sbMessage.ToString + "','600','400')</script> ")

        RegisterClientScriptBlock("", js.ToString())

    End Sub

End Class
