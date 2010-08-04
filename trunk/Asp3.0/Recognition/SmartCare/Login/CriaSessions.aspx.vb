Imports System.Data
Public Class CriaSessions
    Inherits System.Web.UI.Page

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

        Session("Logado") = True 'SETA A SESSION PARA TRUE
        Session("Login") = Request.QueryString("Login") 'GUARDA O LOGIN DO FUNCIONARIO
        Session("Email") = Request.QueryString("Email") 'GUARDA O EMAIL DO FUNCIONARIO
        Session("Funcionario_Nome") = Request.QueryString("Funcionario_Nome") 'GUARDA O NOME DO FUNCIONARIO
        Session("Funcionario_Email") = Request.QueryString("Funcionario_Email") 'GUARDA O ID DO CARGO PARA FUTURAS APLICAÇÕES USAR
        Session("Departamento_Nome") = Request.QueryString("Departamento_Nome") 'GUARDA O NOME DO DEPARTAMENTO 
        Session("Cargo") = Request.QueryString("Cargo") 'GUARDA O NOME DO CARGO
        Session("id_Funcionario") = Request.QueryString("id_Funcionario") 'GUARDA O ID DO FUNCIONARIO PARA FUTURAS APLICAÇÕES USAR
        Session("id_Usuario") = Request.QueryString("id_Usuario") 'GUARDA O ID DO USUARIO LOGADO NO SISTEMA PARA ABRIR O MENU CONFORME AS SUAS PERMISSÕES DE ACESSO
        Session("id_Cargo") = Request.QueryString("id_Cargo") 'GUARDA O ID DO CARGO PARA FUTURAS APLICAÇÕES USAR
        Session("id_Convenio") = Request.QueryString("id_Convenio") 'GUARDA O ID DO CONVENIO QUE SERA USADO
        Session("Convenio_Nome") = Request.QueryString("Convenio_Nome") 'GUARDA O NOME DO CONVENIO QUE SERA USADO
        Session("Tipo_Login") = Request.QueryString("Tipo_Login") 'VERIFICA SE O	USUARIO LOGADO É FUNCIONARIO OU CONTATO DE UM CONVENIO

    End Sub

End Class
