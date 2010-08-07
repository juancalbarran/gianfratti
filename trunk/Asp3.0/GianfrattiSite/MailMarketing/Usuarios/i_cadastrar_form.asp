<%
Session("gravado")=0
If opcao=1 then
	opcao=1
	acao=2
Elseif opcao=2 Then
	opcao=2
	acao=3
End if
%>
<script	language='javascript' for='window' event='onLoad'>
	ConfigurarCampos(frm)
	 
	fnMarcaRequeridosOnLoad(frm)
	
	document.frm.Usuario_NM.focus()
</script>
<script	language='javascript' type="text/javascript">
	function ValidaForm(oFrm){
		if (fnMarcaRequeridos(oFrm)){
			if (oFrm.Usuario_Login.value.toString().length >= 5){
				if (oFrm.Usuario_Senha.value.toString().length >= 5){
					if(oFrm.Usuario_Senha.value == oFrm.Confirma_Senha.value){
						return (true)
					}else{
						alert('Senhas não conferem!')
						oFrm.Usuario_Senha.value=''
						oFrm.Confirma_Senha.value=''
						oFrm.Usuario_Senha.focus()
						return (false)
					}
				}else{
					alert('O campo senha é composto por 5 caractes ou mais!')
					oFrm.Usuario_Senha.select()
					return (false)
				}
			}else{
				alert(oFrm.Usuario_Login.value.toString().length)
				alert('O campo login é composto por 5 caractes ou mais!')
				oFrm.Usuario_Login.select()
				return (false)
			} 				
		}else{
			return (false)
		}
	}
</script>
<form  onSubmit="return ValidaForm(this);" name='frm' method='post' action='../Usuarios/p_Usuarios.asp?opcao=<% =opcao %>&acao=<%=acao%>'>
<input type='hidden' name='Usuario_CD' value='<%=Usuario_CD%>'>

<table cellpadding='0' cellspacing='0' width='98%' border='0'>
	<tr>
		<td valign='top' align='center'>
			<!-- TABELA CADASTRO -->
			<fieldset>
			<table align='center' cellpadding='0' cellspacing='2' width='100%' border='0'>
				<tr>
					<td height='20' class='Font10Vermelho' colspan='2'>&nbsp;&nbsp;&nbsp;Campos sinalizados com (*) tem seu preenchimento obrigatório.</td>
				</tr>
				<tr>
					<td align='right' valign='top' width='15%'>Nome do Usuário:</td>
					<td><input type='text' name='Usuario_NM' value="<%=Server.HTMLEncode(Usuario_NM)%>" maxlength='50' class='input' style='width:350px' required='yes' Error='Preencha corretamente o campo "Nome do Usuário"!'></td>
				</tr>
				<tr>
					<td align='right' valign='top' width='15%'>E-mail do Usuário:</td>
					<td><input type='text' name='Usuario_eMail' value="<%if Usuario_eMail <> "" Then Response.Write Server.HTMLEncode(Usuario_eMail)%>" maxlength='50' class='input' style='width:350px' tipo="" required='no' Error='Preencha corretamente o campo "E-mail do Usuário"!'></td>
				</tr>
				<tr>
					<td align='right' valign='top' width='15%'>Login do Usuário:</td>
					<td><input type='text' name='Usuario_Login' value="<%=Server.HTMLEncode(Usuario_Login)%>" maxlength='15' class='input' style='width:150px' required='yes' Error='Preencha corretamente o campo "Login do Usuário"!'></td>
				</tr>

				<tr>
					<td align='right' valign='top' width='15%'>Senha do Usuário:</td>
					<td><input type='password' name='Usuario_Senha' value="" maxlength='15' class='input' style='width:150px' required='yes' Error='Preencha corretamente o campo "Senha do Usuário"!'></td>
				</tr>
				<tr>
					<td align='right' valign='top' width='15%'>Confirmação de senha:</td>
					<td><input type='password' name='Confirma_Senha' value="" maxlength='15' class='input' style='width:150px' required='yes' Error='Preencha corretamente o campo "Confirmação de senha"!'></td>
				</tr>
				<tr>
					<td height='10' colspan='2'>&nbsp;</td>
				</tr>
			</table>
			</fieldset>
			<!-- FIM DA TABELA -->
		</td>
	</tr>
	<tr>
		<td height='10'>&nbsp;</td>
	</tr>	
	<tr>
		<td valign='top' align='right'><input class='buttom' type="submit" value="Gravar Dados"></td>
	</tr>	
</table>
</form>
