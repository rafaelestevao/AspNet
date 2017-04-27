$(function () {
    var container = $('.containerMensagemHome');
    container.html('');
    var textoMensagem = '<p style="color: red; margin-top: 10px" class="somenteWebPart"> ' +
	'Importante ' +
    '</p> ' +
    ' ' +
    '<p class="mensagem"> ' +
	    'Manual POS ' +
	    '<label>(<a href="/Style Library/GP-Extranet/pdf/manualPOS.pdf" title="Manual Operacional do Terminal">download</a>)</label> ' +
    '</p> ' +
    ' ' +
    '<p class="mensagem"> ' +
	    'Comunicado DIRF 2016 ' +
	    '<label>(competência 2015) (<a href="/Style Library/GP-Extranet/pdf/DIRF_2016.pdf" title="Comunicado DIRF 2016">download</a>)</label> ' +
    '</p> ' +
    ' ' +
    '<div id="divCorrecaoAluguel"> ' +
        '<p class="semMargin mensagem"> ' +
            'Correção de Aluguel:  ' +
        '<label> ' +
            'Prezados clientes, comunicamos que à partir de setembro de 2016, os aluguéis das maquininhas que foram instaladas há mais de  um ano, serão corrigidos com índice IPCA do período. ' +
        '</label> ' +
        '</p> ' +
    '</div> ' +
    ' ' +
    '<div id="divMensagemImportante"> ' +
        '<p class="semMargin mensagem"> ' +
        '<label><strong class="msgFDA"> ' +
            'Prezado cliente, informamos que devido ao expediente bancário de fim de ano,  ' +
            'os pagamentos de transações de débito realizadas nos dias 29/12, 30/12,  ' +
            '31/12 e 01/01 e as de crédito agendados para essas datas, serão pagas no dia 02/02. ' +
            '<br /> ' +
            'Desejamos boas festas e excelentes negócios em 2017! ' +
        '</strong></label> ' +
        '</p> ' +
    '</div> ';

    container.append(textoMensagem);
});