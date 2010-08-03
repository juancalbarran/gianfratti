<% If Session("iUser") = "" Then %>
	<script language="JavaScript">
		window.open('../login/p_login.asp?Erro=3','_top','');
		//alert("Sua sessão expirou!\nVocê será redirecionado para a página de login.\nInforme novamente seu Login e Senha para acessar o sistema.");
	</script>
<% End if %>