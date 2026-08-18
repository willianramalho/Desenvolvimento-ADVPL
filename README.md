# Desenvolvimento ADVPL

Repositório pessoal de **Willian Ramalho** com trechos de código AdvPL/TLPP (ERP TOTVS Protheus) de minha própria autoria, reunidos aqui como portfólio técnico e histórico de evolução como desenvolvedor.

## Propósito

Ao longo de projetos de customização Protheus em que atuei como desenvolvedor, escrevi e mantive diversas functions e methods. Este repositório existe para:

- Servir como portfólio público, demonstrando código real que escrevi (padrões, boas práticas, resolução de problemas).
- Preservar um histórico pessoal do meu crescimento técnico em AdvPL/TLPP, independentemente do vínculo com qualquer empregador ou cliente específico.

## Autoria e escopo do conteúdo

**Todo o código publicado neste repositório é de minha própria autoria** (individual ou em co-autoria, quando explicitado). A autoria de cada trecho é rastreável pela tag `@author` no cabeçalho ProtheusDoc que precede cada function/method no código-fonte original.

Pontos importantes sobre o que é publicado aqui:

- **Não são fontes completos.** Cada arquivo contém apenas os trechos isolados (cabeçalho de documentação + corpo da function/method) que identifiquei como de minha autoria — nunca a rotina, tela ou módulo inteiro de onde foram extraídos.
- **Sem dados ou regras de negócio de clientes.** Os trechos não incluem informações de clientes, credenciais, dados de produção ou lógica de negócio proprietária além do necessário para o funcionamento da function em si.
- Identificadores de tabelas/campos padrão do ERP Protheus (ex.: `SA1`, `SX3`, campos `X3_*`) podem aparecer por fazerem parte da sintaxe padrão da linguagem/framework, sem relação com dados de clientes.

## Conteúdo

- Autor filtrado: `willian.ramalho` (via tag `@author`)
- Arquivos de origem distintos: 22
- Functions/Methods extraídos: 80
- Duplicatas ignoradas (mesmo corpo em arquivo BKP/copy ou repetido): 0

## Lista de functions/methods

- `ProcessaPEQQOFIPEM` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Genéricos/API/AnexosInspecaoQualidadeAPI.prw
- `ajustaCamposNotaParaArray` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Genéricos/QLTQueryManager.prw
- `ajustaCamposNotaParaComparacaoEmQuery` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Genéricos/QLTQueryManager.prw
- `retornaCamposDaNotaFiscalParaChaveDePesquisa` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Genéricos/QLTQueryManager.prw
- `retornaTamanhoDosCamposDaNotaFiscal` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Genéricos/QLTQueryManager.prw
- `validaIndiceNotaAvulsoNaQEL` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Genéricos/QLTQueryManager.prw
- `validaIndiceNotaAvulsoNaQER` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Genéricos/QLTQueryManager.prw
- `validaTamanhoCamposChaveNF` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Genéricos/QLTQueryManager.prw
- `QEPXFUNAuxClass` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Genéricos/Qepxfun.PRW
- `new` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Genéricos/Qepxfun.PRW
- `QADA100CLASS` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Auditoria/qada100.prw
- `populaArrayComRecnoDosCheckListsInativadosDaQUD` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Auditoria/qada100.prw
- `verificaSeCheckListEstaRespondido` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Auditoria/qada100.prw
- `avaliaPEQdoViLiPDF` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Documentos/QDODocumentControl.PRW
- `VldTpRecbt` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Documentos/qdoa151.prw
- `FieldsUser` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEA090.PRW
- `QIE90GatFL` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEA090.PRW
- `LaudosCobertura` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIELaudosCobertura.prw
- `AplicaRegrasPlanoAmostragem` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `AvaliaAmostragemDupla` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `AvaliaAmostragemSimples` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `BuscaDadosPlanoAmostragem` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `BuscaDadosPlanoAmostragemComHistorico` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `CalculaParecer` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `CarregaEnsaiosComPlanoAmostragem` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `CarregaMedicoesDoEnsaio` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `ContaNaoConformidadesNBR5426` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `ContaNaoConformidadesNBR5429` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `ContaNaoConformidadesPadrao` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `ContaNaoConformidadesPlanoInterno` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `ContaNaoConformidadesPorTipoPlano` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `ContaNaoConformidadesQS9000` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `ContaNaoConformidadesTexto` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `FormataMessagemPlanoAmostragem` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `LimpaResultados` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `New` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `ProcessaEnsaios` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `QIEPlanoAmostragem` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `RetornaDetalhes` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `RetornaErro` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `RetornaMensagem` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `RetornaParecer` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `RetornaSucesso` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `SeparaNaoConformidadesPorAmostra` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `ValidaPreCondicoesTamanhoAmostra` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `VerificaExistenciaSegundaAmostra` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `VerificaMedicaoAprovada` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `VerificaMedicaoReprovada` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `retornaLimitesEspecificacao` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEPlanoAmostragem.prw
- `SeekNaQEK` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEXFUNA.PRW
- `SeekQEP183` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/QIEXFUNA.PRW
- `changeFolderPrincipal` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Entradas/qiea215.PRW
- `QIPRDADOS` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Processos/QIPR100.PRW
- `copiaVinculoDosArquivosDaManufaturaPorGrupo` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Processos/QIPXFUN.PRW
- `copiaVinculoDosArquivosDaManufaturaPorProduto` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Processos/QIPXFUN.PRW
- `gravaCopiaArquivosEspecificacao` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Processos/QIPXFUN.PRW
- `TrataGetMv` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Processos/qipa215.PRW
- `usuarioValidoNaDataDaMedicaoDoEnsaio` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Processos/qipa215.PRW
- `validaEnsaioDuplicado` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Processos/smartx/totvs.protheus.manufacturing.processinspection.test.events.tlpp
- `buildValidationResult` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Processos/smartx/totvs.protheus.manufacturing.processinspection.test.valids.tlpp
- `validateQP1Carta` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Processos/smartx/totvs.protheus.manufacturing.processinspection.test.valids.tlpp
- `validateQP1Ensaio` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Processos/smartx/totvs.protheus.manufacturing.processinspection.test.valids.tlpp
- `validateQP1Metodo` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Processos/smartx/totvs.protheus.manufacturing.processinspection.test.valids.tlpp
- `validateQP1Qtde` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Processos/smartx/totvs.protheus.manufacturing.processinspection.test.valids.tlpp
- `validateQP2Classe` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Processos/smartx/totvs.protheus.manufacturing.processinspection.test.valids.tlpp
- `validateQP2NaoCon` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Inspeção de Processos/smartx/totvs.protheus.manufacturing.processinspection.test.valids.tlpp
- `ScaleX` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Metrologia/qmtr270.prw
- `QNCA050AuxClass` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Não Conformidades/qnca050.prw
- `new` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Não Conformidades/qnca050.prw
- `reposicionaNaLinhaDoListBoxAposRecriacaoDaTela` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Não Conformidades/qnca050.prw
- `reposicionaNoFolderAposRecriacaoDaTela` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de Não Conformidades/qnca050.prw
- `QPPMSGWARN` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de PPAP/qppxfun.prw
- `QPPVERAVISO` — Fontes_Doc/Master/Fontes/Gestão de Qualidade/Gestão de PPAP/qppxfun.prw
- `CoberturaTA` — Testes/Automação Protheus/Brasil/SIGAQIE/Script de Automacao/Cases/QIELaudosEnsaiosCoberturaTA.prw
- `QIESXValCov` — Testes/Automação Protheus/Brasil/SIGAQIE/Script de Automacao/Cases/QIESmartXValidsCoberturaUF.prw
- `API_009` — Testes/Automação Protheus/Brasil/SIGAQIP/Script de Automacao/Cases/ResultAPIQIPTestCase.prw
- `API_010` — Testes/Automação Protheus/Brasil/SIGAQIP/Script de Automacao/Cases/ResultAPIQIPTestCase.prw
- `API_011` — Testes/Automação Protheus/Brasil/SIGAQIP/Script de Automacao/Cases/ResultAPIQIPTestCase.prw
- `API_012` — Testes/Automação Protheus/Brasil/SIGAQIP/Script de Automacao/Cases/ResultAPIQIPTestCase.prw
- `RetornaRecnoInvalido` — Testes/Automação Protheus/Brasil/SIGAQIP/Script de Automacao/Cases/ResultAPIQIPTestCase.prw