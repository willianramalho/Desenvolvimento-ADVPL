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
