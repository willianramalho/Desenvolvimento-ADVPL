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
