/* {Protheus.doc} validaTamanhoDoConteudoDosCampos
Method responsavel por validar se havera truncamento de dados no momento de gravacao do valor do campo de referencia para os campos destino,
caso o tamanho do conteudo do campo de referencia seja maior que o tamanho dos campos destino.
@author willian.ramalho / henrique.adelino
@since 18/03/2026
@version 1.0
@param01 aDestinos , array   , campos de destino para comparacao de tamanho com o campo de referencia/origem
@param02 nValorRef , numerico, valor do conteudo do campo de referencia/origem para comparacao
@param03 cCampoRef , caracter, campo de referencia/origem para comparacao de tamanho do conteudo
@param04 nOpc      , numerico, operação selecionada
@return lValido    , logico  , .T. = Indica que o valor do campo referencia/origem cabe no campo de destino sem truncamento de dados.
							   .F. = Indica que havera truncamento do valor do campo origem para o campo destino.

*/
Method validaTamanhoDoConteudoDosCampos(aDestinos, nValorRef, cCampoRef, nOpc) CLASS QEPXFUNAuxClass

	Local aIncompati := {} //Campos incompatíveis para detalhamento da mensagem de erro
	Local cAlias     := ""
	Local cCamposInc := "" //Campos incompatíveis para detalhamento da mensagem de erro
	Local cDestino   := ""
	Local cHelp      := "QEPTRUNCADADOS"
	Local cMsg       := ""
	Local cTipoDesti := ""
	Local cTipoOrig  := ""
	Local cUsaMaisUm := ""
	Local cValorDest := ""
	Local lValido    := .T.
	Local nIndCampo  := 0
	Local nTamanho   := ""
	Local nTamDest   := 0
	Local nTamRef    := GetSx3Cache(cCampoRef, "X3_TAMANHO")
	Local nValDest   := 0

	For nIndCampo := 1 To Len(aDestinos)

		cDestino   := aDestinos[nIndCampo]
		cAlias     := Left(cDestino, 3)
		cTipoDesti := GetSx3Cache(cDestino , "X3_TIPO")
		cTipoOrig  := GetSx3Cache(cCampoRef, "X3_TIPO")
		nTamanho   := GetSx3Cache(cDestino , "X3_TAMANHO")

		If cTipoDesti == "C"
			// Nao usar Transform aqui: sem picture no SX3 o fallback "@E " gera ruido de ponto flutuante.
			// Caso real: Transform(111111111.11, "@E ") = "111111111,10999999940395" -> falso truncamento.
			// cValToChar preserva os decimais do valor e formata sempre com ".", compativel com Val().
			cValorDest := PadR(AllTrim(cValToChar(nValorRef)), nTamanho)
			nValDest   := Val(cValorDest)
		Else
			nValDest  := Self:truncaValorCampoNumerico(cAlias, cDestino, nValorRef)
		EndIf


		If nValDest <> nValorRef
			lValido  := .F.
			AAdd(aIncompati, cDestino + " (" + AllTrim(Str(nTamanho))+ ")")
		EndIf


	Next nIndCampo

	If nOpc == 1 //Inclusão

		cHelp := cModulo + "NOINC" // QIPNOINC / QIENOINC
		// STR0027 - A inclusão da inspeção foi bloqueada devido a incompatibilidade de tamanho dos campos:
		cMsg += STR0027 + Chr(13)+Chr(10)

	Elseif nOpc == 3 // Alteração

		cHelp := cModulo + "NOALT" // QIPNOALT / QIENOALT
		// STR0028 - A alteração da inspeção foi bloqueada devido a incompatibilidade de tamanho dos campos:
		cMsg += STR0028 + Chr(13)+Chr(10)

	Endif

	If !lValido

		AEval(aIncompati, {|cItem| cCamposInc += " - " + cItem + Chr(13)+Chr(10)})
		cUsaMaisUm := IIF(cTipoOrig == "N" .And. cTipoDesti == "C", "+1", "")

		// STR0016 - Estão configurados com tamanho divergente do tamanho do campo de referencia
		cMsg += cCamposInc + STR0016 + cUsaMaisUm + " : " + cCampoRef + IIF(cTipoOrig == "N" .And. cTipoDesti == "C", " (" + cValToChar(nTamRef) + " +1 = " + cValToChar(nTamRef+1) + ")", " (" + cValToChar(nTamRef) + ").")
		nTamDest := IIF(cTipoOrig == "N" .And. cTipoDesti == "C", nTamRef+1, nTamRef) //Considera o byte de final de campo para campos do tipo caractere

		// STR0029 - Corrija o tamanho dos campos citados na mensagem acima para o Tamanho:
		Help(NIL, NIL, cHelp, NIL, cMsg, 1, 0, NIL, NIL, NIL, NIL, NIL, {STR0029 + cValToChar(nTamDest)+"."})

	EndIf

Return lValido
