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
