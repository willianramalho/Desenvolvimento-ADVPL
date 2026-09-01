/* {Protheus.doc} converteStringEmNumero
Method responsavel por converter uma string numerica em valor numerico,
tratando automaticamente o separador decimal conforme o locale do ambiente (ponto ou virgula).
@author willian.ramalho
@since 01/04/2026
@version 1.0
@param cValor , caracter, string contendo o valor numerico a ser convertido, podendo conter separador de milhar e decimal conforme o locale (ex.: "1.250,99" ou "1250.99").
@return nValor, numerico, valor convertido para numerico.
*/
Method converteStringEmNumero(cValor) CLASS QEPXFUNAuxClass

	Local cDecimal  := IIF("." $ AllTrim(Transform(1.5, "@E 9.9")), ".", ",")
	Local cVlrLimpo := ""
	Local nValor    := Val(cValor)

	If cDecimal == ","

		cVlrLimpo := AllTrim(cValor)
		cVlrLimpo := STRTRAN(cVlrLimpo, ".", "")
		cVlrLimpo := STRTRAN(cVlrLimpo, ",", ".")
		nValor 	  := Val(cVlrLimpo)

	EndIf

Return nValor
