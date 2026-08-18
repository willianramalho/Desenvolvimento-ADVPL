// Trechos extraidos automaticamente de: Fontes_Doc\Master\Fontes\Gestão de Qualidade\Gestão de Inspeção de Entradas\QIEA090.PRW
// Contem SOMENTE functions/methods cujo cabecalho ProtheusDoc lista willian.ramalho como autor.
// Este arquivo NAO e o fonte completo original.

/*/{Protheus.doc} FieldsUser
Percorre a aHeader e, para cada campo customizado que o cliente possui na QEH, alimenta a linha nCnt do aCols
com o valor vindo de QEH (quando o registro já existe) ou com o valor
padrão do campo via CriaVar() (quando é um novo registro).

PREACONDICOES:
- Se lFoundQEH == .T., o banco de dados QEH DEVE estar posicionado no registro correto.
- As variáveis aHeader e aCols são herdadas do escopo pai como Private.

@author willian.ramalho
@since 23/07/2026
@type Static Function
@param nCnt, 	Numerico, Linha corrente do aCols a ser preenchida
@param lFoundQEH, Logico, Indica se o registro ja existe em QEH (.T.) ou se e novo (.F.)
/*/
Static Function FieldsUser(nCnt,lFoundQEH)

	Local cCampo     := ""
	Local nFieldUser := 0

	For nFieldUser := 1 To Len(aHeader)
		// Percorre a aHeader e verifica se o campo e de usuario e nao e Virtual, se sim, alimenta o aCols com o valor do campo
		If GetSx3Cache(aHeader[nFieldUser,2], "X3_PROPRI") == "U" .AND.;
			GetSx3Cache(aHeader[nFieldUser,2], "X3_CONTEXT") <> "V"
			cCampo := AllTrim(aHeader[nFieldUser,2])
			If lFoundQEH
				// Pré-condição: QEH deve estar posicionado no registro correto
				aCols[nCnt][nFieldUser] := QEH->(&(cCampo))
			Else
				aCols[nCnt][nFieldUser] := CriaVar(cCampo)
			EndIf
		EndIf
	Next nFieldUser

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A090GrvST ³ Autor ³ Vera Lucia S. Simoes  ³ Data ³ 08/06/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava os Skip-Testes Individuais                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIEA090                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/


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
