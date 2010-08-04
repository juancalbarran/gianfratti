<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="DefaultAbas.aspx.cs" Inherits="Cliente_DefaultAbas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Untitled Page</title>
<!-- RESPONSAVEL POR NÃO DEIXA ARMAZENAR CACHE -->  
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
<!-- FIM DO CACHE -->

<!-- JAVA SCRIPT RESPONSAVEL POR ALTERNAR AS ABAS -->  
<script type="text/javascript" language="JavaScript">
	//Declara um Array com a posicao e nome das Abas
	var arAbas = new Array();
	arAbas[0] = new stAba('td_Aba1','div_Aba1');
	arAbas[1] = new stAba('td_Aba2','div_Aba2');
	arAbas[2] = new stAba('td_Aba3','div_Aba3');
    //Função responsavel por criar os links das abas e pegar os parametros usando a outro function global QueryString
    function Link(TIPO)
    {
        if(TIPO == 1)
            document.getElementById('div_Aba1').src="ClienteAtualizar.aspx?idCliente=" + QueryString("idCliente");
        else if(TIPO == 2)
            document.getElementById('div_Aba2').src="ClienteDepartamento.aspx?idCliente=" + QueryString("idCliente");
        else if(TIPO == 3)
            document.getElementById('div_Aba3').src="Cargo.aspx?idCliente=" + QueryString("idCliente");
    }
</script>
<!-- FIM DO JAVA SCRIPT -->
</head>
<!-- CHAMA A FUNÇÃO AlternarAbas E PASSA A ABA INICIAL, DA MESMO FORMA CHAMA A FUNÇÃO Link E PASSA O iFRAME INICIAL -->
<body onload="javascript: AlternarAbas('td_Aba1','div_Aba1');Link(1)">

<fieldset style="height: 100%">
    <legend align="center">Cadastro de Cliente</legend>
    
    
<!-- TABELA ONDE SÃO MONTADAS AS ABAS -->    
<table cellspacing="0" cellpadding="0" border="0"  style="border-left: 1px solid #000000; width: 100%; height: 15px">
	<tr>
	    <!-- PRIMEIRA ABA -->  
		<td id="td_Aba1" onclick="AlternarAbas('td_Aba1','div_Aba1'); Link(1);" style="border-bottom: 0px solid #000000;width: 110; height:20">
			<a href="#" style="color: #000000;">Cliente</a>
		</td>
		<!-- SEGUNDA ABA -->  
		<td id="td_Aba2" onclick="AlternarAbas('td_Aba2','div_Aba2'); Link(2);" style="border-bottom: 0px solid #000000;width: 110; height:20">
			<a href="#" style="color: #000000;">Departamentos</a>
		</td>
		<!-- TERCEIRA ABA -->  
		<td id="td_aba3" onclick="AlternarAbas('td_Aba3','div_Aba3'); Link(3);" style="border-bottom: 0px solid #000000;width: 110; height:20">
			<a href="#" style="color: #000000;">Cargos</a>
		</td>
		<td style="border-bottom: 1px solid #000000;width:460">			
		</td>
	</tr>
</table>
<!-- FIM TABELA ABAS-->

<!-- TABELA DA COM CONTEUDO DAS ABAS-->    
<table  cellpadding="0" cellspacing="0" border="0" style="border-left: 1px solid #000000; width: 100%; height: 100%;">
	<tr>
		<td class="tb-conteudo" valign="Top" style="border-top: 1px solid #000000;width:100%;height:100%">
            <!-- IFRAME RESPONSAVEL POR BUSCAR A PAGINA DA PRIMEIRA ABA --> 
			<iframe id="div_Aba1" onload="RedimensionaIframe('div_Aba1')" class="conteudo" style="display: none; width:100%; height:100%;" frameborder="0" scrolling="no" src="" ></iframe>
			<!-- IFRAME RESPONSAVEL POR BUSCAR A PAGINA DA SEGUNDA ABA --> 
			<iframe id="div_Aba2" onload="RedimensionaIframe('div_Aba2')" class="conteudo" style="display: none; width:100%; height:100%;" frameborder="0" scrolling="no" src="" ></iframe>				
			<!-- IFRAME RESPONSAVEL POR BUSCAR A PAGINA DA TERCEIRA ABA --> 
			<iframe id="div_Aba3" onload="RedimensionaIframe('div_Aba3')" class="conteudo" style="display: none; width:100%; height:100%;" frameborder="0" scrolling="no" src="" ></iframe>				

		</td>
	</tr>
</table>
<!-- FIM CONTEUDO DAS ABAS -->
</fieldset>
</body>
</html>
</asp:Content>