Imports System.Data
Imports System.Data.SqlClient

Public Class Pedido_Exame
    Inherits System.Web.UI.Page

    Dim ObjConexao As New Funcoes.Conexao
    Dim Conexao As String = ObjConexao.Conexao
    Dim MyConnection As SqlConnection
    Dim Ds = New DataSet

    Protected WithEvents Lbl_Paciente As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Convenio As System.Web.UI.WebControls.Label
    Protected WithEvents Btn_Buscar As System.Web.UI.WebControls.Button
    Protected WithEvents Lbl_Idade As System.Web.UI.WebControls.Label
    Protected WithEvents Chk_Masculino As System.Web.UI.WebControls.CheckBox
    Protected WithEvents Chk_Feminino As System.Web.UI.WebControls.CheckBox
    Protected WithEvents Txt_id_Atendimento As System.Web.UI.WebControls.TextBox
    Protected WithEvents Lbl_DtEmissao As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Medico As System.Web.UI.WebControls.Label
    Protected WithEvents Lbl_Crm As System.Web.UI.WebControls.Label
    Protected WithEvents Txt_ColetaData As System.Web.UI.WebControls.TextBox
    Protected WithEvents Txt_Material As System.Web.UI.WebControls.TextBox
    Protected WithEvents Txt_Coletor As System.Web.UI.WebControls.TextBox
    Protected WithEvents Txt_Hora As System.Web.UI.WebControls.TextBox
    Protected WithEvents Valida_ID As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents Valida_Material As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents Sumario As System.Web.UI.WebControls.ValidationSummary
    Protected WithEvents Valida_Coletor As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents Valida_Data As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents Valida_Hora As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents TextBox3 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_2 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_3 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_4 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_5 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_6 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_7 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_8 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_9 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_10 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_11 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_12 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_13 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_14 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_15 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_16 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_17 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_18 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_19 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_20 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Exame_1 As System.Web.UI.WebControls.TextBox
    Protected WithEvents Btn_Gravar As System.Web.UI.WebControls.Button
    Protected WithEvents Txt_Info_Clinicas As System.Web.UI.WebControls.TextBox
    Protected WithEvents RBL_Tipo_Coleta As System.Web.UI.WebControls.RadioButtonList
    Protected WithEvents Valida_Coleta As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents Valida_Info_Clinicas As System.Web.UI.WebControls.RequiredFieldValidator
    Protected WithEvents LEGEND1 As System.Web.UI.HtmlControls.HtmlGenericControl

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

        MyConnection = New SqlConnection(Conexao)

        If Not Page.IsPostBack Then
            JavaScriptValida()
        End If

    End Sub

    'Evento que busca os dados referente ao numero do atendimento
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

    'Evento que grava o pedido do exame
    Private Sub Btn_Gravar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Btn_Gravar.Click

        MyConnection.Open()
        Dim myTrans As SqlTransaction = MyConnection.BeginTransaction()
        Dim MyCommand As New SqlCommand("INSERT INTO HomeCare_Atendimento_Pedido_Exames (id_Atendimento,id_Funcionario,Material,Coleta,Indicacoes_Clinicas,Nome_Coletor,Data_Coleta,Hora_Coleta) VALUES ( @id_Atendimento,@id_Funcionario,@Material,@Coleta,@Indicacoes_Clinicas,@Nome_Coletor,@Data_Coleta,@Hora_Coleta )", MyConnection)
        MyCommand.Transaction = myTrans

        Try

            MyCommand.Parameters.Add(New SqlParameter("@id_Atendimento", SqlDbType.Int)).Value = Txt_id_Atendimento.Text
            MyCommand.Parameters.Add(New SqlParameter("@id_Funcionario", SqlDbType.Int)).Value = Session("id_Funcionario")
            MyCommand.Parameters.Add(New SqlParameter("@Material", SqlDbType.NVarChar)).Value = Txt_Material.Text
            MyCommand.Parameters.Add(New SqlParameter("@Coleta", SqlDbType.NVarChar)).Value = RBL_Tipo_Coleta.SelectedValue
            MyCommand.Parameters.Add(New SqlParameter("@Indicacoes_Clinicas", SqlDbType.NVarChar)).Value = Txt_Info_Clinicas.Text
            MyCommand.Parameters.Add(New SqlParameter("@Nome_Coletor", SqlDbType.NVarChar)).Value = Txt_Coletor.Text
            MyCommand.Parameters.Add(New SqlParameter("@Data_Coleta", SqlDbType.DateTime)).Value = Txt_ColetaData.Text
            MyCommand.Parameters.Add(New SqlParameter("@Hora_Coleta", SqlDbType.NVarChar)).Value = Txt_Hora.Text

            MyCommand.ExecuteNonQuery()
            Dim id_Transacao As New SqlCommand("SELECT @@IDENTITY", MyConnection)
            myTrans.Commit()

            Call GravaExames(CInt(id_Transacao.ExecuteScalar())) 'Chama a função que ira gravar os exames solicitados

            MyConnection.Close()

            Response.Write("<Script>alert('Pedido de exame gravado com sucesso.')</Script>")
            Response.Write("<script>location = 'Pedido_Exame.aspx' </script>")

        Catch ex As Exception
            myTrans.Rollback()
            Response.Write(ex.Message)
            Response.End()
        End Try

    End Sub

    'Funções responsavel por gravar todos os exames solicitados
    Function GravaExames(ByVal id)

        Dim ctl As Control
        For Each ctl In Page.Controls(1).Controls 'Faz um laço em todos os controles TextBox
            If TypeOf ctl Is TextBox Then 'Verifica se o controle é do tipo TextBox
                If InStr(1, Trim(CType(ctl, TextBox).ID), "Exame", 1) Then 'Pegamos os nome do controle e verificamos com o InStr se o nome do controle tem a palavra Exame
                    If Trim(CType(ctl, TextBox).Text) <> "" Then 'Verifica se o campos não esta vazio para fazer os inserts
                        Dim MyCommand As New SqlCommand("INSERT INTO HomeCare_Atendimento_Pedido_Exames_Itens (Id_Pedido_Exame,Exame) VALUES ( @Id_Pedido_Exame,@Exame )", MyConnection)
                        Try
                            MyCommand.Parameters.Add(New SqlParameter("@Id_Pedido_Exame", SqlDbType.Int)).Value = id
                            MyCommand.Parameters.Add(New SqlParameter("@Exame", SqlDbType.NVarChar)).Value = CType(ctl, TextBox).Text
                            MyCommand.ExecuteNonQuery()
                        Catch ex As Exception
                            Response.Write(ex.Message)
                        End Try
                    End If
                End If
            End If
        Next

    End Function

    'Função que faz as chamadas de validação de JavaScript
    Function JavaScriptValida()

        'Inicia os campos desabilitados, pois sera preenchido pelo banco de dados
        Chk_Masculino.Enabled = False : Chk_Feminino.Enabled = False
        'Chama a função que faz uma mascara para o id_atendimento
        Txt_id_Atendimento.Attributes.Add("onKeyPress", "return MascaraCampo(document.Form, 'Txt_id_Atendimento', '9999999999', event)")
        'Chama a função que faz uma mascara para a data
        Txt_ColetaData.Attributes.Add("onKeyPress", "return MascaraCampo(document.Form, 'Txt_ColetaData', '99/99/9999', event)")
        'Chama a função que faz uma mascara para Hora
        Txt_Hora.Attributes.Add("onKeyPress", "return MascaraCampo(document.Form, 'Txt_Hora', '99:99', event)")
        'Chama a função que faz a validação de DATA - verifica se a data é valida
        Txt_ColetaData.Attributes.Add("onBlur", "ValidarData(Txt_ColetaData);return false;")
        'Chama a função que faz a validação de HORA - verifica se a hora é valida
        Txt_Hora.Attributes.Add("onBlur", "ValidarHoraExpReg(document.Form.Txt_Hora.value, '2');return false;")

    End Function

    Private Sub Exames_1_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Response.Write(Exames_1.Attributes.Item("Manes").ToString())
    End Sub

End Class
