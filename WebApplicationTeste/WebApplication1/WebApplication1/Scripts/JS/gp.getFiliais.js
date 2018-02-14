function getFiliais(merchantLogado, merchanCript) {
    var strBusca = buscaFilial.value;
    var url = '/_layouts/Extranet/FiliaisWs.asmx/GetFiliais';

    var strMerchantLogado = merchantLogado;
    var strMerchantEncript = merchanCript;
    var count = 0;
    $("#temMaisRegistros").addClass("esconder");

    $.ajax({
        type: "POST",
        url: url,
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ consulta: strBusca, merchant: strMerchantLogado, val: strMerchantEncript }),
        dataType: "json",
        success: function (data) {
            if (data.d != null) {
                var items = data.d;
                var fragment = "";

                var item = jQuery.parseJSON(data.d)
                $.each(item, function (i, d) {
                    var codigoFilial = this.codigoFilial;
                    var descricaoFilial = this.descricaoFilial;
                    fragment += "<tr><td class=\"registrosModal\"><a href=\"javascript:setFilial('" + descricaoFilial + "', '" + codigoFilial + "')\" class=\"ajusteLinkNomeFilial modalCloseImg simplemodal-close\">" + codigoFilial + " - " + descricaoFilial + "</a></td>";
                    fragment += "<td><button onClick=\"javascript:setFilial('" + descricaoFilial + "', '" + codigoFilial + "')\" type=\"button\" class=\"btn btn-default btn-xs bntSelecionar modalCloseImg simplemodal-close\">Selecionar</button></td></tr>";
                    count = count + 1;
                });
                if (count > 4 && count <= 10) {
                    $("#simplemodal-container").addClass("altura500");
                    $("#simplemodal-container").removeClass("altura280");
                    $("#simplemodal-container").removeClass("altura600");
                }
                else if (count > 0 && count <= 4) {
                    $("#simplemodal-container").addClass("altura280");
                    $("#simplemodal-container").removeClass("altura600");
                    $("#simplemodal-container").removeClass("altura500");
                }
                else if (count > 10) {
                    $("#simplemodal-container").addClass("altura600");
                    $("#simplemodal-container").removeClass("altura500");
                    $("#simplemodal-container").removeClass("altura280");
                }
                $("#tblModalFiliais").append(fragment);
                success: true;
                errorMessage: null;
                errorRedirectUrl: null;

                if (count == 50)
                    $("#temMaisRegistros").removeClass("esconder");
                else
                    $("#temMaisRegistros").addClass("esconder");

                return data.d;
            }
            else {
                fragment += "<tr><td class=\"registrosModal\">Sua pesquisa não encontrou resultados correspondentes.</td>";
                $("#simplemodal-container").addClass("altura210");
                $("#tblModalFiliais").append(fragment);
                success: true;
                errorMessage: null;
                errorRedirectUrl: null;
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Não foi possível efetuar a busca de filiais. Erro: ' + errorThrown);
        }
    });
}

function clearTable() {
    $("#tblModalFiliais tbody").remove();
}

$(document).on("click", "[id*=est]", function () {
    $('#basic-modal-content').modal();
    divModalFiliais.style.visibility = 'visible';
    btnBuscarFilial.value = 'filial';
    return false;
});

$(document).on("click", "[id*=estabelecimento]", function () {
    $('#basic-modal-content').modal();
    divModalFiliais.style.visibility = 'visible';
    btnBuscarFilial.value = 'filial';
    return false;
});