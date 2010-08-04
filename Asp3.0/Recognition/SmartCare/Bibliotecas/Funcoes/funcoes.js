<script language="JavaScript">
//************************************************************
//FUNÇÃO RESPONSAVEL POR PERGUNTAR SE DESEJA MESMO EXECUTAR DETERMINADA ACAO ANTES DE EXECUTA-LA
//PARA USAR COMO UM LINK BASTA USAR O SEGUINTE EXEMPLO ABAIXO:
//"<a href=""javascript:Confirmar(" & rs("id_Categoria") & " , '" & rs("Categoria_Nome") & "' , 'ATENÇÂO !!\nDeseja mesmo excluir a categoria:' , 'default.asp?action=ExcluirCategorias&id_Categoria="&rs("id_categoria")&"' )"" >Excluir</a>"
//************************************************************
function Confirmar(IdValor,NomeRegistro,Mensagem,url)
	{
	if (confirm("Registo(ID) Nº " + IdValor + "\n\n" +Mensagem + "\n" + NomeRegistro  ))
		{
		location = url;
		}
	}
//Fim da Funcao Confirmar

//Função para imprimir a pagina
//Para usar: OnClick="javascript:Imprimir()"
function Imprimir()
	{
	if (!window.print) //Faz a verificação
		{
			alert("Use o Netscape  ou Internet Explorer \n nas versões 4.0 ou superior!")
			return
		}
			window.print() //Comando para Imprimir
	}
//Fim da Funcao Imprimir

//************************************************************
//FUNÇÃO QUE ABRE UMA POPUP DO LINK DA PAGINA QUE É PASSADO JUNTO COM A lARGURA E ALTURA DA POPUP
//PARA USAR COMO UM LINK BASTA USAR O SEGUINTE EXEMPLO ABAIXO:
//<a href="javascript:AbrePopUp('/SmartCare/Teste2.asp?Busca=seila','570','500',this,event)"><img src="\SmartCare\images\pesquisa.gif" border="0" WIDTH="15" HEIGHT="13"></a>
//************************************************************
function AbrePopUp(Link_Pagina,Largura,Altura) 
	{
	   window.open(Link_Pagina,'','width='+Largura+',height='+Altura+',scrollbars=yes,top=0,left=0,screenX=800,screenY=600,status=yes')
	}

//************************************************************
//FUNÇÃO QUE ABRE UMA POPUP DO LINK DA PAGINA QUE É PASSADO JUNTO COM A lARGURA E ALTURA DA POPUP
//Usamos o showModalDialog pois dessa forma o usuario é obrigado a selecionar alguma coisa na pagina para depois voltar a pagina de baixo
//PARA USAR COMO UM LINK BASTA USAR O SEGUINTE EXEMPLO ABAIXO:
//<a href="javascript:AbrePopUpDialog('/SmartCare/Teste2.asp?Busca=seila','570','500',this,event)"><img src="\SmartCare\images\pesquisa.gif" border="0" WIDTH="15" HEIGHT="13"></a>
//************************************************************
function AbrePopUpDialog(sPg, xnHeight, xnWidth) {
	var sRet = window.showModalDialog(sPg, "","dialogHeight:" +  xnHeight + "px; edge: sunken; status: no; help: no; unadorned: no;dialogWidth:" +  xnWidth + "px; edge: sunken; status: no; help: no; unadorned: no;dialogTop: 0;dialogLeft: 0")
	return(sRet);
 }

//************************************************************
//Função para qualquer tipo de mascara para campos
//Observação: As máscaras podem ser representadas como os exemplos abaixo: 
//CEP -> 99.999-999 
//CPF -> 999.999.999-99 
//CNPJ -> 99.999.999/9999-99 
//Data -> 99/99/9999 
//Tel Resid -> (99) 999-9999 
//Tel Cel -> (99) 9999-9999 
//Processo -> 99.999999999/999-99 
//C/C -> 999999-! 
//E por aí vai...vc pode criar as mascaras que desejar
//Para usar coloco esse linha no campo:
//onKeyPress="return MascaraCampo(document.form, 'Fone', '(99) 9999-9999', event);"
//************************************************************
function MascaraCampo(objForm, strField, sMask, evtKeyPress) { 
      var i, nCount, sValue, fldLen, mskLen,bolMask, sCod, nTecla; 

      if(document.all) { // Internet Explorer 
        nTecla = evtKeyPress.keyCode; } 
      else if(document.layers) { // Nestcape 
        nTecla = evtKeyPress.which; 
      } 

      sValue = objForm[strField].value; 

      // Limpa todos os caracteres de formatação que 
      // já estiverem no campo. 
      sValue = sValue.toString().replace( "-", "" ); 
      sValue = sValue.toString().replace( "-", "" ); 
      sValue = sValue.toString().replace( ".", "" ); 
      sValue = sValue.toString().replace( ".", "" ); 
      sValue = sValue.toString().replace( "/", "" ); 
      sValue = sValue.toString().replace( "/", "" ); 
      sValue = sValue.toString().replace( "(", "" ); 
      sValue = sValue.toString().replace( "(", "" ); 
      sValue = sValue.toString().replace( ")", "" ); 
      sValue = sValue.toString().replace( ")", "" ); 
      sValue = sValue.toString().replace( ":", "" ); 
	  sValue = sValue.toString().replace( " ", "" ); 
      sValue = sValue.toString().replace( " ", "" ); 
      fldLen = sValue.length; 
      mskLen = sMask.length; 

      i = 0; 
      nCount = 0; 
      sCod = ""; 
      mskLen = fldLen; 

      while (i <= mskLen) { 
        bolMask = ((sMask.charAt(i) == "-") || (sMask.charAt(i) == ".") || (sMask.charAt(i) == "/")) 
        bolMask = bolMask || ((sMask.charAt(i) == "(") || (sMask.charAt(i) == ")") || (sMask.charAt(i) == ":") || (sMask.charAt(i) == " ")) 

        if (bolMask) { 
          sCod += sMask.charAt(i); 
          mskLen++; } 
        else { 
          sCod += sValue.charAt(nCount); 
          nCount++; 
        } 

        i++; 
      } 

      objForm[strField].value = sCod; 

      if (nTecla != 8) { // backspace 
        if (sMask.charAt(i-1) == "9") { // apenas números... 
          return ((nTecla > 47) && (nTecla < 58)); } // números de 0 a 9 
        else { // qualquer caracter... 
          return true; 
        } } 
      else { 
        return true; 
      } 
    } 
//Fim da função MascaraCampo


//************************************************************
//Função que faz formatação de campos de Moedas
//Para usar coloque esta propriedade no seu campo
//onKeyPress="return(currencyFormat(this,',','.',event))"
//Obs: Perceba que na linha acima ele passa como formatacao (,)Virgula e (.)Ponto. Se quiser pode mudar tudo para ponto ou tudo para virgula ou entao deixar vazio
function FormataMoeda(fld, milSep, decSep, e) { 
	var sep = 0; 
	var key = ''; 
	var i = j = 0; 
	var len = len2 = 0; 
	var strCheck = '0123456789'; 
	var aux = aux2 = ''; 
	var whichCode = (window.Event) ? e.which : e.keyCode; 
	if (whichCode == 13) return true; // Enter 
	key = String.fromCharCode(whichCode); // Get key value from key code 
	if (strCheck.indexOf(key) == -1) return false; // Not a valid key 
	len = fld.value.length; 
	for(i = 0; i < len; i++) 
	if ((fld.value.charAt(i) != '0') && (fld.value.charAt(i) != decSep)) break; 
	aux = ''; 
	for(; i < len; i++) 
	if (strCheck.indexOf(fld.value.charAt(i))!=-1) aux += fld.value.charAt(i); 
	aux += key; 
	len = aux.length; 
	if (len == 0) fld.value = ''; 
	if (len == 1) fld.value = '0'+ decSep + '0' + aux; 
	if (len == 2) fld.value = '0'+ decSep + aux; 
	if (len > 2) { 
	aux2 = ''; 
	for (j = 0, i = len - 3; i >= 0; i--) { 
	if (j == 3) { 
	aux2 += milSep; 
	j = 0; 
	} 
	aux2 += aux.charAt(i); 
	j++; 
	} 
	fld.value = ''; 
	len2 = aux2.length; 
	for (i = len2 - 1; i >= 0; i--) 
	fld.value += aux2.charAt(i); 
	fld.value += decSep + aux.substr(len - 2, len); 
	} 
	return false; 
	} 
//Fim da Função FormataMoeda
</script>

<Script>
//Função que Valida Data com expressões regulares 
//Coloca no Imput:
//onBlur="ValidarDataExpReg(document.formCadastro.Medico_Avaliador_Data.value, '1'); return false;"
function ValidarDataExpReg(pStr, pFmt)
{
	var reDate1 = /^\d{1,2}\/\d{1,2}\/\d{1,4}$/;
	var reDate2 = /^[0-3]?\d\/[01]?\d\/(\d{2}|\d{4})$/;
	var reDate3 = /^(0?[1-9]|[12]\d|3[01])\/(0?[1-9]|1[0-2])\/(19|20)?\d{2}$/;
	var reDate4 = /^((0?[1-9]|[12]\d)\/(0?[1-9]|1[0-2])|30\/(0?[13-9]|1[0-2])|31\/(0?[13578]|1[02]))\/(19|20)?\d{2}$/;
	var reDate5 = /^((0[1-9]|[12]\d)\/(0[1-9]|1[0-2])|30\/(0[13-9]|1[0-2])|31\/(0[13578]|1[02]))\/\d{4}$/;
	var reDate = reDate4;
	eval("reDate = reDate" + pFmt);
	if (reDate.test(pStr)) {
		//alert(pStr + " é uma data válida.");
	} else if (pStr != null && pStr != "") {
		alert(pStr + " não é um formato de data válido.\n\nExemplo: dd/mm/aaaa");
	}
}
</Script>

<Script>
//Função que valida formata HORA
//Colocar no imput:
//onBlur="ValidarHoraExpReg(document.formCadastro.Medico_Avaliador_Hora.value, '2'); return false;"	
function ValidarHoraExpReg(pStr, pFmt)
{
	var reTime1 = /^\d{2}:\d{2}$/;
	var reTime2 = /^([0-1]\d|2[0-3]):[0-5]\d$/;
	var reTime3 = /^(0[1-9]|1[0-2]):[0-5]\d$/;
	var reTime4 = /^\d+:[0-5]\d:[0-5]\d$/;
	var reTime5 = /^\d+:[0-5]\d:[0-5]\.\d{3}\d$/;
	eval("reTime = reTime" + pFmt);
	if (reTime.test(pStr)) {
		//alert(pStr + " é um horário/tempo válido.");
	} else if (pStr != null && pStr != "") {
		alert(pStr + " não é um formato de horário válido. \n\nExemplo: HH:MM - 12:45");
	}
} 

</Script>

<script>
//Função que quando preenchido um determinado campo com a quantidade de caracteres desejados ele pula para o proxima campo
//Para usar use o seguinte no imput:
//onfocus="this.select()" onkeyup="SaltaKeyUp(formCadastro.CRM, formCadastro.Medico_Solicitante_Contato, 6)" onKeyPress="SaltaKeyPress()" onBlur="SaltaBlur()"
var Salta;

function SaltaBlur()
	{
		Salta = false; 
	}

function SaltaKeyPress()
	{
		Salta = true;
	}

function SaltaKeyUp(Campo1,Campo2,Tam)
	{
		if (Salta && (Campo1.value.length >= Tam)) Campo2.focus(); 
	}
</script>

<script>
//Função que passada o valor verifica se o CPF é valido ou não
//Esta função é para cpf com pontos e traços
//Para usar: if (!Valida_CPF(cpf)){document.form1.Confere_CPF.value = "";return false;}
function Valida_CPF(sCPF) 
	{
		cpf = sCPF.substring(0,3) + sCPF.substring(4,7) + sCPF.substring(8,11) + sCPF.substring(12,14); 
	
		var a = []; var b = new Number;var c = 11;
	
		if (cpf == "00000000000" || cpf == "11111111111" || cpf == "22222222222" || cpf == "33333333333" || cpf == "44444444444" || cpf == "55555555555" || cpf == "66666666666" || cpf == "77777777777" || cpf == "88888888888" || cpf == "99999999999"){return false;}
	
		for (i=0; i<11; i++){a[i] = cpf.charAt(i);if (i < 9) b += (a[i] *  --c);}
	
		if ((x = b % 11) < 2) {a[9] = 0 }else{ a[9] = 11-x }b = 0;c = 11;
	
		for (y=0; y<10; y++) b += (a[y] *  c--); if ((x = b % 11) < 2) { a[10] = 0; }else{a[10] = 11-x; }
	
		if ((cpf.charAt(9) != a[9]) || (cpf.charAt(10) != a[10]))
		{
			alert ("CPF inválido !!!")
			return false;
		}
		return true;
   }
</script>
