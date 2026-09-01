/*/{Protheus.doc} AvaliaAmostragemSimples
Avalia ensaio com amostragem simples aplicando regras de aceite/rejeite.
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@param oResultado, object, Resultado do ensaio processado
@return cParecer, character, Parecer calculado (APRV/REPR/ACND/PEND)
Observação: quando nTotalNC == 0, nAceite1 == 0 e não existem medições classificadas como aprovadas ou reprovadas,
            o retorno deve permanecer PEND por ausência de evidência para aprovar ou reprovar o ensaio.
/*/
METHOD AvaliaAmostragemSimples(oResultado) CLASS QIEPlanoAmostragem

    Local aDadosPlno := oResultado["DadosPlano"]
    Local aMedicoes  := oResultado["Medicoes"]
    Local cParecer   := ""
    Local lTemMedApv := .F.
    Local lTemMedRep := .F.
    Local nAceite1   := aDadosPlno[2]
    Local nIdxMed    := 0
    Local nRejeite1  := aDadosPlno[3]
    Local nTotalNC   := oResultado["TotalNC"]
    Local oMedicao   := Nil

    // Verifica medições aprovadas/reprovadas
    For nIdxMed := 1 To Len(aMedicoes)
        oMedicao := aMedicoes[nIdxMed]

        If !oMedicao["RegistroExcluido"]

            If oMedicao["ResultadoMedicao"] == "A"
                lTemMedApv := .T.

            ElseIf oMedicao["ResultadoMedicao"] == "R"
                lTemMedRep := .T.
            EndIf
        EndIf
    Next nIdxMed

    // O caso NC==0 e o caso NC>=Rejeite são decididos pelo status das medições.
    // Se NC==0 e não houver medição classificada (A/R), o ensaio permanece PEND.
    If nTotalNC <= nAceite1 .And. nTotalNC <> 0

        cParecer := "APRV"
        self:cMensagem := self:FormataMessagemPlanoAmostragem(5, {;
            AllTrim(Str(nTotalNC)),;
            AllTrim(Str(nAceite1));
        })

    ElseIf nTotalNC >= nRejeite1 .Or. nTotalNC == 0

        If lTemMedRep

            cParecer := "REPR"

            If nTotalNC > 0
                self:cMensagem := self:FormataMessagemPlanoAmostragem(6, {;
                    AllTrim(Str(nTotalNC)),;
                    oResultado["CodigoEnsaio"],;
                    AllTrim(Str(nRejeite1));
                })
            Else
                self:cMensagem := self:FormataMessagemPlanoAmostragem(1, {})
            EndIf

        ElseIf lTemMedApv

            cParecer := "APRV"

            // Mantém mensagem de aprovação para garantir resposta determinística.
            self:cMensagem := self:FormataMessagemPlanoAmostragem(5, {;
                AllTrim(Str(nTotalNC)),;
                AllTrim(Str(nAceite1));
            })

        ElseIf nTotalNC == 0 .And. nAceite1 == 0

            cParecer := "PEND"
            self:cMensagem := ""

        EndIf

    // Aceite < NC < Rejeite ? CONDICIONAL
    Else

        cParecer := "ACND"
        self:cMensagem := self:FormataMessagemPlanoAmostragem(7, {;
            AllTrim(Str(nTotalNC)),;
            oResultado["CodigoEnsaio"],;
            AllTrim(Str(nAceite1)),;
            AllTrim(Str(nRejeite1));
        })

    EndIf

Return cParecer
