# Desenvolvimento ADVPL

Repositório pessoal de **Willian Ramalho** com trechos de código AdvPL/TLPP (ERP TOTVS Protheus) de minha própria autoria, reunidos aqui como portfólio técnico e histórico de evolução como desenvolvedor.

## Propósito

Ao longo de projetos de customização Protheus em que atuei como desenvolvedor, escrevi e mantive diversas functions e methods. Este repositório existe para:

- Servir como portfólio público, demonstrando código real que escrevi (padrões, boas práticas, resolução de problemas).
- Preservar um histórico pessoal do meu crescimento técnico em AdvPL/TLPP, independentemente do vínculo com qualquer empregador ou cliente específico.

## Autoria e escopo do conteúdo

**Todo o código publicado neste repositório é de minha própria autoria** (individual ou em co-autoria, quando explicitado no cabeçalho de documentação de cada trecho).

Pontos importantes sobre o que é publicado aqui:

- **Não são fontes completos.** Cada arquivo contém apenas um trecho isolado (cabeçalho de documentação + corpo da function/method) — nunca a rotina, tela ou módulo inteiro de onde foi originado.
- **Sem dados ou regras de negócio de clientes.** Os trechos não incluem informações de clientes, credenciais, dados de produção ou identificação de rotina/projeto de origem.
- Identificadores de tabelas/campos padrão do ERP Protheus (ex.: `SA1`, `SX3`, campos `X3_*`) podem aparecer por fazerem parte da sintaxe padrão da linguagem/framework, sem relação com dados de clientes.

## Conteúdo

- Functions/Methods publicados: 80

## Lista de functions/methods

- [`AnexosInspecaoQualidadeAPI:ProcessaPEQQOFIPEM`](src/AnexosInspecaoQualidadeAPI_ProcessaPEQQOFIPEM.prw)
- [`CoberturaTA`](src/CoberturaTA.prw)
- [`FieldsUser`](src/FieldsUser.PRW)
- [`LaudosCobertura`](src/LaudosCobertura.prw)
- [`QADA100CLASS`](src/QADA100CLASS.prw)
- [`QADA100CLASS:populaArrayComRecnoDosCheckListsInativadosDaQUD`](src/QADA100CLASS_populaArrayComRecnoDosCheckListsInativadosDaQUD.prw)
- [`QADA100CLASS:verificaSeCheckListEstaRespondido`](src/QADA100CLASS_verificaSeCheckListEstaRespondido.prw)
- [`QDODocumentControl:avaliaPEQdoViLiPDF`](src/QDODocumentControl_avaliaPEQdoViLiPDF.PRW)
- [`QEPXFUNAuxClass`](src/QEPXFUNAuxClass.PRW)
- [`QEPXFUNAuxClass:new`](src/QEPXFUNAuxClass_new.PRW)
- [`QIE90GatFL`](src/QIE90GatFL.PRW)
- [`QIEA215AuxClass:changeFolderPrincipal`](src/QIEA215AuxClass_changeFolderPrincipal.PRW)
- [`QIEPlanoAmostragem`](src/QIEPlanoAmostragem.prw)
- [`QIEPlanoAmostragem:AplicaRegrasPlanoAmostragem`](src/QIEPlanoAmostragem_AplicaRegrasPlanoAmostragem.prw)
- [`QIEPlanoAmostragem:AvaliaAmostragemDupla`](src/QIEPlanoAmostragem_AvaliaAmostragemDupla.prw)
- [`QIEPlanoAmostragem:AvaliaAmostragemSimples`](src/QIEPlanoAmostragem_AvaliaAmostragemSimples.prw)
- [`QIEPlanoAmostragem:BuscaDadosPlanoAmostragem`](src/QIEPlanoAmostragem_BuscaDadosPlanoAmostragem.prw)
- [`QIEPlanoAmostragem:BuscaDadosPlanoAmostragemComHistorico`](src/QIEPlanoAmostragem_BuscaDadosPlanoAmostragemComHistorico.prw)
- [`QIEPlanoAmostragem:CalculaParecer`](src/QIEPlanoAmostragem_CalculaParecer.prw)
- [`QIEPlanoAmostragem:CarregaEnsaiosComPlanoAmostragem`](src/QIEPlanoAmostragem_CarregaEnsaiosComPlanoAmostragem.prw)
- [`QIEPlanoAmostragem:CarregaMedicoesDoEnsaio`](src/QIEPlanoAmostragem_CarregaMedicoesDoEnsaio.prw)
- [`QIEPlanoAmostragem:ContaNaoConformidadesNBR5426`](src/QIEPlanoAmostragem_ContaNaoConformidadesNBR5426.prw)
- [`QIEPlanoAmostragem:ContaNaoConformidadesNBR5429`](src/QIEPlanoAmostragem_ContaNaoConformidadesNBR5429.prw)
- [`QIEPlanoAmostragem:ContaNaoConformidadesPadrao`](src/QIEPlanoAmostragem_ContaNaoConformidadesPadrao.prw)
- [`QIEPlanoAmostragem:ContaNaoConformidadesPlanoInterno`](src/QIEPlanoAmostragem_ContaNaoConformidadesPlanoInterno.prw)
- [`QIEPlanoAmostragem:ContaNaoConformidadesPorTipoPlano`](src/QIEPlanoAmostragem_ContaNaoConformidadesPorTipoPlano.prw)
- [`QIEPlanoAmostragem:ContaNaoConformidadesQS9000`](src/QIEPlanoAmostragem_ContaNaoConformidadesQS9000.prw)
- [`QIEPlanoAmostragem:ContaNaoConformidadesTexto`](src/QIEPlanoAmostragem_ContaNaoConformidadesTexto.prw)
- [`QIEPlanoAmostragem:FormataMessagemPlanoAmostragem`](src/QIEPlanoAmostragem_FormataMessagemPlanoAmostragem.prw)
- [`QIEPlanoAmostragem:LimpaResultados`](src/QIEPlanoAmostragem_LimpaResultados.prw)
- [`QIEPlanoAmostragem:New`](src/QIEPlanoAmostragem_New.prw)
- [`QIEPlanoAmostragem:ProcessaEnsaios`](src/QIEPlanoAmostragem_ProcessaEnsaios.prw)
- [`QIEPlanoAmostragem:RetornaDetalhes`](src/QIEPlanoAmostragem_RetornaDetalhes.prw)
- [`QIEPlanoAmostragem:RetornaErro`](src/QIEPlanoAmostragem_RetornaErro.prw)
- [`QIEPlanoAmostragem:RetornaMensagem`](src/QIEPlanoAmostragem_RetornaMensagem.prw)
- [`QIEPlanoAmostragem:RetornaParecer`](src/QIEPlanoAmostragem_RetornaParecer.prw)
- [`QIEPlanoAmostragem:RetornaSucesso`](src/QIEPlanoAmostragem_RetornaSucesso.prw)
- [`QIEPlanoAmostragem:SeparaNaoConformidadesPorAmostra`](src/QIEPlanoAmostragem_SeparaNaoConformidadesPorAmostra.prw)
- [`QIEPlanoAmostragem:ValidaPreCondicoesTamanhoAmostra`](src/QIEPlanoAmostragem_ValidaPreCondicoesTamanhoAmostra.prw)
- [`QIEPlanoAmostragem:VerificaExistenciaSegundaAmostra`](src/QIEPlanoAmostragem_VerificaExistenciaSegundaAmostra.prw)
- [`QIEPlanoAmostragem:VerificaMedicaoAprovada`](src/QIEPlanoAmostragem_VerificaMedicaoAprovada.prw)
- [`QIEPlanoAmostragem:VerificaMedicaoReprovada`](src/QIEPlanoAmostragem_VerificaMedicaoReprovada.prw)
- [`QIEPlanoAmostragem:retornaLimitesEspecificacao`](src/QIEPlanoAmostragem_retornaLimitesEspecificacao.prw)
- [`QIESXValCov`](src/QIESXValCov.prw)
- [`QIPA215AuxClass:usuarioValidoNaDataDaMedicaoDoEnsaio`](src/QIPA215AuxClass_usuarioValidoNaDataDaMedicaoDoEnsaio.PRW)
- [`QIPRDADOS`](src/QIPRDADOS.PRW)
- [`QIPXFUNAuxClass:copiaVinculoDosArquivosDaManufaturaPorGrupo`](src/QIPXFUNAuxClass_copiaVinculoDosArquivosDaManufaturaPorGrupo.PRW)
- [`QIPXFUNAuxClass:copiaVinculoDosArquivosDaManufaturaPorProduto`](src/QIPXFUNAuxClass_copiaVinculoDosArquivosDaManufaturaPorProduto.PRW)
- [`QIPXFUNAuxClass:gravaCopiaArquivosEspecificacao`](src/QIPXFUNAuxClass_gravaCopiaArquivosEspecificacao.PRW)
- [`QLTQueryManager:ajustaCamposNotaParaArray`](src/QLTQueryManager_ajustaCamposNotaParaArray.prw)
- [`QLTQueryManager:ajustaCamposNotaParaComparacaoEmQuery`](src/QLTQueryManager_ajustaCamposNotaParaComparacaoEmQuery.prw)
- [`QLTQueryManager:retornaCamposDaNotaFiscalParaChaveDePesquisa`](src/QLTQueryManager_retornaCamposDaNotaFiscalParaChaveDePesquisa.prw)
- [`QLTQueryManager:retornaTamanhoDosCamposDaNotaFiscal`](src/QLTQueryManager_retornaTamanhoDosCamposDaNotaFiscal.prw)
- [`QLTQueryManager:validaIndiceNotaAvulsoNaQEL`](src/QLTQueryManager_validaIndiceNotaAvulsoNaQEL.prw)
- [`QLTQueryManager:validaIndiceNotaAvulsoNaQER`](src/QLTQueryManager_validaIndiceNotaAvulsoNaQER.prw)
- [`QLTQueryManager:validaTamanhoCamposChaveNF`](src/QLTQueryManager_validaTamanhoCamposChaveNF.prw)
- [`QNCA050AuxClass`](src/QNCA050AuxClass.prw)
- [`QNCA050AuxClass:new`](src/QNCA050AuxClass_new.prw)
- [`QNCA050AuxClass:reposicionaNaLinhaDoListBoxAposRecriacaoDaTela`](src/QNCA050AuxClass_reposicionaNaLinhaDoListBoxAposRecriacaoDaTela.prw)
- [`QNCA050AuxClass:reposicionaNoFolderAposRecriacaoDaTela`](src/QNCA050AuxClass_reposicionaNoFolderAposRecriacaoDaTela.prw)
- [`QPPMSGWARN`](src/QPPMSGWARN.prw)
- [`QPPVERAVISO`](src/QPPVERAVISO.prw)
- [`ResultAPIQIPTestCase:API_009`](src/ResultAPIQIPTestCase_API_009.prw)
- [`ResultAPIQIPTestCase:API_010`](src/ResultAPIQIPTestCase_API_010.prw)
- [`ResultAPIQIPTestCase:API_011`](src/ResultAPIQIPTestCase_API_011.prw)
- [`ResultAPIQIPTestCase:API_012`](src/ResultAPIQIPTestCase_API_012.prw)
- [`ResultAPIQIPTestCase:RetornaRecnoInvalido`](src/ResultAPIQIPTestCase_RetornaRecnoInvalido.prw)
- [`ScaleX`](src/ScaleX.prw)
- [`SeekNaQEK`](src/SeekNaQEK.PRW)
- [`SeekQEP183`](src/SeekQEP183.PRW)
- [`TrataGetMv`](src/TrataGetMv.PRW)
- [`VldTpRecbt`](src/VldTpRecbt.prw)
- [`buildValidationResult`](src/buildValidationResult.tlpp)
- [`validaEnsaioDuplicado`](src/validaEnsaioDuplicado.tlpp)
- [`validateQP1Carta`](src/validateQP1Carta.tlpp)
- [`validateQP1Ensaio`](src/validateQP1Ensaio.tlpp)
- [`validateQP1Metodo`](src/validateQP1Metodo.tlpp)
- [`validateQP1Qtde`](src/validateQP1Qtde.tlpp)
- [`validateQP2Classe`](src/validateQP2Classe.tlpp)
- [`validateQP2NaoCon`](src/validateQP2NaoCon.tlpp)
