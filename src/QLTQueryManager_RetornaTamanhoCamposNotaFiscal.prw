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
