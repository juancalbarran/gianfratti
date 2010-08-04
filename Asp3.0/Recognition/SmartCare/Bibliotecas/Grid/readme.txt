
PamellaGridClass v1.2
=====================
Classe para exibição de recordset, com recursos de paginação e pesquisa.
Desenvolvido por Rubens Farias (rubensf@bigfoot.com) em Dez/2000.
Caso interesse alguém, "Pamella" será o nome de minha filha, que nascerá em Mar/2001 :)

Vale o de sempre:

 - Esta classe foi desenvolvida para uso pessoal. O uso comercial é *vedado*,
   sem a prévia autorização do autor.  Isso  significa  que  você  não  pode
   comercializar esta classe ou incorporá-la em nenhum projeto comercial.

 - O autor não pode ser responsabilizado pela utilização correta ou incorreta
   desta classe. Em caso de dúvidas, não a use.

 - Cartões postais são bem vindos. Caso possa enviar-me um cartão postal de sua
   região, contacte-me por email, para que eu possa passar o endereço.

 - Sugestões/comentários são altamente bem vindos. Caso tenha gostado,
   não hesite em enviar-me um email.


Propriedades:
-------------

 cSQL                    : SQL a ser executado
 nMaxRows                : Número máximo de registros por página. Default 15.
 oConnection             : Conexão com o banco de dados
 oRecordset              : Recordset, definido com o pelo parâmetro cSQL ou passado
 bDestroyRecordset       : Indica se o recordset será destruido ao final. Default true.

 cFormName               : Nome do formulário (uso futuro). Default "form".
 cFormAttribs            : Propriedades da tag <FORM>*

 cTableAttribs           : Atributos da tag <TABLE>*
 cPageBrowserAttribs     : Atributos da tag <SELECT>*

 cHeaderLabel            : Título da tabela, inserido entre <THs>*.
                           Default "PamellaGridClass Demo"
 cHeaderAttribs          : Atributos da tag <TR> com o cabeçalho*
 cFooterAttribs          : Atributos da tag <TR> com o rodapé (paginação)*
 
 cEvenRowAttribs         : Atributo das linhas ímpares, na tag <TR>*
 cOddRowAttribs          : Atributo das linhas pares, na tag <TR>*
 
 cNextLabel              : Texto que será incluído na tag <A>,
                           indicando próxima página. Default "Next".
 cNextAttribs            : Atributos da tag <A> para a próxima página*
 
 cPreviousLabel          : Idem acima, para a página anterior. Default "Previous".
 cPreviousAttribs
 
 cOrderAttribs           : Idem, com os atributos dos links de ordenação do recordset

 bCanSearch              : Valor lógico, indicando se o recordset pode ser pesquisado.
                           Default false.
 cSearchButtonAttribs    : Atributos da tag <INPUT TYPE=Button>*
 cSearchButtonLabel      : Texto do botão da pesquisa (VALUE=""). Default "Search!".
 cSearchTextAttribs      : Atributos da tag <INPUT TYPE=Text>*
 cSearchOperatorsAttribs : Atributos do <SELECT> com os operadores de pesquisa*
 cSearchFieldsAttribs    : Atributos do <SELECT> com os campos a serem pesquisados*
 
 Keys                    : Chaves para execução da classe. Recebe uma array com até cinco
                           chaves para identificação da versão comercial. Caso nenhuma
                           seja válida, uma mensagem indicando que se trata de uma versão
                           de demonstração é exibida. Esta é a única diferença entre a
                           versão comercial da demo. A chave que é distribuída neste demo
                           supõe que o nome do servidor seja "localhost".
 Version                 : Retorna a versão atual da classe (read-only)


* Quando é dito "atributos da tag", significa que é  permitida a utilização de  quaisquer
  propriedades da tag (class, border, bgcolor, etc), não sendo feita nenhuma consistência
  nestes valores, uma vez que são dependentes da versão do HTML que está sendo processada.
  Assim, o programador precisa preocupar-se com a  compatibilidade  entre  browsers,  bem
  como com a correta sintaxe dos mesmos. A demonstração que acompanha este pacote faz uso
  intensivo de propriedades CSS, que são dependentes de browser, sendo testadas no  IE5.5
  SP1 apenas.


Métodos:
--------

 AddColumn  : Adiciona uma coluna do recordset a ser mostrada.
              Recebe cinco parâmetros:
               - Nome do campo: Campo do recordset a ser mostrado
               - Descrição    : Nome que será mostrado no cabeçalho da tabela
               - Formato      : Definição do formato para a coluna.
                                Qualquer propriedade válida para tags TD.
               - Pesquisável  : Valor lógico, indicando se o campo pode ser pesquisado
               - Tipo do dado : Define o tipo do dado, para concatenação de strings na
                                pesquisa. Pode ser: C, D, N ou B, indicando  os  tipos
                                Char, Date, Number e Boolean.
               - Expressão    : Uma expressão que será avaliada quando a coluna for
                                exibida. Nomes de campos devem estar entre {{ }}, qdo
                                será avaliada literalmente ou entre [[]], quando será
                                adicionado o Server.URLEncode à expressão. Por exemplo:
                                "{{ RecordId }}". Se não informada, será utilizado o
                                conteúdo de "Nome do campo".

 DelColumn  : Remove uma coluna da lista de colunas que serão mostradas
              Recebe como parâmetro o nome do campo a ser removido. Este método também é
              chamado internamente, caso o campo a ser exibido não exista no recordset.

 AllColumns : Adiciona automaticamente todos os campos do recordset ao Grid.
              Recebe como parâmetro uma array, contendo todos os cabeçalhos das colunas.
              Caso o número de elementos desta array seja menor  que  o  de  campos  do
              recorset, os nomes dos campos serão usados como títulos.

 BuildGrid  : Monta o grid, com base nas informações fornecidas


Software server-side necessário:
--------------------------------

 - VBScript 5.1 Build 5010 ou superior.

   Atualizações podem ser obtidas em http://msdn.microsoft.com/scripting/vbscript/
   Você pode checar a versão do VBScript instalada com o seguinte script:

   <%@ LANGUAGE = VBScript %>
   <% response.write ScriptEngine & "<BR>" & _
                     "Versão: " & ScriptEngineMajorVersion() & "." & ScriptEngineMinorVersion() & "<BR>" & _
                     "Build: "  & ScriptEngineBuildVersion() & "<BR>" %>

 - ADO 2.5

   Atualizações para o Microsoft Data Access Components (MDAC) podem ser obtidas em http://www.microsoft.com/ado/
   Você pode checar a versão do ADO instalada com o seguinte script:
   
   <%@ LANGUAGE = VBScript %>
   <% Set objConn = Server.CreateObject("ADODB.Connection")
      On Error Resume Next
      If Err.Number <> 0 Then
         Response.Write "Objeto ADODB.Connection <B>não instalado.</B>"
      Else
         Response.Write "ADO versão " & objConn.Version & " instalado"
      End If
      Set objConn = nothing
    %>


Bugs conhecidos:
----------------

 Nenhum, até o momento.


Histórico de versões:
---------------------

 1.0  (19.12.2000)
  - Pre-release de testes (tks Mau!)

 1.0a (20.12.2000)
  - Documentação ampliada, com alguma otimização de código
  - Incluído o método DelColumn
  - Verificação da existência das colunas, antes de mostrá-las.
  - Incluidas as propriedades:
     cHeaderLabel, bCanSearch, cSearchButtonAttribs,
     cSearchButtonLabel, cSearchTextAttribs,
     cSearchOperatorsAttribs e cSearchFieldsAttribs.
  - Incluidas as propriedades Searchable e DataType no método AddColumn.
  - Consertado bug caso haja apenas uma coluna a ser exibida

 1.0b (21.12.2000)
  - Novas otimizações de código e modificações/acertos na documentação
  - Incluida a propriedade oRecordset. Caso passado, a propriedade cSQL é ignorada
  - Incluida a propriedade bDestroyRecordset.

 1.1 (16.01.2001)
  - Incluido workaround para VBS 5.1 (redim)
  - Incluida a propriedade Expression (tks Vinicius Soares!), possibilitando
    montar expressões a serem avaliadas (ex: links)
  - Incluída a possibilidade de ordenar o recordset por colunas!
  - Incluida a propriedade cOrderAttribs, em decorrência do acréscimo das
    rotinas necessárias para a ordenação por colunas
  - A paginação agora é feita por envio de formulário, mantendo assim a
    referência à URL atual.
  - Incluida a propriedade read-only Version, retornando a versão da classe.
  - Incluida a propriedade Keys, por ter surgido a possibilidade de comercializar
    a classe.

 1.2 (29.06.2001)
  - Incluido o método AllColumns
  - Código formatado com a adição de mais comentários, uma vez que o código foi
    liberado para domínio público.
  - Houveram outras alterações (infelizmente não as documentei), mas também mantive
    o meu "ToDoList". Caso faça alguma alteração que acredite ser interessante a
    outras pessoas, não deixe de enviar-me um email.

Enjoy! :)
