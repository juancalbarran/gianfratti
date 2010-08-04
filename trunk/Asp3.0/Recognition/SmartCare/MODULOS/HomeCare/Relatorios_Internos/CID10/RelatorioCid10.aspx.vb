Imports System.Data
Imports System.Data.SqlClient


Public Class RelatorioCid10
    Inherits System.Web.UI.Page

    'Declaração de Variaveis Globais

    'Faz conexao com a DLL onde contem a string de conexao
    Dim ObjConexao As New Funcoes.Conexao

    Dim MyConnection As SqlConnection 'Define a variavel MyConnection como global
    Dim DS = New DataSet 'Cria o Data Set
    Dim SortField As String 'Variavel responsavel por pegar o nome do campo que sera feita a ordenacao do data grid
    Dim Ordenacao As String 'Variavel responsavel por saber se o tipo de ordenacao é do tipo ASC ou DESC
    Dim Clausula As String

    Protected WithEvents LEGEND1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents DDL_Convenio As System.Web.UI.WebControls.DropDownList
    Protected WithEvents TxtBoxData_Final As System.Web.UI.WebControls.TextBox
    Protected WithEvents TxtBoxData_Inicial As System.Web.UI.WebControls.TextBox
    Protected WithEvents TxtBoxCid10 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Table1 As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents MyDataGrid As System.Web.UI.WebControls.DataGrid
    Protected WithEvents TxtBoxIdade_Inicial As System.Web.UI.WebControls.TextBox
    Protected WithEvents TxtBoxIdade_Final As System.Web.UI.WebControls.TextBox
    Protected WithEvents DDL_Sexo As System.Web.UI.WebControls.DropDownList
    Protected WithEvents DDL_Cobertura As System.Web.UI.WebControls.DropDownList
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button
    Protected WithEvents DDL_Funcionario As System.Web.UI.WebControls.DropDownList
    Protected WithEvents Txtbox_UF As System.Web.UI.WebControls.TextBox
    Protected WithEvents Button2 As System.Web.UI.WebControls.Button
    Protected WithEvents ValidationSummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents CompareValidator1 As System.Web.UI.WebControls.CompareValidator
    Protected WithEvents CompareValidator2 As System.Web.UI.WebControls.CompareValidator
    Protected WithEvents CompareValidator3 As System.Web.UI.WebControls.CompareValidator
    Protected WithEvents TxtBoxCid10_2 As System.Web.UI.WebControls.TextBox
    Dim Query As String

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

        Dim Conexao As String = ObjConexao.Conexao

        'Define a String de conexão ao MyConnection.
        'Definimos no Page Load para ser usada em toda a página
        MyConnection = New SqlConnection(Conexao)

        If Not Page.IsPostBack Then 'Verifica se a paginajá foi postada, caso já tenha sido entao não fica carregando sempre o DataGrid
            JavaScriptValida() 'Chama função que valida os campos
            PreencheConvenios()
            PreencheCobertura()
            PreencheFuncionario()
        End If
    End Sub


    Sub DataGrid_Monta()

        Dim MyCommand = New SqlDataAdapter("EXEC Relatorio_CID10 '" & TxtBoxCid10.Text & "' , '" & TxtBoxCid10_2.Text & "' , '" & TxtBoxData_Inicial.Text & "' , '" & TxtBoxData_Final.Text & "' , '" & DDL_Convenio.SelectedItem.Value & "' , '" & DDL_Sexo.SelectedItem.Value & "' , '" & TxtBoxIdade_Inicial.Text & "' , '" & TxtBoxIdade_Final.Text & "' , '" & DDL_Cobertura.SelectedItem.Value & "' , '" & DDL_Funcionario.SelectedItem.Value & "' , '" & Txtbox_UF.Text & "' ", MyConnection) 'Define o SqlDataAdapter para o MyCommand e executa a Query que é uma constante

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

    Private Sub MyDataGrid_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles MyDataGrid.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            'Cria um atributo no DataGrid fazendo com que as chame uma função JavaScript que ira criar um efeito quando passar o mouse em cima das linhas do DataGrid
            e.Item.Attributes.Add("onMouseOver", "CoresGrid(this)") 'Chama a função JavaScript que esta no html
            e.Item.Attributes.Add("onMouseOut", "deCoresGrid(this)") 'Chama a função JavaScript que esta no html
        End If

        If e.Item.ItemType = ListItemType.Footer Then
            DirectCast(e.Item.FindControl("Lbl_Total_Registros"), Label).Text = "Reg. encontrado(s): " & DS.Tables(0).Rows.Count()
        End If
    End Sub

    'Evento resposavel por fazer a ordenação dos campos setados na propriedade do Data Grid
    Private Sub MyDataGrid_SortCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.DataGridSortCommandEventArgs)
        SortField = e.SortExpression 'Pega o nome do campo a ser ordenado
        viewState("SortField") = SortField
        DataGrid_Monta() 'Gera o data Grid ordenado pelo campo selecionado
    End Sub

    'preenchendo o dropdownlist
    Sub PreencheConvenios()
        Dim MyCommand As SqlCommand
        MyCommand = New SqlCommand("Select * From Convenios Order by Convenio", MyConnection)
        MyConnection.Open()
        DDL_Convenio.DataSource = MyCommand.ExecuteReader()
        DDL_Convenio.DataValueField = "ID"
        DDL_Convenio.DataTextField = "Convenio"
        DDL_Convenio.DataBind()
        DDL_Convenio.Items.Insert(0, New ListItem("Selecione", String.Empty))
        MyConnection.Close()
    End Sub

    'preenchendo o dropdownlist
    Sub PreencheCobertura()
        Dim MyCommand As SqlCommand
        MyCommand = New SqlCommand("Select * From Cobertura Order by Nome", MyConnection)
        MyConnection.Open()
        DDL_Cobertura.DataSource = MyCommand.ExecuteReader()
        DDL_Cobertura.DataValueField = "ID"
        DDL_Cobertura.DataTextField = "Nome"
        DDL_Cobertura.DataBind()
        DDL_Cobertura.Items.Insert(0, New ListItem("Selecione", String.Empty))
        MyConnection.Close()
    End Sub



    'preenchendo o dropdownlist
    Sub PreencheFuncionario()
        Dim MyCommand As SqlCommand
        MyCommand = New SqlCommand("Select id,Left(Nome,20) + ' ...' As Nome From Funcionarios Where id_Departamento = 5 Order By Nome", MyConnection)
        MyConnection.Open()
        DDL_Funcionario.DataSource = MyCommand.ExecuteReader()
        DDL_Funcionario.DataValueField = "ID"
        DDL_Funcionario.DataTextField = "Nome"
        DDL_Funcionario.DataBind()
        DDL_Funcionario.Items.Insert(0, New ListItem("Selecione", String.Empty))
        MyConnection.Close()
    End Sub
    'Evento da paginação
    Private Sub MyDataGrid_PageIndexChanged(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs)
        MyDataGrid.CurrentPageIndex = e.NewPageIndex
        DataGrid_Monta()
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        DataGrid_Monta()
        MyDataGrid.Visible = True
    End Sub

    'Função para limpar todos os campos de uma unica vez
    Public Sub Limpar(ByVal controlP As Control)
        Dim ctl As Control
        For Each ctl In controlP.Controls
            If TypeOf ctl Is TextBox Then
                DirectCast(ctl, TextBox).Text = String.Empty
            ElseIf TypeOf ctl Is DropDownList Then
                DirectCast(ctl, DropDownList).SelectedItem.Value = String.Empty
            ElseIf ctl.Controls.Count > 0 Then
                Limpar(ctl)
            End If
        Next
    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        'Chama a função que ira limpar todos os controles
        Call Me.Limpar(Me)
    End Sub

    'Função que faz as chamadas de validação de JavaScript
    Function JavaScriptValida()
        'Chama a função que faz uma mascara para a data
        TxtBoxData_Inicial.Attributes.Add("onKeyPress", "return MascaraCampo(document.Form, 'TxtBoxData_Inicial', '99/99/9999', event)")

        'Chama a função que faz uma mascara para a data
        TxtBoxData_Final.Attributes.Add("onKeyPress", "return MascaraCampo(document.Form, 'TxtBoxData_Final', '99/99/9999', event)")

        'Chama a função que faz a mascara para idade
        TxtBoxIdade_Inicial.Attributes.Add("onKeyPress", "return MascaraCampo(document.Form, 'TxtBoxIdade_Inicial', '999', event)")

        'Chama a função que faz a mascara para idade
        TxtBoxIdade_Final.Attributes.Add("onKeyPress", "return MascaraCampo(document.Form, 'TxtBoxIdade_Final', '999', event)")
    End Function


End Class
