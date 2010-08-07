/* 
Criado em:	13/11/2003 - 12:30
Nome: 		Functions.Js
Programador:	Rogério Silva
Email:		webmaster_wb@brfree.com.br
Finalidade do Arquivo Mostrar e esconder as subcategorias
------------------------------------------------------------------------------------------------------------------------
Este arquivo contém todas as funções utilizadas na loja VSOpen, por isso antes de sair editando este arquivo, faça uma cópia do mesmo e altere a cópia.
Caso algo de errado, recupere o arquivo.
------------------------------------------------------------------------------------------------------------------------
Este arquivo não é prejudicial ao seu micro.
*/

//------------------------------------------------------------------------------------------------------------------------
//CRIA O MENU RETRATIL
// http://www.dynamicdrive.com/dynamicindex1/switchmenu.htm
//------------------------------------------------------------------------------------------------------------------------

function SwitchMenu(obj){
	if(document.getElementById){
	var el = document.getElementById(obj);
	var ar = document.getElementById("masterdiv").getElementsByTagName("span"); //DynamicDrive.com change
		if(el.style.display != "block"){ //DynamicDrive.com change
			for (var i=0; i<ar.length; i++){
				if (ar[i].className=="submenu") //DynamicDrive.com change
				ar[i].style.display = "none";
			}
			el.style.display = "block";
		}else{
			el.style.display = "none";
		}
	}
}

function generico(URL,NOME,LARG,ALT,T,L,R,S)
{
var op ; 
op =window.open(URL,NOME,'width='+LARG+',height='+ALT+',top='+T+',left='+L+',resizable='+R+',scrollbars='+S)
op.focus();
}