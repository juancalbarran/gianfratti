<% 'CRIADO POR ANDREWS WILLIAM M.MORAES. DUVIDAS: WEBDESIGNER@BOL.COM.BR %>
<% 
Session.LCID = 1046

Function abrevia(descricao)
   descricao=left(descricao,110)
   response.write descricao&"..."
End Function



ir=request.querystring("ir")

if ir="fechar" then
           
    session.abandon
	response.Redirect "grato.htm"
	
    
  end if  %>

<% Response.CacheControl="no-cache"
   Response.AddHeader "Pragma","no-cache"
   Response.Expires=0
%> 

<!-- #include file="df.asp" -->
<%

   sql2="select * from sessoes ORDER BY nome"
   set categprincipal=abredb.execute(sql2)      



 
 
  count=0
  


%>


<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/plain; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Ponto M&eacute;dico - Or&ccedil;amento Online</title>
<script>
<!--
function addtocart(formele,prodid,categ,sessoes){

dml=document.f1;
dml2=document.f2;
product=dml.elements[formele];
subcateg=dml.elements[categ];
sessoes=dml.elements[sessoes];

total=dml2.elements[0];


 if(isNaN(product.value) || product.value=="")
     { 
      alert("Please enter a quantity");
      product.value="";
      product.focus();
      //return false;
     }
 else{      
      total.value=prodid +","+Math.ceil(product.value);
      dml2.submit();
      }

//return true;

}

  function removecart(removeprod){
  
  location.href="submitshop.asp?choice=remove&removeprod="+removeprod
  
  
  }

function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
//-->
</script>

<style type="text/css">
<!--
.k {
	font-family: tahoma;
	font-size: 11px;
	color: #333333;
	text-decoration: none;
}
a:visited {
	text-decoration: none;
}
a:hover {
	text-decoration: underline;
}
a:link {
	font-family: tahoma;
	font-size: 11px;
	color: #333333;
	text-decoration: none;
}
a:active {
	font-family: tahoma;
	font-size: 11px;
	color: #333333;
	text-decoration: none;
}
.style2 {
	color: #1A687B;
	font-weight: bold;
}
.style3 {
	font-size: 15px;
	font-weight: bold;
	font-family: arial;
}
.style4 {font-size: 16px; font-weight: bold; font-family: arial; color: #FFFFFF; }
.style5 {
	font-family: tahoma;
	font-size: 10px;
	line-height:15px
}
.style6 {
	font-family: tahoma;
	font-weight: bold;
	font-size: 9px;
}
.style8 {font-size: 11px}
.style9 {font-size: 9px; font-family: tahoma; }
.style10 {
	font-family: tahoma;
	font-size: 11px;
}
.style12 {font-family: tahoma; font-size: 11px; color: #333333; }
.style13 {color: #FF0000}
-->
</style>
<script language=JavaScript type=text/javascript src='carregando.js'></script>
</head>


<body onLoad="OnLoad()">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr><td width="49%" valign="top">
    <table width="100%">
      <tr>
        <td width="49%"><p align="center"><a href="submitshop.asp?choice=again"></a></p>
          <p align="center"><img src="images/topo.gif" width="445" height="47"></p>
          <table width="90%" height="72" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td valign="top"><div align="center"><span class="style5">Para gerar seu or&ccedil;amento, escolha a Categoria desejada. Ir&atilde;o aparecer as subcategorias relacionadas. Escolha a subcategoria para exibir os produtos. Ao encontrar o produto desejado clique em &quot;ADICIONAR&quot;. O seu or&ccedil;amento ser&aacute; montada ao lado direito da p&aacute;gina. Para imprimir o or&ccedil;amento, selecione o lado direito da p&aacute;gina da Primeira Marca&ccedil;&atilde;o at&eacute; a Segunda Marca&ccedil;&atilde;o e clique em Imprimir. Na caixa de impress&atilde;o que ir&aacute; abrir, selecione Imprimir Sele&ccedil;&atilde;o e clique em ok. </span></div></td>
            </tr>
          </table>
          <p align="center" class="style6"><span class="style8"><a href="submitshop.asp?choice=again">[ Clique aqui para iniciar uma nova lista</a> ] </span></p>
          <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td height="69" bgcolor="#D3E2EB"><p align="center"><strong><font size="2" face="Arial">Escolha a categoria dos produtos:</font></strong></p>
                <p align="center">
                  <select name="menu1" onChange="MM_jumpMenu('parent',this,0)" style="font-family:tahoma; font-size:11px">
                    <option selected="selected">Escolha a Categoria</option>
                    <option>----------------------</option>
                    <% while not categprincipal.eof
  %>
                    <option value="orcamento.asp?subcateg=<% =categprincipal("id")%>" <%if 1 + request("subcateg") - 1 = 1 + categprincipal("id") - 1 then response.write "SELECTED" end if%>>
                      <% =categprincipal("nome")%>
                      </option>
                    <%
  categprincipal.movenext
  wend
  %>
                  </select>
                </p></td>
            </tr>
          </table>
		  
		  <%
subcateg= request("subcateg")
if subcateg=""then

else
sql3="select * from categoria WHERE idsessao='"&subcateg&"' ORDER BY nome"
set subc=abredb.execute(sql3) 

%>
		 <br>
 <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td height="69" bgcolor="#CCCCCC"><p align="center"><strong><font size="2" face="Arial">Escolha a subcategoria dos produtos </font></strong></p>
                  <p align="center">
                    <select name="select" onChange="MM_jumpMenu('parent',this,0)" style="font-family:tahoma; font-size:11px">
                      <option selected="selected">Escolha a Categoria</option>
                      <option>----------------------</option>
                      <% while not subc.eof
  %>
                      <option value="orcamento.asp?subcateg=<% =subcateg %>&sessoes=<% =subc("idcategoria")%>" <%if 1 + request("sessoes") - 1 = 1 + subc("idcategoria") - 1 then response.write "SELECTED" end if%>>
                      <% =subc("nome")%>
                      </option>
                      <%
  subc.movenext
  wend
  %>
                    </select>
                </p></td>
            </tr>
          </table>
          <% end if %> 
          <p align="center" class="style10">
		  <% if subcateg = "" then %>
		 
          <p align="center" class="style10">&nbsp;</p>
          <p align="center" class="style10">Por favor, escolha uma categoria no menu acima.</p>
          <p align="center" class="style10">&nbsp;</p>
          <p align="center" class="style10">&nbsp;</p>
          <p align="center" class="style10"> </p>
		  <% else
categoria = request("subcateg")
sql3="select * from categoria WHERE idsessao='"&categoria&"' ORDER BY nome"
set nm=abredb.execute(sql3) 
if categoria="" then %>
<p align="center" class="style10">&nbsp;</p>
          <p align="center" class="style10">Por favor, escolha uma subcategoria no menu acima.</p>
          <p align="center" class="style10">&nbsp;</p>
          <p align="center" class="style10">&nbsp;</p>
          <p align="center" class="style10"> </p>
<% else
sql="select * from produtos WHERE idsessao='"&request("sessoes")&"'"
set rs=abredb.execute(sql)      


			if rs.eof or rs.bof then%>
            <strong>Desculpe, não foram encontrados produtos<br> 
              para 
              a categoria 
              <% =nm("nome")%>
            </strong><br>
              <br>
            Por favor, selecione outra categoria no menu acima. <br>
          </p>
          <p align="center" class="style10">&nbsp;</p>
          <p><span class="style10">
            <% else%>
          </span></p>
          <form method="POST" name="f1">
            <table width="405" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="405"><div align="center"></div></td>
              </tr>
            </table>
            <img src="images/topo_lista.gif" width="400" height="22">
            <% while not rs.eof
  %>
            <table border="0" width="90%">
                <tr>
                  <td  ><table WIDTH="100%" BORDER="0" CELLPADDING="2" CELLSPACING="0" BORDERCOLOR="#003399" style="font-family:tahoma; font-size:11px">
                      <tr>
                        <td width="9"  HEIGHT="18" valign="middle" bgcolor="#F4F4F4"><img src="produtos/<% =rs("impeq") %>" width="55" height="55"></td>
                        <td width="284" valign="top" bgcolor="#F4F4F4"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td style="font-size:11px"><strong><%=rs("Nome")%>
                                <input type="hidden" name="product" size="6" value="1">
                            </strong></td>
                          </tr>
                          <tr>
                            <td style="font-size:11px"><% abrevia(rs("detalhe")) %> </td>
                          </tr>
                        </table></td>
                        <td width="92" bgcolor="#F4F4F4"><div align="center"><strong>R$ <%=rs("preco")%></strong></div></td>
                        <td width="64" valign="middle" bgcolor="#F4F4F4"><div align="center"><a href="#"></a><a href="javascript:addtocart(<%=count%>,<%=rs("idprod")%>,<% =request("subcateg")%>, <% =request("sessoes")%> );"><img src="images/adicionar.gif" width="60" height="14" border="0"></a></div></td>
                      </tr>
                      <tr> </tr>
                  </table></td>
                </tr>
              </table>
              <%
  
 count=count+1
  rs.movenext
  wend
  %>
            </form>
          <form method="POST" action="submitshop.asp?choice=shop&subcateg=<% =request("subcateg")%>&sessoes=<% =request("sessoes")%>" name="f2">
		  
              <input type="hidden" name="total" size="20">
          </form></td>
      </tr>
    </table>
    <% end if %><% end if %><% end if %>
    <p align="center" class="style9">Direitos autorais reservados. Proibido reprodu&ccedil;&atilde;o parcial ou total. <br>
      Este or&ccedil;amento utiliza os produtos cadastrados na base de dados da loja virtual. <br>
    </p></td>
    <td width="1%" valign="top" background="images/divisa.gif">&nbsp;</td>
    <td width="50%" valign="top">

   <div class="k" align="center">
     <p align="left">
       <%
   
   if session("cart")<>"" then
   
   %>
       <img src="images/PRIMEIRAMARCACAO.gif" width="481" height="25"><br>
         <br>
     </p>
     </div>
   <p align="center" class="style2"><font size="4" face="Arial"><span class="style13">ponha um texto aqui ltda</span><br> 
     <br>
       <span class="style12">R. teste sala 4. Centro. S&auml;o Caetano do Sul. Tele-Vendas 31-3.118146</span><br>
     <br>
     Or&ccedil;amento Online Autom&aacute;tico </font></p>
   <form method=post name="f3">
<table class="k" border="0" width="97%" align=center>
    <tr>
      <td width="42%" bgcolor="#DBDBDB"><table style="font-size:11px" width="95%" border="0" align="right" cellpadding="0" cellspacing="0">
        <tr>
          <td><b>Itens</b></td>
        </tr>
      </table></td>
      <td width="17%" bgcolor="#DBDBDB"><table style="font-size:11px" width="93%" border="0" align="right" cellpadding="0" cellspacing="0">
        <tr>
          <td><b>Pre&ccedil;o</b></td>
        </tr>
      </table></td>
      <td width="17%" bgcolor="#DBDBDB"><table style="font-size:11px" width="95%" border="0" align="right" cellpadding="0" cellspacing="0">
        <tr>
          <td><b>Estoque</b></td>
        </tr>
      </table></td>
      <td width="19%" bgcolor="#DBDBDB"><table style="font-size:11px" width="95%" border="0" align="right" cellpadding="0" cellspacing="0">
        <tr>
          <td><b>Sub-Total</b></td>
        </tr>
      </table></td>
      <td width="5%" bgcolor="#CCCCCC">&nbsp;</td>
    </tr>
   
   <%
   
   cartprods=session("cart")
   
   cartitems=split(cartprods,"#")
   
   for i=1 to ubound(cartitems)
   
   eachcartitems=split(cartitems(i),",")
   
   sql="select * from Produtos where idprod=" & eachcartitems(0) &""
   set rs=abredb.execute(sql)
   
   %>
   
   
    <tr>
      <td width="42%" height="30" bgcolor="#F4F4F4"><table style="font-size:11px" width="97%" border="0" align="right" cellpadding="0" cellspacing="0">
        <tr>
          <td><%=rs("Nome")%></td>
        </tr>
      </table></td>
      <td width="17%" bgcolor="#F4F4F4"><table style="font-size:11px" width="95%" border="0" align="right" cellpadding="0" cellspacing="0">
        <tr>
		
			
          <td>R$ <% = rs("preco")%></td>
        </tr>
      </table></td>
      <td width="17%" bgcolor="#F4F4F4"><div align="center">
        <% estoque = rs("estoque") %>
        <% 
		  		if estoque = "s" then
				estoque = "Dispon&iacute;vel"
				elseif estoque = "n" then
				estoque = "Esgotado"
				end if
				response.write estoque %>
          </div>
      <table style="font-size:11px" width="95%" border="0" align="right" cellpadding="0" cellspacing="0">
    <tr>
      <td>        </td>
          </tr>
  </table></td><td width="19%" bgcolor="#F4F4F4">
        <table style="font-size:11px" width="95%" border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td>R$ 
              <% = rs("preco")%></td>
            <td>&nbsp;</td>
          </tr>
        </table>
        <p align="left"></td>
      <td width="5%" bgcolor="#CCCCCC"><div align="center"><a href="javascript:removecart('<%=eachcartitems(0)%>,<%=eachcartitems(1)%>');"><img src="images/delete.gif" width="16" height="15" border="0"></a></div></td>
    </tr>
    
  
  
  
   <%
   Total=Total+(rs("preco"))*eachcartitems(1)
   next
   total =formatnumber(total,2)
   %>
   
  <tr bgcolor="#00FFFF">
      <td height="30"  colspan="2" bgcolor="#DBDBDB">
        <p align="center" class="style3">Total do or&ccedil;amento para pre&ccedil;o &agrave; vista </td>
      <td colspan="3"  align="right" bgcolor="#333333">
        <p align="center" class="style4">R$ <%=Total%></td>
    </tr>
</table>
<p>&nbsp;</p>
<p align="left"><img src="images/SEGUNDAMARCACAO.gif" width="481" height="25"></p>
   </form>

   <div align="center" class="k"> 
     <a href="#" OnClick="javascript: print()"><img src="images/imprimir.gif" width="137" height="32" border="0"></a>
     <p><a href="orcamento.asp?ir=fechar">Terminou se or&ccedil;amento? Clique para fechar </a>
         <%
   end if 
  
  %>
        </p>
</div></td></tr></table>   

</body>

</html>
