<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Default.aspx.vb" Inherits="SmartCare._Default"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Default</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script language="javascript">
			function MostraErro()
				{
				history.go(-1);
				alert('<%=Erro%>');
				}
		</script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			Digite o código mostrado na imagem abaixo e clique em enviar.<br>
			<asp:TextBox id="txtCodigoSeg" style="TEXT-TRANSFORM: uppercase" runat="server" Width="55px"
				MaxLength="5"></asp:TextBox>
			<asp:Button id="Btn_Verificar" runat="server" Text="Ok"></asp:Button><br>
			<img src="imgseguranca.aspx" id="img_seguranca"><br>
			<a href="Default.aspx">Caso tenha dificuldades em ler a imagem, clique aqui</a>.
			<%If Erro<>"" Then%>
			<script>MostraErro();</script>
			<%End If%>
		</form>
	</body>
</HTML>
