/* {Protheus.doc} validaTamanhoDoCampoQuantidadeEPreco
Method responsavel por validar se os campos Caractere de Quantidade e Preco
sao compativeis com o campo numerico de referencia informado.
@author willian.ramalho
@since 10/03/2026
@version 1.0
@param aCamposDst, array    , array de campos do tipo caractere a serem validados com o campo de referencia
@param cCampoRef , caractere, campo de referencia do tipo numerico para comparacao de tamanho dos campos do array
@return lOk	     , logico   , .T. = Indica que os campos do array são compatíveis com o campo de referência
							  .F. = Indica que existe incompatibilidade de tamanho entre os campos destino e o campo de referencia
*/
Method validaTamanhoDoCampoQuantidadeEPreco(aCamposDst, cCampoRef) CLASS QEPXFUNAuxClass

	Local aCmpInco   := {} //Campos incompatíveis para detalhamento da mensagem de erro
	Local cCampoDst  := ""
	Local cDetalhe   := ""
	Local cHelp      := "QEPCAMPOSINCO"
	Local cMsg       := ""
	Local cSugestao  := ""
	Local cTipoField := ""
	Local cTipoRefe  := GetSx3Cache(cCampoRef, "X3_TIPO")
	Local lOk        := .T.
	Local nIndice    := 0
	Local nTamDst    := 0
	Local nTamRef    := GetSx3Cache(cCampoRef, "X3_TAMANHO")

	// Referência sempre será numérica, proteção contra mau uso do método,
	// caso o campo de referência seja do tipo caractere, não será validado.
	If cTipoRefe == "N"

		For nIndice := 1 To Len(aCamposDst)

			cCampoDst  := AllTrim(aCamposDst[nIndice])
			cTipoField := GetSx3Cache(cCampoDst, "X3_TIPO")
			nTamDst    := GetSx3Cache(cCampoDst, "X3_TAMANHO")

			// Caractere Destino diferente do Tamanho Numérico Referência + 1
			If cTipoField == "C"
				If (nTamDst <> (nTamRef + 1))

					lOk := .F.
					AAdd(aCmpInco, cCampoDst + " (" + AllTrim(Str(nTamDst))+ ")")
					cSugestao +=  Chr(13)+Chr(10) + cCampoDst + " (" + AllTrim(Str(nTamRef + 1))+ ")"

				EndIf

			// Tamanho Destino diferente do Tamanho Referência
			Else
				If (nTamDst <> nTamRef)

					lOk := .F.
					AAdd(aCmpInco, cCampoDst + " (" + AllTrim(Str(nTamDst))+ ")")
					cSugestao +=  Chr(13)+Chr(10) + cCampoDst + " (" + AllTrim(Str(nTamRef))+ ")"

				EndIf
			EndIf

		Next nIndice

	EndIf

	If !lOk
		AEval(aCmpInco, {|cItem| cDetalhe += cItem + Chr(13)+Chr(10)})
		// STR0021 - Divergência de tamanho de campos detectada com o campo de referência:
		// STR0016 - Está configurado com tamanho:
		// STR0022 - Essa diferença pode causar inconsistencia de dados.
		// STR0023 - Campos com tamanho incompatível:
		cMsg := STR0021 + " '" + cCampoRef + "' " + STR0016 + "(" + AllTrim(Str(nTamRef)) + ")." +Chr(13)+Chr(10)+ STR0022 + STR0023 + Chr(13)+Chr(10) + cDetalhe

		cHelp := IIF(cModulo $ "QIP", "QIPCAMPOSINCO", IIF(cModulo $ "QIE", "QIECAMPOSINCO", cHelp))

		// STR0024 - Realize o ajuste de tamanho do campo no Configurador (SIGACFG).
		// STR0025 - Para ficar compativel com o tamanho do campo de referencia
		// STR0020 - Tamanho sugerido para compatibilidade:
		LogMsg(cHelp, 0, 0, 1, '', '', "[" + cHelp + "] " + cMsg + ": " + STR0024 +  STR0025 + Chr(13)+Chr(10) + STR0020 + ": " + cSugestao +".")

	EndIf

Return lOk
