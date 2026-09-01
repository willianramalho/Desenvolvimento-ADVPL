/*/{Protheus.doc} retornaLimitesEspecificacao
Retorna detalhes completos do processamento em formato JSON.
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@param cProduto, character, Código do produto
@param cRevisao, character, Código da revisão
@param cCodEnsaio, character, Código do ensaio
@param nLIE, numeric, retorna por referencia - Limite inferior de especificação
@param nLSE, numeric, retorna por referencia - Limite superior de especificação
/*/
METHOD retornaLimitesEspecificacao(cProduto, cRevisao, cCodEnsaio, nLIE, nLSE) CLASS QIEPlanoAmostragem

    Local aAreaAnt := GetArea()

    DbSelectArea("QE7")
    QE7->(DbSetOrder(1)) // QE7_FILIAL+QE7_PRODUT+QE7_REVI+QE7_ENSAIO

    If QE7->(DbSeek(xFilial("QE7") + cProduto + cRevisao + cCodEnsaio))
        nLIE := SuperVal(QE7->QE7_LIE)
        nLSE := SuperVal(QE7->QE7_LSE)
    EndIf

    RestArea(aAreaAnt)

Return
