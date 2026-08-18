// Trechos extraidos automaticamente de: Fontes_Doc\Master\Fontes\Gestão de Qualidade\Gestão de Inspeção de Processos\QIPXFUN.PRW
// Contem SOMENTE functions/methods cujo cabecalho ProtheusDoc lista willian.ramalho como autor.
// Este arquivo NAO e o fonte completo original.

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


/*/{Protheus.doc} gravaCopiaArquivosEspecificacao
Realiza a gravação dos dados copiados para o novo registro na tabela de vínculos dos arquivos da manufatura
@author willian.ramalho
@since 03/12/2025
@version 1.0

@param 01 - aFields, array, array com os campos e valores a serem gravados no novo registro
/*/
Method gravaCopiaArquivosEspecificacao(aFields) CLASS QIPXFUNAuxClass

	Local aAreaQQO := QQO->(GetArea())

	RecLock("QQO",.T.)
	Aeval(aFields,{|x,y|FieldPut(y,x)})
	MsUnLock()

	RestArea(aAreaQQO)

Return
