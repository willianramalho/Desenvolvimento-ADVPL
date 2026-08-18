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
