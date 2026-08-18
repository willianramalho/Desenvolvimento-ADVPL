/*/{Protheus.doc} ContaNaoConformidadesPlanoInterno
Conta não-conformidades para plano interno (PI) com classes A/B/C/D/G.
@type method
@author brunno.costa / willian.ramalho
@since 22/05/2026
@version 1.0
@param oEnsaio, object, Dados do ensaio
@return aContador, array, [NCCríticas, NCGraves, NCToleráveis]
/*/
METHOD ContaNaoConformidadesPlanoInterno(oEnsaio) CLASS QIEPlanoAmostragem

    Local aContador := {0, 0, 0}
    Local aMedicoes := oEnsaio["Medicoes"]
    Local aPlaInt1  := {0, 0, 0, 0, 0, ""} // [Classe, SeqAmostragem, Aceite, Rejeite, TamAmostra, ClassesNC]
    Local aPlaInt2  := {0, 0, 0, 0, 0, ""} // Segunda amostra
    Local cClasse   := ""
    Local nIdx      := 0
    Local nTamAmos1 := oEnsaio["DadosPlano"][1]
    Local nTamAmos2 := oEnsaio["DadosPlano"][4]
    Local oMedicao      := Nil

    // Inicializa arrays: [Classe, SeqAmostragem, Aceite, Rejeite, TamanhoAmostra, ContadoresClasses]
    aPlaInt1[1] := 1  // Classe A
    aPlaInt1[2] := 1  // Sequência Amostragem
    aPlaInt1[3] := 0  // Aceite (será preenchido)
    aPlaInt1[4] := 0  // Rejeite (será preenchido)
    aPlaInt1[5] := nTamAmos1
    aPlaInt1[6] := "ABCDG" // Caracteres numéricos de NC

    aPlaInt2[1] := 1  // Classe A
    aPlaInt2[2] := 2  // Sequência Amostragem (segunda)
    aPlaInt2[3] := 0  // Aceite
    aPlaInt2[4] := 0  // Rejeite
    aPlaInt2[5] := nTamAmos2
    aPlaInt2[6] := "ABCDG"

    // Conta não-conformidades por amostra
    For nIdx := 1 To Len(aMedicoes)
        oMedicao := aMedicoes[nIdx]

        If !oMedicao["RegistroExcluido"] .And. oMedicao["ResultadoMedicao"] == "R"

            cClasse := Upper(oMedicao["ClasseNC"])

            // Classes A/B/C (CRITICAs), D/G (GRAVES), Outras (TOLERÁVEIS)
            Do Case
                Case cClasse $ "ABC"
                    If oMedicao["NumeroAmostra"] == 1
                        aPlaInt1[3]++
                    ElseIf oMedicao["NumeroAmostra"] == 2
                        aPlaInt2[3]++
                    EndIf
                    aContador[NC_CRITICAS]++

                Case cClasse $ "DG"
                    If oMedicao["NumeroAmostra"] == 1
                        aPlaInt1[4]++
                    ElseIf oMedicao["NumeroAmostra"] == 2
                        aPlaInt2[4]++
                    EndIf
                    aContador[NC_GRAVES]++

                OtherWise
                    aContador[NC_TOLERAVEIS]++
            EndCase
        EndIf
    Next nIdx

Return aContador

//==============================================================================
// MÉTODOS PÚBLICOS DE ACESSO (GETTERS)
//==============================================================================
