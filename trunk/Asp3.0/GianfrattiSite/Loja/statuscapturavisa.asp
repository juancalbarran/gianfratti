<%
'#########################################################################################
'#----------------------------------------------------------------------------------------
'#########################################################################################
'#
'#########################################################################################
'# Criado por: Cirilo Jose Veloso - http://www.veloso.adm.br                                                       #
'# Objetivo  : Mostrar status da captura  (QUANDO REALIZAR A CAPTURA ELETRONICAMENTE)    #
'#             0 = Capturado com sucesso                                                 #
'#             1 = Autorização negada                                                    #
'#             2 = Falha na captura, informação inconsistente                            #
'#             3 = Captura já efetuada                                                   #    
'# Observ.   : A captura é a confirmação da venda, o estabelecimento tem 5 dias para     #
'#             realizar esta captura.  Pode ser feita no site da Visanet ou um página    #
'#             construído pelo estabelecimento, neste caso será usada esta página para   #
'#             verificar a efetivação da captura.
'#                                                                                       # 
'#----------------------------------------------------------------------------------------
'#########################################################################################

'INÍCIO DO CÓDIGO
'----------------------------------------------------------------------------------------------------------------
'Este código está otimizado e roda tanto em Windows 2000/NT/XP/ME/98 quanto em servidores UNIX-LINUX com chilli!ASP
%>
<!-- #include file="topo.asp" -->
<table>
 <tr><td align="left" valign="top">
   <table border="0" cellspacing="4" cellpadding="4" width=590>
     <tr><td><font face="<%=fonte%>" style=font-size:11px;color:000000> <a href=default.asp style=text-decoration:none; onMouseOut="window.status='';return true;" onMouseOver="window.status='Home';return true;"><b>Home</b></a> » Status da Captura<br><br><div align=left>
       <table border=0 cellspacing=0 width=100% cellpadding=0>
         <tr><td height=5></td></tr>
         <tr><td height=1 bgcolor=<%=cor3%>></td></tr>
         <tr><td height=5></td></tr>
       </table>
       </div>
    <font face="<%=fonte%>" style=font-size:18px><strong>Status da Captura do cart&atilde;o de cr&eacute;dito.</strong></font><br><br>
    <div align=center>
<!--CONTEUDO-->
            <table width="105%" height="308">
              <tr> 
                <td height="320"> 
                   <h3>Resposta da Captura</h3>
<p><b>TransactionID=</b><%=request.form("tid")%><br>
  <b>Cod.:=</b><%=request.form("cod")%> 
   <br>
  <b>Ars=</b><%=request.form("ars")%><br>
  <b>Cap=</b> 
  <%if request.form("cod") > 99 then
   response.write("Não disponível")
  else
   response.write(request.form("cap"))
end if%>
</p>
                </td>
              </tr>
            </table>
<br>
<br>
<br>
<!--FIM DO CONTEUDO-->
       <table border=0 cellspacing=0 width=100% cellpadding=0>
         <tr><td height=5></td></tr>
         <tr><td height=1 bgcolor=<%=cor3%>></td></tr>
         <tr><td height=5></td></tr>
       </table>
       <A HREF="javascript:history.back();" style=text-decoration:none onMouseOut="window.status='';return true;" onMouseOver="window.status='Voltar';return true;"><font face="<%=fonte%>" style=font-size:11px>:: <b>Voltar</b> ::</font></A></div></ul></td></tr>
   </table></td></tr>
</table>
<!-- #include file="baixo.asp" -->