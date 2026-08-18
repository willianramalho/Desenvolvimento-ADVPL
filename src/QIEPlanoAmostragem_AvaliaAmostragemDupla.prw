/*/{Protheus.doc} AvaliaAmostragemDupla
Avalia ensaio com amostragem dupla aplicando regras específicas.
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@param oResultado, object, Resultado do ensaio processado
@return cParecer, character, Parecer calculado (APRV/REPR/ACND/PEND)
/*/
METHOD AvaliaAmostragemDupla(oResultado) CLASS QIEPlanoAmostragem

    Local aDadosPlno := oResultado["DadosPlano"]
    Local aNCPorAmos := {}
    Local cParecer   := ""
    Local lExiste2Am := .F.
    Local nAceite1   := aDadosPlno[2]
    Local nAceite2   := aDadosPlno[5]
    Local nNCAmos1   := 0
    Local nNCAmos2   := 0
    Local nRejeite1  := aDadosPlno[3]
    Local nRejeite2  := aDadosPlno[6]
    Local nSomaNCs   := 0

    // Separa NCs por número de amostra
    aNCPorAmos := self:SeparaNaoConformidadesPorAmostra(oResultado)
    nNCAmos1   := aNCPorAmos[1]
    nNCAmos2   := aNCPorAmos[2]

    // Verificar existência da segunda amostra por presença de medição
    lExiste2Am := self:VerificaExistenciaSegundaAmostra(oResultado)

    // Avalia primeira amostra
    If nNCAmos1 <= nAceite1

        cParecer := "APRV"
        // STR0006 - "Primeira amostra com "
        // STR0007 - " NC(s), aprovada pelo Aceite1 ("
        self:cMensagem := STR0006 + AllTrim(Str(nNCAmos1)) + STR0007 + AllTrim(Str(nAceite1)) + ")"

    ElseIf nNCAmos1 >= nRejeite1

        cParecer := "REPR"
        // STR0006 - "Primeira amostra com "
        // STR0008 - " NC(s), reprovada pelo Rejeite1 ("
        self:cMensagem := STR0006 + AllTrim(Str(nNCAmos1)) + STR0008 + AllTrim(Str(nRejeite1)) + ")"

    Else
        // Primeira amostra entre limites - necessita segunda amostra

        If !lExiste2Am .Or. self:lBlqPlano
            // Segunda amostra ainda não realizada
            cParecer := "PEND"
             // STR0009 - "Primeira amostra entre limites (" 
             // STR0010 - " NC(s)). Segunda amostra necessária."
            self:cMensagem := STR0009 + AllTrim(Str(nNCAmos1)) + STR0010
        Else
            // Avalia soma das duas amostras
            nSomaNCs := nNCAmos1 + nNCAmos2

            If nSomaNCs <= nAceite2

                cParecer := "APRV"
                // STR0011 - "Soma das amostras: "
                // STR0012 - " NC(s), aprovada pelo Aceite2 ("
                self:cMensagem := STR0011 + AllTrim(Str(nSomaNCs)) + STR0012 + AllTrim(Str(nAceite2)) + ")"

            ElseIf nSomaNCs >= nRejeite2

                cParecer := "REPR"
                // STR0011 - "Soma das amostras: "
                // STR0013 - " NC(s), reprovada pelo Rejeite2 ("
                self:cMensagem := STR0011 + AllTrim(Str(nSomaNCs)) + STR0013 + AllTrim(Str(nRejeite2)) + ")"

            Else

                cParecer := "ACND"
                // STR0011 - "Soma das amostras: "
                // STR0014 - " NC(s), entre limites. Aprovado condicionalmente."
                self:cMensagem := STR0011 + AllTrim(Str(nSomaNCs)) + STR0014

            EndIf
        EndIf
    EndIf

Return cParecer
