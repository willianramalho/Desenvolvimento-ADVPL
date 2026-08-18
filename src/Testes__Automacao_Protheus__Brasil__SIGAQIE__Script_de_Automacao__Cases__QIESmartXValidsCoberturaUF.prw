// Trechos extraidos automaticamente de: Testes\Automação Protheus\Brasil\SIGAQIE\Script de Automacao\Cases\QIESmartXValidsCoberturaUF.prw
// Contem SOMENTE functions/methods cujo cabecalho ProtheusDoc lista willian.ramalho como autor.
// Este arquivo NAO e o fonte completo original.

/*/{Protheus.doc} QIESXValCov
Harness manual para cobertura das validacoes SmartX do cadastro de ensaios.
Executa cenarios direcionados aos branches das linhas alvo do fonte
TOTVS incominginspection test valids.

Linhas alvo:
57, 82, 84, 85, 88, 90, 91, 102, 128, 154, 180.

@type function
@author willian.ramalho
@since 11/08/2026
/*/
User Function QIESXVAL()

    Local nTotal := 0
    Local nOk    := 0

    FWLogMsg("INFO", "SIGAQIE", "QIESXVALCOV", "", "", "", "[U_QIESXVAL] Inicio da execucao dos cenarios de cobertura.")

    nTotal++
    If _QSXRUN("QE1_CARTA_INVALIDA", 57, _QSXCALL("validateQE1Carta", "", "QE1_CARTA", {}), .F., .F.)
        nOk++
    EndIf

    // Um unico cenario cobre 82/84/85 (carta HIS com quantidade fora da faixa).
    nTotal++
    If _QSXRUN("QE1_QTDE_HIS_FORA_FAIXA", 82, _QSXCALL("validateQE1Qtde", 1, "QE1_QTDE", {"HIS"}), .F., .F.)
        nOk++
    EndIf

    // Um unico cenario cobre 88/90/91 (carta NP exige quantidade maior que zero).
    nTotal++
    If _QSXRUN("QE1_QTDE_NP_ZERO", 88, _QSXCALL("validateQE1Qtde", 0, "QE1_QTDE", {"NP"}), .F., .F.)
        nOk++
    EndIf

    nTotal++
    If _QSXRUN("QE1_QTDE_HIS_OK", 102, _QSXCALL("validateQE1Qtde", 5, "QE1_QTDE", {"HIS"}), .T., .T.)
        nOk++
    EndIf

    nTotal++
    If _QSXRUN("QE1_METODO_INVALIDO", 128, _QSXCALL("validateQE1Metodo", "ZZZ_INVALIDO", "QE1_METODO", {}), .F., .F.)
        nOk++
    EndIf

    nTotal++
    If _QSXRUN("QE2_NAOCON_INVALIDA", 154, _QSXCALL("validateQE2NaoCon", "ZZZ_INVALIDO", "QE2_NAOCON", {}), .F., .F.)
        nOk++
    EndIf

    nTotal++
    If _QSXRUN("QE2_CLASSE_INVALIDA", 180, _QSXCALL("validateQE2Classe", "ZZZ_INVALIDO", "QE2_CLASSE", {}), .F., .F.)
        nOk++
    EndIf

    FWLogMsg("INFO", "SIGAQIE", "QIESXVALCOV", "", "", "", ;
        "[U_QIESXVAL] Fim da execucao. Cenarios aprovados: " + cValToChar(nOk) + "/" + cValToChar(nTotal) + ".")

Return (nOk == nTotal)
