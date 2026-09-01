/*/{Protheus.doc} QD080RecFiltro
Retorna os RECNOs de QAA que permanecem visíveis para a filial do treinamento corrente (M->QDA_FILIAL), reaproveitando o mesmo filtro SQL usado por LoadUser para popular a grid. Evita usar QLTQueryManager:ComparacaoFiliais diretamente, pois seu ramo de comparação truncada gera sintaxe SQL (SUBSTRING/RTRIM) que não é válida quando macro-executada como AdvPL, retornando sempre falso quando QAA e QDA têm modos de compartilhamento diferentes.
@type  Function
@author willian.ramalho
@since 01/09/2026
@return aRecnos, array, RECNOs de QAA compatíveis com a filial do treinamento
/*/
Static Function QD080RecFiltro()

	Local aRecnos  := {}
	Local aUserAux := LoadUser()
	Local nX       := 0

	For nX := 1 To Len(aUserAux)
		aAdd(aRecnos, aUserAux[nX][6])
	Next

Return aRecnos
