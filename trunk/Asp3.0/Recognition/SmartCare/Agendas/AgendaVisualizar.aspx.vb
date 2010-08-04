Imports System.Data
Imports System.Data.SqlClient
Imports System.Text


Public Class AgendaVisualizar
    Inherits System.Web.UI.Page
    'Declaração de Variaveis Globais

    Dim DS As New DataSet

    Dim MyCommand As SqlDataAdapter 'Define o SqlDataAdapter

    Dim MyConnection As SqlConnection 'Define a variavel MyConnection como global

    Private Const SELECT_QUERY_USUARIOS As String = "Select id,Descricao,CONVERT(CHAR, Data_Inicio, 103) As Data_Inicio ,CONVERT(CHAR, Data_Final, 103) As Data_Final, CONVERT(char(10), Data_Inicio, 108) AS Hora_Inicio, CONVERT(char(10), Data_Final, 108) AS Hora_Final from Agenda"

    Protected WithEvents lblMessage As System.Web.UI.WebControls.Label
    Protected WithEvents Calendar1 As System.Web.UI.WebControls.Calendar
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid


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

        MyConnection = New SqlConnection(ConfigurationSettings.AppSettings("ConnectionString"))

        MyCommand = New SqlDataAdapter(SELECT_QUERY_USUARIOS, MyConnection) 'Define o SqlDataAdapter para o MyCommand e executa a Query que é uma constante

        MyCommand.Fill(DS, "TabelaTemp")  'Preenche o data set. É passado um nome de uma tabela temporaria que o proprio sistema ira usar

        DataGrid1.DataSource = DS.Tables("TabelaTemp").DefaultView 'É passado um nome de uma tabela temporaria que o proprio sistema ira usar

        DataGrid1.DataBind()

    End Sub


    'Ao executar o evento ira verificar se a data que esta no DS é a mesa do calendario
    Private Sub Calendar1_DayRender(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DayRenderEventArgs) Handles Calendar1.DayRender

        Dim minhalinha As DataRow
        Dim dia As String
        Dim dia_feriado As DateTime
        Dim estiloferiado As New Style
        Dim strEvents = New StringBuilder
        estiloferiado.ForeColor = System.Drawing.Color.Red

        For Each minhalinha In DS.Tables("TabelaTemp").Rows
            dia = minhalinha("Data_Inicio")
            dia_feriado = DateTime.Parse(dia)
            If e.Day.Date = dia_feriado Then
                e.Cell.ApplyStyle(estiloferiado)
                strEvents.Append("<br>" + "<font color='#999999' size='1'>" + Left(minhalinha("Hora_Inicio"), 5) + "-" + Left(minhalinha("Hora_Final"), 5) + "</font>")
            End If
        Next
        e.Cell.Controls.Add(New LiteralControl(strEvents.ToString()))
    End Sub

    Private Sub Calendar1_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Calendar1.SelectionChanged
        Dim sbMessage As New StringBuilder
        sbMessage.Append("A(s) data(s) selecionada(s) sao: ")
        Dim i As Integer
        For i = 0 To Me.Calendar1.SelectedDates.Count - 1
            sbMessage.Append(Me.Calendar1.SelectedDates(i).ToShortDateString & "")
        Next

        Me.lblMessage.Text = sbMessage.ToString

    End Sub

End Class
