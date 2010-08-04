Imports System.Data
Imports System.Data.SqlClient
Imports ADODB

Public Class AgendaDia
    Inherits System.Web.UI.Page

    'Declaração de Variaveis Globais

    Dim MyConnection As SqlConnection 'Define a variavel MyConnection como global
    Dim SortField As String 'Variavel responsavel por pegar o nome do campo que sera feita a ordenacao do data grid
    Dim Ordenacao As String 'Variavel responsavel por saber se o tipo de ordenacao é do tipo ASC ou DESC
    Dim Clausula As String
    Dim Query As String
    Protected WithEvents Table1 As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents MyDataGrid As System.Web.UI.WebControls.DataGrid
    Protected WithEvents LEGEND1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents Panel1 As System.Web.UI.WebControls.Panel
    Protected WithEvents Table3 As System.Web.UI.HtmlControls.HtmlTable

    Dim SELECT_QUERY_AGENDA As String = "SELECT dbo.Agenda.id, dbo.Agenda.Descricao, CONVERT(CHAR, dbo.Agenda.Data_Inicio, 103) AS Data_Inicio, CONVERT(CHAR, dbo.Agenda.Data_Final, 103) " + _
                                                    "AS Data_Final, CONVERT(char(10), dbo.Agenda.Data_Inicio, 108) AS Hora_Inicio, CONVERT(char(10), dbo.Agenda.Data_Final, 108) AS Hora_Final, " + _
                                                    "dbo.Pacientes.nome AS Paciente, dbo.Funcionarios.nome AS Médico, dbo.Agenda_Status.Descricao AS Status, dbo.Agenda_Tipo.Descricao AS Tipo, dbo.Convenios.Convenio " + _
                                                    "FROM dbo.Agenda INNER JOIN " + _
                                                    "dbo.HomeCare_Atendimento ON dbo.Agenda.id_Atendimento = dbo.HomeCare_Atendimento.id INNER JOIN " + _
                                                    "dbo.HomeCare_Solicitacao_Atendimento ON " + _
                                                    "dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id INNER JOIN " + _
                                                    "dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id INNER JOIN " + _
                                                    "dbo.Funcionarios ON dbo.Agenda.id_Funcionario = dbo.Funcionarios.id INNER JOIN " + _
                                                    "dbo.Agenda_Status ON dbo.Agenda.id_Status = dbo.Agenda_Status.id INNER JOIN " + _
                                                    "dbo.Agenda_Tipo ON dbo.Agenda.id_Tipo = dbo.Agenda_Tipo.id AND dbo.Agenda.id_Tipo = dbo.Agenda_Tipo.id INNER JOIN " + _
                                                    "dbo.Convenios ON dbo.HomeCare_Solicitacao_Atendimento.id_Convenio = dbo.Convenios.id "


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

        Me._MyDataGrid.DataKeyField = "ID"

    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Faz conexao com a DLL onde contem a string de conexao
        Dim ObjConexao As New Funcoes.Conexao
        Dim Conexao As String
        Conexao = ObjConexao.Conexao

        MyConnection = New SqlConnection(Conexao)

        'Define a String de conexão ao MyConnection.
        'Definimos no Page Load para ser usada em toda a página
        MyConnection = New SqlConnection(Conexao)

        If Not Page.IsPostBack Then 'Verifica se a paginajá foi postada, caso já tenha sido entao não fica carregando sempre o DataGrid
            DataGrid_Monta() 'Chama a função que monta o Data Grid
            Panel1.Visible = False
        End If

    End Sub

    Sub DataGrid_Monta()

        Dim DS As DataSet 'Define o Data Set
        Dim MyCommand As SqlDataAdapter 'Define o SqlDataAdapter

        Clausula = " Where "

        If Trim(Request("ID")) <> "" Then
            SELECT_QUERY_AGENDA = SELECT_QUERY_AGENDA & Clausula & " dbo.agenda.ID = '" & Request("ID") & "'  "
            Clausula = "and "
        End If
        If Trim(Request("Data")) <> "" Then
            SELECT_QUERY_AGENDA = SELECT_QUERY_AGENDA & Clausula & " (CONVERT(CHAR, dbo.Agenda.Data_Inicio, 103) = '" & Request("Data") & "')  "
            Clausula = "and "
        End If

        MyCommand = New SqlDataAdapter(SELECT_QUERY_AGENDA, MyConnection) 'Define o SqlDataAdapter para o MyCommand e executa a Query que é uma constante

        DS = New DataSet 'Cria o Data Set

        MyCommand.Fill(DS, "TabelaTemp")  'Preenche o data set. É passado um nome de uma tabela temporaria que o proprio sistema ira usar

        MyDataGrid.DataSource = DS.Tables("TabelaTemp").DefaultView 'É passado um nome de uma tabela temporaria que o proprio sistema ira usar

        If SortField <> "" Then 'Antes de ordenar verifica se foi clicado em alguma opcao de ordenação

            If Session("Ordenacao") = "" Then 'Bloco de if para verificar o tipo de ordenacao a ser feito
                Session("Ordenacao") = "Asc"
            ElseIf Session("Ordenacao") = "Asc" Then
                Session("Ordenacao") = "Desc"
            ElseIf Session("Ordenacao") = "Desc" Then
                Session("Ordenacao") = "Asc"
            End If

            Dim DV As DataView = DS.Tables(0).DefaultView 'Cria um Data View
            DV.Sort = SortField & " " & Session("Ordenacao") 'Faz a ordenação conforme o bloco de IF's
        Else
            Session("Ordenacao") = "Asc" 'Já inicia com esta ordenação
        End If

        MyDataGrid.DataBind()

    End Sub

    'Evento resposavel por fazer a ordenação dos campos setados na propriedade do Data Grid
    Private Sub MyDataGrid_SortCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.DataGridSortCommandEventArgs)

        SortField = e.SortExpression 'Pega o nome do campo a ser ordenado
        viewState("SortField") = SortField
        DataGrid_Monta() 'Gera o data Grid ordenado pelo campo selecionado

    End Sub


    Private Sub MyDataGrid_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyDataGrid.SelectedIndexChanged
        'Response.Write(Me._MyDataGrid.SelectedItem.Cells(0).Text)
        Panel1.Visible = True
    End Sub


End Class
