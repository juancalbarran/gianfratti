<%
'#########################################################################################
'#----------------------------------------------------------------------------------------
'#########################################################################################
'#
'#  CÓDIGO: VirtuaStore Versão OPEN - Copyright 2001-2004 VirtuaStore
'#  URL: http://comunidade.virtuastore.com.br
'#  E-MAIL: comunidade@virtuastore.com.br
'#  AUTORES: Otávio Dias(Desenvolvedor)
'# 
'#     Este programa é um software livre; você pode redistribuí-lo e/ou 
'#     modificá-lo sob os termos do GNU General Public License como 
'#     publicado pela Free Software Foundation.
'#     É importante lembrar que qualquer alteração feita no programa 
'#     deve ser informada e enviada para os criadores, através de e-mail 
'#     ou da página de onde foi baixado o código.
'#
'#  //-------------------------------------------------------------------------------------
'#  // LEIA COM ATENÇÃO: O software VirtuaStore OPEN deve conter as frases
'#  // "Powered by VirtuaStore OPEN" ou "Software derivado de VirtuaStore 1.2" e 
'#  // o link para o site http://comunidade.virtuastore.com.br no créditos da 
'#  // sua loja virtual para ser utilizado gratuitamente. Se o link e/ou uma das 
'#  // frases não estiver presentes ou visiveis este software deixará de ser
'#  // considerado Open-source(gratuito) e o uso sem autorização terá 
'#  // penalidades judiciais de acordo com as leis de pirataria de software.
'#  //--------------------------------------------------------------------------------------
'#      
'#     Este programa é distribuído com a esperança de que lhe seja útil,
'#     porém SEM NENHUMA GARANTIA. Veja a GNU General Public License
'#     abaixo (GNU Licença Pública Geral) para mais detalhes.
'# 
'#     Você deve receber a cópia da Licença GNU com este programa, 
'#     caso contrário escreva para
'#     Free Software Foundation, Inc., 59 Temple Place, Suite 330, 
'#     Boston, MA  02111-1307  USA
'# 
'#     Para enviar suas dúvidas, sugestões e/ou contratar a VirtuaWorks 
'#     Internet Design entre em contato através do e-mail 
'#     contato@virtuaworks.com.br ou pelo endereço abaixo: 
'#     Rua Venâncio Aires, 1001 - Niterói - Canoas - RS - Brasil. Cep 92110-000.
'#
'#     Para ajuda e suporte acesse um dos sites abaixo:
'#     http://comunidade.virtuastore.com.br
'#     http://br.groups.yahoo.com/group/virtuastore
'#
'#     BOM PROVEITO!          
'#     Equipe VirtuaStore
'#     []'s
'#
'#########################################################################################
'#----------------------------------------------------------------------------------------
'#########################################################################################

'INÍCIO DO CÓDIGO---------------------
'Este código está otimizado e roda tanto em Windows 2000/NT/XP/ME/98 quanto em servidores UNIX-LINUX com chilli!ASP

'======================================
' ARQUIVO COM AS STRINGS PARA DEFINIÇÃO DA LINGUAGEM
' Português (BR) - LCID 1046
' Pais : Brasil
' HTML Content-Type : ISO-8859-1 
' Traduzido por : Otávio Dias (otavio@virtuaworks.com.br ) 20/08/2002 
' Acréscimos/Correções por : Elizeu Alcantara (elizeu@cristaosite.com.br / elizeu@onda.com.br ) 15/03/2004 
'======================================


nomeloja = application("nomeloja")

strLgDataS1 = "Jan"            													'Nome dos meses abreviados
strLgDataS2 = "Fev"
strLgDataS3 = "Mar"
strLgDataS4 = "Abr"
strLgDataS5 = "Mai"
strLgDataS6 = "Jun"
strLgDataS7 = "Jul"
strLgDataS8 = "Ago"
strLgDataS9 = "Set"
strLgDataS10 = "Out"
strLgDataS11 = "Nov"
strLgDataS12 = "Dez"

strLgData1 = "Janeiro"														 'Nome dos meses completos
strLgData2 = "Fevereiro"
strLgData3 = "Março"
strLgData4 = "Abril"
strLgData5 = "Maio"
strLgData6 = "Junho"
strLgData7 = "Julho"
strLgData8 = "Agosto"
strLgData9 = "Setembro"
strLgData10 = "Outubro"
strLgData11 = "Novembro"
strLgData12 = "Dezembro"


'======================================
'	VALOR DAS STRINGS DA LOJA          
'======================================

strLg1 = "Finalizar Compras"
strLg2 = "Quantidade de itens:"
strLg3 = "Sub-total:"
strLg4 = "Home"
strLg5 = "Registro de Clientes"
strLg6 = "Login"
strLg7 = "Carrinho de Compras de"
strLg8 = "Fechar Pedido"
strLg9 = "Meus Dados"
strLg10 = "Histórico de Compras"
strLg11 = "Logout"
strLg12 = "Departamentos"
strLg13 = "Pesquisa"
strLg14 = "Atendimento"
strLg15 = "Todas as categorias"
strLg16 = "Como Comprar?"
strLg17 = "Por e-mail"
strLg18 = "Sobre Segurança"
strLg19 = "Segurança e Privacidade"
strLg20 = "Quem somos"
strLg21 = "Pesquisar"
strLg22 = "Sobre Segurança"
strLg23 = "Por e-mail"
strLg24 = "Atendimento por e-mail"
strLg25 = "para entrega"
strLg26 = "Pronta Entrega" ' ou "Disponível para entrega"

'strLg27 = "Solicite Cotação de preço" 'ou "Não disponível para entrega"
'strLg28 = "Disponível:"


strLg27 = "Esgotado" 'ou "Não disponível para entrega"
strLg28 = "Estoque:"


strLg29 = "Preço:"
strLg30 = "+ Detalhes"
strLg31 = "Fabricante:"
strLg32 = "Adicionar"
strLg33 = "produto(s) no meu carrinho de compras."
strLg34 = "Comprando o"
strLg35 = "na"
strLg36 = "você economiza até " 
strLg37 = "À vista por:"
strLg38 = "por:"
strLg39 = "de:"
strLg40 = "ou ainda:"
strLg41 = "Voltar"
strLg42 = "Pesquisando por" 
strLg43 = "Foram encontrado(s)"
strLg44 = "produto(s) :"
strLg45 = "Página"
strLg46 = "de"
strLg47 = "Próxima Página"
strLg48 = "Produtos neste departamento:"
strLg49 = "Não há nenhum item em seu carrinho de compras."
strLg50 = "Se você comprou algum produto anteriormente sua sessão de compras está expirada!"
strLg51 = "Ver meu carrinho de compras"
strLg52 = "Mais Ofertas:"
strLg53 = "O item foi adicionado em seu carrinho de compras."
strLg54 = "Compra"
strLg55 = "Sua compra"
strLg56 = "Por favor, verifique se sua compra está correta antes de prosseguir."
strLg57 = "Para modificar a quantidade de algum item digite o novo valor e clique no botão atualizar."
strLg58 = "Quantidade"
strLg59 = "Produto"
strLg60 = "Preço Unitário"
strLg61 = "Preço Total"
strLg62 = "Remover"
strLg63 = "Total da compra"
strLg64 = "Valor da entrega em"
strLg65 = "Sua compra"
strLg66 = "Atualizar"
strLg67 = "Prosseguir"
strLg68 = "Continuar Compras"
strLg69 = "Escolha a região de entrega para o calculo do frete!"
strLg70 = "Clique aqui"
strLg71 = "Clique aqui!"
strLg72 = "Dados para entrega do pedido"
strLg73 = "Para modificar sua compra"
strLg74 = "Por favor, verifique se o endereço para entrega está correto antes de prosseguir."
strLg75 = "se endereço para a entrega e o mesmo que o seu!"
strLg76 = "Opções para entrega"
strLg77 = "Endereço para entrega"
strLg78 = "Endereço:"
strLg79 = "Bairro:"
strLg80 = "Cidade:"
strLg81 = "Estado:"
strLg82 = "CEP:"
strLg83 = "País:"
strLg84 = "Telefone:"
strLg85 = "Você deseja que os itens comprados sejam empacotados e enviados como presente?"
strLg86 = "Sim"
strLg87 = "Não"
strLg88 = "Mensagem escrita no cartão-presente:"
strLg89 = "Limpar"
strLg90 = "Por favor, preencha todos os dados corretamente antes de prosseguir."
strLg91 = "Forma de Pagamento"
strLg92 = "Por favor, preencha todos os dados corretamente antes de prosseguir."
strLg93 = "Para modificar o endereço de entrega das compras e/ou outros dados"
strLg94 = "Selecione a forma de pagamento escolhida:"
strLg95 = "Outras formas de pagamento"
strLg96 = "Pagamento via Cartão de Crédito" 
strLg97 = "Selecione seu cartão:"

strLg98 = "Número do cartão: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Código de Segurança:"

strLg99 = "Expiração do cartão:" 
strLg100 = "Cancelar"
strLg101 = "Ano"
strLg102 = "Titular do cartão (Como aparece no Cartão):" 
strLg103 = "Meus Dados"
strLg104 = "Para modificar seus dados, selecione o campo desejado e escreva o dado atualizado sobre o antigo."
strLg105 = "Para nenhuma modificação clique em 'Cancelar'. "
strLg106 = "Dados do Registro"
strLg107 = "Dados Pessoais"
strLg108 = "Seu e-mail:"
strLg109 = "Seu telefone:"
strLg110 = "Seu país:"
strLg111 = "Seu estado:"
strLg112 = "Sua cidade:"
strLg113 = "Seu bairro:"
strLg114 = "Seu endereço:"
strLg115 = "Seu RG ou IE"
strLg116 = "Seu CPF ou CNPJ"
strLg117 = "Seu nascimento:"
strLg118 = "Seu Nome ou Razão Social:"
strLg119 = "Compras efetuadas por"
strLg120 = "Para visualizar os dados da sua compra digite o número do pedido logo abaixo:"
strLg121 = "Pedido n.:"
strLg122 = "Para sua comodidade e segurança verifique todos os seus dados antes de prosseguir." 
strLg123 = "Sua Senha:"
strLg124 = "Seu e-mail foi enviado com sucesso!"
strLg125 = "Obrigado"
strLg126 = "em breve você receberá a resposta de sua dúvida!"
strLg127 = "Agora desfrute da comodidade e segurança de comprar em nossa loja virtual."
strLg128 = "Como Comprar na "
strLg129 = "Seu Nome:"
strLg130 = "Digite o seu e-mail corretamente para que esta mensagem possa ser respondida."
strLg131 = "Dúvida sobre:"
strLg132 = "Assunto:"
strLg133 = "Mensagem:"
strLg134 = "Como utilizar o Carrinho de Compras?"
strLg135 = "Como pesquisar produtos na loja?"
strLg136 = "Como é o cadastro de clientes?"
strLg137 = "Como efetuar o login na loja?"
strLg138 = "Como modifico meus dados?"
strLg139 = "Dúvidas diversas"
strLg140 = "Enviar"
strLg141 = "Preencha este campo!"
strLg142 = "O CPF deve ter 11 dígitos!"
strLg143 = "CPF ou CNPJ Inválido!"
strLg144 = "Preencha este campo corretamente!"
strLg145 = "E-mail já existente em nossos registros!"
strLg146 = "Modificar meu e-mail ou senha"
strLg147 = "Dia"
strLg148 = "Mês" 
strLg149 = "Registro Alterado"
strLg150 = "Seu registro foi alterado com sucesso!"
strLg151 = "Todos os seus dados foram modificados e atualizados com sucesso em nossa base de dados."
strLg152 = "Digite seu e-mail corretamente!"
strLg153 = "Fechar esta Janela"
strLg154 = "Seu e-mail foi registrado com sucesso!"
strLg155 = "Obrigado, agora você receberá ofertas exclusivas da "
strLg156 = "Este item já existe no seu carrinho de compras."
strLg157 = "O item foi adicionado em seu carrinho de compras."
strLg158 = "Sua Primeira vez aqui?"
strLg159 = "Cadastre-se para receber ofertas exclusivas"
strLg160 = "Digite seu e-mail"
strLg161 = "Cadastre-se Já!"
strLg162 = "Este e-mail já pertence a outro cliente cadastrado!"
strLg163 = "A senha digitada não confere!"
strLg164 = "Para modificação dos dados clique em 'Atualizar', para nenhuma modificação clique em 'Cancelar'."
strLg165 = "Só é permitida a alteração de um item por vez."
strLg166 = "Dados do seu e-mail"
strLg167 = "se você quer modificar seu e-mail!"
strLg168 = "Seu e-mail atual:"
strLg169 = "Digite seu novo e-mail:"
strLg170 = "Dados da sua senha"
strLg171 = "se você quer modificar sua senha!"
strLg172 = "Digite sua senha atual:"
strLg173 = "Digite sua nova senha:"
strLg174 = "O campo Endereço não pode estar vazio!"
strLg175 = "O campo Bairro não pode estar vazio!"
strLg176 = "O campo Cidade não pode estar vazio!"
strLg177 = "O campo CEP não pode estar vazio!"
strLg178 = "O campo Telefone não pode estar vazio!"
strLg179 = "Login na Loja"
strLg180 = "Se é a sua primeira compra nesta loja"
strLg181 = "Se já é nosso cliente registrado então introduza os dados."
strLg182 = "Você esqueceu sua senha?"
strLg183 = "E-mail de usuário não encontrado!"
strLg184 = "A Senha está incorreta!"
strLg185 = "Selecione sua região"
strLg186 = "Informações sobre o pedido "
strLg187 = "Esta compra não está presente na base de dados da loja"
strLg188 = "ou não é referente a este cliente!"
strLg189 = "Compra efetuada por"
strLg190 = "SEDEX à cobrar"
strLg191 = "Depósito Identificado"
strLg192 = "Depósito Simples"
strLg193 = "Aguardando confirmação de pagamento"
strLg194 = "Pagamento confirmado e Compra em processamento"
strLg195 = "Compra já enviada ao cliente"
strLg196 = "Compra já Entregue"
strLg197 = "Compra Cancelada"
strLg198 = "Compra Negada"
strLg199 = "Outras - Contate o Atendimento"
strLg200 = "Frete"
strLg201 = "Status da Compra"
strLg202 = "Data da Compra"
strLg203 = "Estimativa para entrega"
strLg204 = "Você ainda não efetuou nenhuma compra na"
strLg205 = "Ver informações deste pedido!"
strLg206 = "Departamento Inexistente"
strLg207 = "Departamento inexistente na"
strLg208 = "Nenhum produto presente neste departamento!"
strLg209 = "Página Anterior"
strLg210 = " - Cartão Inválido."
strLg211 = " - Número Inválido."
strLg212 = " - Número e Cartão Inválidos."
strLg213 = " - Soma de Controle Inválida."
strLg214 = " - Soma de Controle e Cartão Inválidos."
strLg215 = " - Soma de Controle e Número Inválidos."
strLg216 = " - Soma de Controle, Número e Cartão Inválidos"
strLg217 = " - Digite o número do cartão de crédito"
strLg218 = " - Selecione uma data válida!"
strLg219 = " - Data do cartão inválida."
strLg220 = " - Digite o nome do titular (como aparece no cartão)"
strLg221 = "Cartão de Crédito MASTERCARD"
strLg222 = "Cartão de Crédito VISA"
strLg223 = "Cartão de Crédito AMERICAN EXPRESS"
strLg224 = "Cartão de Crédito DINNERS"
strLg225 = "SEDEX à cobrar"
strLg226 = "Depósito Identificado"
strLg227 = "Depósito Bancário"
strLg228 = "Nenhum produto foi encontrado em nossa base de dados. Refaça sua pesquisa!"
strLg229 = "Produto Inexistente ou Fora de Catálogo"
strLg230 = "Produto inexistente ou Fora de Catálogo na "
strLg231 = "Digite seu e-mail:"
strLg232 = "Senha:"
strLg233 = "Incorreto"
strLg234 = "Sua senha deve ter no máximo 10 caracteres!"
strLg235 = "Sua senha deve ter no mínimo 5 caracteres!"
strLg236 = "Seu registro foi feito com sucesso!"
strLg237 = "Obrigado"
strLg238 = "agora desfrute da comodidade e segurança de comprar na "
strLg239 = "Compra Segura"
strLg240 = "Criptografia"
strLg241 = "Compras com Cartão de Crédito"
strLg242 = "Utilização de Informações"
strLg243 = "Dúvidas e Sugestões"
strLg244 = "E-mail não encontrado em nossos registros!"
strLg245 = "Preencha seu e-mail corretamente!"
strLg246 = "Sua Senha"
strLg247 = "Sua senha foi enviada com sucesso para"
strLg248 = "Digite seu e-mail abaixo para que sua senha possa ser enviada."
strLg249 = "E-mail:"
strLg250 = "Enviar Senha!"
strLg251 = "- Preencha os Campos ao lado."
strLg252 = "em breve você receberá a resposta de sua solicitação."
strLg253 = "Equipe Médica"
strLg254 = "Resultados Reais"
strLg255 = "Sobre"
strLg256  = "Boleto Bancário"
strLg257 = "Compre o produto "
strLg258 = "Atendimento On-Line "
strLg259 = "Atendimento Off-Line "
strLg260 = "Versions in "
strLg261 = "Esta página foi carregada em "
strLg262 = " segundo(s)"
strLg263 = "Visitantes até "
strLg264 = "Visitante "
strLg265 = "Seja Bem Vindo "
strLg266 = "Remover meu email "
strLg267 = "Incluir meu email para receber"
strLg268 = "Seu e-mail foi removido com sucesso!"
strLg269 = "Obrigado, apartir de hoje você não receberá ofertas exclusivas da "
strLg270 = " Máximo de "
strLg271 = " produto(s) por compra. "
strLg272 = " unidade(s) "
strLg273 = " Você está em "
strLg274 = " Campeões de Venda "
strLg275 = " Enviar essa oferta a um amigo "
strLg276 = " Comprar Produto "
strLg277 = "Temos somente"
strLg278 = " produto(s) em nosso estoque"
strLg279 = "Deseja comprar os "
strLg280 = "produtos restantes?"
strLg281 = "O 'CEP' informado está diferente do seu cadastro. Clique em Atualizar para recalcular"
strLg282 = " Calcular o valor da Entrega"
strLg283 = "Dados para entrega da compra"
strLg284 = "Forma de Pagamento"
strLg285 = "Compra concluída!"
strLg286 = "Fechando Pedido..."
strLg287 = "Como Pagar?"
strLg288 = "Como Reimprimir Boleto?"
strLg289 = "Dados para Login na loja"
strLg290 = "Dados Cadastrais"
strLg291 = "Nome do Contato"
strLg292 = " dias"
strLg293 = " após a Confirmação de pagamento"
strLg294 = "Escolha uma Forma de Entrega"
strLg295 = "Digite seu CEP para o calculo do Frete e clique em Atualizar"
strLg296 = "Política de Troca"
strLg297= "Pagamento"
strLg298= "Depósito direto no caixa"
strLg299= "Depósito no caixa eletrônico"
strLg300 = "Pagamento via BRpay"
strLg301= "Transferência entre contas"
strLg302= "Boleto bancário"
strLg303= "Data: "
strLg304= "Observações: "
strLg305= "Horário: "
strLg306= "Agência Origem: "
strLg307= "Valor do pagamento: "
strLg308= "em breve você receberá a confirmação do seu pagamento!"
strLg309= "Dentro de 1 a 2 dias úteis estaremos confirmando seu pagamento por e-mail.<br>Caso necessite de outras informações, entre em contato conosco pelo e-mail "&Email_da_sua_loja
strLg310= "Meu Carrinho"
strLg311= "Confirmar pagamento"
strLg312= "Política de Venda"
strLg313= "Como Confirmar Pagamento"
strLg314 = "O campo Estado não pode estar vazio!"

strLg315 = "Novos PRODUTOS estão sendo catalogados."
strLg316 = "Se você desejar algo que ainda não encontrou,"
strLg317 = "e nos informe o que está procurando."
strLg318 = "Informações sobre produtos"
strLg319 = "Regiões de Entrega"
strLg320 = "Condições de Entrega"
strLg321 = "Mercadorias Conforme Disponibilidade de Estoque"
strLg322 = "Rastreie sua compra"
strLg323 = "Cheque Bancário"
strLg324 = "Pedido"

strLg325 = "Monte Sua Cesta"
strLg326 = "Cotação de Preços"




'###########################################
'Textos da loja
'###########################################

'Este texto é referente a área "Compra Segura"
'This text is used in the "Safety" area
strLgcomprasegura = "&nbsp;&nbsp;&nbsp;&nbsp;A " & nomeloja & " tem um especial compromisso com você, nosso cliente, quanto à segurança e privacidade de seus dados. O respeito ao cliente e o sigilo de suas informações é muito importante para nós. Por isso, você, cliente da " & nomeloja & ", tem a garantia que sua compra é segura.<br>&nbsp;&nbsp;&nbsp;&nbsp;A " & nomeloja & " em parceria com a VirtuaWoks elaborou um conjunto de ações para garantir a segurança de todas as compras feitas em nossa loja, independentemente da forma de pagamento escolhida. Todas as informações que você fornecer no processo de compra são totalmente criptografadas."


'Este texto é referente a área "Criptografia"
'This text is used in the "Criptography" area
strLgcriptografia = "&nbsp;&nbsp;&nbsp;&nbsp;Todas as informações que passam pelo nosso processo de compra são automaticamente codificadas por um sistema de criptografia próprio. Assim, seus dados pessoais, a forma de pagamento escolhida e toda e qualquer outra informação fornecida à " & nomeloja & " será mantida em sigilo. O ícone 'cadeado fechado' - na parte inferior do seu monitor - durante o pedido é um símbolo da criptografia das informações."


'Este texto é referente a área "Compras com Cartão de Crédito"
'This text is used in the "Credit Card Sales" area
strLgcomprascc = "&nbsp;&nbsp;&nbsp;&nbsp;Além da criptografia, outro fator de segurança é a automática destruição dos dados relativos ao número do cartão de crédito. A " & nomeloja & " utiliza o número do cartão somente no processamento da compra e, tão logo ocorra a confirmação pela Administradora do cartão, o número é automaticamente destruído, não sendo, de nenhuma forma, guardado na base de dados da " & nomeloja & "."


'Este texto é referente a área "Utilização de Informações"
'This text is used in the "Your Information" area
strLginformacoes = "&nbsp;&nbsp;&nbsp;&nbsp;A " & nomeloja & " não comercializará suas informações pessoais. Tais informações poderão, entretanto, ser agrupadas conforme determinados critérios e utilizadas como estatísticas genéricas objetivando um melhor entendimento do perfil do consumidor."


'Este texto é referente a área "Dúvidas e sugestões"
'This text is used in the "faq and sugestions" area
strLgduvsug = "&nbsp;&nbsp;&nbsp;&nbsp;Caso tenha qualquer dúvida ou sugestão sobre segurança e privacidade ou sobre qualquer outro aspecto do nosso processo de compra, não deixe de nos contatar."


'Este texto é referente a área "Quem Somos"
'This text is used in the "About Us" area
strLgquemsomos = "&nbsp;&nbsp;&nbsp;&nbsp;somos uma loja VS"




strLgregiaoatendida = "&nbsp;&nbsp;&nbsp;&nbsp;Entrega em Domicílio somente para Belo Horizonte e Região Metropolitana detre elas: Betim, Contagem, Ibirité, Nova Lima, Ribeirão das Neves, Raposos, Sabará, Santa Luzia, Venda Nova e Vespasiano"


strLgcondicaoentrega = "&nbsp;&nbsp;&nbsp;&nbsp;Você agora pode escolher o dia e a hora para o recebimento de suas compras. Com isso, você programa a entrega de acordo com seus compromissos. Para este serviços erá cobrada a taxa de entrega e o prazo mínimo para a entrega programada é de 24 horas a partir do recebimento do pedido"




%>
