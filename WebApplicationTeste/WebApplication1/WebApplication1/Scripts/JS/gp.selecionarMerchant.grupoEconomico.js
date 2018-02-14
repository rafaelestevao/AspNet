$(function () {
    //configurarMenu();
    configurarBuscaEC();
    paginarListaDeEC();

    configurarPlaceholder();
});

if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function (obj, start) {
        for (var i = (start || 0), j = this.length; i < j; i++) {
            if (this[i] === obj) { return i; }
        }
        return -1;
    }
}

//function configurarMenu() {
//    var itensMenu = $('.menu-horizontal > ul > li');
//    var restrito = ['Minha conta', 'Autorizações', 'Recebíveis', 'Meus arquivos', 'Demonstrações financeiras'];
//    for (var i = 0; i < itensMenu.length; i++) {
//        if (restrito.indexOf($(itensMenu[i]).find('.menu-item-text').first().text()) >= 0) {
//            $(itensMenu[i]).hide();
//        }
//    }
//}

function paginarListaDeEC() {
    var container = $('.wrapperPaginacao');
    container.html('');

    // Calcula o numero de páginas
    var quantidadePaginas = ($('.ec.paginavel').length / 15);
    if ($('.ec.paginavel').length % 15 > 0) {
        quantidadePaginas++;
    }

    // renderiza a paginação
    for (var p = 1; p <= quantidadePaginas; p++) {
        container.append('<div class="btPagina">' + p + '</div>');
    }

    // Configura o evento de paginação
    $('.btPagina').on('click', function () {
        irParaPagina($(this).text());
    });
    irParaPagina(1);
}

function configurarBuscaEC() {
    $('#txtBuscaEC').on('keyup', buscarEC);
}

function buscarEC() {
    var texto = $('#txtBuscaEC').val();
    var itens = $('.ec');
    itens.removeClass('paginavel')
        .addClass('paginavel');
    if (texto != "") {
        itens.each(function (i, e) {
            if ($(this).find('td a span').first().text().indexOf(texto) < 0) {
                $(this).removeClass('paginavel');
            }
        });
    }
    paginarListaDeEC();
}

function irParaPagina(pagina) {
    var itens = $('.ec.paginavel');
    itens.addClass('removidoPaginacao');
    pagina = parseInt(pagina);

    var itensParaMostrar = itens.slice((15 * (pagina - 1)), (15 * (pagina - 1) + 15));
    $(itensParaMostrar).removeClass('removidoPaginacao');

    $($('.btPagina').removeClass('ativo')[pagina - 1]).addClass('ativo');

}

function configurarPlaceholder() {
    $('[placeholder]').focus(function () {
        var input = $(this);
        if (input.val() == input.attr('placeholder')) {
            input.val('');
            input.removeClass('placeholder');
        }
    }).blur(function () {
        var input = $(this);
        if (input.val() == '' || input.val() == input.attr('placeholder')) {
            input.addClass('placeholder');
            input.val(input.attr('placeholder'));
        }
    }).blur();

    $('[placeholder]').parents('form').submit(function () {
        $(this).find('[placeholder]').each(function () {
            var input = $(this);
            if (input.val() == input.attr('placeholder')) {
                input.val('');
            }
        })
    });
}