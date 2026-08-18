/*/{Protheus.doc} ContaNaoConformidadesPorTipoPlano
Contador principal - direciona para método específico baseado no tipo de plano.
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@param oEnsaio, object, Objeto JSON com dados do ensaio
@param cProduto, character, Código do produto
@param cRevisao, character, Revisão do produto
@return oResultado, object, Objeto JSON com resultado da contagem contendo:
    - CodigoEnsaio
    - TipoPlano
    - NCCriticas, NCGraves, NCToleraveis
    - TotalNC
    - DadosPlano
    - Medicoes
/*/
METHOD ContaNaoConformidadesPorTipoPlano(oEnsaio, cProduto, cRevisao) CLASS QIEPlanoAmostragem

    Local aContNC    :={0, 0, 0}
    Local cCodEnsaio := AllTrim(oEnsaio["CodigoEnsaio"])
    Local cCodPlano  := AllTrim(oEnsaio["PlanoAmostragem"])
    Local cTipoPlano := AllTrim(oEnsaio["TipoAmostragem"])
    Local nLIE       := 0
    Local nLSE       := 0
    Local oResultado := JsonObject():New()

    Do Case
        // Plano NBR5426 (código "1" ou tipo "1")
        Case cCodPlano == "1" .Or. cCodPlano == "NBR5426" .Or. cTipoPlano == "1"
            aContNC := self:ContaNaoConformidadesNBR5426(oEnsaio)

        // Plano NBR5429 (código "5" ou tipo "5")
        Case cCodPlano == "5" .Or. cCodPlano == "NBR5429" .Or. cTipoPlano == "5"

            self:retornaLimitesEspecificacao(cProduto, cRevisao, cCodEnsaio, @nLIE, @nLSE)
            aContNC := self:ContaNaoConformidadesNBR5429(oEnsaio, nLIE, nLSE)

        // Plano QS9000 (código "QS" ou tipo "QS")
        Case cCodPlano == "QS" .Or. cCodPlano == "QS9000" .Or. cTipoPlano == "QS"
            aContNC := self:ContaNaoConformidadesQS9000(oEnsaio)

        // Plano Texto (código "TX" ou tipo "TX")
        Case cCodPlano == "TX" .Or. cCodPlano == "TEXTO" .Or. cTipoPlano == "TX"
            aContNC := self:ContaNaoConformidadesTexto(oEnsaio)

        // Plano Interno (código "PI" ou tipo "PI")
        Case cCodPlano == "PI" .Or. cCodPlano == "INTERNO" .Or. cTipoPlano == "PI"
            aContNC := self:ContaNaoConformidadesPlanoInterno(oEnsaio)

        // Amostragem Dupla (tipo "3" ou "Du" ou "D")
        Case cTipoPlano == "3" .Or. SubStr(cTipoPlano, 1, 2) $ "DU/"
            aContNC := self:ContaNaoConformidadesNBR5426(oEnsaio)

        OtherWise // Padrão
            aContNC := self:ContaNaoConformidadesPadrao(oEnsaio)
    EndCase

    // Monta objeto de resultado
    oResultado["CodigoEnsaio"] := oEnsaio["CodigoEnsaio"]
    oResultado["Laboratorio" ] := oEnsaio["Laboratorio"]
    oResultado["TipoPlano"   ] := cTipoPlano
    oResultado["CodigoPlano" ] := cCodPlano
    oResultado["NCCriticas"  ] := aContNC[NC_CRITICAS]
    oResultado["NCGraves"    ] := aContNC[NC_GRAVES]
    oResultado["NCToleraveis"] := aContNC[NC_TOLERAVEIS]
    oResultado["TotalNC"     ] := aContNC[NC_CRITICAS] + aContNC[NC_GRAVES] + aContNC[NC_TOLERAVEIS]
    oResultado["DadosPlano"  ] := oEnsaio["DadosPlano"]
    oResultado["Medicoes"    ] := oEnsaio["Medicoes"]

Return oResultado
