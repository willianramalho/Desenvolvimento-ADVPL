/*/{Protheus.doc} Q020Legend
@type  Function
@author Willian.ramalho
@since  06/08/2026
@descricao Exibe a legenda de cores utilizada na consulta de entradas.
@uso QIEC020
/*/
Function Q020Legend()
	Local aLegenda   := {}
	Local aLegenPE   := {}
	Local cTitLegenda := OemToAnsi("Entradas em Skip-Lote")

	Default  cCadastro := ""

	If Type("cCadastro") == "C" .And. !Empty(cCadastro)
		cTitLegenda := cCadastro
	EndIf

	Aadd(aLegenda,{"BR_AZUL",  OemToAnsi("Inspecao")})
	Aadd(aLegenda,{"BR_VERDE", OemToAnsi("Certificacao")})

	If ExistBlock("QE020LEG")
		aLegenPE := ExecBlock("QE020LEG",.F.,.F.,{aClone(aLegenda)})

		If ValType(aLegenPE) == "A" .And. !Empty(aLegenPE)
			aLegenda := aClone(aLegenPE)
		EndIf
	EndIf

	BrwLegenda(cTitLegenda, OemToAnsi("Entradas"), aLegenda)

Return(NIL)
