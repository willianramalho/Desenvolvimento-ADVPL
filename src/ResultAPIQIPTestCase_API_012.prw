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
