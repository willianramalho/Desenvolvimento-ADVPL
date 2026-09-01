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
