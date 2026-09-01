/*{Protheus.doc} QIEAjuIndQEJ
Cria o indice secundario de QEJ por QEJ_FILIAL+QEJ_CODTAB+QEJ_FATOR
(ordem 2), necessario para a checagem de duplicidade de fator usada
pela migracao SmartX de QIEA270/QIEA271 (qualityfactorsia/
qualityfactorsiqs). QEJ so tinha, ate entao, a ordem 1
(QEJ_FILIAL+QEJ_CODTAB+STR(QEJ_VLSUP,6,2)).

ATENCAO -- validar antes de aplicar em qualquer ambiente real:
1) Confirmar no SIX do ambiente-alvo que a ORDEM "2" de QEJ esta
   realmente livre (nao ha template local anterior de inclusao de
   indice via codigo neste pacote para conferir contra). Se a ORDEM
   "2" ja existir com outra CHAVE, esta funcao NAO sobrescreve --
   so' sinaliza (ver ElseIf abaixo) e a ORDEM definitiva deve ser
   escolhida manualmente, atualizando tambem o DbSetOrder(2) usado em
   validateFactorDuplicate/recalcLowerBound de
   qualityfactorsia.events.tlpp e qualityfactorsiqs.events.tlpp.
2) Idempotente (verifica via DbSeek antes de incluir) -- seguro
   executar mais de uma vez ou em mais de um ambiente.
@author willian.ramalho
@version P12
@since   26/08/2026
@type function
@param  cVersion   - Versao do Protheus
@param  cMode      - Modo de execucao. 1=Por grupo de empresas / 2=Por grupo de empresas + filial (filial completa)
@param  cRelStart  - Release de partida  Ex: 002
@param  cRelFinish - Release de chegada  Ex: 005
@param  cLocaliz   - Localizacao (pais). Ex: BRA
*/
Static Function QIEAjuIndQEJ(cVersion, cMode, cRelStart, cRelFinish, cLocaliz )

	Local aAreaSix	as Array
	Local cIndice	as Character
	Local cOrdem	as Character
	Local cChave	as Character

	cIndice	:= "QEJ"
	cOrdem	:= "2"
	cChave	:= "QEJ_FILIAL+QEJ_CODTAB+QEJ_FATOR"

	aAreaSix := SIX->(GetArea())

	DbSelectArea("SIX")
	SIX->(DbSetOrder(1)) // INDICE+ORDEM

	If !SIX->(DbSeek(cIndice + cOrdem))
		RecLock("SIX", .T.)
			SIX->INDICE    := cIndice
			SIX->ORDEM     := cOrdem
			SIX->CHAVE     := cChave
			SIX->DESCRICAO := "Filial+Codigo Tabela+Fator"
			SIX->DESCSPA   := "Filial+Codigo Tabla+Factor"
			SIX->DESCENG   := "Branch+Table Code+Factor"
			SIX->PROPRI    := "U"
			SIX->NICKNAME  := "QEJFATOR"
			SIX->SHOWPESQ  := "N"
		SIX->(MsUnlock())
	ElseIf AllTrim(SIX->CHAVE) <> cChave
		// Ordem "2" ja existe em QEJ com uma chave diferente da esperada --
		// nao sobrescreve indice de proposito desconhecido. Requer analise manual.
		ConOut("RUP_QIE/QIEAjuIndQEJ: QEJ ordem 2 ja existe com CHAVE '" + AllTrim(SIX->CHAVE) + "', esperado '" + cChave + "'. Nao alterado.")
	EndIf

	RestArea(aAreaSix)

Return
