// JScript File

//************************************************************
//FUNÇÃO PARA REDIMENSIONAR UM iFrame
//PARA USAR COMO UM LINK BASTA USAR O SEGUINTE EXEMPLO ABAIXO:
//<iframe onLoad="redimen('Nome do iFrame')">
//************************************************************
function redimen(nome){
    //alert(document.frames[nome].document.body.scrollHeight)
    var altura = eval("document.frames[nome].document.body.scrollHeight");
    eval("document.getElementById(nome).style.height = altura");                             
}
//************************************************************
//Função responsavel por mostrar e ocultar mensagens de erro
//************************************************************
 function ErroDetalhe()
 {
    if(document.getElementById('erroDetalhe').style.display=='none')
    {
        document.getElementById('erroDetalhe').style.display=''; 
        document.getElementById('imgDetalhe').innerHTML="<img src=../Template/Img/icoMenos.gif />";
    }
    else
    {
        document.getElementById('erroDetalhe').style.display='none'; 
        document.getElementById('imgDetalhe').innerHTML="<img src=../Template/Img/icoMais.gif />";
    }
}

//************************************************************
//FUNÇÃO QUE ABRE UMA POPUP DO LINK DA PAGINA QUE É PASSADO JUNTO COM A lARGURA E ALTURA DA POPUP
//PARA USAR COMO UM LINK BASTA USAR O SEGUINTE EXEMPLO ABAIXO:
//<a href="javascript:AbrePopUp('/SmartCare/Teste2.asp?Busca=seila','570','500',this,event)"><img src="\SmartCare\images\pesquisa.gif" border="0" WIDTH="15" HEIGHT="13"></a>
//************************************************************
function AbrePopUp(Link_Pagina,Largura,Altura) 
	{
	   window.open(Link_Pagina,'','width='+Largura+',height='+Altura+',scrollbars=yes,top=0,left=0,screenX=800,screenY=600,status=yes')
	}

function Confirmar(Mensagem,url)
    {
        if (confirm(Mensagem)){location = url;}
    }
//************************************************************
//FUNÇÃO QUE VOCÊ PODE PEGAR OS PARAMENTROS PASSADO NA URL, PODE PEGAR VARIOS PARAMENTROS NA MESMA URL, BASTA IR ADICIONANDO NOVAS LINHAS
//PARA USAR BASTA SEGUIR O EXEMPLO:
//Variavel = getParameter(self.location.href,'NomeParametro')
// OU PODE SER USADO DIRETO
//getParameter(self.location.href,'NomeParametro')
//************************************************************
function PegaParamentro(queryString, parameterName) {
  var parameterName = parameterName + "=";
  if ( queryString.length > 0 ) {
   begin = queryString.indexOf ( parameterName );
   if ( begin != -1 ) {
    begin += parameterName.length;
    end = queryString.indexOf ( "&" , begin );
    if ( end == -1 ) {
     end = queryString.length;
    }
    return unescape ( queryString.substring ( begin, end ) );
   }
   return "";
  }
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
//onKeyPress="return MascaraCampo(document.form, this, '(99) 9999-9999', event);"
//************************************************************
function MascaraCampo(objForm, strField, sMask, evtKeyPress) { 
      
     var i, nCount, sValue, fldLen, mskLen,bolMask, sCod, nTecla; 

      if(document.all) { // Internet Explorer 
        nTecla = evtKeyPress.keyCode; } 
      else if(document.layers) { // Nestcape 
        nTecla = evtKeyPress.which; 
      } 

      //sValue = objForm[strField].value; 
      sValue = strField.value; 

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
      sValue = sValue.toString().replace( ",", "" );
      sValue = sValue.toString().replace( "x", "" ); 
      fldLen = sValue.length; 
      mskLen = sMask.length; 

      i = 0; 
      nCount = 0; 
      sCod = ""; 
      mskLen = fldLen; 

      while (i <= mskLen) { 
        bolMask = ((sMask.charAt(i) == "-") || (sMask.charAt(i) == ".") || (sMask.charAt(i) == "/")) 
        bolMask = bolMask || ((sMask.charAt(i) == "(") || (sMask.charAt(i) == ")") || (sMask.charAt(i) == ":") || (sMask.charAt(i) == " ") || (sMask.charAt(i) == ",") || (sMask.charAt(i) == "x")) 

        if (bolMask) { 
          sCod += sMask.charAt(i); 
          mskLen++; } 
        else { 
          sCod += sValue.charAt(nCount); 
          nCount++; 
        } 

        i++; 
      } 

      //objForm[strField].value = sCod; 
      strField.value = sCod; 

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
//onKeyPress="return(FormataMoeda(this,',','.',event))"
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

//Funcao que valida a data
//Para usar coloque esta propriedade no seu campo
//onblur="javascript:valida_data(this);"
function valida_data(campo) {
	var date = campo.value;
	if(date != "")
	{
	var array_data = new Array;
	var ExpReg = new RegExp("(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/[12][0-9]{3}");
	//vetor que contem o dia o mes e o ano
	array_data = date.split("/");
	erro = false;
	//Valido se a data esta no formato dd/mm/yyyy e se o dia tem 2 digitos e esta entre 01 e 31
	//se o mes tem d2 digitos e esta entre 01 e 12 e o ano se tem 4 digitos e esta entre 1000 e 2999
	if ( date.search(ExpReg) == -1 )
		erro = true;
	//Valido os meses que nao tem 31 dias com execao de fevereiro
	else if ( ( ( array_data[1] == 4 ) || ( array_data[1] == 6 ) || ( array_data[1] == 9 ) || ( array_data[1] == 11 ) ) && ( array_data[0] > 30 ) )
		erro = true;
	//Valido o mes de fevereiro
	else if ( array_data[1] == 2 ) {
		//Valido ano que nao e bissexto
		if ( ( array_data[0] > 28 ) && ( ( array_data[2] % 4 ) != 0 ) )
			erro = true;
		//Valido ano bissexto
		if ( ( array_data[0] > 29 ) && ( ( array_data[2] % 4 ) == 0 ) )
			erro = true;
	}
	if ( erro ) {
		alert("Data Invalida");
		campo.focus();
	}
	}
}