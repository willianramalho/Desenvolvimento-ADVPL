/*/{Protheus.doc} verificaNecessidadeEChamaExibicaoAvisoSubstituicaoPorSmartx
Verifica e exibe o aviso de substituicao das rotinas QIEA270/QIEA271 pelas novas QIEA270SX/QIEA271SX.
A preferencia de supressao e persistida por usuario via FWProfile, de forma independente para cada rotina.
Deve ser chamada no inicio da rotina QIEA270 (nOpcao 1 ou 2), antes de qualquer processamento.
@author willian.ramalho
@since 25/08/2026
@version P12
@param nOpcao, numerico, 1 para QIEA270 (Fatores I.A.) ou 2 para QIEA271 (Fatores I.Q.S.)
/*/
Method verificaNecessidadeEChamaExibicaoAvisoSubstituicaoPorSmartx(nOpcao) Class QIEA270AuxClass

    Local cDataGrava := ""
    Local cProg      := If(nOpcao == 2, QIEA271_PROG, QIEA270_PROG)
    Local dDataExp   := CToD("")
    Local lExibir    := .F.
    Local oProfile   := FWProfile():New()

    // Carrega o profile do usuario atual
    oProfile:SetUser(RetCodUsr())
    oProfile:SetProgram(cProg)
    oProfile:SetTask(QIEA270_TASK)
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
        If Self:exibeAvisoSubstituicaoPorSmartx(nOpcao)
            // Grava a data de expiracao: hoje + 7 dias
            oProfile:SetStringProfile(DToS(Date() + QIEA270_DIAS))
            oProfile:Save()
        EndIf
    EndIf

    FreeObj(oProfile)
	oProfile := NIL

Return
