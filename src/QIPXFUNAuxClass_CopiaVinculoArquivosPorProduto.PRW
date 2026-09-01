/*/{Protheus.doc} copiaVinculoDosArquivosDaManufaturaPorProduto
Copia os vínculos dos arquivos da manufatura de um produto de origem para um produto de destino
@author willian.ramalho
@since 25/11/2025
@version 1.0

@param 01 - cFilQP6 , caracter, código da filial do produto na tabela QP6
@param 02 - cProdOri, caracter, código do produto de origem
@param 03 - cRevOri , caracter, revisão do produto de origem
@param 04 - cProdDes, caracter, código do produto de destino
@param 05 - cRevDes , caracter, revisão do produto de destino

@return lSucesso, lógico, indica se a cópia foi realizada com sucesso
	.T. -> cópia realizada com sucesso
	.F. -> falha na cópia
/*/
Method copiaVinculoDosArquivosDaManufaturaPorProduto(cFilQP6, cProdOri, cRevOri, cProdDes, cRevDes) CLASS QIPXFUNAuxClass 

	Local aAreaQQO := QQO->(GetArea())
	Local aFields  := {}
	Local lSucesso := .F.

	DbSelectArea("QP6")
	dbSelectArea("QQO")

	QQO->(dbSetOrder(1)) //QQO_FILIAL+QQO_FILENT+QQO_ENTIDA+QQO_PRODUT+QQO_REVI

	If QQO->(dbSeek(xFilial("QQO")+cFilQP6+"QP6"+cProdOri+cRevOri))

		lSucesso := .T.

		While QQO->(!Eof()) .And. QQO->QQO_FILIAL == xFilial("QQO") ;
							.And. QQO->QQO_FILENT == cFilQP6 	    ;
							.And. QQO->QQO_ENTIDA == "QP6"  	    ;
						    .And. QQO->QQO_PRODUT == cProdOri 	    ;
							.And. QQO->QQO_REVI   == cRevOri
			
			aFields  := {}
			Aeval(Array(QQO->(fCount())),{|x,y|Aadd(aFields,QQO->(&(FieldName(y))))})
			//Altera os dados para o registro destino
			aFields[QQO->(FieldPos("QQO_PRODUT"))] := cProdDes //Produto Destino
			aFields[QQO->(FieldPos("QQO_REVI"  ))] := cRevDes  //Revisao do Produto Destino

			self:gravaCopiaArquivosEspecificacao(aFields) //Adiciona Registro no Destino
			QQO->(dbSkip())

		EndDo

	EndIf

	RestArea(aAreaQQO)

Return lSucesso
