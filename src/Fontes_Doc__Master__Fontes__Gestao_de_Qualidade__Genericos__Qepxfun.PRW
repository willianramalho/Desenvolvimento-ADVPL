// Trechos extraidos automaticamente de: Fontes_Doc\Master\Fontes\Gestão de Qualidade\Genéricos\Qepxfun.PRW
// Contem SOMENTE functions/methods cujo cabecalho ProtheusDoc lista willian.ramalho como autor.
// Este arquivo NAO e o fonte completo original.

/*/{Protheus.doc} QEPXFUNAuxClass
Classe geral do QEPXFUN
@author willian.ramalho
@since 17/03/2026
/*/
CLASS QEPXFUNAuxClass FROM LongNameClass
    
	METHOD new() CONSTRUCTOR
	METHOD converteStringEmNumero(cValor)
	METHOD truncaValorCampoNumerico(cAlias, cCampoDest, nVlrOrigem)
	METHOD validaTamanhoDoCampoQuantidadeEPreco(aCamposDst, cCampoRef)
	METHOD validaTamanhoDoConteudoDosCampos(aDestinos, nValorRef, cCampoRef, nOpc)

	Static Method copiaArquivoParaServidor(cArqAnexo, cQPathTrm, cPath, cHelpId, cProblema, cSolucao, nCobertura)
	Static Method estagiaEAbrePreSave(cArquivo, cQPathTrm, cAlias, nOpc)
	Static Method garanteDir(cDiretorio, nCobertura)
	Static Method garanteSeparadorFinal(cDiretorio, cSeparador)
	Static Method nomeFisicoAnexo(cMsUid, cNomeOriginal)
	Static Method normalizaSeparador(cPath, cSeparador)
	Static Method renomeiaArquivoPorCaixa(cArquivo)
	Static Method resolveDiretorioServidorPorCaixa(cDiretorio)
	Static Method resolveMVDiretorioServidor(cParamMV, cDefault)
	Static Method visualizaAnexoComFallback(cMsUid, cNomeOriginal, cPath, cQPathTrm, nOpc, cAlias)
	
ENDCLASS


/*/{Protheus.doc} new
Método construtor da classe
@author willian.ramalho
@since 17/03/2026
@return Self
/*/
METHOD new() CLASS QEPXFUNAuxClass 
Return Self
