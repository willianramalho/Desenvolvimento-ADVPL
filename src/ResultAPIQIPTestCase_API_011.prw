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
