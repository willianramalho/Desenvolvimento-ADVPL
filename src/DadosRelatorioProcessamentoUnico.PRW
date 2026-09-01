/*/{Protheus.doc} QIPRDADOS
Retorna dados do relatorio para processamento unico.
@type  Function
@author Willian.Ramalho
@since 03/06/2026
@version 1.0
@return Character, alias da query
/*/
Static Function QIPRDADOS()

	Local aBindParam := {}
	Local cAlias     := ""
	Local cQuery     := ""

	cQuery += " SELECT "
	cQuery += " 	QQ7.QQ7_PRODUT, "
	cQuery += " 	QQ7.QQ7_CLIENT, "
	cQuery += " 	QQ7.QQ7_LOJA, "
	cQuery += " 	QQ7.QQ7_LABOR, "
	cQuery += " 	QQ7.QQ7_ENSAIO, "
	cQuery += " 	QQ7.QQ7_CODREC, "
	cQuery += " 	QQ7.QQ7_OPERAC, "
	cQuery += " 	QP1.QP1_DESCPO, "
	cQuery += " 	QP7.QP7_REVI, "
	cQuery += " 	QP8.QP8_REVI "
	cQuery += " FROM " + RetSqlName("QQ7") + " QQ7 "
	cQuery += " LEFT JOIN " + RetSqlName("QP1") + " QP1 "
	cQuery += " 	ON QP1.QP1_FILIAL = ? "
	cQuery += " 	AND QP1.QP1_ENSAIO = QQ7.QQ7_ENSAIO "
	cQuery += " 	AND QP1.D_E_L_E_T_ = ? "
	cQuery += " LEFT JOIN " + RetSqlName("QP7") + " QP7 "
	cQuery += " 	ON QP7.QP7_FILIAL = ? "
	cQuery += " 	AND QP7.QP7_PRODUT = QQ7.QQ7_PRODUT "
	cQuery += " 	AND QP7.QP7_LABOR  = QQ7.QQ7_LABOR "
	cQuery += " 	AND QP7.QP7_ENSAIO = QQ7.QQ7_ENSAIO "
	cQuery += " 	AND QP7.QP7_CODREC = QQ7.QQ7_CODREC "
	cQuery += " 	AND QP7.QP7_OPERAC = QQ7.QQ7_OPERAC "
	cQuery += " 	AND QP7.D_E_L_E_T_ = ? "
	cQuery += " LEFT JOIN " + RetSqlName("QP8") + " QP8 "
	cQuery += " 	ON QP8.QP8_FILIAL = ? "
	cQuery += " 	AND QP8.QP8_PRODUT = QQ7.QQ7_PRODUT "
	cQuery += " 	AND QP8.QP8_LABOR  = QQ7.QQ7_LABOR "
	cQuery += " 	AND QP8.QP8_ENSAIO = QQ7.QQ7_ENSAIO "
	cQuery += " 	AND QP8.QP8_CODREC = QQ7.QQ7_CODREC "
	cQuery += " 	AND QP8.QP8_OPERAC = QQ7.QQ7_OPERAC "
	cQuery += " 	AND QP8.D_E_L_E_T_ = ? "
	cQuery += " WHERE QQ7.QQ7_FILIAL = ? "
	cQuery += " 	AND QQ7.QQ7_PRODUT >= ? "
	cQuery += " 	AND QQ7.QQ7_PRODUT <= ? "
	cQuery += " 	AND QQ7.QQ7_CLIENT >= ? "
	cQuery += " 	AND QQ7.QQ7_CLIENT <= ? "
	cQuery += " 	AND QQ7.QQ7_LOJA   >= ? "
	cQuery += " 	AND QQ7.QQ7_LOJA   <= ? "
	cQuery += " 	AND QQ7.D_E_L_E_T_ = ? "
	cQuery += " ORDER BY QQ7.QQ7_PRODUT, QQ7.QQ7_CLIENT, QQ7.QQ7_LOJA, QQ7.QQ7_LABOR, QQ7.QQ7_ENSAIO "

	aAdd(aBindParam, {xFilial("QP1"), "S"})
	aAdd(aBindParam, {" ", "S"})
	aAdd(aBindParam, {xFilial("QP7"), "S"})
	aAdd(aBindParam, {" ", "S"})
	aAdd(aBindParam, {xFilial("QP8"), "S"})
	aAdd(aBindParam, {" ", "S"})
	aAdd(aBindParam, {xFilial("QQ7"), "S"})
	aAdd(aBindParam, {mv_par01, "S"})
	aAdd(aBindParam, {mv_par02, "S"})
	aAdd(aBindParam, {mv_par03, "S"})
	aAdd(aBindParam, {mv_par05, "S"})
	aAdd(aBindParam, {mv_par04, "S"})
	aAdd(aBindParam, {mv_par06, "S"})
	aAdd(aBindParam, {" ", "S"})

	cAlias := QLTQueryManager():executeQueryWithBind(cQuery, aBindParam, .T.)

Return cAlias
