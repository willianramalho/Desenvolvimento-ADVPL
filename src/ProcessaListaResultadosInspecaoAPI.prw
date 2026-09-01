/*/{Protheus.doc} ProcessaPEQQOFIPEM
Processa Lista de Resultados em WSRestFul - PE QQOFIPEM
@author willian.ramalho/brunno.costa
@since  19/11/2025
@param 01 - cAlias , caracter, alias dos campos para consulta
@param 02 - nPagina, numérico, numero de pagina para retornar os dados
@param 03 - nTamPag, numérico, tamanho da pagina padrao
@param 04 - oAPIManager, objeto  , objeto do gerenciador de API
@param 05 - cProduto, caracter, produto relacionado
@param 06 - cRevisao, caracter, revisao da especificação de produtos relacionada
@return lRetorno, lógico, indica se conseguiu realizar o processamento com sucesso
/*/
METHOD ProcessaPEQQOFIPEM(cAlias, nPagina, nTamPag, oAPIManager, cProduto, cRevisao) CLASS AnexosInspecaoQualidadeAPI

	Local aItemsPE  := {}
	Local lRetorno  := .T.
	Local oResponse := JsonObject():New()

	oResponse['items'        ] := oAPIManager:MontaItensRetorno(cAlias, nPagina, nTamPag, Nil)

	aItemsPE  := ExecBlock("QQOFIPEM", .F., .F., {cProduto, cRevisao, oResponse['items'        ]})
	If ValType(aItemsPE) == "A"
		oResponse['items'        ] := aItemsPE
	EndIf

	oResponse['hasNext'      ] := .F.

	oAPIManager:oWSRestFul:SetContentType("application/json")

	If Len(oResponse['items']) > 0
		//Processou com sucesso.
		HTTPSetStatus(200)
		oResponse['code'         ] := 200
		oAPIManager:oWSRestFul:SetResponse(EncodeUtf8(oResponse:toJson()))
	Else
		//Não processou com sucesso. Seta o código e mensagem de erro para retorno.
		oResponse['code'         ] := 404
		oResponse['errorCode'    ] := 404
		oResponse['message'      ] := STR0001 //"Nenhum registro foi encontrado."
		oResponse['errorMessage' ] := STR0001 //"Nenhum registro foi encontrado."
		//oResponse['detailedMessage' ] := "Nenhum registro foi encontrado."
		SetRestFault(404, STR0001) //"Nenhum registro foi encontrado."
		lRetorno := .F.
	EndIf

Return lRetorno
