/*/{Protheus.doc} avaliaPEQdoViLiPDF
Avalia existência do PE QDOVILIPDF e o executa, quando existir.
@author Willian.Ramalho
@since  25/04/2025
@return lSucesso, lógico, retorna TRUE indicando sucesso ou indicativo de retorno da customização do ponto de entrada
@param 01 - cArquivo  , caracter, nome do arquivo no diretório padrão de documentos do QDO no servidor
@param 02 - cDocumento, caracter, código do documento relacionado
@param 03 - cRevisao  , caracter, código da revisão do documento relacionada
/*/

METHOD avaliaPEQdoViLiPDF(cArquivo, cDocumento, cRevisao) CLASS QDODocumentControl

    Local lRetPE     := .T.
    Local lSucesso   := .T.

    lPeViliPDF := Iif(lPeViliPDF == Nil, ExistBlock("QDOVILIPDF"), lPeViliPDF)

    If lPeViliPDF
        lRetPE := ExecBlock("QDOVILIPDF", .F., .F., {cArquivo, cDocumento, cRevisao})
        If ValType(lRetPE) == "L"
            lSucesso := lRetPE
        EndIf
    EndIf

Return lSucesso
