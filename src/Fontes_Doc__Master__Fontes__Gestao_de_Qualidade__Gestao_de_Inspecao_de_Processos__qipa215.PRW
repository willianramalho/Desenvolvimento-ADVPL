// Trechos extraidos automaticamente de: Fontes_Doc\Master\Fontes\Gestão de Qualidade\Gestão de Inspeção de Processos\qipa215.PRW
// Contem SOMENTE functions/methods cujo cabecalho ProtheusDoc lista willian.ramalho como autor.
// Este arquivo NAO e o fonte completo original.

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


/*/{Protheus.doc} TrataGetMv
Função responsável por tratar o retorno da função GetMv removendo as aspas duplas que são adicionadas quando o parâmetro já é do tipo string.
@author willian.ramalho
@since  17/03/2026
@version 1.0
@param  cParam, caracter, retorno da função GetMv para o parâmetro a ser tratado
@return cValor, caracter, Conteúdo do parâmetro sem aspas duplas extras
/*/
Function TrataGetMv(cParam)

    Local cValor := cParam

    If Left(cValor, 1) == '"' .And. Right(cValor, 1) == '"'
        cValor := SubStr(cValor, 2, Len(cValor) - 2)
    EndIf

Return cValor
