/*/{Protheus.doc} RetornaRecnoInvalido
Retorna um Recno que não existe na tabela QPR, partindo de nRecno e decrementando até encontrar um inválido
@author willian.ramalho
@since 08/04/2026
@param 01 - nRecno, numérico, recno inicial para verificação
@return nRecno, numérico, recno que não existe na tabela QPR
/*/
METHOD RetornaRecnoInvalido(nRecno) CLASS ResultAPIQIPTestCase
	DbSelectArea("QPR")
	QPR->(DbGoTo(nRecno))
	If !QPR->(Eof()) // registro existe -> decrementa e tenta novamente
		nRecno := Self:RetornaRecnoInvalido(nRecno - 1)
	EndIf
Return nRecno
