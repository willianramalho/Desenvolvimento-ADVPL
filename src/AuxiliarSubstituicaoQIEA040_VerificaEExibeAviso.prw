/*/{Protheus.doc} verificaNecessidadeEChamaExibicaoAvisoSubstituicaoPorSmartx
Verifica no FWProfile do usuario se o aviso de substituicao da QIEA040 pela
QIEA040SX ainda deve ser exibido. Caso o usuario opte por "Lembrar mais tarde",
grava a data de expiracao (hoje + QIEA040_DIAS) para suprimir o aviso ate la.
@author willian.ramalho
@since 18/08/2026
@version P12
@return NIL
/*/
Method verificaNecessidadeEChamaExibicaoAvisoSubstituicaoPorSmartx() Class QIEA040AuxClass

	Local cDataGrava := ""
	Local dDataExp   := CToD("")
	Local lExibir    := .F.
	Local oProfile   := FWProfile():New()

	// Carrega o profile do usuario atual
	oProfile:SetUser(RetCodUsr())
	oProfile:SetProgram(QIEA040_PROG)
	oProfile:SetTask(QIEA040_TASK)
	oProfile:Load()

	cDataGrava := AllTrim(oProfile:GetStringProfile())

	If Empty(cDataGrava)
		// Nunca suprimiu: exibe o aviso
		lExibir := .T.
	Else
		// Verifica se o periodo de supressao ja expirou
		dDataExp := SToD(cDataGrava)
		lExibir  := (dDataBase >= dDataExp)
	EndIf

	If lExibir
		// Retorna .T. se o usuario clicou em "Lembrar mais tarde"
		If Self:exibeAvisoSubstituicaoPorSmartx()
			// Grava a data de expiracao: hoje + 7 dias
			oProfile:SetStringProfile(DToS(Date() + QIEA040_DIAS))
			oProfile:Save()
		EndIf
	EndIf

	FreeObj(oProfile)
	oProfile := NIL

Return
