Public Class WebForm1
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents DataGrid2 As System.Web.UI.WebControls.DataGrid

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
        If Not Page.IsPostBack Then
            Dim ds As New DataSet
            ds.ReadXml(Server.MapPath("data.xml"), XmlReadMode.InferSchema)
            DataGrid2.DataSource = ds
            DataGrid2.DataBind()
        End If
    End Sub

    Private Sub DataGrid2_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles DataGrid2.ItemCommand
        If e.CommandName = "Expand" Then
            'troca a imagem de "+" pra "-" no imagebutton
            Dim imbExpand As ImageButton = e.Item.FindControl("imbExpand")
            imbExpand.ImageUrl = "minus.gif"
            imbExpand.CommandName = "Collapse"

            'mostra o painel com o campo "summary" do livro
            Dim pnlSummary As Panel = e.Item.FindControl("pnlSummary")
            pnlSummary.Visible = True
        ElseIf e.CommandName = "Collapse" Then
            'troca a imagem de "-" pra "+" no imagebutton
            Dim imbExpand As ImageButton = e.Item.FindControl("imbExpand")
            imbExpand.ImageUrl = "plus.gif"
            imbExpand.CommandName = "Expand"

            'esconde o painel com o campo "summary" do livro
            Dim pnlSummary As Panel = e.Item.FindControl("pnlSummary")
            pnlSummary.Visible = False
        End If
    End Sub
End Class
