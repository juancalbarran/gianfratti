<!--#include file="../include/admentor2.asp"-->
<!--#include file="../include/admentorsecurity.asp"-->
<!--#include file="menu.inc"-->
<html>

<head>
<%
'''''''''''  (C) Stefan Holmberg 1999  
'''''''''''  Free to use if these sourcecode lines is not deleted 
'''''''''''  Contact me at webmaster@sqlexperts.com
'''''''''''  http://www.sqlexperts.com
'''''''''''  AdMentor homepage at http://www.create-a-webshop.com

'    Set oConn = AdMentor_DBOpenConnection2("0")
    
%>


<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>AdMentor - Admin interface</title>
<style type="text/css">
<!--
     body {  font-family: Arial, Geneva, Helvetica, Verdana; font-size: smaller; color: #000000}
     td {  font-family: Arial, Geneva, Helvetica, Verdana; font-size: smaller; color: #000000}
     th {  font-family: Arial, Geneva, Helvetica, Verdana; font-size: smaller; color: #000000}
     A:link {text-decoration: none;}
     A:visited {text-decoration: none;}
     A:hover {text-decoration: underline;}
-->
</style>
</head>

<body>

<table align="center" bgColor="#003399" border="0" cellPadding="3" cellSpacing="0" height="100%" width="100%">
  <tbody>
    <tr>
      <td vAlign="top" width="50%" height="60">
      <img src="../images/administration.gif" border="0">
      </td>
      <td vAlign="top" width="468" height="60">
      <b><font color="#FFFFFF" face="verdana,arial,helvetica" size="+2">Administração</font></b>
      <table border="0" width="100%">
        <tr>
                            <td width="50%">
                            </td>
        </tr>
      </table>
      </td>
    </tr>
    <tr>
      <td height="100%" vAlign="top" width="100%" colspan="2">
        <table align="center" bgColor="#ffffff" border="0" cellPadding="0" cellSpacing="0" height="100%" width="100%">
          <tbody>
            <tr>
              <td height="100%" vAlign="top" width="85%">
                <table bgColor="#ffffff" border="0" cellPadding="10" cellSpacing="0" height="100%" width="100%">
                  <tbody>
                    <tr>
                      <td align="left" height="100%" vAlign="top" width="65%">
                        <table border="0" width="100%">
                          <tr>
                            <td width="50%"><b><font color="#aa3333" face="verdana,arial,helvetica" size="4">Bem
                              vindo <%=Session("fullname")%></font></b>
                             
                            </td>
                            <td width="50%">
<%=GetAdminPagesBannerCode()%>
                            </td>
                          </tr>
                        </table>
                        <font color="#aa3333" face="verdana,arial,helvetica" size="+2">
                        <hr color="#000066" noShade SIZE="1">
                             
                        </font>
                             
                        <table border="0" width="100%">
                          <tr>
                            <td width="120" valign="top">
                              <%AdAdminWriteMenu%></td>
                            <td width="70%">
                             
                        <ul>
                          <li><font face="helvetica, arial" size="2"><i><b>Minha
                            Conta<br>
                            </b></i>Nesta página você pode alterar sua senha,
                            e-mail, etc.</font></li>
<% If Session("admin") = True Then %>                           
                          <li><font face="helvetica, arial" size="2"><b><i>Administração
                            de Anunciantes</i></b></font><font face="helvetica, arial" size="2"><b><i><br>
                            </i></b>Nesta página você pode adicionar,
                            modificar e excluir contas de anunciantes.</font></li>
                          <li><font face="helvetica, arial" size="2"><b><i>Banners/campanhas<br>
                            </i></b>Nesta pagina você pode adicionar, modificar
                            ou excluir campanha e banners.</font></li>
                          <li><font face="helvetica, arial" size="2"><b><i>Tipos<br>
                            </i></b>Nesta página você pode adicionar,
                            modificar ou excluir tipos de banners.(em relação
                            a tamanhos).</font>
                            </li>
                          <li><font face="helvetica, arial" size="2"><b><i>Categoria<br>
                            </i></b>Nesta página você pode adicionar,
                            modificar ou excluir categorias de banners.</font>
                            </li>
                          <li><font face="helvetica, arial" size="2"><i><b>Gerar
                            código HTML<br>
                            </b></i>Gerar o código ASP ou HTML que você
                            precisa para inserir nas páginas para exibição.</font>
                            </li>
<% End If %>                           
                          <li><font face="helvetica, arial" size="2"><b><i>Conferir
                            Estatísticas<br>
                            </i></b>Vefirique os cliques no banner ou no texto
                            em sua conta.</font>
                            </li>
                          <li><font face="helvetica, arial" size="2"><b><i>Log Out<br>
                            </i></b>Efetuar o log out de seu sistema.</font>
                            </li>
<% If Session("admin") = True Then %>                           
                          <li><font face="helvetica, arial" size="2"><b><i>Suporte
                            AdMentor&nbsp;<br>
                            </i></b>Link pra a pagina da Admentor.</font>
                            </li>
                          </ul>
<% End If %>                           
                             
                        <p><font face="helvetica, arial" size="2">AdMentor foi
                        desenvolvida por <a href="mailto:webmaster@sqlexperts.com">Stefan
                        Holmberg</a>. Uso totalmente gratuito.<br>
                        Foi traduzida por <a href="mailto:marquinho@tpnet.psi.br">Marco
                        Antonio Amancio</a></font></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </td>
            </tr>
          </tbody>
        </table>
      </td>
    </tr>
  </tbody>
</table>

</body>

</html>
