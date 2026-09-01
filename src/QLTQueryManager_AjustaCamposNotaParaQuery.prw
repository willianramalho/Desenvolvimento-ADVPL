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
