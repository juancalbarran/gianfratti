	function isArray(obj){return(typeof(obj.length)=="undefined")?false:true;}
	
	function isObject(obj){return(typeof(obj)=='object')?true:false}
	
	function fnMarcaRequeridosOnLoad(oFrm){
		try{
			for (var i = 0; i<oFrm.length; i++)	{
				if (oFrm.elements[i].required == 'yes'){oFrm.elements[i].insertAdjacentHTML('afterEnd', '<span>&nbsp;*</span>')	}
			}
		}catch(e){
			return (false);		
		}
	}
	
	function fnOpenOne(sPg, xnHeight, xnWidth, xndialogTop, xndialogLeft){
		var sRet = window.showModalDialog(sPg, "","dialogHeight:"	+  xnHeight + "px; edge: sunken; status: no; help: no; unadorned: no;dialogWidth:" +  xnWidth + "px; edge: sunken; status: no; help: no; unadorned: no;dialogTop: " +  xndialogTop + ";dialogLeft: " +  xndialogLeft )
		return(sRet);
	}
	
	function fnExecutar(sHref){
		try{
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP");
			xmlHTTP.Open('POST', sHref, false);
			xmlHTTP.Send();
		
			return xmlHTTP.responseText;
		
		}catch(e){
			return (false)
		}
	}
	
			
	function Checar(id){
		if (document.getElementById(id).checked==false){
			document.getElementById(id).checked =true
		}else{
			document.getElementById(id).checked = false
		}
	}
	
	function checkall(oFrm, oBj, img){
		try{
			if(isArray(oBj)){
				if (todos){
				for(i=0; i<oBj.length; i++){oBj[i].checked = true}
					document.images[img].src='../Shared/img/icones/naochecado.gif';
					document.images[img].alt="Desselecionar todos."
					todos=false	
				}else if (!todos){
					for(i=0; i<oBj.length; i++){oBj[i].checked = false}
						document.images[img].src='../Shared/img/icones/checado.gif';
						document.images[img].alt="Selicionar todos."
						todos = true
				}
			}else{
				if(!oBj.checked){
					oBj.checked = true
					document.images[img].src='../Shared/img/icones/naochecado.gif';
					document.images[img].alt="Desselecionar todos."
				}else if (oBj.checked){
					oBj.checked = false
					document.images[img].src='../Shared/img/icones/checado.gif';
					document.images[img].alt="Selicionar todos."
				}
			}
		}catch(e){
			return(false);		
		}
	}
	
	
	function checkall_a(oFrm, oBj, img){
		try{
			for(i=0; i<oFrm.length; i++){
				if (oFrm.elements[i].type == 'checkbox'){					
					oFrm.elements[i].checked = todos
				}
			}
			
			if (todos==true){
				document.images[img].src='../Shared/img/icones/naochecado.gif';
				document.images[img].alt="Desselecionar todos."
				todos=false
			}else{
				document.images[img].src='../Shared/img/icones/checado.gif';
				document.images[img].alt="Selicionar todos."
				todos=true
			}
		}catch(e){
			return(false);		
		}
	}
	
	_editor_url = "";                     // URL to htmlarea files
	var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
	if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
	if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
	if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
	if (win_ie_ver >= 5.5) {
	  document.write('<scr' + 'ipt src="' +_editor_url+ '../Shared/htmlarea/editor.js"');
	  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
	} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
