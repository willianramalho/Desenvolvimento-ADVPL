/*/{Protheus.doc} usuarioValidoNaDataDaMedicaoDoEnsaio
Verifica se a data de inativação do usuário é posterior ou igual a data da Medição do ensaio, e se a data de inativação é vazia.
@author willian.ramalho
@since 31/07/2025
@param dDataMedi, data, data da medição do ensaio
@param cMatUsr, caracter, codigo de usuário do ensaiador
@param cFilMat, caracter, filial do ensaiador (QPR_FILMAT); default filial da QAA
@return lRet, lógico, 
		.T. = data de inativação posterior ou igual a data da medição ou data de inativação vazia
		.F. = data de inativação inferior a data da medição
/*/
METHOD usuarioValidoNaDataDaMedicaoDoEnsaio(dDataMedi, cMatUsr, cFilMat) CLASS QIPA215AuxClass

	Local aAreaQAA := QAA->(GetArea())
	Local lRet     := .F.

	Default dDataMedi := Date() //Data da medição do ensaio
	Default cFilMat   := xFilial('QAA') //Filial do ensaiador (QPR_FILMAT)
	
	DbSelectArea("QAA")
	QAA->(dbSetOrder(1))

	If QAA->(dbSeek(cFilMat+cMatUsr))
		lRet := Iif(Empty(QAA->QAA_FIM), .T., dDataMedi <= QAA->QAA_FIM)
    EndIf

	RestArea(aAreaQAA)

Return lRet
