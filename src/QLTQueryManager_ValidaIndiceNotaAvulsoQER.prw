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
