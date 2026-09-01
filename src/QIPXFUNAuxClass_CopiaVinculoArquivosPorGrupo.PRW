/*/{Protheus.doc} copiaVinculoDosArquivosDaManufaturaPorGrupo
Copia os vínculos dos arquivos da manufatura do grupo de origem para o grupo destino
@author willian.ramalho
@since 25/11/2025
@version 1.0

@param 01 - cFilQQC , caracter, código da filial onde do grupo na tabela QQO
@param 02 - cGrpOri , caracter, codigo do grupo de origem
@param 03 - cRevOri , caracter, revisão do grupo de origem
@param 04 - cRevDes , caracter, revisão do grupo de destino

@return lSucesso, lógico, indica se a cópia foi realizada com sucesso
	.T. -> cópia realizada com sucesso
	.F. -> falha na cópia
/*/
Method copiaVinculoDosArquivosDaManufaturaPorGrupo(cFilQQC, cGrpOri, cRevOri, cRevDes) CLASS QIPXFUNAuxClass

	Local aAreaQQO := QQO->(GetArea())
	Local aFields  := {}
	Local lSucesso := .F.

	DbSelectArea("QQC")
	dbSelectArea("QQO")

	QQO->(dbSetOrder(2)) // QQO_FILIAL+QQO_FILENT+QQO_ENTIDA+QQO_GRUPO+QQO_REVIGR

	If QQO->(dbSeek(xFilial("QQO")+cFilQQC+"QQC"+cGrpOri+cRevOri))

		lSucesso := .T.
	
		While QQO->(!Eof()) .And. QQO->QQO_FILIAL == xFilial("QQO") ;
							.And. QQO->QQO_FILENT == cFilQQC 		;
							.And. QQO->QQO_ENTIDA == "QQC"	 		;
							.And. QQO->QQO_GRUPO  == cGrpOri 		;
							.And. QQO->QQO_REVIGR == cRevOri

			aFields := {}
			Aeval(Array(QQO->(fCount())),{|x,y|Aadd(aFields,QQO->(&(FieldName(y))))})
			aFields[QQO->(FieldPos(("QQO_REVIGR")))] := cRevDes

			self:gravaCopiaArquivosEspecificacao(aFields) //Adiciona Registro no Destino
			QQO->(dbSkip())

		EndDo
		
	EndIf

	RestArea(aAreaQQO)

Return lSucesso
