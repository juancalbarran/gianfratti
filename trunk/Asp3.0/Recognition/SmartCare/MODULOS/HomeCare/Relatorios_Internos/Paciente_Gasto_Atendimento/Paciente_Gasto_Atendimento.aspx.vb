Imports System.Data
Imports System.Data.SqlClient

Public Class Paciente_Gasto_Atendimento
    Inherits System.Web.UI.Page

    'Faz conexao com a DLL onde contem a string de conexao
    Dim ObjConexao As New Funcoes.Conexao

    'Faz conexao com a DLL onde contem funções genericas
    Dim ObjFuncoes As New Funcoes.Funcoes

    Dim MyConnection As SqlConnection 'Define a variavel MyConnection como global

    Dim DS = New DataSet 'Cria o Data Set
    
    Protected WithEvents TxtBoxData_Inicial As System.Web.UI.WebControls.TextBox
    Protected WithEvents TxtBoxData_Final As System.Web.UI.WebControls.TextBox
    Protected WithEvents Table1 As System.Web.UI.HtmlControls.HtmlTable
    Protected WithEvents TxtBoxId_Atendimento As System.Web.UI.WebControls.TextBox
    Protected WithEvents MyDataGrid As System.Web.UI.WebControls.DataGrid
    Protected WithEvents DDL_Tipo As System.Web.UI.WebControls.DropDownList
    Protected WithEvents TextBoxSimpro As System.Web.UI.WebControls.TextBox
    Protected WithEvents LEGEND1 As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button

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
            JavaScriptValida()
        End If

    End Sub

    'Função que monta o DataGrid
    Sub DataGrid_Monta()

        'A Proc Chamada retorna uma consulta em um Layout diferente para ser adaptado a este tipo de relatorio
        Dim MyCommand = New SqlDataAdapter("Exec Relatorio_Gasto_Paciente  '" & TxtBoxId_Atendimento.Text & "' , '" & ObjFuncoes.ArrumaData(TxtBoxData_Inicial.Text) & "' , '" & ObjFuncoes.ArrumaData(TxtBoxData_Final.Text) & "' , '" & DDL_Tipo.SelectedItem.Value & "' , '" & TextBoxSimpro.Text & "'   ", MyConnection) 'Define o SqlDataAdapter para o MyCommand e executa a Query que é uma constante

        MyCommand.Fill(DS, "TabelaTemp")  'Preenche o data set. É passado um nome de uma tabela temporaria que o proprio sistema ira usar

        MyDataGrid.DataSource = DS.Tables("TabelaTemp").DefaultView 'É passado um nome de uma tabela temporaria que o proprio sistema ira usar

        MyDataGrid.DataBind()

    End Sub

    'Variavel usada para nao repetir o nome do paciente
    Private VerificaID As Integer

    Private Sub MyDataGrid_ItemCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles MyDataGrid.ItemCreated
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            If Not Convert.IsDBNull(DataBinder.Eval(e.Item.DataItem, "id_Atendimento")) Then
                'Verifica se a variavel VerificaID é diferente de id_Atendimento
                If VerificaID <> DataBinder.Eval(e.Item.DataItem, "id_Atendimento") Then
                    'Atribui o id_Atendimento a variavel VerificaID
                    VerificaID = DataBinder.Eval(e.Item.DataItem, "id_Atendimento")

                    'Criaremos uma nova Tablecell 
                    Dim Tabela As New TableCell
                    Tabela.BackColor = Color.FromName("#999999")
                    Tabela.Font.Size = FontUnit.XXSmall
                    Tabela.HorizontalAlign = HorizontalAlign.Left

                    'Criaremos um novo Label 
                    Dim Texto As New Label
                    Texto.ForeColor = Color.White
                    Texto.Font.Bold = True
                    Texto.Text = " " & CType(DataBinder.Eval(e.Item.DataItem, "Paciente"), String) & " ( " & DataBinder.Eval(e.Item.DataItem, "id_Atendimento") & " )"

                    'Adicionaremo o label ao TableCell 
                    Tabela.Controls.Add(Texto)
                    Tabela.ColumnSpan = 8

                    'Criaremos um novo DataGridItem e adicionaremos o TableCell 
                    Dim DataGridRow As New DataGridItem(0, 0, ListItemType.Separator)
                    DataGridRow.Cells.Add(Tabela)

                    'Adicionaremos o DataGridItem(Row) ao DataGrid
                    MyDataGrid.Controls(0).Controls.Add(DataGridRow)

                End If
            End If

            'Verificamos se o numero do campo CD_MERCADO e colocamos no template
            'Importante lembrar que estamos usando Convert.IsDBNull() porque na cosulta retorna campos nulos
            If Not Convert.IsDBNull(DataBinder.Eval(e.Item.DataItem, "CD_MERCADO")) Then
                If DataBinder.Eval(e.Item.DataItem, "CD_MERCADO") = "20" Then
                    DirectCast(e.Item.FindControl("Lbl_Tipo"), Label).Text = "Mat. Hospitalar"
                ElseIf DataBinder.Eval(e.Item.DataItem, "CD_MERCADO") = "50" Then
                    DirectCast(e.Item.FindControl("Lbl_Tipo"), Label).Text = "Medicamento"
                ElseIf DataBinder.Eval(e.Item.DataItem, "CD_MERCADO") = "70" Then
                    DirectCast(e.Item.FindControl("Lbl_Tipo"), Label).Text = "Perfumaria"
                End If
            End If

            'Neste IF eu verifico se a o campos CD_MERCADO é nulo, caso seja então eu sei que é a linha de valor total e mudo a cor da linha
            If Convert.IsDBNull(DataBinder.Eval(e.Item.DataItem, "CD_MERCADO")) Then
                e.Item.BackColor = Color.FromName("#F8F0BE")
                e.Item.Font.Bold = True
                e.Item.Font.Italic = True
            End If
        End If
    End Sub

    'Função que faz as chamadas de validação de JavaScript
    Function JavaScriptValida()

        'Chama a função que faz uma mascara para o id_atendimento
        TxtBoxId_Atendimento.Attributes.Add("onKeyPress", "return MascaraCampo(document.Form, 'TxtBoxId_Atendimento', '9999999999', event)")
        'Chama a função que faz a validação de DATA - verifica se a data é valida
        TxtBoxData_Inicial.Attributes.Add("onBlur", "ValidarData(TxtBoxData_Inicial);return false;")
        'Chama a função que faz uma mascara para a data
        TxtBoxData_Inicial.Attributes.Add("onKeyPress", "return MascaraCampo(document.Form, 'TxtBoxData_Inicial', '99/99/9999', event)")
        'Chama a função que faz a validação de DATA - verifica se a data é valida
        TxtBoxData_Final.Attributes.Add("onBlur", "ValidarData(TxtBoxData_Final);return false;")
        'Chama a função que faz uma mascara para a data
        TxtBoxData_Final.Attributes.Add("onKeyPress", "return MascaraCampo(document.Form, 'TxtBoxData_Final', '99/99/9999', event)")
        'Chama a função que faz uma mascara para o id_atendimento
        TextBoxSimpro.Attributes.Add("onKeyPress", "return MascaraCampo(document.Form, 'TextBoxSimpro', '9999999999', event)")

    End Function

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        'Caso a pessoa nao tenha preenchido o campo de data final entao eu seto o data final com a data inicial
        If TxtBoxData_Final.Text = "" Then TxtBoxData_Final.Text = TxtBoxData_Inicial.Text
        DataGrid_Monta()
    End Sub

End Class
