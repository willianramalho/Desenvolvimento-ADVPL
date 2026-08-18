/*/{Protheus.doc} verificaSeCheckListEstaRespondido
Method responsável por verificar se o check-list está respondido.

@author willian.ramalho / thiago.rover
@since 07/11/2025
@param cCheckList, caracter, Código do check-list a ser verificado.
@param cRevisao  , caracter, Revisão do check-list a ser verificado.
@param cTopico   , caracter, Tópico do check-list a ser verificado.
@return lRetorno, logico, .T. - Verdadeiro SE o check-list está respondido
						  .F. - Falso se NÃO está respondido
/*/
METHOD verificaSeCheckListEstaRespondido(cCheckList, cRevisao, cTopico) CLASS QADA100CLASS 

	Local aBindParam   := {}
	Local cAliasQUD    := ""
	Local cQuery       := ""
	Local lChangeQuery := .F.
	Local lRetorno     := .F.
	Local oQLTQueryM   := QLTQueryManager():New()

	DEFAULT cCheckList := ""
	DEFAULT cRevisao   := ""
	DEFAULT cTopico    := ""

	cQuery := " SELECT 1 "
	cQuery += " FROM " + RetSqlName("QUD")
	cQuery += " WHERE QUD_FILIAL = ? "
	cQuery +=   " AND QUD_NUMAUD = ? "    // Auditoria
	cQuery +=   " AND QUD_CHKLST = ? "    // Check List
	cQuery +=   " AND QUD_REVIS  = ? "    // Revisão
	cQuery +=   " AND QUD_CHKITE = ? "    // Tópico

	aAdd(aBindParam, {xFilial("QUD") , "S"})
	aAdd(aBindParam, {QUB->QUB_NUMAUD, "S"})
	aAdd(aBindParam, {cCheckList     , "S"})
	aAdd(aBindParam, {cRevisao       , "S"})
	aAdd(aBindParam, {cTopico        , "S"})

	cQuery +=   " AND NULLIF(QUD_NOTA                , 0  ) IS NOT NULL " // Nota Questao
	cQuery +=   " AND NULLIF(RTRIM(LTRIM(QUD_DTAVAL)), '' ) IS NOT NULL " // Dt Avaliacao
	cQuery +=   " AND NULLIF(RTRIM(LTRIM(QUD_FILMAT)), '' ) IS NOT NULL " // Filial do Usuario
	cQuery +=   " AND NULLIF(RTRIM(LTRIM(QUD_CODAUD)), '' ) IS NOT NULL " // Codigo do Auditor
	cQuery +=   " AND D_E_L_E_T_ = ' ' "
	
	cAliasQUD := oQLTQueryM:executeQueryWithBind(cQuery, aBindParam, lChangeQuery)

	If (cAliasQUD)->(!EOF())
		lRetorno := .T.
	EndIf

	(cAliasQUD)->(DbCloseArea())

RETURN lRetorno
