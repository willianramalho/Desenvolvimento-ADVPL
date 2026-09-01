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
