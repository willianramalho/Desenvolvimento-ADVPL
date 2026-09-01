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
