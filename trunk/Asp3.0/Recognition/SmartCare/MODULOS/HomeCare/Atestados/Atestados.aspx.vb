Imports System.Data
Imports System.Data.SqlClient

Public Class Atestados1
    Inherits System.Web.UI.Page

    Dim ObjConexao As New Funcoes.Conexao
    Dim MyConnection As SqlConnection 'Define a variavel MyConnection como global
    Dim DS = New DataSet 'Cria o Data Set
    Dim SortField As String 'Variavel responsavel por pegar o nome do campo que sera feita a ordenacao do data grid

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents MyDataGrid As System.Web.UI.WebControls.DataGrid
    Protected WithEvents Lbl_id_Atendimento As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Paciente As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Idade As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Sexo As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Convenio As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Texto As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Cadastro As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Medico As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Crm As System.Web.UI.WebControls.Label
    Protected WithEvents Btn_Voltar As System.Web.UI.WebControls.Button
    Protected WithEvents LEGEND1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents Tbl_DataGrid As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents TABLE1 As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents TD1 As System.Web.UI.HtmlControls.HtmlTableCell
    Protected WithEvents FONT1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents Tbl_Editar As System.Web.UI.HtmlControls.HtmlTable

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
        'Define o Campos ID do Data Grid
        Me._MyDataGrid.DataKeyField = "ID"

    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim Conexao As String = ObjConexao.Conexao
        MyConnection = New SqlConnection(Conexao)

        If Not Page.IsPostBack Then 'Verifica se a paginajá foi postada, caso já tenha sido entao não fica carregando sempre o DataGrid
            Tbl_Editar.Visible = False
            DataGrid_Monta()
        End If
    End Sub

    Sub DataGrid_Monta()

        Dim Query As String
        Query = "SELECT HomeCare_Atendimento_Atestado.id, HomeCare_Atendimento_Atestado.id_Atendimento, HomeCare_Atendimento_Atestado.Data_Cadastro, " & _
                "Funcionarios.nome AS medico, Pacientes.nome AS Paciente, Convenios.Convenio " & _
                "FROM  HomeCare_Atendimento_Atestado INNER JOIN " & _
                "Funcionarios ON HomeCare_Atendimento_Atestado.id_Funcionario = Funcionarios.id INNER JOIN " & _
                "HomeCare_Atendimento ON HomeCare_Atendimento_Atestado.id_Atendimento = HomeCare_Atendimento.id INNER JOIN " & _
                "HomeCare_Solicitacao_Atendimento ON HomeCare_Atendimento.id_Solicitacao_Atendimento = HomeCare_Solicitacao_Atendimento.id INNER JOIN " & _
                "Pacientes ON HomeCare_Solicitacao_Atendimento.id_Paciente = Pacientes.id INNER JOIN " & _
                "Convenios ON HomeCare_Solicitacao_Atendimento.id_Convenio = Convenios.id "

        Dim MyCommand = New SqlDataAdapter(Query, MyConnection)  'Define o SqlDataAdapter para o MyCommand e executa a Query que é uma constante

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

    End Sub

    'Evento resposavel por fazer a ordenação dos campos setados na propriedade do Data Grid
    Private Sub MyDataGrid_SortCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridSortCommandEventArgs) Handles MyDataGrid.SortCommand
        SortField = e.SortExpression 'Pega o nome do campo a ser ordenado
        viewState("SortField") = SortField
        DataGrid_Monta() 'Gera o data Grid ordenado pelo campo selecionado
    End Sub

    Private Sub MyDataGrid_EditCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles MyDataGrid.EditCommand

        Try
            'Busca o compo id da tabela que foi iniciado no evento Page_Init
            Dim id As Integer = Convert.ToInt32(Me._MyDataGrid.DataKeys(e.Item.ItemIndex))

            Tbl_DataGrid.Visible = False
            Tbl_Editar.Visible = True

            Dim Query As String

            Query = "SELECT HomeCare_Atendimento_Atestado.id, HomeCare_Atendimento_Atestado.id_Atendimento, HomeCare_Atendimento_Atestado.Texto, " & _
                    "HomeCare_Atendimento_Atestado.Data_Cadastro, Funcionarios.nome AS Medico, Pacientes.nome AS Paciente, Pacientes.data_nascimento, " & _
                    "Pacientes.sexo, Funcionarios.CODIGO_MEDICO, Convenios.Convenio " & _
                    "FROM HomeCare_Atendimento_Atestado INNER JOIN " & _
                    "HomeCare_Atendimento ON HomeCare_Atendimento_Atestado.id_Atendimento = HomeCare_Atendimento.id INNER JOIN " & _
                    "HomeCare_Solicitacao_Atendimento ON HomeCare_Atendimento.id_Solicitacao_Atendimento = HomeCare_Solicitacao_Atendimento.id INNER JOIN " & _
                    "Pacientes ON HomeCare_Solicitacao_Atendimento.id_Paciente = Pacientes.id INNER JOIN " & _
                    "Convenios ON HomeCare_Solicitacao_Atendimento.id_Convenio = Convenios.id INNER JOIN " & _
                    "Funcionarios ON HomeCare_Atendimento_Atestado.id_Funcionario = Funcionarios.id " & _
                    "WHERE(HomeCare_Atendimento_Atestado.id = " & id & " ) "

            Dim MyCommand As New SqlCommand(Query, MyConnection)
            MyConnection.Open()
            Dim Dr As SqlDataReader = MyCommand.ExecuteReader()
            If Not Dr.HasRows Then Response.Write("<Script>alert('Atendimento não encontrado')</Script>")
            While Dr.Read()
                Dim Data_Nascimento As String = (Date.Now.Year - Year(Dr("Data_Nascimento")))
                Lbl_id_Atendimento.Text = Dr("id_Atendimento")
                Lbl_Paciente.Text = Dr("Paciente")
                Lbl_Convenio.Text = Dr("Convenio")
                Lbl_Idade.Text = Data_Nascimento
                Lbl_Cadastro.Text = Dr("Data_Cadastro")
                Lbl_Crm.Text = Dr("Codigo_Medico")
                Lbl_Texto.Text = Dr("Texto")
                Lbl_Medico.Text = Dr("Medico")

                If Dr("Sexo") = "M" Then
                    Lbl_Sexo.Text = "Masculino"
                Else
                    Lbl_Sexo.Text = "Feminino"
                End If
            End While
            Dr.Close() : MyConnection.Close()
        Catch ex As Exception
            Response.Write(ex.Message) : Response.End()
        End Try

    End Sub

    Private Sub Btn_Voltar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Btn_Voltar.Click
        Response.Redirect("Atestados.aspx")
    End Sub

End Class
