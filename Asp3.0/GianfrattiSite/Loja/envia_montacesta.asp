<%

Email = Request.form("email") 
meu_email = "loja@loja.com.br"
Assunto = Request.form("assunto")

empresa = Request.form("empresa")
cnpj = Request.form("cnpj")
endereco = Request.form("endereco")
bairro = Request.form("bairro")
complemento = Request.form("complemento")

cidade = Request.form("cidade")
nome = Request.form("nome")
cargo = Request.form("cargo")
ddd1 = Request.form("ddd1")
telefone = Request.form("fone")

ddd2 = Request.form("ddd2")
fax = Request.form("fax")
ddd3 = Request.form("ddd3")
celular = Request.form("celular")
qtcesta = Request.form("qtcesta")

mensagem = Request.form("mensagem")

qt1 = Request.form("qt1")
qt2 = Request.form("qt2")
qt3 = Request.form("qt3")
qt4 = Request.form("qt4")
qt5 = Request.form("qt5")
qt6 = Request.form("qt6")
qt7 = Request.form("qt7")
'qt8 = Request.form("qt8")
qt9 = Request.form("qt9")
qt10 = Request.form("qt10")
qt11 = Request.form("qt11")
qt12 = Request.form("qt12")
qt13 = Request.form("qt13")
qt14 = Request.form("qt14")
qt15 = Request.form("qt15")
qt16 = Request.form("qt16")
qt17 = Request.form("qt17")
qt18 = Request.form("qt18")
qt19 = Request.form("qt19")
qt20 = Request.form("qt20")
qt21 = Request.form("qt21")
qt22 = Request.form("qt22")
qt23 = Request.form("qt23")
qt24 = Request.form("qt24")
qt25 = Request.form("qt25")
qt26 = Request.form("qt26")
qt27 = Request.form("qt27")
'qt28 = Request.form("qt28")
qt29 = Request.form("qt29")
qt30 = Request.form("qt30")
qt31 = Request.form("qt31")
qt32 = Request.form("qt32")
'qt33 = Request.form("qt33")
qt34 = Request.form("qt34")
qt35 = Request.form("qt35")
qt36 = Request.form("qt26")
qt37 = Request.form("qt37")
qt38 = Request.form("qt38")
qt39 = Request.form("qt39")
qt40 = Request.form("qt40")
qt41 = Request.form("qt41")
qt42 = Request.form("qt42")
qt43 = Request.form("qt43")
qt44 = Request.form("qt44")
qt45 = Request.form("qt45")

marca1 = Request.form("marca1")
marca2 = Request.form("marca2")
marca3 = Request.form("marca3")
marca4 = Request.form("marca4")
marca5 = Request.form("marca5")
marca6 = Request.form("marca6")
marca7 = Request.form("marca7")
'marca8 = Request.form("marca8")
marca9 = Request.form("marca9")
marca10 = Request.form("marca10")
marca11 = Request.form("marca11")
marca12 = Request.form("marca12")
marca13 = Request.form("marca13")
marca14 = Request.form("marca14")
marca15 = Request.form("marca15")
marca16 = Request.form("marca16")
marca17 = Request.form("marca17")
marca18 = Request.form("marca18")
marca19 = Request.form("marca19")
marca20 = Request.form("marca20")
marca21 = Request.form("marca21")
marca22 = Request.form("marca22")
marca23 = Request.form("marca23")
marca24 = Request.form("marca24")
marca25 = Request.form("marca25")
marca26 = Request.form("marca26")
marca27 = Request.form("marca27")
'marca28 = Request.form("marca28")
marca29 = Request.form("marca29")
marca30 = Request.form("marca30")
marca31 = Request.form("marca31")
marca32 = Request.form("marca32")
'marca33 = Request.form("marca33")
marca34 = Request.form("marca34")
marca35 = Request.form("marca35")
marca36 = Request.form("marca36")
marca37 = Request.form("marca37")
marca38 = Request.form("marca38")
marca39 = Request.form("marca39")
marca40 = Request.form("marca40")
marca41 = Request.form("marca41")
marca42 = Request.form("marca42")
marca43 = Request.form("marca43")
marca44 = Request.form("marca44")
marca45 = Request.form("marca45")

outro1 = Request.form("outro1")
outro2 = Request.form("outro2")
outro3 = Request.form("outro3")
outro4 = Request.form("outro4")
outro5 = Request.form("outro5")
outro6 = Request.form("outro6")
outro7 = Request.form("outro7")
'outro8 = Request.form("outro8")
outro9 = Request.form("outro9")
outro10 = Request.form("outro10")
outro11 = Request.form("outro11")
outro12 = Request.form("outro12")
outro13 = Request.form("outro13")
outro14 = Request.form("outro14")
outro15 = Request.form("outro15")
outro16 = Request.form("outro16")
outro17 = Request.form("outro17")
outro18 = Request.form("outro18")
outro19 = Request.form("outro19")
outro20 = Request.form("outro20")
outro21 = Request.form("outro21")
outro22 = Request.form("outro22")
outro23 = Request.form("outro23")
outro24 = Request.form("outro24")
outro25 = Request.form("outro25")
outro26 = Request.form("outro26")
outro27 = Request.form("outro27")
'outro28 = Request.form("outro28")
outro29 = Request.form("outro29")
outro30 = Request.form("outro30")
outro31 = Request.form("outro31")
outro32 = Request.form("outro32")
'outro33 = Request.form("outro33")
outro34 = Request.form("outro34")
outro35 = Request.form("outro35")
outro36 = Request.form("outro36")
outro37 = Request.form("outro37")
outro38 = Request.form("outro38")
outro39 = Request.form("outro39")
outro40 = Request.form("outro40")
outro41 = Request.form("outro41")
outro42 = Request.form("outro42")
outro43 = Request.form("outro43")
outro44 = Request.form("outro44")
outro45 = Request.form("outro45")





corpo = "<b>Cotação Online</b>" & "<br>" & "<br>"

corpo = corpo & "----------------------------------------------------------------------" & "<br>"
corpo = corpo & "Os dados abaixo foram preenchidos para uma cotação de cesta." & "<br>"
corpo = corpo & "Nome:" & "&nbsp;&nbsp;" & "<b>" & Nome & "</b>" & "<br>"
corpo = corpo & "CNPJ/CPF:" & "&nbsp;&nbsp;" & "<b>" & cnpj & "</b>" & "<br>"
corpo = corpo & "Empresa:" & "&nbsp;&nbsp;" & "<b>" & empresa & "</b>" & "<br>"
corpo = corpo & "Cargo:" & "&nbsp;&nbsp;" & "<b>" & cargo & "</b>" & "<br>"
corpo = corpo & "Email:" & "&nbsp;&nbsp;" & "<b>" & Email & "</b>" & "<br>"
corpo = corpo & "----------------------------------------------------------------------" & "<br>" & "<br>"

corpo = corpo & "----------------------------------------------------------------------" & "<br>"
corpo = corpo & "Endereço:" & "&nbsp;&nbsp;" & "<b>" & endereco & "</b>" & "<br>"
corpo = corpo & "Bairro:" & "&nbsp;&nbsp;" & "<b>" & bairro & "</b>" & "<br>"
corpo = corpo & "Complemento:" & "&nbsp;&nbsp;" & "<b>" & complemento & "</b>" & "<br>"
corpo = corpo & "Cidade:" & "&nbsp;&nbsp;" & "<b>" & cidade & "</b>" & "<br>"
corpo = corpo & "Telefone:" & "&nbsp;&nbsp;" & "<b>" & ddd1 & "&nbsp;" & "-" & "&nbsp;" & telefone & "</b>" & "<br>"
corpo = corpo & "Fax:" & "&nbsp;&nbsp;" & "<b>" & ddd2 & "&nbsp;" & "-" & "&nbsp;" & fax & "</b>" & "<br>"
corpo = corpo & "Celular:" & "&nbsp;&nbsp;" & "<b>" & ddd3 & "&nbsp;" & "-" & "&nbsp;" & celular & "</b>" & "<br>"
corpo = corpo & "----------------------------------------------------------------------" & "<br>" & "<br>"

corpo = corpo & "----------------------------------------------------------------------" & "<br>"
corpo = corpo & "Observação:" & "&nbsp;&nbsp;" & "<b>" & mensagem & "</b>" & "<br>"
corpo = corpo & "----------------------------------------------------------------------" & "<br>" & "<br>"

corpo = corpo & "----------------------------------------------------------------------" & "<br>"
corpo = corpo & "Quantidade de Cestas:" & "&nbsp;&nbsp;" & "<b>" & qtcesta & "</b>" & "<br>"
corpo = corpo & "----------------------------------------------------------------------" & "<br>" & "<br>"


corpo = corpo & "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>"
corpo = corpo & "<html xmlns='http://www.w3.org/1999/xhtml'>"
corpo = corpo & "<head>"
corpo = corpo & "<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1' />"
corpo = corpo & "<title></title>"
corpo = corpo & "</head>"

corpo = corpo & "<body>"
corpo = corpo & "<table class='menuesq' cellspacing='2' cellpadding='2' width='700' border='2'>"
corpo = corpo &  "<tbody>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td width='60' bgcolor='#341c88'><div align='center'><strong><font color='#ffffff'>QTD.</font>"
corpo = corpo & "</strong></div>"
corpo = corpo & "</td>"
corpo = corpo &      "<td bgcolor='#341c88'><font color='#ffffff'><strong>PRODUTO</strong></font></td>"
corpo = corpo &      "<td width='240' bgcolor='#341c88'><strong><font color='#ffffff'>MARCA</font></strong></td>"
corpo = corpo &      "<td align='middle' width='240' bgcolor='#341c88'><strong><font color='#ffffff'>OUTRA </font></strong></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" &qt1& "</div></td>"
corpo = corpo &      "<td width='239'>Açúcar refinado - 1kg</td>"
corpo = corpo &      "<td align=middle'><div align='left'>" & marca1 & "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & outro1 & "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align=middle height=30><div align=center>" & qt44 & "</div></td>"
corpo = corpo &      "<td>Açucar Cristal - 5kg </td>"
corpo = corpo &      "<td align=middle><div align=left>" & marca44 & "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & outro44 & "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align=middle height=30><div align=center>" & qt45 & "</div></td>"
corpo = corpo &      "<td>Açucar Cristal - 2kg </td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &marca45& "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro45& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" &qt2& "</div></td>"
corpo = corpo &     "<td>Achocolatado - 200g</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & marca2 & "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro2& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" & qt3 & "</div></td>"
corpo = corpo &      "<td>Achocolatado - 400g</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & marca3 & "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & outro3 & "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &     "<td align='middle' height='30'><div align='center'>" & qt4 & "</div></td>"
corpo = corpo &    "<td>Arroz Agulhinha Tipo 1 - 5kg</td>"
corpo = corpo &    "<td align='middle'><div align='left'>" & marca4& "</div></td>"
corpo = corpo &    "<td align='middle'><div align='left'>" &outro4& "</div></td>"
corpo = corpo &   "</tr>"
corpo = corpo &   "<tr>"
corpo = corpo &   "<td align='middle' height='30'><div align='center'>" &qt5& "</div></td>"
corpo = corpo &   "<td>Arroz Agulhinha Tipo 2 - 5kg</td>"
corpo = corpo &   "<td align='middle'><div align='left'>" &marca5& "</div></td>"
corpo = corpo &   "<td align='middle'><div align='left'>" &outro5& "</div></td>"
corpo = corpo &   "</tr>"
corpo = corpo &   "<tr>"
corpo = corpo &   "<td align='middle' height='30'><div align='center'>" &qt6& "</div></td>"
corpo = corpo &   "<td>Arroz Agulhinha Tipo 1 - 1kg</td>"
corpo = corpo &   "<td align='middle'><div align='left'>" &marca6& "</div></td>"
corpo = corpo &   "<td align='middle'><div align='left'>" &outro6& "</div></td>"
corpo = corpo &   "</tr>"
corpo = corpo &   "<tr>"
corpo = corpo & "<td align='middle' height='30'><div align='enter'>" &qt7& "</div></td>"
corpo = corpo &  "<td>Azeitonas Verdes - 100g</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &marca7& "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro7& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" &qt9& "</div></td>"
corpo = corpo &      "<td>Biscoito Doce - 150g</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &marca9& "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro9& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" &qt10& "</div></td>"
corpo = corpo &      "<td>Biscoito Maizena - 200g</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &marca10& "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro10& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align=middle height=30><div align=center>" & qt11 & "</div></td>"
corpo = corpo &      "<td>Biscoito Recheado - 180g </td>"
corpo = corpo &      "<td align=middle><div align=left>" & marca11 & "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & outro11 & "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align=middle height=30><div align=center>" & qt12 & "</div></td>"
corpo = corpo &      "<td>Biscoito Salgado - 200g </td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &marca12& "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro12& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" &qt13& "</div></td>"
corpo = corpo &     "<td>Café Torrado - 250g</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & marca13 & "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro13& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" & qt14 & "</div></td>"
corpo = corpo &      "<td>Café Torrado - 500g</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & marca14 & "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & outro14 & "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &     "<td align='middle' height='30'><div align='center'>" & qt15 & "</div></td>"
corpo = corpo &    "<td>Creme Dental - 50g</td>"
corpo = corpo &    "<td align='middle'><div align='left'>" & marca15& "</div></td>"
corpo = corpo &    "<td align='middle'><div align='left'>" &outro15& "</div></td>"
corpo = corpo &   "</tr>"
corpo = corpo &   "<tr>"
corpo = corpo &   "<td align='middle' height='30'><div align='center'>" &qt16& "</div></td>"
corpo = corpo &   "<td>Extrato de Tomate - 140g</td>"
corpo = corpo &   "<td align='middle'><div align='left'>" &marca16& "</div></td>"
corpo = corpo &   "<td align='middle'><div align='left'>" &outro16& "</div></td>"
corpo = corpo &   "</tr>"
corpo = corpo &   "<tr>"
corpo = corpo &   "<td align='middle' height='30'><div align='center'>" &qt17& "</div></td>"
corpo = corpo &   "<td>Farinha de Mandioca - 500g</td>"
corpo = corpo &   "<td align='middle'><div align='left'>" &marca17& "</div></td>"
corpo = corpo &   "<td align='middle'><div align='left'>" &outro17& "</div></td>"
corpo = corpo &   "</tr>"
corpo = corpo &   "<tr>"
corpo = corpo & "<td align='middle' height='30'><div align='enter'>" &qt18& "</div></td>"
corpo = corpo &  "<td>Farinha de Trigo Especial - 1kg</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &marca18& "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro18& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" &qt19& "</div></td>"
corpo = corpo &      "<td>Feijão Carioca - 1kg</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &marca19& "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro19& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" &qt20& "</div></td>"
corpo = corpo &      "<td>Farinha de Milho - 1kg</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &marca20& "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro20& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"      
corpo = corpo &      "<td align=middle height=30><div align=center>" & qt21 & "</div></td>"
corpo = corpo &      "<td>Fubá Mimoso - 500g </td>"
corpo = corpo &      "<td align=middle><div align=left>" & marca21 & "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & outro21 & "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align=middle height=30><div align=center>" & qt22 & "</div></td>"
corpo = corpo &      "<td>Pó para gelatina - 85g </td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &marca22& "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro22& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" &qt23& "</div></td>"
corpo = corpo &     "<td>Goiabada - 500g</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & marca23 & "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro23& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" & qt24 & "</div></td>"
corpo = corpo &      "<td>Lã de aço - 8 unidades</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & marca24 & "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & outro24 & "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &     "<td align='middle' height='30'><div align='center'>" & qt25 & "</div></td>"
corpo = corpo &    "<td>Leite Condensado - 395g</td>"
corpo = corpo &    "<td align='middle'><div align='left'>" & marca25& "</div></td>"
corpo = corpo &    "<td align='middle'><div align='left'>" &outro25& "</div></td>"
corpo = corpo &   "</tr>"
corpo = corpo &   "<tr>"
corpo = corpo &   "<td align='middle' height='30'><div align='center'>" &qt26& "</div></td>"
corpo = corpo &   "<td>Leite em Pó Integral - 400g</td>"
corpo = corpo &   "<td align='middle'><div align='left'>" &marca26& "</div></td>"
corpo = corpo &   "<td align='middle'><div align='left'>" &outro26& "</div></td>"
corpo = corpo &   "</tr>"
corpo = corpo &   "<tr>"
corpo = corpo &   "<td align='middle' height='30'><div align='center'>" &qt27& "</div></td>"
corpo = corpo &   "<td>Leite em Pó Modificado - 400g</td>"
corpo = corpo &   "<td align='middle'><div align='left'>" &marca27& "</div></td>"
corpo = corpo &   "<td align='middle'><div align='left'>" &outro27& "</div></td>"
corpo = corpo &   "</tr>"
corpo = corpo &   "<tr>"
corpo = corpo & "<td align='middle' height='30'><div align='enter'>" &qt29& "</div></td>"
corpo = corpo &  "<td>Macarrão Espagueti - 500g</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &marca29& "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro29& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" &qt30& "</div></td>"
corpo = corpo &      "<td>Macarrão Parafuso - 500g</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &marca30& "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro30& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" &qt31& "</div></td>"
corpo = corpo &      "<td>Milho Verde em Conserva - 200g</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &marca31& "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro31& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align=middle height=30><div align=center>" & qt32 & "</div></td>"
corpo = corpo &      "<td>Mistura para Bolo - 450g </td>"
corpo = corpo &      "<td align=middle><div align=left>" & marca32 & "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & outro32 & "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" &qt34& "</div></td>"
corpo = corpo &     "<td>Óleo de Soja Refinado - 900ml</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & marca34 & "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro34& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" &qt35& "</div></td>"
corpo = corpo &     "<td>Papel Higiênico Branco - 4 unid</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & marca35 & "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro35& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" & qt36 & "</div></td>"
corpo = corpo &      "<td>Polpa de Tomate - 520g</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & marca36 & "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" & outro36 & "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &     "<td align='middle' height='30'><div align='center'>" & qt37 & "</div></td>"
corpo = corpo &    "<td>Purê de Tomate - 340g</td>"
corpo = corpo &    "<td align='middle'><div align='left'>" & marca37& "</div></td>"
corpo = corpo &    "<td align='middle'><div align='left'>" &outro37& "</div></td>"
corpo = corpo &   "</tr>"
corpo = corpo &   "<tr>"
corpo = corpo &   "<td align='middle' height='30'><div align='center'>" &qt38& "</div></td>"
corpo = corpo &   "<td>Sabão em Pedra 5 pedaços - 1kg </td>"
corpo = corpo &   "<td align='middle'><div align='left'>" &marca38& "</div></td>"
corpo = corpo &   "<td align='middle'><div align='left'>" &outro38& "</div></td>"
corpo = corpo &   "</tr>"
corpo = corpo &   "<tr>"
corpo = corpo &   "<td align='middle' height='30'><div align='center'>" &qt39& "</div></td>"
corpo = corpo &   "<td>Sabonete - 90g</td>"
corpo = corpo &   "<td align='middle'><div align='left'>" &marca39& "</div></td>"
corpo = corpo &   "<td align='middle'><div align='left'>" &outro39& "</div></td>"
corpo = corpo &   "</tr>"
corpo = corpo &   "<tr>"
corpo = corpo & "<td align='middle' height='30'><div align='enter'>" &qt40& "</div></td>"
corpo = corpo &  "<td>Sal Refinado - 1kg</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &marca40& "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro40& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" &qt41& "</div></td>"
corpo = corpo &      "<td>Salsicha em Conserva - 180g</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &marca41& "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro41& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" &qt42& "</div></td>"
corpo = corpo &      "<td>Sardinha em Conserva - 130g</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &marca42& "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro42& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"  	  
corpo = corpo &      "<td align='middle' height='30'><div align='center'>" &qt43& "</div></td>"
corpo = corpo &      "<td>Tempero Completo - 300g</td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &marca43& "</div></td>"
corpo = corpo &      "<td align='middle'><div align='left'>" &outro43& "</div></td>"
corpo = corpo &    "</tr>"
corpo = corpo &    "<tr>"  	  
corpo = corpo &	   "<tr>"
corpo = corpo&     "</tbody>"
corpo = corpo&     "</table>"
corpo = corpo&     "</body>"
corpo = corpo&      "</html>"
corpo = corpo&      "<br>"
corpo = corpo&      "<br>"

corpo = corpo & "Programador Cleverson Fabiano" & "<br>" & "<br>"

Set iMail = CreateObject("CDONTS.NewMail")
iMail.From = email
iMail.To = meu_email
iMail.Subject = Assunto
iMail.MailFormat = 0
iMail.BodyFormat = 0
iMail.Body = corpo
iMail.Send

Response.Redirect("montacesta.asp?acao=1")
Set iMail = nothing
%> 