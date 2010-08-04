Imports System.Data
Imports System.Data.SqlClient

Public Class Atestados
    Inherits System.Web.UI.Page

    Dim ObjConexao As New Funcoes.Conexao
    Dim Conexao As String = ObjConexao.Conexao
    Dim MyConnection As SqlConnection

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Txt_id_Atendimento As System.Web.UI.WebControls.TextBox
    Protected WithEvents Btn_Buscar As System.Web.UI.WebControls.Button
    Protected WithEvents Lbl_Paciente As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Idade As System.Web.UI.WebControls.Label
    Protected WithEvents Chk_Masculino As System.Web.UI.WebControls.CheckBox
    Protected WithEvents Chk_Feminino As System.Web.UI.WebControls.CheckBox
    Protected WithEvents Lbl_Convenio As System.Web.UI.WebControls.Label
    Protected WithEvents Txt_Texto As System.Web.UI.WebControls.TextBox
    Protected WithEvents Lbl_DtEmissao As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Medico As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Crm As System.Web.UI.WebControls.Label
    Protected WithEvents Btn_Gravar As System.Web.UI.WebControls.Button
    Protected WithEvents RequiredFieldValidator1 As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents RequiredFieldValidator2 As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents ValidationSummary1 As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents LEGEND1 As System.Web.UI.HtmlControls.HtmlGenericControl

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
        MyConnection = New SqlConnection(Conexao)

        If Not Page.IsPostBack Then
            JavaScriptValida()
        End If
    End Sub

    Private Sub Btn_Buscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Btn_Buscar.Click
        Try
            If Txt_id_Atendimento.Text = "" Then
                Response.Write("<Script>alert('Entre com o número do atendimento')</Script>")
                Response.Write("<script>location = 'JavaScript:history.back()' </script>")
            End If
            Dim Query As String
            Query = "SELECT dbo.Pacientes.nome AS Paciente, dbo.Convenios.Convenio, dbo.Pacientes.sexo, dbo.Pacientes.data_nascimento, " & _
                    "dbo.HomeCare_Atendimento.id AS Id_Atendimento, dbo.Funcionarios.nome AS Medico, dbo.Funcionarios.CODIGO_MEDICO " & _
                    "FROM dbo.Pacientes INNER JOIN " & _
                    "dbo.HomeCare_Solicitacao_Atendimento ON dbo.Pacientes.id = dbo.HomeCare_Solicitacao_Atendimento.id_Paciente INNER JOIN " & _
                    "dbo.Convenios ON dbo.HomeCare_Solicitacao_Atendimento.id_Convenio = dbo.Convenios.id INNER JOIN " & _
                    "dbo.HomeCare_Atendimento ON dbo.HomeCare_Solicitacao_Atendimento.id = dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento INNER JOIN " & _
                    "dbo.HomeCare_Atendimento_Medicos ON dbo.HomeCare_Atendimento.id = dbo.HomeCare_Atendimento_Medicos.id_Atendimento INNER JOIN " & _
                    "dbo.Funcionarios ON dbo.HomeCare_Atendimento_Medicos.id_Funcionario = dbo.Funcionarios.id " & _
                    "WHERE(dbo.HomeCare_Atendimento_Medicos.id_Funcionario_Status = 1) AND (dbo.HomeCare_Atendimento.id = " & Txt_id_Atendimento.Text & "  ) "

            Dim MyCommand As New SqlCommand(Query, MyConnection)
            MyConnection.Open()
            Dim Dr As SqlDataReader = MyCommand.ExecuteReader()
            If Not Dr.HasRows Then Response.Write("<Script>alert('Atendimento não encontrado')</Script>")
            While Dr.Read()
                Dim Data_Nascimento As String = (Date.Now.Year - Year(Dr("Data_Nascimento")))
                Lbl_Convenio.Text = UCase(Dr("Convenio"))
                Lbl_Paciente.Text = UCase(Dr("Paciente"))
                Lbl_Idade.Text = Data_Nascimento
                Lbl_Medico.Text = UCase(Dr("Medico"))
                Lbl_Crm.Text = Dr("Codigo_medico")
                Lbl_DtEmissao.Text = Now
                If Dr("Sexo") = "M" Then
                    Chk_Masculino.Checked = True
                    Chk_Feminino.Checked = False
                Else
                    Chk_Feminino.Checked = True
                    Chk_Masculino.Checked = False
                End If
            End While
            Dr.Close() : MyConnection.Close()
        Catch ex As Exception
            Response.Write(ex.Message) : Response.End()
        End Try
    End Sub

    Private Sub Btn_Gravar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Btn_Gravar.Click
        MyConnection.Open()
        Dim myTrans As SqlTransaction = MyConnection.BeginTransaction()
        Dim MyCommand As New SqlCommand("INSERT INTO HomeCare_Atendimento_Atestado (id_Atendimento,id_Funcionario,texto) VALUES ( @id_Atendimento,@id_Funcionario,@Texto )", MyConnection)
        MyCommand.Transaction = myTrans

        Try

            MyCommand.Parameters.Add(New SqlParameter("@id_Atendimento", SqlDbType.Int)).Value = Txt_id_Atendimento.Text
            MyCommand.Parameters.Add(New SqlParameter("@id_Funcionario", SqlDbType.Int)).Value = Session("id_Funcionario")
            MyCommand.Parameters.Add(New SqlParameter("@Texto", SqlDbType.NText)).Value = Txt_Texto.Text

            MyCommand.ExecuteNonQuery()

            myTrans.Commit()

            MyConnection.Close()

            Response.Write("<Script>alert('Receituário gravado com sucesso.')</Script>")
            Response.Write("<script>location = 'Atestados.aspx' </script>")

        Catch ex As Exception
            myTrans.Rollback()
            Response.Write(ex.Message)
            Response.End()
        End Try
    End Sub

    'Função que faz as chamadas de validação de JavaScript
    Function JavaScriptValida()

        'Inicia os campos desabilitados, pois sera preenchido pelo banco de dados
        Chk_Masculino.Enabled = False : Chk_Feminino.Enabled = False
        'Chama a função que faz uma mascara para o id_atendimento
        Txt_id_Atendimento.Attributes.Add("onKeyPress", "return MascaraCampo(document.Form, 'Txt_id_Atendimento', '9999999999', event)")

    End Function
End Class
