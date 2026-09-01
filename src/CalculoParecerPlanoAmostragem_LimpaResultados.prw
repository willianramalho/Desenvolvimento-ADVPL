/*/{Protheus.doc} LimpaResultados
Limpa resultados de execuções anteriores.
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
/*/
METHOD LimpaResultados() CLASS QIEPlanoAmostragem

    self:aAcumAglut := {}
    self:aEnsaios   := {}
    self:aResultado := {}
    self:cErro      := ""
    self:cMensagem  := ""
    self:cParecer   := ""
    self:lSucesso   := .F.

Return
