Imports System.Data
Imports System.Data.SqlClient

Public Class Resultados_Exames
    Inherits System.Web.UI.Page

    'Faz conexao com a DLL onde contem a string de conexao
    Dim ObjConexao As New Funcoes.Conexao

    Dim MyConnection As SqlConnection 'Define a variavel MyConnection como global
    Dim DS = New DataSet 'Cria o Data Set
    Dim SortField As String 'Variavel responsavel por pegar o nome do campo que sera feita a ordenacao do data grid
    Protected WithEvents TextBoxImg_Grande As System.Web.UI.HtmlControls.HtmlInputFile
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button
    Protected WithEvents Tbl_Upload As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents Hidden_Id_Exame As System.Web.UI.HtmlControls.HtmlInputHidden
    Dim Ordenacao As String 'Variavel responsavel por saber se o tipo de ordenacao é do tipo ASC ou DESC

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents MyDataGrid As System.Web.UI.WebControls.DataGrid
    Protected WithEvents Lbl_id_Atendimento As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Paciente As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Convenio As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Sexo As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Idade As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Material As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Coleta As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_InfoClinicas As System.Web.UI.WebControls.Label
    Protected WithEvents Dtg_Exames As System.Web.UI.WebControls.DataGrid
    Protected WithEvents Lbl_DtEmissao As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Med_Solicitante As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_CRM As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Coletor As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Coleta_Dt As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Hora As System.Web.UI.WebControls.Label
    Protected WithEvents Btn_Cancelar As System.Web.UI.WebControls.Button
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
        'Define o Campos ID do Data Grid
        MyDataGrid.DataKeyField = "ID"
        Dtg_Exames.DataKeyField = "ID"

        InitializeComponent()

    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim Conexao As String = ObjConexao.Conexao

        'Define a String de conexão ao MyConnection.
        'Definimos no Page Load para ser usada em toda a página
        MyConnection = New SqlConnection(Conexao)

        If Not Page.IsPostBack Then 'Verifica se a paginajá foi postada, caso já tenha sido entao não fica carregando sempre o DataGrid
            Tbl_Editar.Visible = False
            Tbl_Upload.Visible = False
            DataGrid_Monta()
        End If
    End Sub

    Sub DataGrid_Monta()

        Dim Query As String
        Query = "SELECT (SELECT COUNT(id) FROM HomeCare_Atendimento_Pedido_Exames_Itens WHERE Id_Pedido_Exame = HomeCare_Atendimento_Pedido_Exames.Id) AS Total_Exames, dbo.Pacientes.nome AS Paciente,  " & _
                "dbo.Convenios.Convenio, dbo.HomeCare_Atendimento.id AS Id_Atendimento, dbo.Funcionarios.nome AS Medico, " & _
                "dbo.HomeCare_Atendimento_Pedido_Exames.Data_Emissao, dbo.HomeCare_Atendimento_Pedido_Exames.Data_Coleta, " & _
                "dbo.HomeCare_Atendimento_Pedido_Exames.Hora_Coleta,dbo.HomeCare_Atendimento_Pedido_Exames.Coleta,  dbo.HomeCare_Atendimento_Pedido_Exames.id " & _
                "FROM dbo.Pacientes INNER JOIN " & _
                "dbo.HomeCare_Solicitacao_Atendimento ON dbo.Pacientes.id = dbo.HomeCare_Solicitacao_Atendimento.id_Paciente INNER JOIN " & _
                "dbo.Convenios ON dbo.HomeCare_Solicitacao_Atendimento.id_Convenio = dbo.Convenios.id INNER JOIN " & _
                "dbo.HomeCare_Atendimento ON dbo.HomeCare_Solicitacao_Atendimento.id = dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento INNER JOIN " & _
                "dbo.HomeCare_Atendimento_Pedido_Exames ON  " & _
                "dbo.HomeCare_Atendimento.id = dbo.HomeCare_Atendimento_Pedido_Exames.Id_Atendimento LEFT OUTER JOIN " & _
                "dbo.Funcionarios ON dbo.HomeCare_Atendimento_Pedido_Exames.id_Funcionario = dbo.Funcionarios.id "

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

            Dim Lbl_Img As Label = CType(e.Item.FindControl("Lbl_Img"), Label)
            If DataBinder.Eval(e.Item.DataItem, "Coleta") = "Urgência" Then Lbl_Img.Text = "<img src='/SmartCare/images/Flg_vermelho.gif' alt='Urgência' >"
            If DataBinder.Eval(e.Item.DataItem, "Coleta") = "Hoje" Then Lbl_Img.Text = "<img src='/SmartCare/images/Flg_verde.gif' alt='Hoje' >"
            If DataBinder.Eval(e.Item.DataItem, "Coleta") = "Amanhã" Then Lbl_Img.Text = "<img src='/SmartCare/images/Flg_azul.gif' alt='Amanhã' >"
            If DataBinder.Eval(e.Item.DataItem, "Coleta") = "Marcar" Then Lbl_Img.Text = "<img src='/SmartCare/images/Flg_amerelo_escuro.gif' alt='Marcar' >"


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

            Call DataGrid_Exames(id)

            Dim Query As String
            Query = "SELECT dbo.HomeCare_Atendimento_Pedido_Exames.*, dbo.Pacientes.nome AS Paciente, dbo.Pacientes.sexo, dbo.Funcionarios.nome As Medico, " & _
                    "dbo.Funcionarios.CODIGO_MEDICO , dbo.Convenios.Convenio, dbo.Pacientes.data_nascimento " & _
                    "FROM dbo.HomeCare_Atendimento_Pedido_Exames INNER JOIN " & _
                    "dbo.HomeCare_Atendimento ON dbo.HomeCare_Atendimento_Pedido_Exames.Id_Atendimento = dbo.HomeCare_Atendimento.id INNER JOIN " & _
                    "dbo.HomeCare_Solicitacao_Atendimento ON " & _
                    "dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id INNER JOIN " & _
                    "dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id INNER JOIN " & _
                    "dbo.Convenios ON dbo.HomeCare_Solicitacao_Atendimento.id_Convenio = dbo.Convenios.id LEFT OUTER JOIN " & _
                    "dbo.Funcionarios ON dbo.HomeCare_Atendimento_Pedido_Exames.id_Funcionario = dbo.Funcionarios.id " & _
                    "WHERE(dbo.HomeCare_Atendimento_Pedido_Exames.id = " & id & ") "

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
                Lbl_Material.Text = Dr("Material")
                Lbl_Coleta.Text = Dr("Coleta")
                Lbl_DtEmissao.Text = Dr("Data_Emissao")
                Lbl_Coleta_Dt.Text = Dr("Data_Coleta")
                Lbl_Hora.Text = Dr("Hora_Coleta")
                Lbl_InfoClinicas.Text = Dr("indicacoes_clinicas")
                Lbl_CRM.Text = Dr("Codigo_Medico")
                Lbl_Med_Solicitante.Text = Dr("Medico")
                Lbl_Coletor.Text = Dr("Nome_coletor")

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

    Function DataGrid_Exames(ByVal Id_Pedido_Exame)

        Dim DS As DataSet
        Dim MyCommand As SqlDataAdapter

        Dim Query As String
        Query = "SELECT dbo.HomeCare_Atendimento_Pedido_Exames_Itens.* " & _
                "FROM dbo.HomeCare_Atendimento_Pedido_Exames_Itens " & _
                "WHERE id_Pedido_Exame = " & Id_Pedido_Exame & "  "

        MyCommand = New SqlDataAdapter(Query, MyConnection)

        DS = New DataSet

        MyCommand.Fill(DS, "TabelaTemp")

        Dtg_Exames.DataSource = DS.Tables("TabelaTemp").DefaultView

        Dtg_Exames.DataBind()

    End Function

    Private Sub Btn_Cancelar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Btn_Cancelar.Click
        Tbl_DataGrid.Visible = True
        Tbl_Editar.Visible = False
    End Sub


    Private Sub Dtg_Exames_EditCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles Dtg_Exames.EditCommand
        Dim id As Integer = Convert.ToInt32(Me._Dtg_Exames.DataKeys(e.Item.ItemIndex))
        Hidden_Id_Exame.Value = id
        Tbl_Editar.Visible = False
        Tbl_Upload.Visible = True
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click

        Response.Write(Hidden_Id_Exame.Value)

        Dim ImgGrande As New IO.FileInfo(TextBoxImg_Grande.PostedFile.FileName) 'Pegamos as informacoes do arquivo imagem grande que foi postado
        Dim strCaminho As String

        If Not IsNothing(TextBoxImg_Grande.PostedFile) Then 'Verificamos se tem alguma coisa postada 
            strCaminho = Request.ServerVariables("appl_physical_path") & "Temp/" & ImgGrande.Name 'Definimos onde ele será salvo 
            TextBoxImg_Grande.PostedFile.SaveAs(strCaminho) 'Salvamos o mesmo
        End If

        Tbl_Editar.Visible = True
        Tbl_Upload.Visible = False

    End Sub
End Class
