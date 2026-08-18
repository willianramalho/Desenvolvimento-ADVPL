/*/{Protheus.doc} ContaNaoConformidadesNBR5426
Conta não-conformidades para plano NBR5426 com suporte a aglutinação.
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@param oEnsaio, object, Objeto JSON com dados do ensaio
@return aContador, array, Array com 3 posições [NCCríticas, NCGraves, NCToleráveis]
/*/
METHOD ContaNaoConformidadesNBR5426(oEnsaio) CLASS QIEPlanoAmostragem

    Local aContador  := {0, 0, 0}
    Local aMedicoes  := oEnsaio["Medicoes"]
    Local cChavePlan := ""
    Local cClasseNC  := ""
    Local nIdxMed    := 0
    Local nPosAcum   := 0
    Local oMedicao   := Nil

    // Conta não-conformidades por classe
    For nIdxMed := 1 To Len(aMedicoes)
        oMedicao := aMedicoes[nIdxMed]

        // Considera apenas medições reprovadas não excluídas
        If oMedicao["ResultadoMedicao"] == "R" .And. !oMedicao["RegistroExcluido"]

            cClasseNC := Upper(AllTrim(oMedicao["ClasseNC"]))

            Do Case
                Case cClasseNC == "C" // Crítica
                    aContador[NC_CRITICAS]++
                Case cClasseNC == "G" // Grave
                    aContador[NC_GRAVES]++
                OtherWise             // Tolerável
                    aContador[NC_TOLERAVEIS]++
            EndCase
        EndIf
    Next nIdxMed

    // Aplica aglutinação se habilitado (MV_QACUPAM)
    If self:lAglutPlan .And. oEnsaio["TipoAmostragem"] == "1"

        // Cria chave do plano: TipoAmostragem + Nivel + PlanoAmostragem + NQA
        cChavePlan :=  oEnsaio["TipoAmostragem"]  + ;
                       oEnsaio["NivelAmostragem"] + ;
                       oEnsaio["PlanoAmostragem"] + ;
                       oEnsaio["NQA"]

        // Busca se já existe acumulador para este plano
        nPosAcum := Ascan(self:aAcumAglut, {|x| x[1] == cChavePlan})

        If nPosAcum == 0
            // Primeira ocorrência deste plano - adiciona ao acumulador
            AAdd(self:aAcumAglut, {;
                cChavePlan,;
                {aContador[NC_CRITICAS], aContador[NC_GRAVES], aContador[NC_TOLERAVEIS]},;
                oEnsaio["CodigoEnsaio"];
            })
            nPosAcum := Len(self:aAcumAglut)

        Else
            // Plano já existe - acumula contadores
            self:aAcumAglut[nPosAcum][2][NC_CRITICAS] += aContador[NC_CRITICAS]
            self:aAcumAglut[nPosAcum][2][NC_GRAVES] += aContador[NC_GRAVES]
            self:aAcumAglut[nPosAcum][2][NC_TOLERAVEIS] += aContador[NC_TOLERAVEIS]

            // Atualiza contadores locais com valores acumulados
            aContador[NC_CRITICAS]   := self:aAcumAglut[nPosAcum][2][NC_CRITICAS]
            aContador[NC_GRAVES]     := self:aAcumAglut[nPosAcum][2][NC_GRAVES]
            aContador[NC_TOLERAVEIS] := self:aAcumAglut[nPosAcum][2][NC_TOLERAVEIS]

            // Adiciona código do ensaio à lista
            self:aAcumAglut[nPosAcum][3] += ", " + oEnsaio["CodigoEnsaio"]
        EndIf
    EndIf

Return aContador
