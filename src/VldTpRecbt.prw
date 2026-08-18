/*/{Protheus.doc} VldTpRecbt
Valida campo Tipo de recebimento da QAXA010

@author willian.ramalho
@since 25/07/2025
@type  Function
@param1 oModel, objeto, conteudo dos dados do MVC
@return False - Indica que o campo Tp Receb na QAXA010 do usuario é igual a 4 
/*/
//-------------------------------------------------------------------
Function VldTpRecbt(oModel)
Local cLoginQAD  := oModel:GetValue('QADMASTER', 'QAD_MAT')
Local cTpRecebto := Posicione("QAA", 1, xFilial("QAA") + cLoginQAD, "QAA_TPRCBT")
Local lRet       := .T.

	If cTpRecebto == "4"
		//STR0020 - O usuário não pode ser definido como responsável pelo departamento, pois no cadastro de usuários (rotina QAXA010), o campo Tipo de Recebimento está definido como 4 - Não Recebe.
		//STR0021 - Para que o usuário possa ser atribuído como responsável pelo departamento, é necessário alterar o campo Tipo de Recebimento no cadastro do usuário para um conteúdo diferente de 4 - Não Recebe.
		Help(NIL, NIL, "QDOATPRCBT", NIL, STR0020, 1, NIL, NIL, NIL, NIL, NIL, NIL, {STR0021})
		lRet:= .F.
	Endif

Return lRet
