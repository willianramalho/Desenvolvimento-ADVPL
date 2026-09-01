/*/{Protheus.doc} reposicionaNaLinhaDoListBoxAposRecriacaoDaTela
Método responsável por posicionar na linha do ListBox

@author thiago.rover/willian.ramalho
@since 11/07/2025

@param nNumFolder, numerico, número do folder selecionado
@param nNumLine, numerico, número da linha para ser posicionada
@param oQI3, objeto, objeto do QI3
@param oQI5, objeto, objeto do QI5
@return Lógico, retorna sempre .T.
/*/
METHOD reposicionaNaLinhaDoListBoxAposRecriacaoDaTela(nNumFolder, nNumLine, oQI3, oQI5) CLASS QNCA050AuxClass

	IF nNumFolder == 1
		oQI5:nAt := nNumLine
		oQI5:Refresh(.T.)
	ELSEIF nNumFolder == 2
		oQI3:nAt := nNumLine
		oQI3:Refresh(.T.)
	ENDIF

RETURN .T.
