/*/{Protheus.doc} QPPVERAVISO
Verifica e exibe o aviso de descontinuacao do modulo PPAP.
A preferencia de supressao e persistida por usuario via FWProfile por contexto.
@type Function
@author willian.ramalho
@since 01/07/2026
@version P12
@param cContexto, caractere, "LOAD" para entrada do modulo ou "ROTINA" para entrada de rotina
/*/
Function QPPVERAVISO(cContexto)

	Local cDataGrava := ""
	Local cTask      := ""
	Local dDataExp   := CToD("")
	Local lExibir    := .F.
	Local oProfile   := FWProfile():New()

	Default cContexto := "ROTINA"

	cContexto := Upper(AllTrim(cContexto))
	If cContexto == "LOAD"
		cTask := QPPAP_TASK_LOAD
	Else
		cTask := QPPAP_TASK_ROT
	EndIf

	// Carrega o profile do usuario atual
	oProfile:SetUser(RetCodUsr())
	oProfile:SetProgram(QPPAP_PROG)
	oProfile:SetTask(cTask)
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
		If QPPMSGWARN()
			// Grava a data de expiracao: data base do servidor + 7 dias
			oProfile:SetStringProfile(DToS(dDataBase + QPPAP_DIAS))
			oProfile:Save()
		EndIf
	EndIf

	FreeObj(oProfile)
	oProfile := Nil

Return Nil
