/*{Protheus.doc} retornaProximaRevisaoEfetivadaDoCheckList
Retorna a próxima revisão efetivada do check-list
@author willian.ramalho / thiago.rover
@param cCheckList, string, Código do check-list
@since 11/09/2025
@return cRevisao, string, retorna a próxima revisão efetivada do check-list
/*/
METHOD retornaProximaRevisaoEfetivadaDoCheckList(cCheckList) CLASS QADA100CLASS

	Local cAliasQU2  := ""
	Local cQuery     := ""
	local cRvRet     := '00'
	Local oQLTQueryM := QLTQueryManager():New()

	DEFAULT cCheckList := ""

	If !Empty(cCheckList)
		cQuery := " SELECT MAX(QU2_REVIS) REVISAO "
		cQuery += " FROM " + RetSqlName("QU2")
		cQuery += " WHERE QU2_CHKLST = '" + cCheckList+"' "
		cQuery += "   AND QU2_FILIAL = '" + xFilial("QU2")+"' "
		cQuery += "   AND QU2_EFETIV = '1' "
		cQuery += "   AND D_E_L_E_T_ = ' ' "

		cQuery 	  := oQLTQueryM:changeQuery(cQuery)
		cAliasQU2 := oQLTQueryM:executeQuery(cQuery)
		If (cAliasQU2)->(!EOF())
			cRvRet := (cAliasQU2)->(REVISAO)
		EndIf
	EndIf

RETURN cRvRet
