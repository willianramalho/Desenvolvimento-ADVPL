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
