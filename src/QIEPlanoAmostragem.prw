/*/{Protheus.doc} QIEPlanoAmostragem
Classe especializada para cálculo de parecer baseado em plano de amostragem.
Implementa todas as regras do QIEA215 de forma independente e reutilizável,
incluindo NBR5426, NBR5429, QS9000, Texto e Amostragem Dupla.
@type class
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
/*/
CLASS QIEPlanoAmostragem FROM LongNameClass

    // ========================================================================
    // PROPRIEDADES DA CLASSE (DATA)
    // ========================================================================

    // Dados de entrada
    DATA nRecnoQEK                  AS NUMERIC   // Recno da inspeção na QEK
    DATA cLaborat                   AS CHARACTER // Laboratório para análise
    DATA cUsuario                   AS CHARACTER // Usuário processando

    // Dados carregados
    DATA aEnsaios                   AS ARRAY    // Ensaios com dados de PA
    DATA aResultado                 AS ARRAY    // Resultados processados
    DATA aAcumAglut                 AS ARRAY    // Acumulador para MV_QACUPAM

    // Resultados do cálculo
    DATA cParecer                   AS CHARACTER // Parecer calculado
    DATA cMensagem                  AS CHARACTER // Mensagem explicativa
    DATA lSucesso                   AS LOGICAL   // Se cálculo foi bem-sucedido
    DATA cErro                      AS CHARACTER // Mensagem de erro

    // Configurações de parâmetros
    DATA lAglutPlan                 AS LOGICAL   // MV_QACUPAM
    DATA lBlqPlano                  AS LOGICAL   // MV_QBLQPLA
    DATA lAprConTol                 AS LOGICAL   // Aprovação Condicional com Tolerância
    DATA lMedForEsp                 AS LOGICAL   // Medições Fora de Especificação como NC
    DATA lQ215PL1                   AS LOGICAL   // Verifica se existe PE Q215PL1 para Plano Interno
    DATA lQ215PL2                   AS LOGICAL   // Verifica se existe PE Q215PL2 para Plano Interno Especializado
    DATA lQ215PINT                  AS LOGICAL   // Verifica se existe PE Q215PINT para alteração de contagem PI

    // ========================================================================
    // MÉTODOS PÚBLICOS
    // ========================================================================

    METHOD New(nRecnoQEK, cLaborat) CONSTRUCTOR

    METHOD CalculaParecer()
    METHOD RetornaDetalhes()
    METHOD RetornaErro()
    METHOD RetornaMensagem()
    METHOD RetornaParecer()
    METHOD RetornaSucesso()

    // ========================================================================
    // MÉTODOS PRIVADOS - CARREGAMENTO DE DADOS
    // ========================================================================

    METHOD BuscaDadosPlanoAmostragem(cCodEnsaio)
    METHOD CarregaEnsaiosComPlanoAmostragem()
    METHOD CarregaMedicoesDoEnsaio(nRecnoQER)
    METHOD MontaDadosPlanoAmostragem(aRetQep, cTabEspec, cCampoPref)
    METHOD RetornaLimitesEspecificacao(cProduto, cRevisao, cCodEnsaio, nLIE, nLSE)

    // ========================================================================
    // MÉTODOS PRIVADOS - PROCESSAMENTO
    // ========================================================================

    METHOD BuscaDadosPlanoAmostragemComHistorico(cCodEnsaio)
    METHOD CalculaIndiceDefeitosNBR5429(aMedicoes, oEnsaio, nLIE, nLSE)
    METHOD ContaNaoConformidadesNBR5426(oEnsaio)
    METHOD ContaNaoConformidadesNBR5429(oEnsaio)
    METHOD ContaNaoConformidadesPadrao(oEnsaio)
    METHOD ContaNaoConformidadesPlanoInterno(oEnsaio)
    METHOD ContaNaoConformidadesPorTipoPlano(oEnsaio)
    METHOD ContaNaoConformidadesQS9000(oEnsaio)
    METHOD ContaNaoConformidadesTexto(oEnsaio)
    METHOD ProcessaEnsaios(cProduto, cRevisao)
    METHOD ValidaPreCondicoesTamanhoAmostra(oEnsaio)
    METHOD VerificaExistenciaSegundaAmostra(oResultado)

    // ========================================================================
    // MÉTODOS PRIVADOS - APLICAÇÃO DE REGRAS
    // ========================================================================

    METHOD AplicaRegrasPlanoAmostragem()
    METHOD AvaliaAmostragemDupla(oResultado)
    METHOD AvaliaAmostragemSimples(oResultado)

    // ========================================================================
    // MÉTODOS PRIVADOS - VALIDAÇÕES E AUXILIARES
    // ========================================================================

    METHOD FormataMessagemPlanoAmostragem(nTipo, aParams)
    METHOD LimpaResultados()
    METHOD SeparaNaoConformidadesPorAmostra(oResultado)
    METHOD VerificaMedicaoAprovada(oResultado)
    METHOD VerificaMedicaoReprovada(oResultado)

ENDCLASS
