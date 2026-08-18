/*/{Protheus.doc} CalculaParecer
Método principal - Calcula parecer baseado em plano de amostragem.
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@return lSucesso, lógical, .T. se cálculou com sucesso, .F. se houve erro
/*/
METHOD CalculaParecer() CLASS QIEPlanoAmostragem

    Begin Sequence

        // Limpa resultados de execuções anteriores
        self:LimpaResultados()

        // Carrega dados da inspeção com planos de amostragem - Posiciona na QEK
        If !self:CarregaEnsaiosComPlanoAmostragem()
            //STR0002 - Nenhum ensaio encontrado para análise
            self:cErro := STR0002
            Break
        EndIf

        // Processa ensaios (conta não-conformidades)
        If !self:ProcessaEnsaios(QEK->QEK_PRODUT, QEK->QEK_REVI)
            // STR0003 - Falha ao processar ensaios 
            self:cErro := STR0003
            Break
        EndIf

        // Aplica regras de aprovação/reprovação
        If !self:AplicaRegrasPlanoAmostragem()
            // STR0004 - Falha ao aplicar regras de plano de amostragem
            self:cErro := STR0004
            Break
        EndIf

        self:lSucesso := .T.

    Recover

        self:lSucesso := .F.
        self:cParecer := "REPR"

        // STR0005 - Erro não identificado no cálculo
        self:cErro := Iif(Empty(self:cErro), STR0005, self:cErro)

    End Sequence

Return self:lSucesso
