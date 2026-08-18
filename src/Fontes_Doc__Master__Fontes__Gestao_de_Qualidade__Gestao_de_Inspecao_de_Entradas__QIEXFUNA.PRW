// Trechos extraidos automaticamente de: Fontes_Doc\Master\Fontes\Gestão de Qualidade\Gestão de Inspeção de Entradas\QIEXFUNA.PRW
// Contem SOMENTE functions/methods cujo cabecalho ProtheusDoc lista willian.ramalho como autor.
// Este arquivo NAO e o fonte completo original.

/*/{Protheus.doc} SeekNaQEK
Realiza posicionamento na QEK usando a chave do indice E via QLTQueryManager():dbSeek().
@type  static function
@author willian.ramalho
@since 16/06/2026
@param 01 cFornec, caracter, Fornecedor 	  	  - (QEK_FORNEC)
@param 02 cLojFor, caracter, Loja do fornecedor   - (QEK_LOJFOR)
@param 03 cProdut, caracter, Produto 			  - (QEK_PRODUT)
@param 04 cNtFisc, caracter, Nota fiscal 		  - (QEK_NTFISC)
@param 05 cSerInf, caracter, Serie da nota fiscal - (QEK_SERINF)
@param 06 cItemNF, caracter, Item da NF 		  - (QEK_ITEMNF)
@param 07 dDtEntr, data    , Data de entrada      - (QEK_DTENTR)
@param 08 cLote  , caracter, Lote 				  - (QEK_LOTE)  
@param 09 cNumSeq, caracter, Numero sequencial    - (QEK_NUMSEQ)
@return lFound, logico, .T. se localizar registro conforme filtros; .F. caso contrario
/*/
Static Function SeekNaQEK(cFornec, cLojFor, cProdut, cNtFisc, cSerInf, cItemNF, dDtEntr, cLote, cNumSeq)
	
	Local aFiltros := {}
	Local lFound   := .F.

	// Ordem da chave do indice E: QEK_FILIAL+QEK_FORNEC+QEK_LOJFOR+QEK_PRODUT+QEK_NTFISC+QEK_SERINF+DTOS(QEK_DTENTR)+QEK_LOTE+QEK_NUMSEQ
	// O campo QEK_FILIAL já será filtrado conforme filial logada em QLTQueryManager():dbSeek("QEK", "", aFiltros)
	
	//Campos em ordem do indice E:
	aAdd(aFiltros, {" QEK_FORNEC = ? ", {{cFornec      , "S"}}})
	aAdd(aFiltros, {" QEK_LOJFOR = ? ", {{cLojFor      , "S"}}})
	aAdd(aFiltros, {" QEK_PRODUT = ? ", {{cProdut      , "S"}}})
	aAdd(aFiltros, {" QEK_NTFISC = ? ", {{cNtFisc      , "S"}}})
	aAdd(aFiltros, {" QEK_SERINF = ? ", {{cSerInf      , "S"}}})
	aAdd(aFiltros, {" QEK_DTENTR = ? ", {{DtoS(dDtEntr), "S"}}})
	aAdd(aFiltros, {" QEK_LOTE   = ? ", {{cLote        , "S"}}})
	aAdd(aFiltros, {" QEK_NUMSEQ = ? ", {{cNumSeq      , "S"}}})
	
	//Fora do índice, por isso abaixo dos demais, respeitando indexação padrão
	aAdd(aFiltros, {" QEK_ITEMNF = ? ", {{cItemNF      , "S"}}})

	// O dbSeek interno ja aplica QEK_FILIAL (xFilial) e D_E_L_E_T_ = ' '.
	lFound := QLTQueryManager():dbSeek("QEK", "", aFiltros)

Return lFound


/*/{Protheus.doc} SeekQEP183
Realiza posicionamento na QEP usando a chave do indice 2 via QLTQueryManager():dbSeek().
@type  static function
@author willian.ramalho
@since 16/06/2026
@param 01 cCodTab, caracter, Codigo da tabela 	  - (QEP_CODTAB) - Identifica o Status da entrega: 1 - Importação correta, 2 - Inconsistencia na Importação.
@param 02 cFornec, caracter, Fornecedor 	  	  - (QEP_FORNEC)
@param 03 cLojFor, caracter, Loja do fornecedor   - (QEP_LOJFOR)
@param 04 cProdut, caracter, Produto 			  - (QEP_PRODUT)
@param 05 cNtFisc, caracter, Nota fiscal 		  - (QEP_NTFISC)
@param 06 cSerInf, caracter, Serie da nota fiscal - (QEP_SERINF)
@param 07 cItemNF, caracter, Item da NF 		  - (QEP_ITEMNF)
@param 08 cTipoNF, caracter, Tipo da NF 		  - (QEP_TIPONF)
@param 09 dDtEntr, data    , Data de entrada      - (QEP_DTENTR)
@param 10 cLote  , caracter, Lote 			      - (QEP_LOTE)
@param 11 cNumSeq, caracter, Numero sequencial    - (QEP_NUMSEQ)
@return lFound, logico, .T. se localizar registro conforme filtros; .F. caso contrario
/*/
Static Function SeekQEP183(cCodTab, cFornec, cLojFor, cProdut, cNtFisc, cSerInf, cItemNF, cTipoNF, dDtEntr, cLote, cNumSeq)

	Local aFiltros := {}
	Local lFound   := .F.

	// Ordem da chave do indice 2: QEP_FILIAL + QEP_CODTAB + QEP_FORNEC + QEP_LOJFOR + QEP_PRODUT + QEP_NTFISC + QEP_SERINF + QEP_ITEMNF + QEP_TIPONF + DTOS(QEP_DTENTR) + QEP_LOTE + QEP_NUMSEQ
	// O campo QEP_FILIAL já será filtrado conforme filial logada em QLTQueryManager():dbSeek("QEP", "", aFiltros)
	aAdd(aFiltros, {" QEP_CODTAB = ? ", {{cCodTab      , "S"}}})
	aAdd(aFiltros, {" QEP_FORNEC = ? ", {{cFornec      , "S"}}})
	aAdd(aFiltros, {" QEP_LOJFOR = ? ", {{cLojFor      , "S"}}})
	aAdd(aFiltros, {" QEP_PRODUT = ? ", {{cProdut      , "S"}}})
	aAdd(aFiltros, {" QEP_NTFISC = ? ", {{cNtFisc      , "S"}}})
	aAdd(aFiltros, {" QEP_SERINF = ? ", {{cSerInf      , "S"}}})
	aAdd(aFiltros, {" QEP_ITEMNF = ? ", {{cItemNF      , "S"}}})
	aAdd(aFiltros, {" QEP_TIPONF = ? ", {{cTipoNF      , "S"}}})
	aAdd(aFiltros, {" QEP_DTENTR = ? ", {{DtoS(dDtEntr), "S"}}})
	aAdd(aFiltros, {" QEP_LOTE   = ? ", {{cLote        , "S"}}})
	aAdd(aFiltros, {" QEP_NUMSEQ = ? ", {{cNumSeq      , "S"}}})

	// O dbSeek interno ja aplica QEP_FILIAL (xFilial) e D_E_L_E_T_ = ' '.
	lFound := QLTQueryManager():dbSeek("QEP", "", aFiltros)

Return lFound
