// Trechos extraidos automaticamente de: Fontes_Doc\Master\Fontes\Gestão de Qualidade\Genéricos\QLTQueryManager.prw
// Contem SOMENTE functions/methods cujo cabecalho ProtheusDoc lista willian.ramalho como autor.
// Este arquivo NAO e o fonte completo original.

/*/{Protheus.doc} validaIndiceNotaAvulsoNaQEL
Valida se o índice QEL_NISERI está presente na tabela QEL
@type	Method
@author willian.ramalho
@since 05/08/2025
@return lIndAvulso, lógico, .T. - indica se o índice está presente na tabela QEL
/*/
METHOD validaIndiceNotaAvulsoNaQEL() CLASS QLTQueryManager

    Local aIndexes   := Nil
    Local lIndAvulso := Nil
    Local nRelease   := GetRPORelease()

    If slIndAvQEL == Nil .Or. nRelease > "12.1.2510"
        aIndexes    := FWSIXUtil():GetAliasIndexes("QEL")
        lIndAvulso  := "QEL_NISERI" $ AllTrim(aIndexes[3][5])
        slIndAvQEL := lIndAvulso
    Else
         lIndAvulso := slIndAvQEL
    EndIf

Return lIndAvulso


/*/{Protheus.doc} validaIndiceNotaAvulsoNaQER
Valida se o índice QER_NISERI está presente na tabela QER
@type	Method
@author willian.ramalho / brunno.costa
@since 05/03/2026
@return lIndAvulso, lógico, .T. - indica se o índice está presente na tabela QER
/*/
METHOD validaIndiceNotaAvulsoNaQER() CLASS QLTQueryManager

    Local aIndexes   := Nil
    Local lIndAvulso := Nil
    Local nRelease   := GetRPORelease()

    If slIndAvQER == Nil .Or. nRelease > "12.1.2510"
        aIndexes    := FWSIXUtil():GetAliasIndexes("QER")
        lIndAvulso  := "QER_NISERI" $ AllTrim(aIndexes[5][6])
        slIndAvQER := lIndAvulso
    Else
         lIndAvulso := slIndAvQER
    EndIf

Return lIndAvulso


/*/{Protheus.doc} validaTamanhoCamposChaveNF
Valida Tamanho dos Campos nas tabelas QER e/ou QEL
@type	Method
@author willian.ramalho
@since 05/08/2025
@param 01 - cAliasA, caracter, nome do alias da tabela A para validação (SD1 ou QEK)
@param 02 - cAliasB, caracter, nome do alias da tabela B para valida (QEL ou QER)
@param 03 - cCmpNISERI, caracter, campo _NSERI para validação com concatenação de campos
@param 04 - cAliasOLD, caracter, nome do alias antigo para validação
@return lValido, lógico, .T. - indica se os tamanhos dos campos são do mesmo tamanho das tabelas QER e QEL
/*/
Method validaTamanhoCamposChaveNF(cAliasA, cAliasB, cCmpNISERI, cAliasOLD) CLASS QLTQueryManager

    Local aCampos    :={"_NTFISC", "_SERINF", "_ITEMNF"}
    Local aCamposSD1 :={"_DOC"   , "_SERIE" , "_ITEM"}
    Local cCpsErros  := ""
    Local lValido    := .T.
    Local nIndice    := 0
    Local nTamCampos := GetSX3Cache(cAliasOLD + Iif("D1" $ cAliasOLD, aCamposSD1[1], aCampos[1]), "X3_TAMANHO") +;
                        GetSX3Cache(cAliasOLD + Iif("D1" $ cAliasOLD, aCamposSD1[2], aCampos[2]), "X3_TAMANHO") +;
                        GetSX3Cache(cAliasOLD + Iif("D1" $ cAliasOLD, aCamposSD1[3], aCampos[3]), "X3_TAMANHO")


    If (cAliasB == "QEL" .And. Self:validaIndiceNotaAvulsoNaQEL()) .Or. (cAliasB == "QER" .And. Self:validaIndiceNotaAvulsoNaQER())

        If GetSX3Cache(cCmpNISERI, "X3_TAMANHO") != nTamCampos 
            Help(" ",1,"QIENISERI")
            lValido := .F.
        EndIf

    Else

        For nIndice := 1 to Len(aCampos) -1

            If GetSX3Cache(cAliasA + Iif("D1" $ cAliasA, aCamposSD1[nIndice], aCampos[nIndice]), "X3_TAMANHO") != GetSX3Cache(cAliasB + Iif("D1" $ cAliasB, aCamposSD1[nIndice], aCampos[nIndice]), "X3_TAMANHO")
                cCpsErros += Iif(Empty(cCpsErros), "", ", ") + cAliasA + Iif("D1" $ cAliasA, aCamposSD1[nIndice], aCampos[nIndice]) + "/" +;
                                                               cAliasB + Iif("D1" $ cAliasB, aCamposSD1[nIndice], aCampos[nIndice])
            EndIf

        Next nIndice

        If  !Empty(cCpsErros)
             // STR0019 - Os campos: 
             // STR0020 - Estão com tamanhos incompatíveis.
             // STR0021 - Ajuste o tamanho dos campos _NTFISC, _SERINF e _ITEMNF nos alias QER, QEL, QEK e SD1.
             Help(NIL, NIL, "QIENISERI1", NIL, STR0019 + " '" + cCpsErros + "' " + STR0020, 1, 0, NIL, NIL, NIL, NIL, NIL, {STR0021})
            lValido := .F.
        EndIf

    EndIf

Return lValido


/*/{Protheus.doc} retornaCamposDaNotaFiscalParaChaveDePesquisa
Method responsável por retornar a chave de pesquisa da Nota Fiscal.
@type	Method
@author willian.ramalho
@since 05/08/2025
@param 01 -       cAlias   , caracter, nome da tabela.
@param 02 -       lPonteiro, lógico  , indica se deverá utilizar o ponteiro no retorno da chave.
@param 03 -       cPonteiro, caracter, tipo de ponteiro para retorno da chave, por padrão "->".
@Return cRetorno, Caracter , retorna se sera utilizado o campo _NISERI ou a concatenação dos campos _NTFISC, _SERINF e _ITEMNF para chave de pesquisa da Nota Fiscal, dependendo da validação do índice de nota avulso na QEL.
/*/
Method retornaCamposDaNotaFiscalParaChaveDePesquisa(cAlias, lPonteiro, cPonteiro) CLASS QLTQueryManager
 
    Local aCampos     :={"_NTFISC + ", "_SERINF + ", "_ITEMNF ", "_NISERI"}
    Local cRetorno    := ""
    Local cUsaPont    := ""

    Default cPonteiro := "->"
    cUsaPont := Iif(lPonteiro, cAlias + cPonteiro + cAlias, cAlias)

    If (cAlias == "QEL" .And. Self:validaIndiceNotaAvulsoNaQEL()) .Or. (cAlias == "QER" .And. Self:validaIndiceNotaAvulsoNaQER())
        cRetorno := cUsaPont + aCampos[4]
    Else
        cRetorno := cUsaPont + aCampos[1] + cUsaPont + aCampos[2] + cUsaPont + aCampos[3]
    EndIf

Return cRetorno


/*/{Protheus.doc} retornaTamanhoDosCamposDaNotaFiscal
@type	Method
@author willian.ramalho
@since 19/02/2026
@param 01 - cAlias   , caracter, nome da tabela.
@return nTamCampos, numerico , retorna o tamanho total dos campos que compõe a chave de pesquisa da Nota Fiscal, dependendo da validação do índice de nota avulso na QEL.
*/
Method retornaTamanhoDosCamposDaNotaFiscal(cAlias) CLASS QLTQueryManager
 
    Local aCampos    :={"_NTFISC + ", "_SERINF + ", "_ITEMNF ", "_NISERI"}
    Local nTamCampos := 0

    If (cAlias == "QEL" .And. Self:validaIndiceNotaAvulsoNaQEL()) .Or. (cAlias == "QER" .And. Self:validaIndiceNotaAvulsoNaQER())
        nTamCampos := GetSX3Cache(cAlias + aCampos[4], "X3_TAMANHO")
    Else
        nTamCampos := GetSX3Cache(cAlias + aCampos[1], "X3_TAMANHO") 
        nTamCampos += GetSX3Cache(cAlias + aCampos[2], "X3_TAMANHO") 
        nTamCampos += GetSX3Cache(cAlias + aCampos[3], "X3_TAMANHO") 
    EndIf

Return nTamCampos


/*/{Protheus.doc} ajustaCamposNotaParaArray
Ajusta Array com base no Indice da QEL para campos de Nota Avulsa.
@type	Method
@author willian.ramalho
@since 03/03/2026
@param 01 - aGetCampos   , array   , array de campos para ser tratado com base no Indice da QEL.
@param 02 - cAlias       , caracter, nome da tabela.
@return   - aGetCampos   , array   , array de campos ajustado com base no Indice da QEL.
*/
Method ajustaCamposNotaParaArray(aGetCampos, cAlias) CLASS QLTQueryManager
 
    Local aCampos     := {cAlias+"_NTFISC", cAlias+"_SERINF", cAlias+"_ITEMNF", cAlias+"_NISERI"}
    
    If (cAlias == "QEL" .And. Self:validaIndiceNotaAvulsoNaQEL()) .Or. (cAlias == "QER" .And. Self:validaIndiceNotaAvulsoNaQER())
        aAdd(aGetCampos, aCampos[4])
    Else
        aAdd(aGetCampos, aCampos[1])
        aAdd(aGetCampos, aCampos[2])
        aAdd(aGetCampos, aCampos[3])
    EndIf

Return aGetCampos


/*/{Protheus.doc} ajustaCamposNotaParaComparacaoEmQuery
Ajusta campos de Nota Avulsa para comparação em query com base no índice da QEL.
@type	Method
@author willian.ramalho
@since 03/03/2026
@param 01 - cAlias      , caracter, nome da tabela.
@param 02 - cPonteiro   , caracter, tipo de ponteiro para retorno da chave, por padrão "->".
@param 03 - cPrefixo    , caracter, prefixo do alias do campo para comparação
@param 04 - cPontCmpar  , caracter, Ponteiro da concatenação
Return    - cQuery      , caracter, query de comparação entre os campos de Nota Avulsa com base no índice da QEL para ser utilizado em cláusula WHERE ou ON de query.
*/
Method ajustaCamposNotaParaComparacaoEmQuery(cAlias, cPonteiro, cPrefixo, cPontCmpar) CLASS QLTQueryManager
 
    Local aCampos := {"_NTFISC", "_SERINF", "_ITEMNF", "_NISERI"}
    Local cQuery  := ""

    Default cPonteiro := "->"
    
    If (cAlias == "QEL" .And. Self:validaIndiceNotaAvulsoNaQEL()) .Or. (cAlias == "QER" .And. Self:validaIndiceNotaAvulsoNaQER())
        cQuery :=         cPonteiro+cAlias+aCampos[4] +"= " + self:acertaConcatenacaoComConcat(cPrefixo, "QEK_NTFISC+QEK_SERINF+QEK_ITEMNF")
    Else
        cQuery :=         cPonteiro+cAlias+aCampos[1]+" = "+cPrefixo+cPontCmpar+aCampos[1]
        cQuery += " AND "+cPonteiro+cAlias+aCampos[2]+" = "+cPrefixo+cPontCmpar+aCampos[2]
        cQuery += " AND "+cPonteiro+cAlias+aCampos[3]+" = "+cPrefixo+cPontCmpar+aCampos[3]
    EndIf

Return cQuery
