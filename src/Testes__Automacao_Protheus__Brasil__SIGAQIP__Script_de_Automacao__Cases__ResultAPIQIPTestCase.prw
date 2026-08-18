// Trechos extraidos automaticamente de: Testes\Automação Protheus\Brasil\SIGAQIP\Script de Automacao\Cases\ResultAPIQIPTestCase.prw
// Contem SOMENTE functions/methods cujo cabecalho ProtheusDoc lista willian.ramalho como autor.
// Este arquivo NAO e o fonte completo original.

/*/{Protheus.doc} API_009
Edição de Amostra - Falha na Edição - Registro não Encontrado
@author willian.ramalho
@since 08/04/2026
/*/
METHOD API_009() CLASS ResultAPIQIPTestCase

	Local aRecnosQPR := {}
	Local cErrorMsg  := ""
	Local lSucesso   := .T.
	Local oAPI       := ResultadosEnsaiosInspecaoDeProcessosAPI():New()
	Local oHelper    := FWTestHelper()                           :New()
	Local oItems     := JsonObject()                             :New()
	Local oRegistro  := JsonObject()                             :New()

	QPK->(DbSetOrder(2)) //QPK_FILIAL+QPK_PRODUT+DTOS(QPK_EMISSA)
	If QPK->(DbSeek(xFilial("QPK") + "QIP_TESTEMOBILE100000000000001"))

		QP7->(DbSetOrder(1)) //QP7_FILIAL+QP7_PRODUT+QP7_REVI+QP7_CODREC+QP7_OPERAC+QP7_ENSAIO
		If QP7->(DbSeek(xFilial("QP7") + "QIP_TESTEMOBILE100000000000001")) //Testa registro numérico

			oRegistro["recnoInspection"] := QPK->(Recno())
			oRegistro["recnoTest"]       := QP7->(Recno())
			oRegistro["measurementDate"] := "2020-06-28"
			oRegistro["measurementTime"] := "10:25"
			oRegistro["rehearser"]       := ""
			oRegistro["testType"]        := "N"
			oRegistro["measurements"]    := {"   09,55"}
			oRegistro["textStatus"]      := ""
			oRegistro["textDetail"]      := ""
			oRegistro["protheusLogin"]   := "ADMINISTRADOR"
			oRegistro["recno"]           := Self:RetornaRecnoInvalido(99999999)

			oItems["items"] := {}
			aAdd(oItems["items"], oRegistro)

			lSucesso := !oAPI:ProcessaItensRecebidos(@oItems, @aRecnosQPR, @cErrorMsg)

			If lSucesso
				If Empty(oAPI:cErrorMessage)
					lSucesso := .F.
				EndIf
			EndIf

		Else
			lSucesso := .F.
		EndIf

		If lSucesso
			QP8->(DbSetOrder(1)) //QP8_FILIAL+QP8_PRODUT+QP8_REVI+QP8_CODREC+QP8_OPERAC+QP8_ENSAIO
			If QP8->(DbSeek(xFilial("QP8") + "QIP_TESTEMOBILE000000000000001")) //Testa registro texto

				oRegistro              := JsonObject():New()
				oItems["items"]        := {}
				oAPI:cErrorMessage     := ""

				oRegistro["recnoInspection"] := QPK->(Recno())
				oRegistro["recnoTest"]       := QP8->(Recno())
				oRegistro["measurementDate"] := "2020-06-28"
				oRegistro["measurementTime"] := "10:25"
				oRegistro["rehearser"]       := ""
				oRegistro["testType"]        := "T"
				oRegistro["textStatus"]      := ""
				oRegistro["textDetail"]      := ""
				oRegistro["protheusLogin"]   := "ADMINISTRADOR"
				oRegistro["recno"]           := Self:RetornaRecnoInvalido(99999999)
				aAdd(oItems["items"], oRegistro)

				lSucesso := !oAPI:ProcessaItensRecebidos(@oItems, @aRecnosQPR, @cErrorMsg)

				If lSucesso
					If Empty(oAPI:cErrorMessage)
						lSucesso := .F.
					EndIf
				EndIf

			Else
				lSucesso := .F.
			EndIf
		EndIf

	Else
		lSucesso := .F.
	EndIf

	//oHelper:AssertTrue(lSucesso,"")
	oHelper:AssertFalse(lSucesso,"")

Return oHelper


/*/{Protheus.doc} API_010
Edição de Amostras texto e numérica - Salvas com Sucesso
@author willian.ramalho
@since 08/04/2026
/*/
METHOD API_010() CLASS ResultAPIQIPTestCase

	Local aRecnosQPR := {}
	Local cErrorMsg  := ""
	Local lSucesso   := .T.
	Local nRecnoQPR  := 0
	Local oAPI       := ResultadosEnsaiosInspecaoDeProcessosAPI():New()
	Local oHelper    := FWTestHelper()                           :New()
	Local oItems     := JsonObject()                             :New()
	Local oRegistro  := JsonObject()                             :New()

	oHelper:UTSetParam("MV_QPINSOB", "N", .T.)
	oHelper:UTSetParam("MV_QIPQMT" , "N", .T.)

	QPK->(DbSetOrder(2)) //QPK_FILIAL+QPK_PRODUT+DTOS(QPK_EMISSA)
	If QPK->(DbSeek(xFilial("QPK") + "QIP_TESTEMOBILE000000000000001"))

		QP7->(DbSetOrder(1)) //QP7_FILIAL+QP7_PRODUT+QP7_REVI+QP7_CODREC+QP7_OPERAC+QP7_ENSAIO
		If QP7->(DbSeek(xFilial("QP7") + "QIP_TESTEMOBILE000000000000001")) //Testa registro numérico

			QPR->(DbSetOrder(5)) //QPR_FILIAL+QPR_PRODUT+QPR_REVI+QPR_FORNEC+QPR_LOJFOR+DTOS(QPR_DTENTR)+QPR_LOTE+QPR_LABOR+QPR_ENSAIO+DTOS(QPR_DTMEDI)+QPR_HRMEDI+STR(QPR_AMOSTR,1)               
			If QPR->(DbSeek(xFilial("QPR") + QPK->QPK_PRODUT)) //+ QPK->QPK_REVI + QPK->QPK_FORNEC + QPK->QPK_LOJFOR + DtoS(QPK->QPK_DTENTR) + QPK->QPK_LOTE + QP7->QP7_LABOR + QP7->QP7_ENSAIO))
				nRecnoQPR := QPR->(Recno())

				oRegistro["recnoInspection"] := QPK->(Recno())
				oRegistro["recnoTest"]       := QP7->(Recno())
				oRegistro["testID"]          := AllTrim(QP7->QP7_ENSAIO)
				oRegistro["measurementDate"] := "2026-04-09" 
				oRegistro["measurementTime"] := "14:32"
				oRegistro["rehearser"]       := ""
				oRegistro["testType"]        := "N"
				oRegistro["measurements"]    := {"   09,55"}
				oRegistro["textStatus"]      := ""
				oRegistro["textDetail"]      := ""
				oRegistro["protheusLogin"]   := "ADMINISTRADOR"
				oRegistro["recno"]           := nRecnoQPR

				oItems["items"] := {}
				aAdd(oItems["items"], oRegistro)

				lSucesso := oAPI:ProcessaItensRecebidos(@oItems, @aRecnosQPR, @cErrorMsg)

			Else
				lSucesso := .F.
			EndIf

		Else
			lSucesso := .F.
		EndIf

		If lSucesso
			QP8->(DbSetOrder(1)) //QP8_FILIAL+QP8_PRODUT+QP8_REVI+QP8_ENSAIO
			If QP8->(DbSeek(xFilial("QP8") + "QIP_TESTEMOBILE000000000000001"))

				QPR->(DbSetOrder(5)) //QPR_FILIAL+QPR_PRODUT+QPR_REVI+QPR_FORNEC+QPR_LOJFOR+DTOS(QPR_DTENTR)+QPR_LOTE+QPR_LABOR+QPR_ENSAIO+DTOS(QPR_DTMEDI)+QPR_HRMEDI+STR(QPR_AMOSTR,1)               
				If QPR->(DbSeek(xFilial("QPR") + QPK->QPK_PRODUT))
					nRecnoQPR := QPR->(Recno())

					oRegistro              := JsonObject():New()
					oItems["items"]        := {}

					oRegistro["recnoInspection"] := QPK->(Recno())
					oRegistro["recnoTest"]       := QP8->(Recno())
					oRegistro["testID"]          := AllTrim(QP8->QP8_ENSAIO)
					oRegistro["measurementDate"] := "2020-06-28"
					oRegistro["measurementTime"] := "10:25"
					oRegistro["rehearser"]       := ""
					oRegistro["testType"]        := "T"
					oRegistro["textStatus"]      := "A"
					oRegistro["textDetail"]      := "OK"
					oRegistro["protheusLogin"]   := "ADMINISTRADOR"
					oRegistro["recno"]           := nRecnoQPR
					aAdd(oItems["items"], oRegistro)

					lSucesso := oAPI:ProcessaItensRecebidos(@oItems, @aRecnosQPR, @cErrorMsg)

				Else
					lSucesso := .F.
				EndIf

			Else
				lSucesso := .F.
			EndIf
		EndIf

	Else
		lSucesso := .F.
	EndIf

	//oHelper:AssertFalse(lSucesso, "Falha na edição da amostra. ")
	oHelper:AssertTrue(lSucesso,"")
	// Recupera parametros padroes do Sistema
	oHelper:UTRestParam(oHelper:aParamCT) 

Return oHelper


/*/{Protheus.doc} API_011
Exclusão de Amostra de Resultados Numérica
@author willian.ramalho
@since 08/04/2026
/*/
METHOD API_011() CLASS ResultAPIQIPTestCase
	Local cChaveQPK := ""
	Local lSucesso  := .T.
	Local nRecnoQPR := 0
	Local oAPI      := ResultadosEnsaiosInspecaoDeProcessosAPI():New()
	Local oHelper   := FWTestHelper()                           :New()

	QPK->(DbSetOrder(2)) //QPK_FILIAL+QPK_PRODUT+QPK_ENTINV+QPK_LOTINV
	If QPK->(DbSeek(xFilial("QPK") + "QIP_TESTEMOBILE000000000000002"))

		QP7->(DbSetOrder(1)) //QP7_FILIAL+QP7_PRODUT+QP7_REVI+QP7_ENSAIO
		If QP7->(DbSeek(xFilial("QP7") + "QIP_TESTEMOBILE000000000000002"))

			QPR->(DbSetOrder(5)) //QPR_FILIAL+QPR_PRODUT+QPR_REVI+QPR_FORNEC+QPR_LOJFOR+DTOS(QPR_DTENTR)+QPR_LOTE+QPR_LABOR+QPR_ENSAIO+DTOS(QPR_DTMEDI)+QPR_HRMEDI+STR(QPR_AMOSTR,1)               
			If QPR->(DbSeek(xFilial("QPR") + QPK->QPK_PRODUT)) //+ QPK->QPK_REVI + QPK->QPK_FORNEC + QPK->QPK_LOJFOR + DtoS(QPK->QPK_DTENTR) + QPK->QPK_LOTE + QP7->QP7_LABOR + QP7->QP7_ENSAIO))
				nRecnoQPR := QPR->(Recno())
				lSucesso  := oAPI:DeletaAmostraSemResponse(nRecnoQPR, @cChaveQPK)
			Else
				lSucesso := .F.
			EndIf

		Else
			lSucesso := .F.
		EndIf

	Else
		lSucesso := .F.
	EndIf

	oHelper:AssertTrue(lSucesso,"")
Return oHelper


/*/{Protheus.doc} API_012
Exclusão de Amostra de Resultados Texto
@author willian.ramalho
@since 08/04/2026
/*/
METHOD API_012() CLASS ResultAPIQIPTestCase
	Local cChaveQPK := ""
	Local lSucesso  := .T.
	Local nRecnoQPR := 0
	Local oAPI      := ResultadosEnsaiosInspecaoDeProcessosAPI():New()
	Local oHelper   := FWTestHelper()                           :New()

	QPK->(DbSetOrder(2)) //QPK_FILIAL+QPK_PRODUT+QPK_ENTINV+QPK_LOTINV
	If QPK->(DbSeek(xFilial("QPK") + "QIP_TESTEMOBILE000000000000003"))

		QP8->(DbSetOrder(1)) //QP8_FILIAL+QP8_PRODUT+QP8_REVI+QP8_ENSAIO
		If QP8->(DbSeek(xFilial("QP8") + "QIP_TESTEMOBILE000000000000003"))

			QPR->(DbSetOrder(5)) //QPR_FILIAL+QPR_PRODUT+QPR_REVI+QPR_FORNEC+QPR_LOJFOR+DTOS(QPR_DTENTR)+QPR_LOTE+QPR_LABOR+QPR_ENSAIO+DTOS(QPR_DTMEDI)+QPR_HRMEDI+STR(QPR_AMOSTR,1)               
			If QPR->(DbSeek(xFilial("QPR") + QPK->QPK_PRODUT)) //+ QPK->QPK_REVI + QPK->QPK_FORNEC + QPK->QPK_LOJFOR + DtoS(QPK->QPK_DTENTR) + QPK->QPK_LOTE + QP8->QP8_LABOR + QP8->QP8_ENSAIO))
				nRecnoQPR := QPR->(Recno())
				lSucesso  := oAPI:DeletaAmostraSemResponse(nRecnoQPR, @cChaveQPK)
			Else
				lSucesso := .F.
			EndIf

		Else
			lSucesso := .F.
		EndIf

	Else
		lSucesso := .F.
	EndIf

	oHelper:AssertTrue(lSucesso,"")
Return oHelper


/*/{Protheus.doc} RetornaRecnoInvalido
Retorna um Recno que não existe na tabela QPR, partindo de nRecno e decrementando até encontrar um inválido
@author willian.ramalho
@since 08/04/2026
@param 01 - nRecno, numérico, recno inicial para verificação
@return nRecno, numérico, recno que não existe na tabela QPR
/*/
METHOD RetornaRecnoInvalido(nRecno) CLASS ResultAPIQIPTestCase
	DbSelectArea("QPR")
	QPR->(DbGoTo(nRecno))
	If !QPR->(Eof()) // registro existe -> decrementa e tenta novamente
		nRecno := Self:RetornaRecnoInvalido(nRecno - 1)
	EndIf
Return nRecno
