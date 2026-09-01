/*/{Protheus.doc} ProcessaEnsaios
Processa todos os ensaios carregados contando não-conformidades.
Popula self:aResultado com resultados de cada ensaio.
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@param cProduto, character, Código do produto
@param cRevisao, character, Revisão do produto
@return lSucesso, lógical, .T. se processou ao menos um ensaio
/*/
METHOD ProcessaEnsaios(cProduto, cRevisao) CLASS QIEPlanoAmostragem

    Local nIndice    := 0
    Local oEnsaio    := Nil
    Local oResEnsaio := Nil

    For nIndice := 1 To Len(self:aEnsaios)
        oEnsaio := self:aEnsaios[nIndice]

        // Conta não-conformidades baseado no tipo de plano
        oResEnsaio := self:ContaNaoConformidadesPorTipoPlano(oEnsaio, cProduto, cRevisao)

        AAdd(self:aResultado, oResEnsaio)
    Next nIndice

Return (Len(self:aResultado) > 0)
