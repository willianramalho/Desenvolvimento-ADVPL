/*/{Protheus.doc} QADA100CLASS
Classe da QADA100 
@author willian.ramalho / thiago.rover
@since 11/09/2025
@version version
/*/
CLASS QADA100CLASS FROM LongNameClass

	METHOD new()
	METHOD populaArrayComRecnoDosCheckListsInativadosDaQUD(cCheckList, cTopico, cRevisao)
	METHOD retornaProximaRevisaoEfetivadaDoCheckList(cCheckList)
	METHOD validaSeUsuarioDigitadoExisteNaQAA(cFilAux,cUsrAux)
	METHOD verificaSeCheckListEstaRespondido(cCheckList, cRevisao, cTopico)

ENDCLASS

/*{Protheus.doc} New
Criação do method New da class QADA100CLASS
@author willian.ramalho / thiago.rover
@since 11/09/2025
@return Self, object, Retorna o objeto instanciado da class QADA100CLASS
/*/
