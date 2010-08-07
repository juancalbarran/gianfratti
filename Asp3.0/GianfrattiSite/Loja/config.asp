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



'***   LEIA AS INSTRUCOES ABAIXO ANTES DE INICIAR O USO DA SUA LOJA VIRTUASTORE !!!   ***



'#########################################################################################
'#
'#    ------------------------------------------------------------------------------------------------------------------
'#    Este código está otimizado e roda tanto em Windows 2000/NT/XP/ME/98 quanto em servidores UNIX-LINUX com Chilli!ASP
'#    ------------------------------------------------------------------------------------------------------------------
'#
'#    ------------------------------------------------------------------------------------------------
'#    Para a VirtuaStore OPEN rodar corretamente em seu servidor você precisará de:					  
'#
'#    - Conexão com internet (Para o calculo de SEDEX a partir dos Correios Online)					  
'#    - Componente FSO (File System Object) rodando com permissões de escrita no diretório			  
'#    - Componente XML 3.0 (MSXML3) instalado														  
'#    - IIS (Internet Information Services), PWS (Personal Web Server) ou Sun ONE como servidor WEB	  
'#    - Permissao de Escrita nas pastas onde tem Banco de Dados e Imagens de Produtos				  
'#      (Pastas: Database , Chat , Banners , Produtos) 												  
'#
'#    ------------------------------------------------------------------------------------------------
'#    >>> Administrador:  
'#
'# 	  - 1. Se você baixou este arquivo do grupo VirtuaStore do Yahoo (http://br.groups.yahoo.com/group/virtuastore),
'#    vc terá acesso a área administrativa (administrador.asp) usando como Usuario padrao: admin , e Senha padrao: 123456
'#    portanto é IMPORTANTE mudar a Senha quando a sua loja entrar em operação na Internet.
'#    - 2. Para usar a área administrativa, é recomendado que se use o browser Internet Explorer 5.5 ou superior,
'#    para poder usufruir da Ferramenta HTML, para escrever a Descrição de Produtos com recursos HTML , nas áreas de
'#    Inserir e Editar Produtos, como também para escrever emails em HTML na área de Escrever nova Newsletter.
'#
'#    >>> Segurança:  Procure usar uma Pasta protegida do Provedor para o seu Banco de Dados, após testar a loja usando
'#    a Pasta /Database criada originalmente.
'#
'#    >>> Atualizacoes:  Durante as proximas semanas, pode haver atualizacoes de algum arquivo .asp pela Comunidade VirtuaStore,
'#    portanto acompanhe o Painel de Notificações de Atualizações (administrador.asp) , e como dica para aprendizagem ;-) 
'#    use o programa Compare It! do site http://www.grigsoft.com (ou similar) , para analisar melhor as diferencas entre os 
'#	  arquivos .asp de sua loja e dos que foram modificados nas atualizacoes.
'#    ------------------------------------------------------------------------------------------------
'#
'#########################################################################################



'       =================================================================
'        C O N F I G U R A Ç Õ E S   G E R A I S   D A   S U A   L O J A 
'                    Altere todos os dados que desejar                   
'																		 
'							I N D I C E									 
'																		 
'		1.	CONFIGURAÇÃO DE BANCO DE DADOS E TIPO DE CONEXÃO			 
'		2.	CONFIGURAÇÃO DE FRETE										 
'		3.	CONFIGURAÇÕES GERAIS										 
'	 	4.	CONFIGURAÇÕES DO BOLETO BANCÁRIO							 
'		5.	CONFIGURAÇÕES DAS CORES DA SUA LOJA							 
'																		 
'       =================================================================



'######################################################################################
'	1.	CONFIGURAÇÃO DE BANCO DE DADOS  E  TIPO DE CONEXÃO (Access, SQLServer ou MySQL)
'######################################################################################

'## Para selecionar a opção basta retirar o comentário que é representado por " ' " nas partes "'StringdeConexao" e "VersaoDb" e preencher com os dados corretos

'********************************************************
'## Use 1 para MySql									 
'## Use 2 para Access       ( Recomendado )				 
'## Use 3 para SQL Server  								 

VersaoDb = 2

'------> Observação:
' Esta versão não está operando 100% otimizado para MySql
' portanto precisamos de voluntários para complementar   
' a programação da loja para que trabalhe com o MySql,   
'********************************************************


'******************************************************************
'## 1. Se você usa MySQL 

'------> Usando o MyODBC
'StringdeConexao = "driver={MySQL ODBC 3.51 Driver};SERVER=localhost;DATABASE=database;UID=root;PWD=;"

'------> Usando o DRIVER direto do MySql
'StringdeConexao = "DRIVER={MySQL};SERVER=localhost;DATABASE=database;UID=root;PWD=;" 
'******************************************************************


'******************************************************************
'## 2. Se você usa Access escolha a versão e preencha abaixo (Para o seu banco ficar protegido, utilize a 2a opção)

'------> MS Access 2000 usando a Pasta /Database criada originalmente
StringdeConexao = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("database/virtuastore.mdb")

'------> MS Access 2000 usando uma Pasta protegida do Provedor
'        OBS.: Entre em contato com o seu Provedor para informá-lo o caminho físico corretamente da sua pasta de dados protegida

'pasta_dados_protegido="D:\Inetpub\Clientes\host521ewn.plugin.com.br\Data\database\virtuastore.mdb"
'StringdeConexao = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&pasta_dados_protegido&";"
'******************************************************************


'******************************************************************
'## 3. Se você usa SQLServer escolha a versão e preencha abaixo 
'------> MS SQL Server 6.x/7.x/2000 (Conexão OLEDB)
'StringdeConexao = "Provider=SQLOLEDB;Data Source=servidor;database=virtuastore;uid=sa;pwd=;"

'------> MS SQL Server 6.x/7.x/2000 (Conexão ODBC) 
'StringdeConexao = "Provider=MSDASQL.1;Persist Security Info=False;Data Source=VirtuaStore;Initial Catalog=virtuastore" 
'******************************************************************


'******************************************************************
'## 4. Se você usa DSN preencha abaixo:
'StringdeConexao = "NOME_DA_DSN_NAME"
'******************************************************************




'#########################################################################################################
'	2.	CONFIGURAÇÃO DE FRETE																			  
'#########################################################################################################


'***	2.1  ENTREGA NACIONAL OU ESTADUAL (VIA CORREIOS)


'## Colocar a Forma de Entrega dos pedidos via Sedex?
entrega_sedex="Sim"	'Deixe "Sim" ou "Nao"

seu_cep = "314710360"		'Digite o CEP de sua loja usando somente numeros

'## Você deseja testar Offline e sem Conexao Internet?
sem_calculo_online_SiteCorreios = "Nao" 
'IMPORTANTE: Deixe "Sim" caso voce NÃO esteja conectado na Internet (para nao travar Calc. de Frete), 
'pois o cálculo vem do site dos Correios, mas setando para "Sim" será colocado um valor fictício de R$ 10,00

'## Serviço Adicional dos Correios para entrega do pedido SOMENTE para o Cliente, digite "S" para ativar ou "N" para não ativar
mao_propria = "N"			

'## Serviço Adicional dos Correios de Aviso de Recebimento da encomenda na casa do Cliente, digite "S" para ativar ou "N" para não ativar
aviso_recebimento = "N"		

'## Serviço de Seguro do próprio Correios da encomenda do Cliente, digite  "S" para ativar ou "N" para não ativar
cobrar_seguro_produto = "N"		
'Obs 1: Quando o cliente opta por Sedex a Cobrar, este valor é cobrado obrigatoriamente pelos Correios
'Obs 2: O seguro é 1% do valor da compra

'## Colocar a Opção de Pagamento do pedido via Sedex a Cobrar?
entrega_sedex_a_cobrar="Sim"	'Deixe "Sim" ou "Nao"



'***	2.2  ENTREGA REGIONAL (Via Motoboy, Tele-Entrega [com Carro próprio] ou similares que são cobrados Taxas Fixas)

'## Colocar a Forma de Entrega dos pedidos via Motoboy?
entrega_motoboy="Sim"	'Deixe "Sim" ou "Nao"

'## Descricao da Forma de Entrega dos pedidos a Domicilio 
descricao_forma_entrega_motoboy = "Em Domicílio" '(Por padrão está como Motoboy, mas pode ser outro como "Tele-Entrega" , etc...)

'## Tarifa para Entrega dos pedidos via Motoboy (se valor com CENTAVOS, digite COM PONTO - Exemplo: 4.50 )
tarifa_entrega_motoboy = 12.0

'## Descricao da Regiao da Entrega dos pedidos via Motoboy
descricao_regiao_entrega_motoboy = "Entrega em Domicílio somente para Belo Horizonte e Região Metropolitana detre elas: Betim, Contagem e Ibirité"



'***	2.3  ENTREGA PESSOAL (Via Download, Pessoalmente ou similares que NÃO são cobrados)

'## Colocar a Forma de Entrega dos pedidos via Download?
entrega_download="Nao"	'Deixe "Sim" ou "Nao" 
'IMPORTANTE: Caso deixe Sim, por questoes de logica DESATIVE as formas de entrega anteriores ( entrega_motoboy="Nao" e entrega_sedex="Nao")

'## Descricao da Forma de Entrega dos pedidos a Domicilio 
descricao_forma_entrega_download = "Download" '(Por padrão está como Download, mas pode ser outro como "Pessoalmente" , etc...)

'## Tarifa para Entrega dos pedidos via Download
tarifa_entrega_download = 0

'## Descricao da Regiao da Entrega dos pedidos via Download
descricao_regiao_entrega_download = "Você poderá fazer o Download direto do site!"


'---> ENCOMENDA NORMAL IMPLEMENTADO POR MATEUS MORAES (mateusmoraes@bol.com.br)

'***	2.4  ENCOMENDA NORMAL

'## Colocar a Forma de Entrega dos pedidos via Encomenda Normal?
entrega_encomenda="Sim"	'Deixe "Sim" ou "Nao" 

'## Descrição da Forma de Entrega dos pedidos a Domicilio 
descricao_forma_entrega_encomenda = "Encomenda Normal"

'## Configuração das Regiões para frete via Encomenda Normal (Modelo Padrão configurado para o PARANÁ - CAPITAL)

' 1. Configure o Estado em que sua loja se encontra para ZERO
' 2. Configure os demais Estados de acordo com o arq em anexo (ENCOMENDA_NORMAL.xls), ou pelas tabelas disponibilizadas
' pelos Correios: http://www.correios.com.br/servicos/precos_tarifas/nacionais/tar_encomenda_normal.cfm

' 3. Dê uma olhada em http://www.correios.com.br/servicos/precos_tarifas/nacionais/pdf/ENC_NORMAL_PR.pdf
' para entender melhor a configuração desse tipo de frete. No caso do Paraná, por ser LOCAL (conforme o PDF acima),
' ele leva o valor 0 no valor abaixo, os da 2a coluna leva o valor 1  e assim por diante

estado_pr = 1

estado_rs = 1
estado_sc = 1
estado_sp = 1

estado_go = 2
estado_mg = 0
estado_rj = 2
estado_ms = 2

estado_df = 3
estado_es = 3

estado_ba = 4
estado_mt = 4
estado_to = 4

estado_se = 5
estado_al = 5
estado_ro = 5

estado_ac = 6
estado_ma = 6
estado_pa = 6
estado_pe = 6
estado_pb = 6
estado_rn = 6

estado_ce = 7
estado_pi = 7
estado_ap = 7

estado_am = 8
estado_rr = 8



'###################################################################################
'	3.	CONFIGURAÇÕES GERAIS	
'###################################################################################

'## Escreva o nome do administrador da loja para suporte via Administrador
Seu_nome = "Cleverson Fabiano"

'## Você deseja Usar Criptografia de 64 BITS em sua loja?
Cripto_Ativa = "Sim" 'Deixe "Sim" para usar ou então escreva "Nao"

'## Você deseja mostra 4, 6 ou 8 produtos no inicio da sua loja?
mostrar_produtos_fachada=6		'Digite 4 ou 6 ou 8

'## Você deseja colocar Destaque de Produto na página inicial? (produto aleatório)
mostrar_produto_destaque_fachada="Sim" 'Deixe "Sim" para usar ou então escreva "Nao"

'## Você deseja mostra qtos produtos por página (paginas Secoes e Pesquisa)?
mostrar_produtos_por_pagina_na_secao=16

'## Você deseja mostrar o aviso de estoque "Esgotado" automaticamente , qdo acabar o estoque do Produto?
'Se Sim, o produto ficará "Visível", mas aparecerá um aviso de estoque "Esgotado". Este aviso não aparecerá se o produto já estava com o status de "Não Visível"
'Se Nao, o produto ficará com o status de "Não Visível" ao público, qdo acabar o estoque do Produto. 
mostrar_produto_esgotado="Sim" 'Deixe "Sim" ou "Nao"

'## Você deseja mostrar as Opções de Cartões de Creditos como Forma de Pgto?
mostrar_pgtos_com_cartoescredito="Sim" 'Deixe "Sim" para usar ou então escreva "Nao"

'## Você deseja limitar a compra de um produto conforme a qtidade Máxima fixada na área administrativa?
mostrar_limite_max_prod_compra="Sim" 'Deixe "Sim" ou "Nao"
'Em caso de Nao, pode acontecer de o cliente comprar mais do que tem no estoque, portanto poderá aparecer para o Administrador estoques "negativos"

'## Você deseja mostrar o Formulário para o Cliente solicitar por email produtos que estão como "Esgotados"?
mostrar_form_email_prod_esgotado="Sim" 'Deixe "Sim" para usar ou então escreva "Nao"

'## Você deseja mostrar o link de Política de Trocas no Quadro Atendimento?
mostrar_politica_de_trocas="Sim" 'Deixe "Sim" ou "Nao"

'## Nome da imagem da Logo da Loja (coloque dentro da Pasta /Imagens/ de cada linguagem)
arquivo_logo_loja="logo.gif"

'## Dados da loja	
Nome_da_sua_loja = "Virtua Store"
CNPJ_da_sua_empresa = "00.000.000/0000-00"
Razao_Social = "cleverson fabiano"
Email_da_sua_loja = "loja@loja.com.br"
Slogan_da_sua_loja = "A sua Loja Virtual!"
Endereco_do_site = "www.localhost/vs6.0.1/loja" 
         'ATENÇÃO: Escreva o endereço virtual da sua loja sem o Http:// e sem o / no final

Endereco_da_sua_loja = "nome da sua rua"
Bairro_da_sua_loja = "seu bairro"
Cidade_da_sua_loja = "estado"
Estado_da_sua_loja = "MG"
Pais_da_sua_loja = "Brasil"
Telefone_da_sua_loja = "(0xx00) 000.0000"

'## Dados bancarios - Banco 1
Seu_banco = "Bradesco"
Sua_agencia = "0000"
Sua_conta_corrente = "00000"
Nome_do_cedente = "loja"

'## Dados bancarios - Banco 2		( 'Se nao for usar , deixe os 4 campos abaixo como "" )
Seu_banco2 = "Banco do Brasil" 
Sua_agencia2 = "0000"
Sua_conta_corrente2 = "0000"
Nome_do_cedente2 = "loja"

'## Confirurações de e-mail
Host_da_loja = "-" ' --> Se o componente usado for CDONTS deixe esse campo assim: "-"

'## Escolha o componente e desmarque o comentário
'Componente_usado = "AspEmail"
'omponente_usado = "AspMail"
'Componente_usado = "AspQmail"
Componente_usado = "CDONTS"
'Componente_usado = "JMail"

'## Banners da Loja
Banner_AdMentor=""	'--> Coloque "Sim" se for usar Banners via Sistema Admentor, da Area Administrativa, ou deixe como ""
Banner_Fixo="" '--> Para usar um banner fixo, coloque o nome da imagem entre as aspas, coloque a imagem na pasta Banners e deixe Banner_AdMentor=""

'## Fonte da loja
Fontes_da_loja = "tahoma,verdana,arial,helvetica"

'## Dias para entrega dos pedidos
Dias_para_entrega = 7

'## Mostrar Quadro Linguagens na Loja
mostrar_quadro_linguagens="Nao"	'--> 'Deixe "Sim" ou "Nao"

'## Mostrar Contador na Loja
mostrar_contador="Sim"	'--> Coloque "Sim" se quiser mostrar

'## Tipo da Moeda Corrente
strLgMoeda = "R$"  ' REAL - R$ - Brasil
strLgMoedax = "Reais"  ' Nome da moeda no plural

'## Configurações para pagamento com cartão Visanet
URL_Componentes_Visa = server.mapPath("/")&"\Componentes_vbv" 'pasta onde foram registrados os componentes visa
Numero_Registro_Visa = "1001734898"  'Coloque o número do estabelecimento
Nome_Arquivo_Visa    = "LojaTeste"   'coloque o nome do arquivo com as configurações da visa (sem extensão .ini).
Valor_Autenticacao   = 100.00        'A partir deste valor o cliente deve digitar a Conta e Senha do Banco emissor do cartão.


'## Configurações para pagamento com cartão RedeCard
URL_Codv_RedeCard    = "e:\home\seudominio\RedeCard\" 'pasta com permissao de escrita para gravar Arq. com código de verificação
Filiacao_RedeCard    = "012345678"  'Coloque o número do estabelecimento
URL_Retorno_RedeCard = "http://www.seudominio.com.br/vs6.0.1/loja/pagamentokomerci.asp"



'###################################################################################
'	4.	CONFIGURAÇÕES DO BOLETO BANCÁRIO
'###################################################################################

'## Você deseja colocar a opção Boleto como Forma de Pagamento?
mostrar_pagamento_por_boleto="Sim" 'Deixe "Sim" para usar ou então escreva "Nao"

'caminho_boleto = "boleto_hsbc.asp" ' use este caminho para utilizar o boleto do HSBC
'caminho_boleto = "boleto_bb.asp" ' use este caminho para utilizar o boleto do BANCO DO BRASIL
caminho_boleto = "boleto_bradesco.asp" ' use este caminho para utilizar o boleto do BRADESCO
'caminho_boleto = "boleto_itau.asp" ' use este caminho para utilizar o boleto do ITAÚ
'caminho_boleto = "boleto_caixa.asp" ' use este caminho para utilizar o boleto do Caixa
'caminho_boleto = "boleto_real.asp" ' use este caminho para utilizar o boleto do Real
'caminho_boleto = "boleto_unibanco1.asp" ' use este caminho para utilizar o boleto do Unibanco comum
'caminho_boleto = "boleto_unibanco2.asp" ' use este caminho para utilizar o boleto do Unibanco shop

'## Informações bancárias referente ao seu Boleto  ( Alguns campos são opcionais )
bol_nr_cedente="000000" 'numero do seu codigo cedente (não é necessário para alguns bancos)
bol_agencia = "0000" 'agencia
bol_dagencia = "" 'digito da agencia (não é necessário para alguns bancos)
bol_conta = "000000" 'conta (não é necessário para alguns bancos)
bol_dconta = "0" 'digito da conta (não é necessário para alguns bancos)
bol_carteira = "0" 'código da carteira
bol_convenio = "" 'numero do seu convenio (não é necessário para alguns bancos)
bol_cedente = "loja" 'Geralmente é o nome da loja e o nome do cedente no banco

'## Observações no Boleto  ( Campos opcionas )
' Voce pode colocar alguma instrução para o cliente, por exemplo "Obrigado por comprar em nossa loja"

obs_linha1 = "Para agilizar o seu atendimento, envie-nos o seu email após o seu pagamento para "&Email_da_sua_loja ' Observação Linha 1 
obs_linha2 = "informando apenas o número do seu pedido e o banco usado para pagamento." ' Observação Linha 2
obs_linha3 = "A "& Nome_da_sua_loja &" agradece o seu pedido." ' Observação Linha 3
obs_linha4 = "SERÁ COBRADO R$ 3.50 REFERENTE A TARIFA ADMINISTRATIVA, LANÇADOS" ' Observação Linha 4
obs_linha5 = "EM OUTROS ACRÉSCIMOS" ' Observação Linha 5


'## Instruções ao Caixa do Banco (Por exemplo "Não Receber após o vencimento" ou "Cobrar multa de 2 % após o vencimento")
instr_linha1 = "PAGÁVEL EM QUALQUER BANCO"  ' Instrucoes Linha 1
instr_linha2 = "NÃO ACEITAR APÓS VENCIMENTO" ' Instrucoes Linha 2
instr_linha3 = "" ' Instrucoes Linha 3
instr_linha4 = ""  ' Instrucoes Linha 4
instr_linha5 = ""  ' Instrucoes Linha 5



'###################################################################################
'	5.	CONFIGURAÇÕES DE PAGAMENTO VIA BRPAY
'###################################################################################

'## Você deseja colocar a opção BRpay como Forma de Pagamento?
brpay_aceitar_pagamentos = "Sim" 'Deixe "Sim" para usar ou então escreva "Nao"

brpay_email = "loja@loja.com.br" 'Seu email cadastrado na BRpay
brpay_moeda = "BRL" 'Tipo de moeda que o seu site trabalha. (BRL = Brasil Real)

brpay_token = "00000000000" 'Digite o seu Token cadastrado na BRpay. Você poderá recuperar/gerar seu Token, através
'do menu "Meus Dados >> Retorno Automático"

brpay_aceitar_cartao_credito = "Sim" 'Deixe "Sim" caso você aceite pagamentos por cartão de crédito
'através da BRpay, ou escreva "Nao" caso você não aceite pagamentos por cartão de crédito pela BRpay

brpay_tipo_calculo_frete = "2" 'Digite o tipo de cálculo de frete que você deseja que a BRpay calcule
'Você deverá configurar o tipo de cálculo de frete no menu "Meus Dados >> "Preferências Web e Frete"
'**** OPÇÕES ****
' "0" - Sem frete / frete grátis
' "1" - Cobre sempre o valor especificado no campo frete (para múltiplos itens será sempre cobrado o 
'       valor total do frete especificado no campo frete).  
' "2" - Cobre o frete do item que tiver o maior valor de frete no carrinho de compras e para os itens  
'       restantes cobre um valor adicional por cada item extra. Cobrar por cada item extra: R$ ,   
' "3" - Cobre por peso baseado na tabela dos Correios e no CEP informado pelo cliente. O cliente poderá  
'       optar por escolher entre pagar por Encomenda Normal ou Sedex.  
'****************

brpay_tipo_frete = "" 'Digite o tipo de frete que você usa
'Você deverá configurar esta opção apenas se estiver utilizando na variável "brpay_tipo_calculo_frete"
'a opção número "3", e desejar sempre que a BRpay calcule por este tipo de frete
'**** OPÇÕES ****
' "" - O cliente poderá escolher o tipo de envio/frete
' "EN" - Sempre calcular o frete utilizando a opção de Encomenda Normal
' "SD" - Sempre calcular o frete utilizando a opção de Sedex
'****************



'###################################################################################
'	6.	CONFIGURAÇÕES DO CHEQUE
'###################################################################################

'## Você deseja colocar a opção Pagamento com Cheque como Forma de Pagamento?
mostrar_pagamento_por_cheque="Sim" 'Deixe "Sim" para usar ou então escreva "Nao"
descricao_forma_entrega_cheque = "Entregue o cheque ao funcionário credenciado no ato do recebimento da compra junto com seu recibo de entrga. Pagamento com cheque somente para entrega em domicílio"





'###################################################################################
'	7.	CONFIGURAÇÕES DAS CORES DA SUA LOJA
'###################################################################################

'Dica: Acesse o arquivo tabela_de_cores.asp para ver a Tabela de Cores e os respectivos códigos hexadecimais


'Cor do fundo na resolução 1024x768
Cor_de_fundo = "#eeeeee"

'Cor principal da loja
Cor_principal = "#198ce8"

'Cor das linhas
Cor_das_linhas = "#cccccc"

'Cor da borda do contador de visitas
Cor_do_Contador = "#fcc701"

'Cor da barra de menu e copyright
Cor_do_menu = "#FF0000" '#a0a0a0

'Cor principal dos links
Cor_dos_links ="#000000"

'Cor secundaria dos links
Cor_dos_links_secundarios ="#808080"

'Cor do texto dos menus
Texto_dos_menus = "#ffffff"

'Cor do texto da loja
Texto_da_loja = "#000000"

'Cor da borda do carrinho de compras
Cor_da_borda_carrinho_de_compras = "#b62424"

'Cor do texto do menu de navegacao de fechamento de compras
Cor_texto_menu_fechamento_compras = "#0000ff" 'Exemplo: #0000ff ou #ff4500

'##################################################################







'####################################################################
'																	 
'     NAO ALTERE ESSA PARTE, VOCÊ PODERÁ ESTRAGAR SUA LOJA !		 
'																	 
'####################################################################


    'Inicia as variaveis da Aplicação 
 	application("razaoloja") = Razao_Social
    application("nomeloja") = Nome_da_sua_loja
    application("emailloja") = Email_da_sua_loja
   	application("slogan") = Slogan_da_sua_loja
   	application("urlloja") = Endereco_do_site
   	application("endereco11") = Endereco_da_sua_loja
   	application("bairro11") = Bairro_da_sua_loja
   	application("cidade11") = Cidade_da_sua_loja
   	application("estado11") = Estado_da_sua_loja
   	application("pais11") = Pais_da_sua_loja
   	application("fone11") = Telefone_da_sua_loja
    application("CORREIOSseucep11") = seu_cep 
    application("CORREIOSmaop11") = mao_propria 
    application("CORREIOSaviso11") = aviso_recebimento 
   	application("bancopag") = Seu_banco
   	application("contapag") = Sua_conta_corrente
   	application("pagpara") = Nome_do_cedente
	application("agpag") = Sua_agencia
   	application("bancopag2") = Seu_banco2
   	application("contapag2") = Sua_conta_corrente2
   	application("pagpara2") = Nome_do_cedente2
	application("agpag2") = Sua_agencia2
	application("fonte") = Fontes_da_loja
	application("maopropria") = Preco_da_mao_propria
	application("diasentrega") = Dias_para_entrega
	application("corfundo") = Cor_de_fundo
	application("cor1") = Cor_das_linhas
	application("cor2") = Cor_do_menu
	application("cor3") = Cor_principal
	application("cor4") = Cor_dos_links
	application("cor5") = Cor_dos_links_secundarios
    application("cor6") = Cor_do_Contador
	application("fontebranca") = Texto_dos_menus
	application("fontepreta") = Texto_da_loja
	application("corborda") = Cor_da_borda_carrinho_de_compras
    application("nomecontato") = Seu_nome
	application("HostLoja") = Host_da_loja
    application("ComponenteLoja") = Componente_usado
	application("Cripto_Ativa") = Cripto_Ativa
	application("URLComponentesVisa") = URL_Componentes_Visa
    application("NumeroRegistroVisa") = Numero_Registro_Visa
    application("NomeArquivoVisa")    = Nome_Arquivo_Visa
    application("ValorAutenticacao")  = Valor_Autenticacao
    application("URLCodvRedeCard")    = URL_Codv_RedeCard
    application("FiliacaoRedeCard")   = Filiacao_RedeCard
    application("URLRetornoRedeCard") = URL_Retorno_RedeCard


'>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<

    Server.ScriptTimeOut = 60		'*** Evite usar mais do que 60 segundos
	application("vsversao") = "Virtua Developer - Pack 6.0.1 - Beta"
	application("ultimaatualizacao")  = "Terça, 19 de dezembro de 2006"
	application("link_comunidade")  = "<a class=menu  href=""http://br.groups.yahoo.com/group/virtuadeveloper"" target=_blank>Participe do Grupo Virtua Developer</a>"
	set abredb = Server.CreateObject("ADODB.Connection")
	abredb.Open(StringdeConexao)

'>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<

'Executa a função GLOBAL

set rsglobal = abredb.execute("SELECT * FROM compras Order by idcompra desc")
if rsglobal.eof then
Session("orderID") = ""
end if
rsglobal.close
set rsglobal = nothing

if Session("orderID") = "" then
set rs = abredb.execute("SELECT * FROM compras Order by idcompra desc")
	if rs.eof then
	Session("orderID") = 1
	abredb.Execute("INSERT INTO compras (idcompra, datacompra, status) values ('" &session("orderID") & "', '" & date & "', 'Compra em Aberto')")
	else
	Session("orderID") = rs("idcompra") + 1
	abredb.Execute("INSERT INTO compras (idcompra, datacompra, status) values (" &session("orderID") & ", '" & date & "','Compra em Aberto')")
	end if
session.timeout = 120
else
end if

'####################################################################



'###################################################################################
'## ARQUIVOS DE LINGUAGEM DA LOJA
'###################################################################################

'###################################################################################
'### Mostra a linguagem padrão dependendo do navegador
'### Rogério Silva - 15/01/2004 - WBSolutions - http://www.libihost.net/wbsolutions.
'### Elizeu Alcantara - 10/02/2004 - Atualizacoes e Correcoes - elizeu@onda.com.br / elizeu@cristaosite.com.br
'###################################################################################

IF Escolha <> "" then
 Response.Cookies("VirtuaStore").Expires 	=  DateAdd("d",365,date()) 'VENCE NO PROXIMO ANO
 Response.Cookies("VirtuaStore")("Linguagem")	= Escolha
End IF

IF Request("Lan") <> "" THEN
	Response.cookies("VirtuaStore")("Linguagem")= ""
	Response.cookies("VirtuaStore")("Linguagem")= Request("Lan")
END IF

strReporLingua = "?"&replace(replace(replace(replace(replace(Request.ServerVariables("Query_String") ,"&Lan=Espanol",""),"&Lan=Portugal",""),"&Lan=Brasil",""),"&Lan=English","")," ","")
strReporLingua = "?"&replace(replace(replace(replace(replace(Request.ServerVariables("Query_String") ,"Lan=Espanol",""),"Lan=Portugal",""),"Lan=Brasil",""),"Lan=English","")," ","")

SELECT CASE Request.cookies("VirtuaStore")("Linguagem")

	CASE "Brasil"
	dirlingua = "linguagens/portuguesbr"
	OpcaoLingua = "<a href='"& strReporLingua&"&Lan=English'><img src=linguagens/english.gif border=0></a>"&_
		      "<a href='"& strReporLingua&"&Lan=Portugal'><img src=linguagens/portugal.gif border=0></a>"&_
		      "<a href='"& strReporLingua&"&Lan=Espanol'><img src=linguagens/espanha.gif border=0></a>"
	%><!--#include file="linguagens/portuguesbr/linguagem.asp"--><%
	
	CASE "English"
	dirlingua = "linguagens/ingles"
	OpcaoLingua = "<a href='"& strReporLingua&"&Lan=Brasil'><img src=linguagens/brasil.gif border=0></a>"&_
		      "<a href='"& strReporLingua&"&Lan=Portugal'><img src=linguagens/portugal.gif border=0></a>"&_
		      "<a href='"& strReporLingua&"&Lan=Espanol'><img src=linguagens/espanha.gif border=0></a>"
	%><!--#include file="linguagens/ingles/linguagem.asp"--><%
	
	CASE "Portugal"
	dirlingua = "linguagens/portuguespt"
	OpcaoLingua = "<a href='"& strReporLingua&"&Lan=Brasil'><img src=linguagens/brasil.gif border=0></a>"&_
		      "<a href='"& strReporLingua &"&Lan=English'><img src=linguagens/english.gif border=0></a>"&_
		      "<a href='"& strReporLingua &"&Lan=Espanol'><img src=linguagens/espanha.gif border=0></a>"
	%><!--#include file="linguagens/portuguespt/linguagem.asp"--><%
	
	CASE "Espanol"
	dirlingua = "linguagens/espanhol"
	OpcaoLingua = "<a href='"& strReporLingua&"&Lan=Brasil'><img src=linguagens/brasil.gif border=0></a>"&_
		      "<a href='"& strReporLingua&"&Lan=Portugal'><img src=linguagens/portugal.gif border=0></a>"&_
		      "<a href='"& strReporLingua&"&Lan=English'><img src=linguagens/english.gif border=0></a>"
	%><!--#include file="linguagens/espanhol/linguagem.asp"--><%
	
	CASE ELSE
	
		'-----------------------------------------------------------------
		'### BRASIL
		'-----------------------------------------------------------------
		IF Request.ServerVariables("HTTP_ACCEPT_LANGUAGE") = "pt-br" THEN
		dirlingua = "linguagens/portuguesbr"
		OpcaoLingua = "<a href='"& strReporLingua&"&Lan=English'><img src=linguagens/english.gif border=0></a>"&_
			      "<a href='"& strReporLingua&"&Lan=Portugal'><img src=linguagens/portugal.gif border=0></a>"&_
			      "<a href='"& strReporLingua&"&Lan=Espanol'><img src=linguagens/espanha.gif border=0></a>"
				%><!--#include file="linguagens/portuguesbr/linguagem.asp"--><%
				
		'-----------------------------------------------------------------
		'### PORTUGAL
		'-----------------------------------------------------------------
		ELSEIF Request.ServerVariables("HTTP_ACCEPT_LANGUAGE") = "pt" THEN
		dirlingua = "linguagens/portuguespt"
		OpcaoLingua = "<a href='"& strReporLingua&"&Lan=Brasil'><img src=linguagens/brasil.gif border=0></a>"&_
			      "<a href='"& strReporLingua&"&Lan=English'><img src=linguagens/english.gif border=0></a>"&_
			      "<a href='"& strReporLingua&"&Lan=Espanol'><img src=linguagens/espanha.gif border=0></a>"
				%><!--#include file="linguagens/portuguespt/linguagem.asp"--><%
				
		'-----------------------------------------------------------------
		'### ESPANHOL
		'-----------------------------------------------------------------
		ELSEIF Request.ServerVariables("HTTP_ACCEPT_LANGUAGE") = "es" THEN
		dirlingua = "linguagens/espanhol"
		OpcaoLingua = "<a href='"& strReporLingua&"&Lan=Brasil'><img src=linguagens/brasil.gif border=0></a>"&_
			      "<a href='"& strReporLingua&"&Lan=English'><img src=linguagens/english.gif border=0></a>"&_
			      "<a href='"& strReporLingua&"&Lan=Portugal'><img src=linguagens/portugal.gif border=0></a>"
				%><!--#include file="linguagens/portuguespt/linguagem.asp"--><%
				
		'-----------------------------------------------------------------
		'### INGLES TB PODE SER US
		'-----------------------------------------------------------------
		ELSE
		dirlingua = "linguagens/portuguesbr"
		OpcaoLingua = "<a href='"& strReporLingua&"&Lan=English'><img src=linguagens/english.gif border=0></a>"&_
			      "<a href='"& strReporLingua&"&Lan=Portugal'><img src=linguagens/portugal.gif border=0></a>"&_
			      "<a href='"& strReporLingua&"&Lan=Espanol'><img src=linguagens/espanha.gif border=0></a>"
				%><!--#include file="linguagens/portuguesbr/linguagem.asp"--><%
		END IF
END SELECT

OpcaoLingua=replace(OpcaoLingua,"?&","?")
OpcaoLingua=replace(OpcaoLingua,"&&","&")

'###################################################################################

'if aaaa="" then   '*** Ativar   
if aaaa<>"" then   '*** Desativar

response.write "<font size=1 face=arial>"
response.write "<br> Testando as sessoes...<br> "

response.write "<br> modo_entrega: "&session("modo_entrega")
response.write "<br> usuario: "&session("usuario")
response.write "<br> orderID: "&Session("orderID")
response.write "<br> pedido1: "&Session("pedido1")
response.write "<br> PesoTotalValor: "&session("PesoTotalValor")
response.write "<br> sql: "&session("sql")
response.write "<br> sql_max: "&session("sql_max")
response.write "<br> dados_gravados_compra: "&session("dados_gravados_compra")

response.write "</font>"
end if

%>