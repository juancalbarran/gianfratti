<%

Email = Request.form("email") 
meu_email = "loja@loja.com.br"
Assunto = Request.form("assunto")

empresa = Request.form("empresa")
cnpj = Request.form("cnpj")
endereco = Request.form("endereco")
bairro = Request.form("bairro")

cidade = Request.form("cidade")
nome = Request.form("nome")
cargo = Request.form("cargo")
ddd1 = Request.form("ddd1")
telefone = Request.form("telefone")

ddd2 = Request.form("ddd2")
fax = Request.form("fax")
ddd3 = Request.form("ddd3")
celular = Request.form("celular")
lista1 = Request.form("lista1")

qt1 = Request.form("qt1")
lista2 = Request.form("lista2")
qt2 = Request.form("qt2")
lista3 = Request.form("lista3")
qt3 = Request.form("qt3")
data1 = Request.form("data1")

data2 = Request.form("data2")
mensagem = Request.form("mensagem")



corpo = "<b>Cotação Online</b>" & "<br>" & "<br>"

corpo = corpo & "----------------------------------------------------------------------" & "<br>"
corpo = corpo & "Os dados abaixo foram preenchidos para uma cotação de cestas." & "<br>"
corpo = corpo & "Nome:" & "&nbsp;&nbsp;" & "<b>" & Nome & "</b>" & "<br>"
corpo = corpo & "CNPJ/CPF:" & "&nbsp;&nbsp;" & "<b>" & cnpj & "</b>" & "<br>"
corpo = corpo & "Empresa:" & "&nbsp;&nbsp;" & "<b>" & empresa & "</b>" & "<br>"
corpo = corpo & "Cargo:" & "&nbsp;&nbsp;" & "<b>" & cargo & "</b>" & "<br>"
corpo = corpo & "Email:" & "&nbsp;&nbsp;" & "<b>" & Email & "</b>" & "<br>"
corpo = corpo & "----------------------------------------------------------------------" & "<br>" & "<br>"

corpo = corpo & "----------------------------------------------------------------------" & "<br>"
corpo = corpo & "Endereço:" & "&nbsp;&nbsp;" & "<b>" & endereco & "</b>" & "<br>"
corpo = corpo & "Bairro:" & "&nbsp;&nbsp;" & "<b>" & bairro & "</b>" & "<br>"
corpo = corpo & "Cidade:" & "&nbsp;&nbsp;" & "<b>" & cidade & "</b>" & "<br>"
corpo = corpo & "Telefone:" & "&nbsp;&nbsp;" & "<b>" & ddd1 & "&nbsp;" & "-" & telefone & "</b>" & "<br>"
corpo = corpo & "Fax:" & "&nbsp;&nbsp;" & "<b>" & ddd2 & "&nbsp;" & "-" & fax & "</b>" & "<br>"
corpo = corpo & "Celular:" & "&nbsp;&nbsp;" & "<b>" & ddd3 & "&nbsp;" & "-" & celular & "</b>" & "<br>"
corpo = corpo & "----------------------------------------------------------------------" & "<br>" & "<br>"

corpo = corpo & "----------------------------------------------------------------------" & "<br>"
corpo = corpo & "Opção de cesta 01:" & "&nbsp;&nbsp;" & "<b>" & lista1 & "</b>" & "&nbsp;&nbsp;" & "Quantidade:" & "&nbsp;&nbsp;" & "<b>" & qt1 & "</b>" & "<br>"
corpo = corpo & "Opção de cesta 01:" & "&nbsp;&nbsp;" & "<b>" & lista2 & "</b>" & "&nbsp;&nbsp;" & "Quantidade:" & "&nbsp;&nbsp;" & "<b>" & qt2 & "</b>" & "<br>"
corpo = corpo & "Opção de cesta 01:" & "&nbsp;&nbsp;" & "<b>" & lista3 & "</b>" & "&nbsp;&nbsp;" & "Quantidade:" & "&nbsp;&nbsp;" & "<b>" & qt3 & "</b>" & "<br>"
corpo = corpo & "----------------------------------------------------------------------" & "<br>" & "<br>"

corpo = corpo & "----------------------------------------------------------------------" & "<br>"
corpo = corpo & "Data do Fechamento" & "&nbsp;&nbsp;" & "<b>" & data1 & "</b>" & "<br>"
corpo = corpo & "Data da Entrega" & "&nbsp;&nbsp;" & "<b>" & data2 & "</b>" & "<br>"
corpo = corpo & "Observações:" & "&nbsp;&nbsp;" & "<b>" & mensagem & "</b>" & "<br>"
corpo = corpo & "----------------------------------------------------------------------" & "<br>" & "<br>"

corpo = corpo & "Programador Cleverson Fabiano" & "<br>" & "<br>"


Set iMail = CreateObject("CDONTS.NewMail")
iMail.From = email
iMail.To = meu_email
iMail.Subject = Assunto
iMail.MailFormat = 0
iMail.BodyFormat = 0
iMail.Body = corpo
iMail.Send

Response.Redirect("cotacaocesta.asp?acao=1")
Set iMail = nothing
%> 