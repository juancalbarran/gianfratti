	String.prototype.trim  = trim;	
	String.prototype.ltrim = ltrim;	
	String.prototype.rtrim = rtrim;	 
	
	function trim()	{
		var Str = this.ltrim();
		Str = Str.rtrim();
		return Str;
	}	 
	
	function ltrim(){	
		var strRegExp = /^\s+/;
		var Str = this.replace(strRegExp,'');
		return Str;
	}	 
	
	function rtrim(){
		var strRegExp = /\s+$/;
		var Str = this.replace(strRegExp,'');
		return Str;
	}
	
	function fnMarcaRequeridos(oFrm){
		try{
			var aux = true
			var sFocus = ''
			for (var i = 0; i<oFrm.length; i++)	{
				if (oFrm.elements[i].required == 'yes' && oFrm.elements[i].value.toString().trim() == ''){
					aux = false
					if(sFocus == ''){sFocus = i}
					if (oFrm.elements[i].parentElement.childNodes.length > 1){
						if (oFrm.elements[i].nextSibling.tagName != 'SPAN'){
							oFrm.elements[i].insertAdjacentHTML('afterEnd', '<span style="color=#FF0000;font-weight: bold;">&nbsp;*</span>')
						}else{
							oFrm.elements[i].nextSibling.innerHTML = '<font style="color=#FF0000;font-weight: bold;">&nbsp;*<font>'
						}
					}else{
						oFrm.elements[i].insertAdjacentHTML('afterEnd', '<span style="color=#FF0000;font-weight: bold;">&nbsp;*</span>')
					}					
				}else if (oFrm.elements[i].required == 'yes' && oFrm.elements[i].value.toString().trim() != ''){
					if (oFrm.elements[i].parentElement.childNodes.length > 1){
						if (oFrm.elements[i].nextSibling.tagName == 'SPAN')	{
							oFrm.elements[i].nextSibling.innerText = '';
						}
					}
				}
			}
			if (aux == false){
				alert('Campos sinalizados com (*) tem seu preenchimento obrigatório!         ')
				if(sFocus != ''){oFrm.elements[sFocus].focus();}
			}
			return (aux)
		}catch(e){
			//alert('Descrição: ' + e.description + ' \nNúmero: ' + e.number + ' \nLinha: ' + e.line);
			return(false);		
		}
	}

	
	function fnValidaRequerido(oFrm){
		for (var i = 0; i<oFrm.length; i++)	{
			if (oFrm.elements[i].required == 'yes' && oFrm.elements[i].value.toString().trim() == ''){
				alert(oFrm.elements[i].Error)
				oFrm.elements[i].focus();
				return (false)
			}
		}
		return (true)
	}

	function ConfigurarCampos(oFrm)
		{	
		for (var i = 0; i<oFrm.length; i++)
			{
			switch(oFrm.elements[i].tipo)
				{
				case 'data':
					oFrm.elements[i].onkeydown = FormatarCampoNumero
					oFrm.elements[i].onkeypress = FormatarCampoData
					oFrm.elements[i].onblur = ValidarData
					oFrm.elements[i].title = 'dd/mm/aaaa'
					break;
				case 'numero':
					oFrm.elements[i].onkeydown = FormatarCampoNumero
					break;
				case 'email':
					oFrm.elements[i].onkeydown = FormatarCampoEMail
					oFrm.elements[i].onblur = ValidarEmail
					break;
				case 'cpf':
					oFrm.elements[i].onkeydown = FormatarCampoNumero
					oFrm.elements[i].onkeypress = FormatarCampoCPF
					oFrm.elements[i].onblur = ValidarCpf
					break;
				case 'cnpj':
					oFrm.elements[i].onkeydown = FormatarCampoNumero
					oFrm.elements[i].onkeypress = FormatarCampoCNPJ
					oFrm.elements[i].onblur = ValidarCnpj
					break;
				case 'caracteres':
					oFrm.elements[i].onkeydown = FormatarCampoCaracter
					break;
				case 'cep':
					oFrm.elements[i].onkeydown = FormatarCampoNumero
					oFrm.elements[i].onkeypress = FormatarCampoCEP
					oFrm.elements[i].onblur = ValidarCep
					oFrm.elements[i].title = 'nnnnn-nn'
					break;										
				}
			}
		}


	function ValidarData()
		{
		var campo = window.event.srcElement
		if(IsData(campo.value) == false)
			{
			alert('A data informada nao e valida!         \nA data deve estar no formato "dd/mm/aaaa".         ')
			//campo.value = ''
			campo.focus()
			campo.select();			
			}
		}


	function ValidarEmail()
		{
		var campo = window.event.srcElement
		if (IsEMail(campo.value) == false)
			{
			alert('O E-mail informado não é válido!')
			//campo.value = ''
			campo.focus()
			campo.select();
			}
		}

	
	function ValidarCnpj()
		{
		var campo = window.event.srcElement
		if (IsCNPJ(campo.value) == false)
			{
			alert('O CNPJ informado não é válido!')
			//campo.value = ''
			campo.focus()
			campo.select();
			}		
		}


	function ValidarCpf()
		{
		var campo = window.event.srcElement
		if (IsCPF(campo.value) == false)
			{
			alert('O CPF informado não é válido!')
			campo.value = ''
			campo.focus()
			}else if (iIsCPF(campo.value) == false){
				alert('O CPF informado não é válido!')
			//campo.value = ''
			campo.focus()
			campo.select();
			}	
		}


	function ValidarCep()
		{
		var campo = window.event.srcElement
		if (IsCEP(campo.value) == false)
			{
			alert('O CEP informado não é válido!')
			//campo.value = ''
			campo.focus()
			campo.select();
			}
		}


	function IsCEP(sStr)
		{
		try
			{
			//Se String vier vazia retorna
			if (sStr=='')
				{
				return(true);
				}
			//Valida Expressão nnnnn-nnn
			var oRegExp = /^(\d{8}|\d{5}-\d{3})$/;
			if (oRegExp.test(sStr))
				{
				return(true);
				}
			else
				{
				return(false);
				}
			}
		catch(e)
			{
			return(false);		
			}
		}


	function IsCNPJ(sStr)
		{
		try
			{
			//Se String vier vazia retorna
			if (sStr=='')
				{
				return(true);
				}
			//Valida Expressão nn.nnn.nnn/nnnn-nn
			var oRegExp = /^(\d{14}|\d{2}.\d{3}.\d{3}\/\d{4}-\d{2})$/;
			if (oRegExp.test(sStr))
				{
				return(true);
				}
			else
				{
				return(false);
				}
			}
		catch(e)
			{
			return(false);		
			}
		}


	function IsData(sStr)
		{
		try
			{
			//Se String vier vazia retorna
			if (sStr=='')
				{
				return(true);
				}
			//Valida Expressão dd/mm/aaaa
			var oRegExp = /^(\d{10}|\d{2}\/\d{2}\/\d{4})$/;
			if (oRegExp.test(sStr))
				{
				var sData = new String(sStr);
				var aData = sData.split('/');
				var dia = new Number(aData[0]);
				var mes = new Number(aData[1]);
				var ano = new Number(aData[2]);
				//Verefica se o ano está entre 1990 e 2010
				if(ano < 1990 || ano > 2010){
					return(false);
				}

				//Verifica se dia e mes existe
				if (dia < 1 || dia > 31 || mes < 1 || mes > 12)
					{
					return(false);
					}
				//Verifica se dia existe no mes	
				if ((mes == 4 || mes == 6 || mes == 9 || mes == 11) && (dia == 31))
					{
					return(false);
					}
				//Se Fevereiro	
				if (mes == 2)
					{
					//Se for Ano-Bissexto
					if (ano % 4 == 0)
						{
						if (dia > 29)
							{
							return(false);
							}
						}
					//Se não for Ano-Bissexto	
					else
						{
						if (dia > 28)
							{
							return(false);
							}				
						}				
					}
				return(true);
				}
			else
				{
				return(false);
				}
			}
		catch(e)
			{
			return(false);		
			}
		}


	function IsEMail(sStr) 
		{
		try
			{
			if (sStr=='')
				{
				return(true)
				}	
			if (!isNaN(sStr))
				{
				return(false)
				}
			var sEMail = new String(sStr)	
			if (sEMail.indexOf('@') == -1 || sEMail.indexOf('@') == 0)
				{
				return(false)
				}
			if (sEMail.indexOf('.') == -1 || sEMail.indexOf('.') == 0)
				{
				return(false)
				}
			if (sEMail.length < 9)
				{
				return(false)
				}	
			return(true)		
			}
		catch(e)
			{
			return(false)
			}	
		}

	function IsCPF(sStr)
		{
		try
			{
			//Se String vier vazia retorna
			if (sStr=='')
				{
				return(true);
				}
			//Valida Expressão nnn.nnn.nnn-nn
			var oRegExp = /^(\d{11}|\d{3}.\d{3}.\d{3}-\d{2})$/;
			if (oRegExp.test(sStr))
				{
				return(true);
				}
			else
				{
				return(false);
				}
			}
		catch(e)
			{
			return(false);		
			}
		}

	function FormatarCampoCaracter()
		{
		with(window.event.srcElement)
			{
			if ((event.keyCode < 48 && event.keyCode != 8 && event.keyCode != 9 && event.keyCode != 32 && event.keyCode != 45 && event.keyCode != 46) || event.keyCode > 122)
				{				
				event.returnValue = false;		
				}
			if(event.keyCode > 90 && event.keyCode < 97 && event.keyCode != 95)
				{				
				event.returnValue = false;		
				}
			if(event.keyCode > 57 && event.keyCode < 65)
				{				
				event.returnValue = false;		
				}
			}
		}

	function FormatarCampoCEP()
		{
		try
			{
			with(window.event.srcElement)
				{
				maxLength = 9
				if(event.keyCode < 48 || event.keyCode > 57)
					{
					event.returnValue = false;		
					}
				if(value.length == 5 && event.keyCode != 8)
					{
					value += "-";
					}
				}		
			}	
		catch(e)
			{
			event.returnValue = false;
			}
		}

	function FormatarCampoCNPJ()
		{
		try
			{
			with(window.event.srcElement)
				{
				maxLength = 18
				if(event.keyCode < 48 || event.keyCode > 57)
					{
					event.returnValue = false;		
					}
				if((value.length == 2 || value.length == 6) && event.keyCode != 8)
					{
					value += ".";
					}
				if(value.length == 10 && event.keyCode != 8)
					{
					value += "/";
					}
				if(value.length == 15 && event.keyCode != 8)
					{
					value += "-";
					}
				}		
			}	
		catch(e)
			{
			event.returnValue = false;
			}
		}

	function FormatarCampoCPF()
		{
		try
			{
			with(window.event.srcElement)
				{
				maxLength = 14
				if(event.keyCode < 48 || event.keyCode > 57)
					{
					event.returnValue = false;		
					}
				if((value.length == 3 || value.length == 7) && event.keyCode != 8)
					{
					value += ".";
					}
				if(value.length == 11 && event.keyCode != 8)
					{
					value += "-";
					}
				}		
			}	
		catch(e)
			{
			event.returnValue = false;
			}
		}

	function FormatarCampoData()
		{
		try
			{
			with(window.event.srcElement)
				{
				maxLength = 10			
				if(((event.keyCode < 48 && event.keyCode != 9) || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105) && event.keyCode != 46 && event.keyCode != 8 && event.keyCode != 16 && event.keyCode != 37 && event.keyCode != 9)
					{
					event.returnValue = false;		
					}					
				if((value.length == 2 || value.length == 5) && event.keyCode != 8)
					{
					value += "/";
					}
				}		
			}	
		catch(e)
			{
			event.returnValue = false;
			}
		}

	function FormatarCampoEMail()
		{
		with(window.event.srcElement)
			{
			maxLength = 60
			if ((event.keyCode < 48 && event.keyCode != 45 && event.keyCode != 46) || (event.keyCode > 122 && event.keyCode != 190))
				{				
				event.returnValue = false;		
				}
			if(event.keyCode > 90 && event.keyCode < 97 && event.keyCode != 95)
				{				
				event.returnValue = false;		
				}
			if(event.keyCode > 57 && event.keyCode < 64)
				{				
				event.returnValue = false;		
				}
			}
		}

	function FormatarCampoFONE()
		{
		try
			{
			with(window.event.srcElement)
				{
				maxLength = 9
				if(event.keyCode < 48 || event.keyCode > 57)
					{
					event.returnValue = false;		
					}
				if(value.length == 3 && event.keyCode != 8)
					{
					value += '-';
					}
				if(value.length == 8 && event.keyCode != 8)
					{
					value = value.replace('-','');
					value = value.substr(0, 4) + '-' + value.substr(4)
					}
				}		
			}	
		catch(e)
			{
			event.returnValue = false;
			}
		}

	function FormatarCampoNumero()
		{
		try
			{
			with(window.event.srcElement)
				{
				if((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105) && event.keyCode != 46 && event.keyCode != 8 && event.keyCode != 16 && event.keyCode != 37 && event.keyCode != 9)
					{
					event.returnValue = false;		
					}					
				}		
			}	
		catch(e)
			{
			event.returnValue = false;
			}
		}

	function FormatarCampoValor(sPalavra, nQtdDec, tipoEdit)
		{
		nPosiVirgula = sPalavra.indexof(",")  + 1;
		
		if(nPosiVirgula == 0)
			{
			nPosiVirgula = sPalavra.length + 1;
			}
			
		nPos = 0;
		bDec = false;
		nQtdDecimais = nQtdDec;
		sNovaPalavra = ""; 
	
		while(true)
			{
			if(nPos < sPalavra.length)
				{
				sLetra = sPalavra.charAt(nPos);
				}            
			else
				{
				sLetra = "";
				if(bDec == false)
					{
					bDec = true;
					sNovaPalavra += ",";
					}
				}
			if(sLetra == '.')
				{
				nPos++;
				continue;
				}
			if(sLetra == ',')
				{
				if(bDec == true)
					{
					sNovaPalavra = sPalavra
					break;
					}
				bDec = true;
				if(nQtdDec > 0)
					{
					sNovaPalavra += ",";
					nPos++;
					nQtdDecimais = nQtdDec;
					continue;
					}
				else
					{
					break;
					}                
				}
			if(bDec == true && sLetra == "")
				{
				sLetra="0";
				}            
			if(sLetra < '0' || sLetra > '9')
				{
				sNovaPalavra = sPalavra;
				break;
				}
			sNovaPalavra += sLetra;
			nPos++;
			if(bDec == true)
				{
				nQtdDecimais--;
				if(nQtdDecimais == 0)
					{
					break;
					}			    
				}
			}
		if(tipoEdit == 1)
			{
			sPalavra = sNovaPalavra;
			sNovaPalavra = "";
			bDec = false;
			nPosiVirgula = sPalavra.indexof(",");
			if(nPosiVirgula == 0)
				{
				nPosiVirgula = sPalavra.length;
				}            
			nQtdGrupo = nPosiVirgula % 3;
			if(nQtdGrupo == 0)
				{
				nQtdGrupo = 3;
				}            
			nPos = 0;
			while(true)
				{
				if(nPos < sPalavra.length)
					{
					sLetra = sPalavra.charAt(nPos);
					}	            
				else
					{
					break;
					}                
				if(sLetra == ',' || sLetra == '-')
					{
					bDec = true;
					}                
				if(nQtdGrupo == 0)
					{
					if(bDec == false)
						{
						sNovaPalavra += ".";
						}                    
					nQtdGrupo=3;
					}			
				sNovaPalavra += sLetra;
				nQtdGrupo--;
				nPos++;
				}
			}
	
		if(sNovaPalavra.indexof(",") == 0)
			{
			sNovaPalavra = "0" + sNovaPalavra
			}
	
		if(nQtdDec > 0 && sNovaPalavra.indexof(",") == -1)
			{
			sNovaPalavra += ','	
			for (var i = 0; i < nQtdDec; i++)
				{
				sNovaPalavra += '0'
				}
			}
		
		return(sNovaPalavra);
		}


	function iIsCPF(sCPF) {
		cpf = sCPF.substring(0,3) + sCPF.substring(4,7) + sCPF.substring(8,11) + sCPF.substring(12,14); 
		var a = []; 
		var b = new Number;	
		var c = 11;
		
		if (cpf == "00000000000" || cpf == "11111111111" || cpf == "22222222222" || cpf == "33333333333" || cpf == "44444444444" || cpf == "55555555555" || cpf == "66666666666" || cpf == "77777777777" || cpf == "88888888888" || cpf == "99999999999"){
			return false;
		}
		for (i=0; i<11; i++){
			a[i] = cpf.charAt(i);
			if (i < 9) b += (a[i] *  --c);
		}
		if ((x = b % 11) < 2) { 
			a[9] = 0 
		}else{ 
			a[9] = 11-x 
		}
		b = 0;c = 11;
		
		for (y=0; y<10; y++) 
		b += (a[y] *  c--); 
		if ((x = b % 11) < 2) { 
			a[10] = 0; 
		}else{
			a[10] = 11-x; 
		}
		if ((cpf.charAt(9) != a[9]) || (cpf.charAt(10) != a[10])){
			return false;
		}
		return true;
	}
