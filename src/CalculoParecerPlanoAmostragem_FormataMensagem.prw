/*/{Protheus.doc} FormataMessagemPlanoAmostragem
Formata mensagens explicativas de plano de amostragem.
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@param nTipo, numeric, Tipo de mensagem (1-7)
@param aParams, array, Parâmetros para substituição na mensagem
@return cMensagem, character, Mensagem formatada
/*/
METHOD FormataMessagemPlanoAmostragem(nTipo, aParams) CLASS QIEPlanoAmostragem

    Local cMensagem := ""

    Default aParams := {}

    Do Case
        Case nTipo == 1
            // STR0015 - "Existem medições reprovadas, o Laudo deverá ser Rejeitado"
            cMensagem := STR0015

        Case nTipo == 2
            // STR0016 - "Existem medições aprovadas com tolerância, o Laudo deverá ser Aprovado Condicionalmente"
            cMensagem := STR0016

        Case nTipo == 5
            If Len(aParams) >= 2
                // STR0017 - "Foram encontradas "
                // STR0018 - " não-conformidades, inferior ou igual ao Aceite de "
                // STR0019 - " O Laudo deverá ser Aprovado."
                cMensagem := STR0017 + aParams[1] + STR0018 + aParams[2] + ". " + STR0019
            EndIf

        Case nTipo == 6
            If Len(aParams) >= 3
                // STR0017 - "Foram encontradas "
                // STR0020 - " não-conformidades no Ensaio "
                // STR0021 - ", superior ou igual ao Rejeite de "
                // STR0022 - " O Laudo deverá ser Rejeitado."
                cMensagem := STR0017 + aParams[1] + STR0020 + aParams[2] + STR0021 + aParams[3] + ". " + STR0022
            EndIf

        Case nTipo == 7
            If Len(aParams) >= 4
                // STR0017 - "Foram encontradas "
                // STR0020 - " não-conformidades no Ensaio "
                // STR0023 - ", entre o Aceite de " 
                // STR0024 - " e Rejeite de "  
                // STR0025 - "O Laudo deverá ser Aprovado Condicionalmente."
                cMensagem := STR0017 + aParams[1] + STR0020 + aParams[2] + STR0023 + aParams[3] + STR0024 + aParams[4] + ". " + STR0025
            EndIf

        OtherWise
            // STR0026 - "Análise por plano de amostragem concluída"
            cMensagem := STR0026
    EndCase

Return cMensagem
