<%

'Option Explicit

'ToDo list:
'campos memo devem ter quebra de linha HTML
'implementar adição de registros (+)
'implementar edição (lapis, &radic;) / exclusao ( &#134; )
'vai haver a necessidade de imagens ? (espero que nao)
'testar e testar

Const COLUMN_NAME       = 0
Const COLUMN_ALIAS      = 1
Const COLUMN_FORMAT     = 2      'Referências à primeira dimensão da array aColumns()
Const COLUMN_SEARCHABLE = 3
Const COLUMN_TYPE       = 4
Const COLUMN_EXPRESSION = 5
Const COLUMN_TOTAL      = 5
Const ClassVersion      = "1.2"


'+-------------------+
': PamellaGridClass  +-----------------------------------------------------+'
':                                                                         :'
': Classe para exibição de recordset, com recursos de paginação e pesquisa :'
': Autor: Rubens Farias (rubensf@bigfoot.com)                              :'
': Escrita em Dezembro / 2000                                              :'
':                                                                         :'
': Inclua este arquivo em seu script ASP                                   :'
': Defina as propriedades e então use o método BuildGrid                   :'
'+-------------------------------------------------------------------------+'

Class PamellaGridClass

 Public cSQL                     ' SQL a ser executado
 Public nMaxRows                 ' Número máximo de registros por página
 Public oConnection              ' Conexão com o banco de dados
 Public oRecordset               ' Recordset, definido com o pelo parâmetro cSQL ou passado
 Public bDestroyRecordset        ' Indica se o recordset será destruido ao final
 Public bCanSearch               ' Boolean, indicando se o recordset pode ser pesquisado

 Public cFormName                ' Nome do formulário (uso futuro)
 Public cFormAttribs             ' Propriedades da tag <FORM>

 Public cTableAttribs            ' Atributos da tag <TABLE>
 Public cPageBrowserAttribs      ' Atributos da tag <SELECT>

 Public cHeaderLabel             ' Título da tabela, inserido entre <THs>
 Public cHeaderAttribs           ' Atributos da tag <TR> com o cabeçalho
 Public cFooterAttribs           ' Atributos da tag <TR> com o rodapé (paginação)

 Public cEvenRowAttribs          ' Atributo das linhas ímpares, na tag <TR>
 Public cOddRowAttribs           ' Atributo das linhas pares, na tag <TR>

 Public cNextLabel               ' Texto que será incluído na tag <A>, indicando próxima página
 Public cNextAttribs             ' Atributos da tag <A> para a próxima página

 Public cPreviousLabel           ' Idem acima, para a página anterior
 Public cPreviousAttribs

 Public cOrderAttribs            ' Idem, para os links com ordem do recordset

 Public cSearchButtonAttribs     ' Atributos da tag <INPUT TYPE=Button>
 Public cSearchButtonLabel       ' Texto do botão
 Public cSearchTextAttribs       ' Atributos da tag <INOUT TYPE=Text>
 Public cSearchOperatorsAttribs  ' Atributos do <SELECT> com os operadores de pesquisa
 Public cSearchFieldsAttribs     ' Atributos do <SELECT> com os campos a serem pesquisados

 Public Keys                     ' Ids do server

 Private aColumns( )             ' Array, com os campos a serem exibidos
 Private nColumns                ' Número de campos a serem exibidos
 Private bAllColumns             ' Indica se todos os campos serão exibidos
 Private aAllColumnsLabels       ' Array, com todos os títulos dos campos do recordset
 Private bDemoVersion            ' Indica se é versão de demonstração

 Public Default Sub BuildGrid()
   ' Verifica se todos os dados estão ok e então processa o Grid
   if VitalProprietiesAreOk() then ReallyBuildGrid()
 End Sub

 Public Property Get Version
  Version = ClassVersion
 End Property

 Private Function VitalProprietiesAreOk()
   Dim AllRight, nFields, ColumnExists, isDestroyDefined
   AllRight         = true
   isDestroyDefined = true
   nMaxRows         = int( "0" & nMaxRows   )
   if nMaxRows <= 0 then nMaxRows     = 15
   if len( "" & cFormName          )  =  0 then cFormName          = "form"
   if len( "" & cNextLabel         )  =  0 then cNextLabel         = "Next"
   if len( "" & cPreviousLabel     )  =  0 then cPreviousLabel     = "Previous"
   if len( "" & cHeaderLabel       )  =  0 then cHeaderLabel       = "Titulo Branco"
   if len( "" & cSearchButtonLabel )  =  0 then cSearchButtonLabel = "Search!"
   if vartype(  bCanSearch         ) <> 11 then bCanSearch         = false
   if vartype(  bDestroyRecordset  ) <> 11 then bDestroyRecordset  = true: isDestroyDefined = false

   if isEmpty( oConnection ) or isNull( oConnection ) then
      AllRight = False
      ERR.Number = vbObjectError + 1001
      ERR.Description = "<b>PamellaGridClass error:</b> Connection object is invalid"
      Response.Write Err.Number & vbCRLF & ERR.Description
      ERR.Clear
   end if

   oConnection.CursorLocation = 3         ' Certidicar-se que é o cursor correto (adUserClient)
   if varType( oRecordset ) = 9 then      ' Foi passado o objeto ?
      oRecordset.PageSize  = nMaxRows
      oRecordset.CacheSize = nMaxRows
      if not isDestroyDefined then bDestroyRecordset = false
   else
      if len( cSQL & "" ) =  0 then
      AllRight = False
      ERR.Number = vbObjectError + 1002
      ERR.Description = "<b>PamellaGridClass error:</b> SQL string is empty"
      Response.Write Err.Number & vbCRLF & ERR.Description
      ERR.Clear
      end if
      set oRecordset = Server.CreateObject( "ADODB.RecordSet" )
      oRecordset.PageSize  = nMaxRows
      oRecordset.CacheSize = nMaxRows
      if not isDestroyDefined then bDestroyRecordset = true
      oRecordset.Open cSQL,  oConnection
	  	If oRecordset.Eof Then '**********LINHA COLOCADA POR FABRIZIO. QUANDO NAO ENCONTRAVA REGISTRO ESTAVA DANDO ERRO ENTAO FIZ A VERIFICAÇÃO E MANDEI PARAR
	  		Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' >"
			Response.Write  "<Tr>"
			Response.Write "<TD class='texto' align='center' >Nenhum registro encontrado</TD>"
			Response.Write "</TR>"
			Response.Write "</Table>"
			Response.end
		End if
	  
   end if

   if isEmpty( bAllColumns ) then bAllColumns = false
   if bAllColumns then
      for nFields = 0 to oRecordset.Fields.Count - 1
          if nFields <= uBound( aAllColumnsLabels ) then
             AddColumn oRecordset(nFields).name, aAllColumnsLabels( nFields ), "", "", "", ""
          else
             AddColumn oRecordset(nFields).name, "", "", "", "", ""
          end if 
      next
   end if

   '----------------------------------------------------------------------------
   'Checa se todos os campos a serem mostrados existem no recordset
   if isEmpty( nColumns ) then nColumns = -1
   for nFields = 0 to nColumns
       ColumnExists = false
       on error resume next   ' Intercepta a rotina de captura de erros, para fazer a checagem
       ColumnExists = oRecordset.Fields( aColumns( COLUMN_NAME, nFields ) ).name <> ""
       on error goto 0
       if not ColumnExists then
          if nFields > uBound( aColumns, 2 ) then exit for
          DelColumn( aColumns( COLUMN_NAME, nFields ) )
          nFields = nFields - 1
       end if
   next

   if isEmpty( nColumns ) or nColumns < 0 then
      AllRight = False
      ERR.Number = vbObjectError + 1003
      ERR.Description = "<b>PamellaGridClass error:</b> At least one column must be displayed"
      Response.Write Err.Number & vbCRLF & ERR.Description
      ERR.Clear
   end if

   'Pesquisa pelos campos nas expressoes
   for nFields  = 0 to nColumns
       aColumns( COLUMN_EXPRESSION, nFields ) = TranslateExpression( aColumns( COLUMN_EXPRESSION, nFields ) )
   next

   if vartype( Keys ) <> 8204 then Keys = array( Keys )
   bDemoVersion = FALSE '( not CheckKeys( Keys ) )

   VitalProprietiesAreOk = AllRight
 End Function

 '----------------------------------------------------------------------------
 ' Sub chamada internamente, após a verificação dos dados passados
 Private Sub ReallyBuildGrid()

      dim nRecords, nFields, FieldValue, ActualPage, PageName, MaxPage
      dim cSearchFieldName, cSearchOperator, cSearchText2Search, Criteria
      dim SortField, Text2SearchOk

      PageName   = Request.ServerVariables("SCRIPT_NAME")
      SortField  = Request.Form("_SortField")
      MaxPage    = oRecordset.PageCount
      ActualPage = min( max( int( "0" & Request.Form( "page" ) ), 1 ), MaxPage )
      if len( SortField ) > 0 then oRecordset.Sort = SortField
      cSearchFieldName      = Request.form( "_PGC_Fields" )
      cSearchOperator       = Request.form( "_PGC_Operator" )
      cSearchText2Search    = Request.form( "_PGC_Text2Search" )
      oRecordset.AbsolutePage = ActualPage

      '----------------------------------------------------------------------------
      'Processa a pesquisa no campo selecionado
      if bCanSearch and len( cSearchText2Search & "" ) > 0 then
          Text2SearchOk = false
          for nFields = 0 to nColumns
              if aColumns( COLUMN_NAME, nFields ) = cSearchFieldName then
                 select case aColumns( COLUMN_TYPE, nFields )
                     case "D": if IsDate( cSearchText2Search ) then
                                  Text2SearchOk = true
                                  Criteria = "#" & CDate( cSearchText2Search ) & "#"
                                  if cSearchOperator = "like" then cSearchOperator = "="
                               end if
                     case "N": if IsNumeric( cSearchText2Search ) then
                                 Text2SearchOk = true
                                 Criteria = CDbl( cSearchText2Search )
                                  if cSearchOperator = "like" then cSearchOperator = "="
                               end if
                     case "B": if IsNumeric( cSearchText2Search ) then
                                 Text2SearchOk = true
                                 Criteria = iif( CBool( cSearchText2Search ), "true", "false" )
                                  if cSearchOperator <> "="   and _
                                     cSearchOperator <> "<>"  then cSearchOperator = "="
                               end if
                     case "C": Text2SearchOk = true
                               if cSearchOperator = "like" then
                                  Criteria = "'%" & replace( cSearchText2Search, "'", "''" ) & "%'"
                               else
                                  Criteria = "'"  & replace( cSearchText2Search, "'", "''" ) & "'"
                               end if
                 end select
                 exit for
              end if
          next

          if Text2SearchOk then

            Criteria = cSearchFieldName & " " & cSearchOperator & " " & Criteria
            oRecordset.find Criteria   'Processa a pesquisa

            if oRecordset.eof then
               ActualPage = MaxPage
            else
               ActualPage = oRecordset.AbsolutePage
               if ( oRecordset.AbsolutePosition mod nMaxRows ) > 1 and ActualPage < MaxPage then
                  ActualPage = ActualPage + 1   'Se sobram registros, some uma página
               end if
            end if
         else
            cSearchText2Search = " Não Encontrado "
         end if

      end if

      response.write "<script type=""text/javascript"">" & vbCRLF
      response.write "<!" & "--" & vbCRLF
      response.write "function SetOrder( FieldName ){ " & vbCRLF
      response.write "   " & cFormName & "._PGC_Text2Search.value = '';" & vbCRLF
      response.write "   " & cFormName & "._SortField.value = FieldName;" & vbCRLF
      response.write "   " & cFormName & ".submit();" & vbCRLF
      response.write "}" & vbCRLF & vbCRLF
      response.write "function SetPage( PageNumber ){ " & vbCRLF
      response.write "   " & cFormName & "._PGC_Text2Search.value = '';" & vbCRLF
      response.write "   " & cFormName & ".page.value = PageNumber;" & vbCRLF
      response.write "   " & cFormName & ".submit();" & vbCRLF
      response.write "}" & vbCRLF & vbCRLF
      response.write "// -->" & vbCRLF
      response.write "</script>" & vbCRLF

	  response.write "<table width='100%' border='0' cellspacing='0' cellpadding='0' >"

      response.write "<form name=""" & cFormName & """ action=""" & request.serverVariables( "URL" ) & _
                     """ " & cFormAttribs & " method=""POST"">" & vbCRLF

      response.write "  <tr>"  & vbCRLF
      response.write "  <th>"  & vbCRLF

 	  response.write "<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#F7F7FB' >"
       '----------------------------------------------------------------------------
      'Mostra o título da tabela e cria campos hidden com parâmetros para a classe
	  'CAMPOS OCULTADOS POIS NAO QUERIA QUE MOSTRASSE O TITILO, POIS EU MESMO QUERIA FAZER O TITULO POR MOTIVOS TECNICOS
	  'Campos hiden nao foram ocultados porque senao para de funcionar a ordem ASC e DESC
      'response.write "  <tr >"  & vbCRLF
      'response.write "   <th colspan=" & ( nColumns + 1 )& " bgcolor='#000099'><font color='#FFFFFF' size='2' face='Arial, Helvetica, sans-serif' ><B>" & cHeaderLabel & "</b></Font></th>"      & vbCRLF
      response.write "   <input type=""hidden"" name=""page"" value=""" & ActualPage & """>" & vbCRLF
      response.write "   <input type=""hidden"" name=""_SortField"" value=""" & SortField & """>" & vbCRLF
      'response.write "  </tr>"  & vbCRLF

      response.write "  <tr>"  & vbCRLF
      response.write "  <th>"  & vbCRLF

      if bCanSearch then
         'response.write "     <br>" & vbCRLF

         '--------------------------------------------
         'Mostra a lista dos campos a ser pesquisada
         response.write "     <select name=""_PGC_Fields"" " & cSearchFieldsAttribs & ">" & vbCRLF
         for nFields = 0 to nColumns
             if aColumns( COLUMN_SEARCHABLE, nFields ) then
                response.write "      <option value=""" & aColumns( COLUMN_NAME, nFields ) & """" & _
                               iif(  aColumns( COLUMN_NAME, nFields ) = cSearchFieldName, " SELECTED", "" ) & _
                               ">" & aColumns( COLUMN_ALIAS, nFields ) & "</option>" & vbCRLF
             end if
         next
         response.write "     </select>" & vbCRLF

         '--------------------------------------------
         'Mostra os operadores lógicos para a pesquisa
         nFields = "     <select name=""_PGC_Operator"" " & cSearchOperatorsAttribs & ">"  & vbCRLF & _
                   "      <option value=""="">Igual</option>"                  & vbCRLF & _
                   "      <option value=""like"">Aproximado</option>"    & vbCRLF & _
                   "      <option value="">"">Maior</option>"           & vbCRLF & _
                   "      <option value=""<"">Menor</option>"              & vbCRLF & _
                   "      <option value="">="">Maior ou Igual</option>" & vbCRLF & _
                   "      <option value=""<="">Menor ou Igual</option>"    & vbCRLF & _
                   "      <option value=""<>"">Diferente</option>"             & vbCRLF & _
                   "     </select>" & vbCRLF
         response.write replace( nFields, """" & cSearchOperator & """", _
                                          """" & cSearchOperator & """ SELECTED" )

         '-------------------------------------A???u???????????@-----------
         'Mostra o textbox da string de pesquisa e o botão
         response.write "     <input type=text " & cSearchTextAttribs & _
                        " name=""_PGC_Text2Search"" size=15 value=""" & cSearchText2Search & """>" & vbCRLF
         response.write "     <input type=button " & cSearchButtonAttribs & " value=""" & cSearchButtonLabel & """ " & _
                        "onclick=""" & cFormName & "._PGC_Text2Search.value.length > 0 ? " & cFormName & _
                        ".submit() : alert('Your MUST enter text to search');"">" & vbCRLF
      end if
      response.write "  </th>"  & vbCRLF
      response.write "  </tr>"  & vbCRLF
  	  response.write "</table>" & vbCRLF

      response.write " <table " & cTableAttribs & ">" & vbCRLF

      '----------------------------------------------------------------------------
      'Exibe a mensagem, caso seja a versão de demonstração
      if bDemoVersion then
         response.write "  <tr style=""background-color:darkred; color:white; font-family:Arial; font-size: xx-small;"">"  & vbCRLF
         response.write "   <td align=""center"" colspan=" & ( nColumns + 1 )& ">" & _
                        "Esta é uma versão de demonstração da PamellaGridClass.<br>" & _
                        "Se você deseje adquiri-la, entre em contato com " & _
                        "<a style=""color: white;"" href=""mailto:rubensf@bigfoot.com?subject=PamellaGridClass"">" & _
                        "rubensf@bigfoot.com</a><br>" & _
                        "<big><b>A versão comercial não exibe esta mensagem.</b></big>" & _
                        "</td>" & vbCRLF
         response.write "  </tr>"  & vbCRLF
      end if


      '----------------------------------------------------------------------------
      'Mostra o cabeçalho da tabela, com os nomes dos campos definidos pelo usuário
      response.write "  <tr " & cHeaderAttribs & ">"  & vbCRLF
      for nFields = 0 to nColumns
          response.write "   <th nowrap>" & vbCRLF & _
                         "    " & Order( aColumns( COLUMN_NAME, nFields ), "ASC" ) & "&nbsp;" & vbCRLF & _
                         "    " & aColumns( COLUMN_ALIAS, nFields )                           & vbCRLF & _
                         "    &nbsp;" & Order( aColumns( COLUMN_NAME, nFields ), "DESC" )     & vbCRLF & _
                         "   </th>" & vbCRLF
      next
      response.write "  </tr>"  & vbCRLF

      '----------------------------------------------------------------------------
      'Mostra os dados do recordset
      for nRecords = 1 to nMaxRows
          if oRecordset.eof then exit for
          response.write "  <tr " & iif( nRecords mod 2 = 0, cOddRowAttribs, cEvenRowAttribs ) & ">"  & vbCRLF
          for nFields = 0 to nColumns
              'FieldValue = oRecordset( aColumns( COLUMN_NAME, nFields ) )
              FieldValue = eval( aColumns( COLUMN_EXPRESSION, nFields ) )
              response.write "   <td " & aColumns( COLUMN_FORMAT, nFields ) & ">"  & _
                             iif( ( FieldValue & "" ) = "", "&nbsp;", FieldValue ) & "</td>" & vbCRLF
          next
          response.write "  </tr>" & vbCRLF
          oRecordset.movenext
      next

      response.write " </table>" & vbCRLF


	  response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0'  bgcolor='#FFFFFF'>"
      '----------------------------------------------------------------------------
      ' Monta última linha, com navegação no recorset e pesquisa
      response.write "  <tr " & cFooterAttribs & ">"  & vbCRLF
      response.write "   <td colspan=" & ( nColumns + 1 ) & ">" & vbCRLF

      if ActualPage > 1 then
         response.write "     <a " & cPreviousAttribs & " href=""#"" " & _
                        " onclick=""SetPage( " & ( ActualPage - 1 ) & " ); return false"">"  & _
                        cPreviousLabel & "</a>&nbsp;" & vbCRLF
      end if

      response.write "     <select " & cPageBrowserAttribs & " name=""jump"" " & _
                     "onchange=""SetPage( jump.options[jump.selectedIndex].value );"">" & vbCRLF
      for nRecords = 1 to MaxPage
          response.write "      <option value=""" & nRecords & """" & _
                         iif( nRecords = ActualPage, " SELECTED", "" ) & ">" & _
                         "Página " & nRecords & "</option>" & vbCRLF
      next
      response.write "     </select>" & vbCRLF

      if ActualPage < MaxPage then
         response.write "     &nbsp;<a " & cNextAttribs & " href=""#"" " & _
                        " onclick=""SetPage( " & ( ActualPage + 1 ) & " ); return false"">" & _
                                     cNextLabel & "</a>" & vbCRLF
      end if

      response.write "   </td>"  & vbCRLF
      response.write "  </tr>"   & vbCRLF
	  response.write "</table>"

      response.write "   </td>"  & vbCRLF
      response.write "  </tr>"   & vbCRLF
      response.write "</form>"   & vbCRLF
	  response.write "</table>"

      response.write "<!-- Grid created with PamellaGridClass by Rubens Farias (rubensf@bigfoot.com) -->" & vbCRLF

      if bDestroyRecordset then
         oRecordset.Close     'Libera a memória alocada pelo recordset
         set oRecordset = nothing
      end if

 End Sub

 '----------------------------------------------------------------------------
 ' Método AllColumns: Adiciona todos os campos do recordset no grid.
 '   Recebe como parâmetro uma array com os títulos de todos os campos
 Public Sub AllColumns( aColumnsLabels )
   bAllColumns = true
   if varType( aColumnsLabels ) = 8204 then
      aAllColumnsLabels = aColumnsLabels
   else
      aAllColumnsLabels = array( aColumnsLabels & "" ) 'Converte em string e cria uma array
   end if
 End Sub

 '----------------------------------------------------------------------------
 ' Método AddColumn: Insere um elemento na array, referenciando o campo a ser exibido.
 '   Recebe como parâmetros: nome do campo no recordset, nome da coluna,
 '   se é pesquisável, formato da célula e a expressão de exibição
 Public Sub AddColumn( FieldName, Alias, CellFormat, Searchable, DataType, Expression )
        Dim LastItem
   if len( FieldName   & ""  ) >   0 then
      DataType = uCase( DataType )
      if len(  Alias      & ""  ) =   0 then Alias = FieldName
      if len(  Expression & ""  ) =   0 then Expression = "{{" & FieldName & "}}"
      if len(  DataType   & ""  ) =   0 or _
         int( "0" & InStr( "CDBN", DataType ) ) = 0 then DataType = "C"
      if varType( Searchable ) <> 11 then Searchable = false
      if isEmpty( nColumns ) then nColumns = -1 'Se for a primeira vez

      'Linha adicionada, por erro com VBS 5.1
      if vartype( aColumns ) = 0 then redim aColumns ( COLUMN_TOTAL, 0 )

      nColumns = nColumns + 1
      redim Preserve aColumns( COLUMN_TOTAL, nColumns )
      LastItem = ubound( aColumns, 2 )
      aColumns( 0, LastItem ) = FieldName
      aColumns( 1, LastItem ) = Alias
      aColumns( 2, LastItem ) = CellFormat
      aColumns( 3, LastItem ) = Searchable
      aColumns( 4, LastItem ) = DataType
      aColumns( 5, LastItem ) = """" & replace( Expression, """", """""" ) & """"
   end if
 End Sub

 '----------------------------------------------------------------------------
 ' Método DelColumn: Remove uma coluna da array aColumns.
 '   Recebe como parâmetro o nome do campo a ser removido
 Public Sub DelColumn( FieldName )
        Dim nRows, ColumnExists, nColumn
   if len( FieldName & "" ) > 0 then
      ColumnExists = false
      for nRows = 0 to nColumns
          ColumnExists = ColumnExists or _
                         ( aColumns( COLUMN_NAME, nRows ) = FieldName ) ' Se existe...
          if ColumnExists and nRows > 0 then
              for nColumn = 0 to COLUMN_TOTAL
                  aColumns( nColumn, nRows - 1 ) = aColumns( nColumn, nRows )
              next
          end if
      next
      if ColumnExists then
         redim Preserve aColumns( COLUMN_TOTAL, nColumns - 1 )
         nColumns = nColumns - 1
      end if
   end if
 End Sub
 '----------------------------------------------------------------------------
 ' Uso interno: Retorna o maior de dois números
 Private Function Max( valor1, valor2 )
    if valor1 > valor2 then max = valor1 else max= valor2
 End Function

 '----------------------------------------------------------------------------
 ' Uso interno: Retorna o menor de dois números
 Private Function Min( valor1, valor2 )
    if valor1 < valor2 then min = valor1 else min= valor2
 End Function

 '----------------------------------------------------------------------------
 ' Uso interno: Caso a condição seja verdadeira, retorna o primeiro valor; senão, o segundo
 Private Function iif( condicao, valor1, valor2 )
    if condicao then iif = valor1 else iif = valor2
 End Function

 '----------------------------------------------------------------------------
 ' Uso interno: Monta o link de ordenação de colunas
 Private Function Order( FieldName, OrderType )
  Order = "<a href=""#"" " & cOrderAttribs & _
          " title="""   & iif( OrderType = "ASC", "Ordem ascendente", "Ordem descendente" ) & """" & _
          " onclick=""SetOrder( '[" & FieldName & "] " & OrderType & "' ); return false"">" & _
          iif( OrderType = "ASC", "&#9650;", "&#9660;" ) & "</a>"
 End Function

 '----------------------------------------------------------------------------
 ' Uso interno: Traduz a expressão de exibição para código passível de execução
 Private Function TranslateExpression( value )
  Dim n, re, Matches, Match, item, FieldName, replaceValue
  for n = 0 to 1
      set re        = new RegExp
      re.pattern    = array( "{{(\w+)}}", "\[\[(\w+)\]\]" )( n )
      re.IgnoreCase = true
      re.Global     = true
      set Matches   = re.execute( value )
      replaceValue  = array( """ & oRecordset( ""*"" ) & """, """ & Server.URLEncode( oRecordset( ""*"" ) ) & """ )( n )

      for each Match in Matches
          FieldName = lCase( mid( Match.value, 3, len( Match.value ) - 4 ) )
          for item = 0 to nColumns
              if lCase( aColumns( COLUMN_NAME, item ) ) = FieldName then
                 value = replace( value, Match.value, replace( replaceValue, "*", aColumns( COLUMN_NAME, item ) ) )
                 exit for
              end if
          next
      next
  next
  TranslateExpression = value
 End Function

 '----------------------------------------------------------------------------
 ' Uso interno: Verifica se a chave informada corresponde a identificação do servidor
 ' Nota: Atualmente em desuso, uma vez que o código tornou-se aberto :)
 Private Function CheckKeys( Keys )
  dim n, aux, ServerName
  ServerName = Request.ServerVariables( "SERVER_NAME" )
  aux        = len( ServerName )
  CheckKeys  = false
  randomize aux
  for n = 1 to len( ServerName )
      aux = aux + log( asc( mid( ServerName, n, 1 ) ) * rnd() )
  next
  aux = left( strReverse( replace( replace( aux, ",", "" ), ".", "" ) ), 15 )
  for n = 0 to min( uBound( Keys ), 4 )
      if Keys( n ) = aux then CheckKeys = true: exit for
  next
 End Function

End Class
%>