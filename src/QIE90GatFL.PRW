/*/{Protheus.doc} QIE90GatFL
Gatilha o campo loja do fornecedor e produto baseado nas informações cadastradas na tabela SA5(Amarração Produto x Fornecedor) e SA2(Fornecedor).
@type  Static Function
@author willian.ramalho
@since 02/02/2026
@version version
@return lRetorno, .T. indica se os campos foram preenchidos e engatilhados.
/*/
Static Function QIE90GatFL()

Local aBindParam := {}
Local cAlias     := ""
Local cQuery     := ""
Local lRetorno   := .F.

If !Empty(cIE090For) .And. Empty(cIE090LjF) .And. Empty(cIE090Pro)

	cQuery += " SELECT "
	cQuery +=        " SA5.A5_FORNECE, "
	cQuery +=        " SA5.A5_LOJA, "
	cQuery +=        " SA5.A5_PRODUTO "
	cQuery +=   " FROM " + RetSqlName("SA5") + " SA5 "
	cQuery +=  " INNER JOIN " + RetSqlName("SA2") + " SA2 "
	cQuery +=     " ON SA2.A2_COD   = SA5.A5_FORNECE "
	cQuery +=    "AND SA2.A2_FILIAL = '" + xFilial("SA2") + "' "
	cQuery +=    " AND SA2.A2_LOJA  = SA5.A5_LOJA "
	cQuery +=    " AND SA2.D_E_L_E_T_ = ' ' "
	cQuery +=  " WHERE SA5.A5_FILIAL  = '" + xFilial("SA5") + "' "
	cQuery +=    " AND SA5.A5_FORNECE = ? "
    aAdd(aBindParam, {cIE090For, "S"})
	cQuery +=    " AND SA5.D_E_L_E_T_ = ' ' "
	cQuery +=    " AND SA2.A2_MSBLQL  = '2' "

	cAlias := QLTQueryManager():executeQueryWithBind(cQuery, aBindParam, .T.)

	If (cAlias)->(!Eof())
		cIE090LjF := (cAlias)->A5_LOJA
		cIE090Pro := (cAlias)->A5_PRODUTO
		lRetorno  := .T.
	Endif

	(cAlias)->(dbCloseArea())

EndIf
	
Return lRetorno
