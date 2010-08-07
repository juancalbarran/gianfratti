<?php 

if(@$_POST['send'] == "true"){ // Se o form nao for preenchido ele nao ira enviar o email>>>
	
	$destinatario = "info@stiper.com.br"; // Aqui voce coloca o E-MAIL para onde sera enviado o EMAIL>>>>>>>>>
	$remetente = $_POST['email'];
	$assunto = "Contato via Formulario ";		// Aqui voce coloca o ASSUNTO do email>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	
    $nome = $_POST['nome']; 
    $empresa  = $_POST['empresa']; 
    $endereco = $_POST['endereco']; 
    $cidade = $_POST['cidade']; 
    $estado  = $_POST['estado'];
    $cep = $_POST['cep']; 
    $telefone = $_POST['telefone']; 
    $email  = $_POST['email']; 
    $quantidade = $_POST['quantidade'];
    $mensagem = $_POST['mensagem']; 
	
    $mensagem = htmlspecialchars($mensagem); // Isso aqui é pra Desabilitar Tag's HTML (Muito Util)
	
	$IP = $_POST['IP']; 
    $headers  = "\nContent-type: text/html\n";
    
	$fonte = "<font size=\"-1\" face=\"Verdana, Arial, Helvetica, sans-serif\">";
	
	$msg  = "$fonte Você recebeu 1 email vindo de: $email <br>";
	$msg .= "<br>Ip do Remetente: $IP <br>";
	$msg .= "<br> Nome:$nome <br>";
	$msg .= "Empresa: $empresa <br>";
	$msg .= "Endereço: $endereco <br>";
	$msg .= "Cidade: $cidade <br>";
	$msg .= "Estado: $estado <br>";
        $msg .= "CEP: $cep <br>";
	$msg .= "Telefone: $telefone <br>";
	$msg .= "E-mail: $email <p />";
        $msg .= "Quantidade: $qte <br>";
	$msg .= "Mensagem: $mensagem <br>";
	
    //$envia = mail("$destinatario" , "from: ".$remetente , "$assunto" , "$headers" , "$msg" );
	$envia = mail("$destinatario", "$assunto", "$msg", "from: $remetente".$headers ); 
     
    if($envia){ 

		header("Location: formtest.php?status=enviado");
		
        	}
			else
				{ header("Location: formtest.php?status=erro"); }
			 
         
    }else{ 
?> 
<html>
<head>
<title>Formulario</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
BODY {
scrollbar-face-color:#5989D2;
scrollbar-highlight-color:#eeeeee;
scrollbar-3dlight-color:#C0C0C0;
scrollbar-darkshadow-color:#627177;
scrollbar-shadow-color:#FFFFFF;
scrollbar-arrow-color:#ffffff;
scrollbar-track-color:#eeeeee;
margin-left: 0px;
margin-top: 0px;
margin-right: 0px;
margin-bottom: 0px;
}
..bg {
	background-color: #FFFFFF;
	background-image: url(../img/bg.jpg);
	background-repeat: repeat-x;
}
..distancia_1 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	padding-top: 0px;
	padding-right: 0px;
	padding-bottom: 0px;
	padding-left: 10px;
	text-align: justify;
}
..box_recomende {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	height: 20px;
	border: 1px solid #999999;
}
..recomende_bt {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	background-color: #FFFFFF;
	height: 22px;
	border: 1px solid #999999;
}
A.link1 {
	FONT-SIZE: 12px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: none
}
A.link1:hover {
	FONT-SIZE: 12px; COLOR: #333333; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; TEXT-DECORATION: underline
}
A.link1:visited {
	FONT-SIZE: 12px; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif
}
..borda {
	border: 1px solid #999999;
}
..minifoto {
	border: 1px solid #666666;
}

</style>

<script>
	function Valida(){
		
		if(form1.nome.value == ""){
			alert("Informe seu nome por gentileza.");
			form1.nome.focus();return false;
			}

		if(form1.cidade.value == ""){
			alert("Informe o nome de sua cidade por gentileza.");
			form1.cidade.focus();return false;
			}

		if(form1.telefone.value == ""){
			alert("Informe seu telefone por gentileza.");
			form1.telefone.focus();return false;
			}

		if(form1.email.value == ""){
			alert("Informe seu e-mail por gentileza.");
			form1.email.focus();return false;
			}

		if(form1.mensagem.value == ""){
			alert("Campo mensagem não pode estar em branco!");
			form1.mensagem.focus();return false;
			}

		if(form1.quantidade.value == ""){
			alert("Informe a quantidade desejada !");
			form1.mensagem.focus();return false;
			}

}
</script>
</head>

<body onLoad="javascript:form1.nome.focus();">
<table width="547" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td>
<table border="0" cellpadding="0" cellspacing="0" width="547">
        <tr> 
          <td colspan="5" align="center" valign="middle"> <form name="form1" method="post" action="formtest.php" onSubmit="return Valida();">
            <table width=547 border=0 align="center" cellpadding=0 cellspacing=5>
                <tbody>
                  <tr align="center"> 
                    <td colspan="2" class=fonte><font face="Verdana" size="1"><br><strong>Faça seu pedido !<br>
                      <br></font></td>
                  </tr>
                  <tr> 
                    <td colspan="2" class=fonte><div align="center">
					<font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#FF0000">
					<?php
					if(@$_GET['status'] == "enviado"){
						echo "E-mail enviado com sucesso!";
						}else
						if(@$_GET['status'] == "erro"){
							echo "Desculpe-nos, tente novamente!";
							}					
					?>
					</font></div></td>
                  </tr>
                  <tr> 
                    <td width=127 align="right" class=fonte><font color=#000000 size="1" face="Verdana, Arial, Helvetica, sans-serif">Nome:</font></td>
                    <td class=fonte width=405><font color=#000000 size="1" face="Verdana, Arial, Helvetica, sans-serif"> 
                      <input name="nome" 
                  class="box1" id="nome" size=60 maxlength="50">
                      </font></td>
                  </tr>
                  <tr> 
                    <td width=127 align="right" class=fonte>
					<font color=#000000 size="1" face="Verdana, Arial, Helvetica, sans-serif">Empresa:</font></td>
                    <td class=fonte width=405><font color=#000000 size="1" face="Verdana, Arial, Helvetica, sans-serif"> 
                      <input name="empresa"
                  class="box1" id="txtEmpresa2" size=60 maxlength="50">
                      </font></td>
                  </tr>
                  <tr> 
                    <td width=127 align="right" class=fonte><font 
                color=#000000 size="1" face="Verdana, Arial, Helvetica, sans-serif">Endereço:</font></td>
                    <td class=fonte width=405><font color=#000000 size="1" face="Verdana, Arial, Helvetica, sans-serif"> 
                      <input name="endereco"
                  class="box1" id="empresa" size=60 maxlength="50">
                      </font></td>
                  </tr>
                  <tr> 
                    <td width=127 align="right" class=fonte><font color=#000000 size="1" face="Verdana, Arial, Helvetica, sans-serif">Cidade:</font></td>
                    <td class=fonte width=405><font color=#000000 size="1" face="Verdana, Arial, Helvetica, sans-serif"> 
                      <input name="cidade" 
                  class="box1" id="txtCidade2" size=39 maxlength="30">
                      &nbsp;Estado:<img src="../imagens/spacer.gif" width="1" height="1"></font> 
                      <font color=#000000 size="1" face="Verdana, Arial, Helvetica, sans-serif"> 
                      <input 
                  name="estado" class="box1" id="txtUF2" size=4 maxlength="2">
                      </font></td>
                  </tr>
                  <tr> 
                    <td width=127 align="right" class=fonte><font 
                  color=#000000 size="1" face="Verdana, Arial, Helvetica, sans-serif">Telefone:<br>
                      </font></td>
                    <td class=fonte width=405><font color=#000000 size="1" face="Verdana, Arial, Helvetica, sans-serif"> 
                      <input name="telefone"
                  class="box1" id="txtTelefone2" size="20" maxlength="20">
                      &nbsp;&nbsp; E-mail:&nbsp; 
                      <input name="email" class="box1" id="txtEmail2" size=27 maxlength="50">
                      </font></td>
                  </tr>

                  <tr> 
                    <td width=127 align="right" class=fonte><font 
                  color=#000000 size="1" face="Verdana, Arial, Helvetica, sans-serif">Quantidade:<br>
                      </font></td>
                    <td class=fonte width=405><font color=#000000 size="1" face="Verdana, Arial, Helvetica, sans-serif"> 
                      <input name="quantidade"
                  class="box1" id="txtQuantidade" size="20" maxlength="20">
                      &nbsp;&nbsp; CEP:&nbsp; 
                      <input name="cep" class="box1" id="txtCep" size=27 maxlength="50">
                      </font></td>
                  </tr>

                  <tr> 
                    <td align="right" valign="top" class=fonte><font 
                color=#000000 size="1" face="Verdana, Arial, Helvetica, sans-serif">Mensagem:</font></td>
                    <td class=fonte><font color=#000000 size="1" face="Verdana, Arial, Helvetica, sans-serif"> 
                      <textarea name="mensagem" cols="60" rows="10" class="box2" id="empresa2"></textarea> 
                      </font></td>
                  </tr>
                  <tr> 
                    <td class=fonte colspan=2 height=7><table width="290" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="196" align="right"> <input name="enviar" type="submit" class="bt" id="enviar" value="Enviar"> 
                          </td>
                          <td width="12">&nbsp;</td>
                          <td width="133"><input name="limpar" type="reset" class="bt" id="limpar" value="Limpar">
                            <font color=#000000 size="1" face="Verdana, Arial, Helvetica, sans-serif">
                            <input type="hidden" name="send" value="true">
                            <input type="hidden" name="IP" value="<?php echo $_SERVER['REMOTE_ADDR']; ?>">
						  </font></td>
                        </tr>
                      </table>
                      </td>
                  </tr>
                  <tr> 
                    <td class=fonte colspan=2><img height=1 alt="" 
                  src="../imagens/t.gif" 
                  width=1 border=0> </td>
                  </tr>
                </tbody>
              </table>
			</form></td>
        </tr>
      </table>
	</td>
  </tr>
</table>
</body>
</html><?php } // Termina o Script // ?>