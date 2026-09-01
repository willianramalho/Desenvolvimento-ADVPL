/* {Protheus.doc} truncaValorCampoNumerico
Method responsavel por formatar e truncar o valor de referencia de acordo com
a mascara (picture) e o tamanho maximo definidos para o campo destino, evitando
erros de gravacao por excesso de tamanho.
@author willian.ramalho
@since 26/03/2026
@version 1.0
@param cAlias     , caracter, alias da tabela que contem o campo destino
@param cCampoDest , caracter, nome do campo destino utilizado para obter a mascara e o tamanho maximo permitido - exclusivo campo numérico
@param nVlrOrigem , numerico, valor do campo de referencia/origem a ser formatado e truncado
@return nVlrCampo , numerico, valor formatado e truncado
*/
Method truncaValorCampoNumerico(cAlias, cCampoDest, nVlrOrigem) CLASS QEPXFUNAuxClass

    Local nTamCampo := GetSx3Cache(cCampoDest, "X3_TAMANHO")
	Local nVlrCampo := Val(Padr(nVlrOrigem, nTamCampo))

Return nVlrCampo
