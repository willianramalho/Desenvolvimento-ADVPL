/*/{Protheus.doc} changeFolderPrincipal
Valida a mudança de aba no folder principal
@author willian.ramalho / brunno.costa
@since 08/10/2025
@version 12.1.2510
@param 01 nOpc, numérico, operação da tela
/*/
Static METHOD changeFolderPrincipal(nOpc) CLASS QIEA215AuxClass

	If Empty(aResultados[nFldLabGer,_LAUGER,nPosLauGer]) .And. nFldLibCq0 == nFldLab .And. lIntEst
		
		If nOpc <> 2
			//"Informe o Laudo Geral para Libera/Rejeitar o material no CQ"
			Help(" ",1,"Q215NAOCQ")
			oFolder:SetOption(nFldLabAnt)
			oFolder:Refresh()
		EndIf

	EndIf

Return Nil
