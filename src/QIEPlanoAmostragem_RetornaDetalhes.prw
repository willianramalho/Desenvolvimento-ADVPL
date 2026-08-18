/*/{Protheus.doc} RetornaDetalhes
Retorna detalhes completos do processamento em formato JSON.
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@return oDetalhes, object, JSON com todos os detalhes
/*/
METHOD RetornaDetalhes() CLASS QIEPlanoAmostragem

    Local oDetalhes := JsonObject():New()

    oDetalhes["Parecer"           ] := self:cParecer
    oDetalhes["Mensagem"          ] := self:cMensagem
    oDetalhes["Sucesso"           ] := self:lSucesso
    oDetalhes["Erro"              ] := self:cErro
    oDetalhes["QuantidadeEnsaios" ] := Len(self:aEnsaios)
    oDetalhes["Resultados"        ] := self:aResultado
    oDetalhes["Aglutinacao"       ] := self:lAglutPlan
    oDetalhes["PlanosAglutinados" ] := self:aAcumAglut

Return oDetalhes
