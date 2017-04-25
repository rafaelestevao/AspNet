<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication2._Default" %>


<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">


    <style type="text/css">
        .tamanho {
            height: 200px;
            width: 200px;
        }
    </style>

    
    <script type="text/javascript">
        //teste
        var url = '/app/Palmolive/BR/HomePage/';
        var config = {
            tplData: {
                url: url,
                urlFiles: url,
                urlAssets: '/Palmolive/BR/HomePage/assets/',
                urlBody: url + 'body-care/',
                urlHair: url + 'hair-care/',
                urlXp: '/app/Palmolive/BR/experiencias/',
                urlXpBody: '/app/Palmolive/BR/produtos/body-care/',
                urlXpHair: '/app/Palmolive/BR/produtos/hair-care/',
                urlAssetsBody: '/Palmolive/BR/HomePage/assets/images/experiencias/produtos/body-care/',
                urlAssetsHair: '/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-care/',
                urlAssetsTips: '/Palmolive/BR/HomePage/assets/images/experiencias/',
            },
            breakpoints: {
                col_size_small: [0, 660],
                col_size_medium: [661, 959],
                col_size_desktop: [960, 6000]
            },
            shareUrl: 'http://promolatam.com/colgate/apps/sharer/page/br/palmolive/',
            newWindowOptions: "toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=yes, width=508, height=365, top=85, left=140",
        };

        var PON = {
            init: function () {
                this.checkConsoleAvailability();
                this.bindElems();
                this.loadShareTab();
                this.loadTpls();
                this.checkShares();
            },
            bindSideMenu: function () {
                if (j('#side-hair').length >= 1) {
                    var $el = j('#side-hair');
                    $el.find('li p').click(function (e) {
                        var $elClick = j(e.currentTarget);
                        if (!$elClick.next().hasClass('open')) {
                            $el.find('.open').slideToggle().removeClass('open');
                            $elClick.next().addClass('open').slideToggle();
                        }
                    });
                }
            },
            bindElems: function () {
                j('.modal').on('loaded.bs.modal', function (e) { PON.checkYtVideos('show', j(e.currentTarget)); });
                j('.modal').on('shown.bs.modal', function (e) { PON.checkYtVideos('show', j(e.currentTarget)); });
                j('.modal').on('hide.bs.modal', function (e) { PON.checkYtVideos('hide', j(e.currentTarget)); });

                j('#content')
                .on('click', '.btn-open-plus, .open-overlay', function (e) {
                    e.preventDefault();
                    var $el = j(e.currentTarget);
                    if (typeof $el.attr('data-open') != 'undefined') {

                        $overlay = j('body').find('div[data-overlay="' + $el.attr('data-open') + '"]');

                        $overlay.toggleClass('overlay-hidden');

                        if ($overlay.find('iframe') && typeof $overlay.find('iframe').attr('data-youtube') != 'undefined') {
                            $overlay.find('iframe').attr("src", $overlay.find('iframe').attr('data-youtube'));
                        }

                    } else {
                        j(".btn-open-plus").hide();
                        j(".showerGel").show();
                    }
                    return (false);
                })
                .on('click', '.btn-close-x, .overlay', function (e) {
                    e.preventDefault();
                    var $el = j(e.currentTarget);
                    if ($el.parents('.overlay') || $el.hasClass('overlay')) {
                        var $overlay = ($el.hasClass('overlay')) ? $el : $el.parents('.overlay');
                        $overlay.toggleClass('overlay-hidden');

                        if ($overlay.find('iframe')) {
                            var $iframe = $overlay.find('iframe');
                            var src = $iframe.attr("src");
                            $iframe.attr("src", "");
                        }

                    } else {
                        j(".btn-open-plus").show();
                        j(".showerGel").hide();
                    }
                    return (false);
                });

                j('#website')
                .on('click', '[data-link-social]', function (e) {
                    e.preventDefault();
                    var link = j(this).attr('data-link-social');
                    window.open(link, 'share', config.newWindowOptions);
                })
                .on('click', '[data-tag]', function (e) { //bind links with tagging
                    OmnitureTag(j(e.currentTarget).attr('data-tag'));
                })
                .on('click', '[data-href]', function (e) { //for touch windows
                    window.location.href = j(e.currentTarget).attr('data-href');
                })
                .on('click', '#btn-filtrar-artigos', function (e) {
                    e.preventDefault();
                    var anchoBrowser = j(window).width() + 17;
                    j("#list-filters-artigos").slideToggle();
                    //j("#list-filters-artigos").slideToggle('slow');
                })
                .on('click', '#list-filters-artigos a', function (e) {
                    e.preventDefault();
                    var $el = j(e.currentTarget);
                    var filter = $el.data('filter');
                    var $container = j('#container');
                    if (filter == "all-artigos") {
                        $container.find('.item').show();
                        $container.masonry();
                    } else {
                        $container.find('.item').not('[data-item-filter*="' + filter + '"]').hide();
                        $container.find('[data-item-filter*="' + filter + '"]').show();
                        $container.masonry();
                    }
                });
            },
            checkShares: function () {
                j('#website').find('[data-col-share]').each(function () {
                    var $el = j(this);
                    if (typeof $el.attr('data-col-share-rendered') === 'undefined') {
                        var tk = $el.attr('data-col-share');
                        $el.attr('data-col-share-rendered', true);
                        $el.find('.facebook').attr('data-link-social', config.shareUrl + tk + '/fb').attr('data-tag', 'social-click/fb/' + tk);
                        $el.find('.twitter').attr('data-link-social', config.shareUrl + tk + '/tw').attr('data-tag', 'social-click/tw/' + tk);
                        $el.find('.pinterest').attr('data-link-social', config.shareUrl + tk + '/pin').attr('data-tag', 'social-click/pin/' + tk);
                    }
                });
            },
            checkYtVideos: function (action, $el) {

                PON.checkShares();

                if ($el.find('[data-yt]').length > 0) {

                    switch (action) {
                        case 'show':

                            var src = $el.find('[data-yt]').attr('data-yt');

                            if (j('html').hasClass('col_size_small')) {
                                j('.modal').modal('hide');
                                var win = window.open(src, '_blank');
                                win.focus();
                            } else {
                                $el.find('iframe').attr('src', src);
                            }

                            break;

                        case 'hide':
                            $el.find('iframe').attr('src', '');
                            break;
                    }
                }

            },
            setWidthClass: function () {
                var w = j(window).width();
                var size = '';
                for (var i in config.breakpoints) {
                    if (config.breakpoints[i][0] <= w && config.breakpoints[i][1] >= w) {
                        size = i;
                    }
                }

                var $html = j('html');
                if (!$html.hasClass(size)) {
                    $html.removeClass(function (k, css) {
                        return (css.match(/\bcol_size\S+/g) || []).join(' ');
                    });
                    $html.addClass(size);
                }
            },
            showMenuTab: function ($el) {
                var $tabItem = j('#tabs');
                var tabSelected = $el.attr('href');

                if ($tabItem.find(tabSelected)) {
                    $tabItem.find('.topSubMenu li').removeClass('ui-tabs-selected');
                    $tabItem.find('.contentSubMenu').hide();
                    $el.parent().addClass('ui-tabs-selected');
                    $tabItem.find(tabSelected).show();
                }
            },
            checkConsoleAvailability: function () {
                if (!window['console']) {
                    window.console = {};
                    window.console.info = function () { };
                    window.console.log = function () { };
                    window.console.warn = function () { };
                    window.console.error = function () { };
                }
            },
            loadTpls: function () {
                j('#topMenu').html(Mustache.render(tpls.menu, config.tplData));
                j('#siteFooter').html(Mustache.render(tpls.footer, config.tplData));
                j('#topMenuMobile').html(Mustache.render(tpls.menuResponsive, config.tplData));
                var tplSide;
                if (j('.body-tpl').length == 1) {
                    tplSide = tpls.sideBody;
                }
                if (j('.hair-tpl').length == 1) {
                    tplSide = tpls.sideHair;
                }
                j('#sideMenu').html(Mustache.render(tplSide, config.tplData));
                this.bindMenu();
                this.bindSideMenu();
            },
            bindMenu: function ($, availableTags) {
                //menu responsive
                j('#topMenuMobile .menu-title h3').click(function (e) {
                    if (!j(e.currentTarget).hasClass('open')) {
                        j('#topMenuMobile .menu-title h3').removeClass('open');
                        j(e.currentTarget).addClass('open');
                    } else {
                        j(e.currentTarget).removeClass('open');
                    }
                });

                j('.menu-mobile-icon').click(function () {
                    j('.nav').toggleClass('mobile-open');
                });

                //diabled click Menu
                j('.disClick').click(function () {
                    return false;
                });

                //search  menu
                j('#searchInput').val("Busca");

                //Search input field behavior.
                j('#searchInput').focus(function () {
                    //j(this).addClass('sfocus');
                    j('.btnSearch').addClass('active');
                    if (j(this).val() == "Busca") {
                        j(this).val("");
                    }
                }
                ).focusout(function () {
                    if (j(this).val() == "") {
                        j(this).val("Busca");
                        j('.subMenuSearch').hide();
                        j(this).removeClass('sfocus');
                        j('.btnSearch').removeClass('active');
                    }
                });

                //Hide search box.
                j('#content').click(function () {
                    if (j('.subMenuSearch').is(':visible')) {
                        j('.subMenuSearch').hide();
                        j('#searchInput').removeClass('sfocus');
                        j('.btnSearch').removeClass('active');

                    }
                }
                );

                j('#searchInput').keyup(function (e) {
                    j('.subMenuSearch').show();
                    var valSearch = j('#searchInput').val().toLowerCase();

                    var maxItems = 4;

                    var htmlProducts = '',
                        htmlDicas = '',
                        htmlInfo = '';

                    var contProducts = 1,
                        contDicas = 1,
                        contInfo = 1;

                    availableTags.forEach(function (item) {
                        if (item.value.indexOf(valSearch) >= 0) {
                            switch (item.category) {
                                case 'producto':
                                    if (contProducts >= maxItems) {
                                        break;
                                    } else {
                                        htmlProducts += Mustache.render(tpls.searchItem_producto, item);
                                        contProducts++;
                                    }
                                    break;
                                case 'dicas':
                                    if (contDicas >= maxItems) {
                                        break;
                                    } else {
                                        htmlDicas += Mustache.render(tpls.searchItem_dicas, item);
                                        contDicas++;
                                    }
                                    break;

                                case 'info':
                                    if (contDicas >= maxItems) {
                                        break;
                                    } else {
                                        htmlInfo += Mustache.render(tpls.searchItem_info, item);
                                        contInfo++;
                                    }
                                    break;
                            }
                        }
                    });

                    j('[data-category="producto"]').html(htmlProducts);
                    j('[data-category="dicas"]').html(htmlDicas);
                    j('[data-category="info"]').html(htmlInfo);
                });

                //Search field dataprovider.
                var availableTags = [
                    {
                        label: "RenovaÃ§Ã£o PÃ³s-QuÃ­mica - Keratina & KaritÃ©",
                        value: "renovaÃ§Ã£o quÃ­mica quimica keratina karite",
                        category: "producto",
                        image: "http://www.colgate.com.br/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-care/product_haircare_05.png",
                        urlsearch: "http://www.colgate.com.br/app/Palmolive/BR/produtos/hair-care/renovacao-pos-quimica.cvsp"
                    },
                        {
                            label: "Nutri-liss - ProteÃ­na de Trigo & Ã“leo de Palmeira",
                            value: "nutri-liss proteÃ­na trigo Ã³leo oleo palmeira",
                            category: "producto",
                            image: "http://www.colgate.com.br/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-care/product_haircare_01.png",
                            urlsearch: "http://www.colgate.com.br/app/Palmolive/BR/produtos/hair-care/nutri-liss.cvsp"
                        },
                    {
                        label: "Longo Sedutor - Microcristais de Turmalina",
                        value: "longo sedutor microcristais turmalina",
                        category: "producto",
                        image: "http://www.colgate.com.br/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-careproduct_haircare_02.png",
                        urlsearch: config.tplData.urlXpHair + "longo-sedutor.cvsp"
                    },
                    {
                        label: "Agencia Foster",
                        value: "agencia foster - fabrica de software",
                        category: "info",
                        image: "http://www.foster.com.br/images/logo-foster-home.png",
                        urlsearch: "http://www.foster.com.br/index.aspx"
                    },
                    {
                        label: "Ã“leo Surpreendente",
                        value: "Ã³leo oleo surpreendente Ã³leo oleo de camÃ©lia",
                        category: "producto",
                        image: "http://www.colgate.com.br/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-careproduct_haircare_00.png",
                        urlsearch: config.tplData.urlXpHair + "oleo-surpreendente.cvsp"
                    },
                    {
                        label: "HidrataÃ§Ã£o Luminosa - Ã“leo de Argan",
                        value: "argan luminosa oleo",
                        category: "producto",
                        image: "http://www.colgate.com.br/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-careproduct_haircare_03.png",
                        urlsearch: config.tplData.urlXpHair + "hidratacao-luminosa.cvsp"
                    },
                    {
                        label: "ReparaÃ§Ã£o Completa - Geleia Real",
                        value: "reparaÃ§Ã£o completa geleia gelÃ©ia real",
                        category: "producto",
                        image: "http://www.colgate.com.br/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-careproduct_haircare_04.png",
                        urlsearch: config.tplData.urlXpHair + "reparacao-completa.cvsp"
                    },
                    {
                        label: "Ceramidas - Ceramida de origem 100% natural",
                        value: "ceramidas",
                        category: "producto",
                        image: "http://www.colgate.com.br/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-careproduct_haircare_16.png",
                        urlsearch: config.tplData.urlXpHair + "ceramidas.cvsp"
                    },
                    {
                        label: "Kids - Para todo o tipo de cabelo",
                        value: "kids crianÃ§a crianÃ§as infantil",
                        category: "producto",
                        image: "http://www.colgate.com.br/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-careproduct_haircare_06.png",
                        urlsearch: config.tplData.urlXp + "kids.cvsp"
                    },
                    {
                        label: "Cores Brilhantes - Extrato de RomÃ£",
                        value: "cores brilhantes roma romÃ£ tingido",
                        category: "producto",
                        image: "http://www.colgate.com.br/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-careproduct_haircare_07.png",
                        urlsearch: config.tplData.urlXpHair + "cores-brilhantes.cvsp"
                    },
                    {
                        label: "Iluminador Pretos - Melanina de origem 100% natural",
                        value: "iluminador pretos preto melanina",
                        category: "producto",
                        image: "http://www.colgate.com.br/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-careproduct_haircare_08.png",
                        urlsearch: config.tplData.urlXpHair + "iluminador-pretos.cvsp"
                    },
                    {
                        label: "Queda Resist - Ceramida de origem 100% natural",
                        value: "queda resist anti ceramida",
                        category: "producto",
                        image: "http://www.colgate.com.br/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-careproduct_haircare_09.png",
                        urlsearch: config.tplData.urlXpHair + "queda-resist.cvsp"
                    },
                    {
                        label: "Cachos Control - Extrato de Aloe Vera e Oil-Complex",
                        value: "cachos control cacheado aloe vera oil complex",
                        category: "producto",
                        image: "http://www.colgate.com.br/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-careproduct_haircare_10.png",
                        urlsearch: config.tplData.urlXpHair + "cachos-control.cvsp"
                    },
                    {
                        label: "Anticaspa ClÃ¡ssico - Climbanzol e Ã“leo de Eucalipto",
                        value: "anticaspa caspa climbanzol oleo Ã³leo de eucalipto",
                        category: "producto",
                        image: "http://www.colgate.com.br/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-careproduct_haircare_11.png",
                        urlsearch: config.tplData.urlXpHair + "anticaspa-classico.cvsp"
                    },
                    {
                        label: "Anticaspa 2 em 1 - Climbanzol e Extrato de Aloe Vera",
                        value: "anticaspa caspa 2 em 1 climbanzol aloe vera",
                        category: "producto",
                        image: "http://www.colgate.com.br/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-careproduct_haircare_12.png",
                        urlsearch: config.tplData.urlXpHair + "anticaspa-2-em-1.cvsp"
                    },
                    {
                        label: "Anticaspa for Men - Climbanzol e Extrato de Algas",
                        value: "anticaspa caspa homem climbanzol extrato de algas",
                        category: "producto",
                        image: "http://www.colgate.com.br/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-careproduct_haircare_13.png",
                        urlsearch: config.tplData.urlXpHair + "anticaspa-men.cvsp"
                    },
                    {
                        label: "Anti-Armado",
                        value: "anti armado abacate",
                        category: "producto",
                        image: "http://www.colgate.com.br/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-careproduct_haircare_14.png",
                        urlsearch: config.tplData.urlXpHair + "anti-armado.cvsp"
                    },
                    {
                        label: "Neutro",
                        value: "neutro erva cidreira",
                        category: "producto",
                        image: "http://www.colgate.com.br/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-careproduct_haircare_17.png",
                        urlsearch: config.tplData.urlXpHair + "neutro.cvsp"
                    },
                    {
                        label: "NutriÃ§Ã£o e Suavidade - GelÃ©ia Real e ProteÃ­na da Seda",
                        value: "nutriÃ§ao suavidade geleia real seda",
                        category: "producto",
                        image: config.tplData.urlAssetsBody + "product_bodycare_01.png",
                        urlsearch: config.tplData.urlXpBody + "nutricao-e-suavidade.cvsp"
                    },
                        {
                            label: "Ã“leo Nutritivo",
                            value: "Ã³leo oleo nutritivo Ã³leo oleo de amÃªndoas ",
                            category: "producto",
                            image: config.tplData.urlAssetsBody + "product_bodycare_00.png",
                            urlsearch: config.tplData.urlXpBody + "oleo-nutritivo.cvsp"
                        },
                    {
                        label: "SensaÃ§Ã£o Luminosa - Ã“leo de Argan",
                        value: "sensaÃ§Ã£o luminosa Ã³leo oleo de argan",
                        category: "producto",
                        image: config.tplData.urlAssetsBody + "product_bodycare_03.png",
                        urlsearch: config.tplData.urlXpBody + "sensacao-luminosa.cvsp"
                    },
                    {
                        label: "EsfoliaÃ§Ã£o Suave - Coco & AlgodÃ£o",
                        value: "esfoliaÃ§Ã£o suave coco algodÃ£o",
                        category: "producto",
                        image: config.tplData.urlAssetsBody + "product_bodycare_04.png",
                        urlsearch: config.tplData.urlXpBody + "esfoliacao-suave.cvsp"
                    },
                    {
                        label: "Aromatherapy Relax - Relaxa seus sentidos e Suaviza sua pele",
                        value: "aromatherapy relax aroma lavanda",
                        category: "producto",
                        image: config.tplData.urlAssetsBody + "product_bodycare_06.png",
                        urlsearch: config.tplData.urlXpBody + "aromatherapy-relax.cvsp"
                    },
                    {
                        label: "Nutri-Milk - ProteÃ­nas do Leite",
                        value: "nutri milk proteÃ­nas leite",
                        category: "producto",
                        image: config.tplData.urlAssetsBody + "product_bodycare_07.png",
                        urlsearch: config.tplData.urlXpBody + "nutri-milk.cvsp"
                    },
                    {
                        label: "Nutri-Milk Dupla HidrataÃ§Ã£o - ProteÃ­nas do Leite & Manteiga de KaritÃª",
                        value: "nutri milk proteÃ­nas leite manteiga karitÃª",
                        category: "producto",
                        image: config.tplData.urlAssetsBody + "product_bodycare_08.png",
                        urlsearch: config.tplData.urlXpBody + "nutri-milk-karite.cvsp"
                    },
                    {
                        label: "Nutri-Milk Esfoliante - ProteÃ­nas do Leite",
                        value: "nutri milk esfoliante proteÃ­nas leite",
                        category: "producto",
                        image: config.tplData.urlAssetsBody + "product_bodycare_09.png",
                        urlsearch: config.tplData.urlXpBody + "nutri-milk-esfoliante.cvsp"
                    },
                    {
                        label: "HidrataÃ§Ã£o SaudÃ¡vel - Aloe e Oliva",
                        value: "hidrataÃ§Ã£o hidratante aloe oliva",
                        category: "producto",
                        image: config.tplData.urlAssetsBody + "product_bodycare_10.png",
                        urlsearch: config.tplData.urlXpBody + "hidratacao-saudavel.cvsp"
                    },
                    {
                        label: "HidrataÃ§Ã£o Intensiva - KaritÃ©",
                        value: "hidrataÃ§Ã£o hidratante karitÃ© karite",
                        category: "producto",
                        image: config.tplData.urlAssetsBody + "product_bodycare_13.png",
                        urlsearch: config.tplData.urlXpBody + "hidratacao-intensiva.cvsp"
                    },
                    {
                        label: "Nutre & Hidrata - Ã“leo de AmÃªndoas & Lanolina",
                        value: "hidrataÃ§Ã£o iogurte oleo amendoa lanolina",
                        category: "producto",
                        image: config.tplData.urlAssetsBody + "product_bodycare_14.png",
                        urlsearch: config.tplData.urlXpBody + "nutre-hidrata.cvsp"
                    },
                    {
                        label: "HidrataÃ§Ã£o & Perfuma - Leite e PÃ©talas de Rosas",
                        value: "hidrataÃ§Ã£o petalas pÃ©talas rosas",
                        category: "producto",
                        image: config.tplData.urlAssetsBody + "product_bodycare_15.png",
                        urlsearch: config.tplData.urlXpBody + "hidrata-perfuma.cvsp"
                    },
                    {
                        label: "Como manter o cabelo liso por mais tempo",
                        value: "cabelo liso lisos",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_01.jpg",
                        urlsearch: config.tplData.urlXp + "nutri-liss/tips/como-manter-cabelo-liso-por-mais-tempo.cvsp"
                    },
                    {
                        label: "Penteados para cabelos lisos",
                        value: "penteados cabelos lisos liso",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_02.jpg",
                        urlsearch: config.tplData.urlXp + "nutri-liss/tips/penteados-para-cabelos-lisos.cvsp"
                    },
                    {
                        label: "Como escolher pentes e escovas",
                        value: "pentes escovas",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_03.jpg",
                        urlsearch: config.tplData.urlXp + "nutri-liss/tips/como-escolher-pentes-e-escovas.cvsp"
                    },
                    {
                        label: "AcessÃ³rios que valorizam seu look",
                        value: "acessÃ³rios acessorios look",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_04.jpg",
                        urlsearch: config.tplData.urlXp + "nutri-liss/tips/acessorios-que-valorizam-seu-look.cvsp"
                    },
                    {
                        label: "O banho dos sonhos",
                        value: "banho",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_05.jpg",
                        urlsearch: config.tplData.urlXp + "nutri-liss/tips/banho-dos-sonhos.cvsp"
                    },
                    {
                        label: "Estilos de cabelos longos",
                        value: "estilos cabelos longos longo",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_06.jpg",
                        urlsearch: config.tplData.urlXp + "longo-sedutor/tips/estilos-de-cabelos-longos.cvsp"
                    },
                    {
                        label: "6 dicas para manter seu cabelo longo, forte e radiante",
                        value: "cabelo longo forte radiante",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_07.jpg",
                        urlsearch: config.tplData.urlXp + "longo-sedutor/tips/cabelo-longo.cvsp"
                    },
                    {
                        label: "Penteados romÃ¢nticos e fÃ¡ceis para cabelos longos",
                        value: "penteados penteado cabelos longo longos",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_08.jpg",
                        urlsearch: config.tplData.urlXp + "longo-sedutor/tips/penteados-romanticos.cvsp"
                    },
                    {
                        label: "10 dicas para que seu cabelo cresÃ§a muito mais",
                        value: "10 dicas para que seu cabelo cresÃ§a muito mais",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_09.jpg",
                        urlsearch: config.tplData.urlXp + "longo-sedutor/tips/cabelo-cresca-muito-mais.cvsp"
                    },
                    {
                        label: "5 formas para receber elogios com sua pele",
                        value: "pele",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_10.jpg",
                        urlsearch: config.tplData.urlXp + "longo-sedutor/tips/elogios-com-sua-pele.cvsp"
                    },
                    {
                        label: "Banho combina com diversÃ£o",
                        value: "banho crianÃ§a infantil crianca",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_11.jpg",
                        urlsearch: config.tplData.urlXp + "kids/tips/banho-combina-com-diversao.cvsp"
                    },
                    {
                        label: "Como tratar o cabelo da crianÃ§a?",
                        value: "cabelo crianÃ§a infantil crianca",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_12.jpg",
                        urlsearch: config.tplData.urlXp + "kids/tips/como-tratar-cabelo-da-crianca.cvsp"
                    },
                    {
                        label: "Por que crianÃ§a precisa de produtos para crianÃ§as?",
                        value: "cabelo crianÃ§a infantil crianca",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_13.jpg",
                        urlsearch: config.tplData.urlXp + "kids/tips/por-que-crianca-precisa-de-produtos-para-criancas.cvsp"
                    },
                    {
                        label: "HidrataÃ§Ã£o Ã© vida para o cabelo",
                        value: "hidrataÃ§Ã£o cabelo",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_15.jpg",
                        urlsearch: config.tplData.urlXp + "hidratacao-luminosa/tips/hidratacao-vida-para-cabelo.cvsp"
                    },
                    {
                        label: "Alimentos que fazem bem Ã  pele",
                        value: "alimentos pele",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_14.jpg",
                        urlsearch: config.tplData.urlXp + "hidratacao-luminosa/tips/alimentos-que-fazem-bem-a-pele.cvsp"
                    },
                    {
                        label: "Confira dicas incrÃ­veis para seu cabelo ficar livre do frizz",
                        value: "cabelo frizz",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_16.jpg",
                        urlsearch: config.tplData.urlXp + "hidratacao-luminosa/tips/como-deixar-cabelo-brilhante-e-sem-frizz.cvsp"
                    },
                    {
                        label: "Por que usar sabonete lÃ­quido?",
                        value: "sabonete liquido lÃ­quido shower gel",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_17.jpg",
                        urlsearch: config.tplData.urlXp + "nutri-milk/tips/por-que-usar-sabonete-liquido.cvsp"
                    },
                    {
                        label: "Pele hidratada, sinÃ´nimo de saÃºde e beleza",
                        value: "pele hidratada saÃºde beleza",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_18.jpg",
                        urlsearch: config.tplData.urlXp + "nutri-milk/tips/pele-hidratada-sinonimo-de-saude-e-beleza.cvsp"
                    },
                    {
                        label: "Caspa: o que Ã© e como tratÃ¡-la?",
                        value: "caspa",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "anticaspa/tip_1.jpg",
                        urlsearch: config.tplData.urlXp + "anticaspa/tips/caspa:o-que-e-como-trata-la.cvsp"
                    },
                    {
                        label: "Caspa: tÃ£o comum quanto intrigante",
                        value: "caspa",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "anticaspa/tip_2.jpg",
                        urlsearch: config.tplData.urlXp + "anticaspa/tips/caspa:tao-comum-quanto-intrigante.cvsp"
                    },
                    {
                        label: "Como evitar a caspa",
                        value: "caspa",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "anticaspa/tip_4.jpg",
                        urlsearch: config.tplData.urlXp + "anticaspa/tips/como-evitar-a-caspa.cvsp"
                    },
                    {
                        label: "Mitos e verdades sobre a caspa",
                        value: "caspa",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "anticaspa/tip_3.jpg",
                        urlsearch: config.tplData.urlXp + "anticaspa/tips/mitos-e-verdades-sobre-a-caspa.cvsp"
                    },
                    {
                        label: "Como manter seus cachos hidratados e definidos",
                        value: "cachos cacheado",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "aloeoliva/tip_1.jpg",
                        urlsearch: config.tplData.urlXp + "cachos-control/tips/como-manter-seus-cachos-hidratados-e-definidos.cvsp"
                    },
                    {
                        label: "Cortes e penteados para cabelos cacheados",
                        value: "cortes penteados cabelo cacheado cacho",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "aloeoliva/tip_2.jpg",
                        urlsearch: config.tplData.urlXp + "cachos-control/tips/cortes-e-penteados-para-cabelos-cacheados.cvsp"
                    },
                    {
                        label: "Como os sabonetes atuam na pele",
                        value: "sabonete pele",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "aloeoliva/tip_3.jpg",
                        urlsearch: config.tplData.urlXp + "cachos-control/tips/como-os-sabonetes-atuam-na-pele.cvsp"
                    },
                    {
                        label: "Como saber se o cabelo estÃ¡ danificado?",
                        value: "cabelo danificado",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "karite/tip_1.jpg",
                        urlsearch: config.tplData.urlXp + "renovacao-pos-quimica/tips/como-saber-se-o-cabelo-esta-danificado.cvsp"
                    },
                    {
                        label: "As diferenÃ§as entre cabelo danificado, seco e poroso",
                        value: "cabelo seco poroso ressecado",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "karite/tip_2.jpg",
                        urlsearch: config.tplData.urlXp + "renovacao-pos-quimica/tips/as-diferencas-entre-cabelo-danificado-seco-e-poroso.cvsp"
                    },
                    {
                        label: "Dicas prÃ© e pÃ³s-quÃ­mica no cabelo",
                        value: "pÃ³s quÃ­mica tingido alisado alisamento",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "karite/tip_3.jpg",
                        urlsearch: config.tplData.urlXp + "renovacao-pos-quimica/tips/dicas-pre-e-pos-quimica-no-cabelo.cvsp"
                    },
                    {
                        label: "Como as ceramidas mantÃªm o cabelo mais forte",
                        value: "ceramidas",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "ceramidas/tip_1.jpg",
                        urlsearch: config.tplData.urlXp + "ceramidas/tips/como-as-ceramidas-mantem-o-cabelo-mais-forte.cvsp"
                    },
                    {
                        label: "O que ajuda a manter o cabelo forte: Mitos e Verdades",
                        value: "cabelo forte",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "ceramidas/tip_2.jpg",
                        urlsearch: config.tplData.urlXp + "ceramidas/tips/o-que-ajuda-a-manter-o-cabelo-forte:mitos-e-verdades.cvsp"
                    },
                    {
                        label: "Como evitar a quebra dos fios?",
                        value: "quebra quebrado",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "quedaresist/tip_1.jpg",
                        urlsearch: config.tplData.urlXp + "queda-resist/tips/como-evitar-a-quebra-dos-fios.cvsp"
                    },
                    {
                        label: "Por que o cabelo cai?",
                        value: "cabelo caindo queda",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "quedaresist/tip_2.jpg",
                        urlsearch: config.tplData.urlXp + "queda-resist/tips/por-que-o-cabelo-cai.cvsp"
                    },
                    {
                        label: "Dez hÃ¡bitos que ajudam a manter a cor do cabelo",
                        value: "cor cabelo tingido",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "roma/tip_1.jpg",
                        urlsearch: config.tplData.urlXp + "cores-brilhantes/tips/dez-habitos-que-ajudam-a-manter-a-cor-do-cabelo.cvsp"
                    },
                    {
                        label: "Cuidados na primeira coloraÃ§Ã£o",
                        value: "coloraÃ§Ã£o tingido cor colorido",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "roma/tip_2.jpg",
                        urlsearch: config.tplData.urlXp + "cores-brilhantes/tips/cuidados-na-primeira-coloracao.cvsp"
                    },
                    {
                        label: "A cor de cabelo mais indicada para vocÃª",
                        value: "coloraÃ§Ã£o tingido cor colorido",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "roma/tip_3.jpg",
                        urlsearch: config.tplData.urlXp + "cores-brilhantes/tips/cor-de-cabelo-mais-indicada-para-voce.cvsp"
                    },
                    {
                        label: "A histÃ³ria da romÃ£ e seus benefÃ­cios para a pele",
                        value: "roma romÃ£ pele",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "roma/tip_4.jpg",
                        urlsearch: config.tplData.urlXp + "cores-brilhantes/tips/historia-da-roma-e-seus-beneficios-para-a-pele.cvsp"
                    },
                    {
                        label: "A histÃ³ria da romÃ£ e seus benefÃ­cios para a pele",
                        value: "roma romÃ£ pele",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "geleia/tip_1.jpg",
                        urlsearch: config.tplData.urlXp + "reparacao-completa/tips/como-saber-se-seu-cabelo-esta-danificado.cvsp"
                    },
                    {
                        label: "Verdadeiro ou falso: o que danifica o cabelo?",
                        value: "cabelo danificado seco",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "geleia/tip_2.jpg",
                        urlsearch: config.tplData.urlXp + "reparacao-completa/tips/verdadeiro-ou-falso-o-que-danifica-o-cabelo.cvsp"
                    },
                    {
                        label: "Cuidados com o secador para manter o cabelo forte",
                        value: "Cuidados com o secador cabelo forte",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "artigos/artigo_33.jpg",
                        urlsearch: config.tplData.urlXp + "oleo-surpreendente/tips/proteger-cabelos-contra-o-calor.cvsp"
                    },
                    {
                        label: "Mitos e verdades sobre a pele na hora do banho",
                        value: "Mitos e verdades sobre a pele na hora do banho",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "oleo/tip_2.jpg",
                        urlsearch: config.tplData.urlXp + "oleo-surpreendente/tips/pele-na-hora-do-banho.cvsp"
                    },
                    {
                        label: "6 Maneiras para deixar seu cabelo naturalmente lindo",
                        value: "6 Maneiras para deixar seu cabelo naturalmente lindo",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "oleo/tip_4.jpg",
                        urlsearch: config.tplData.urlXp + "oleo-surpreendente/tips/cabelo-naturalmente-lindo.cvsp"
                    },
                    {
                        label: "6 Dicas para uma escova perfeita",
                        value: "6 Dicas para uma escova perfeita",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "oleo/tip_5.jpg",
                        urlsearch: config.tplData.urlXp + "oleo-surpreendente/tips/uma-escova-perfeita.cvsp"
                    },

                    {
                        label: "Como manter sua pele radiante o ano todo",
                        value: "pele radiante o ano todo",
                        category: "dicas",
                        image: config.tplData.urlAssetsTips + "oleo/tip_6.jpg",
                        urlsearch: config.tplData.urlXp + "oleo-surpreendente/tips/uma-pele-radiante.cvsp"
                    }
                ];

                //Override search form submit.
                j('div.searchBox #form1').submit(function () {
                    if (j(this).attr('action') != "") {
                        j(location).attr("href", j(this).attr('action'));
                    }
                    return (false);
                });

                //Set default styles for some components.
                j('div.subMenuSearch a').css('cursor', 'default');
                j('#header .wrap .topMenu ul.principalMenu .subMenu').mouseenter(function () {
                    j(this).siblings('a').addClass('select');
                });
                j('#header .wrap .topMenu ul.principalMenu .subMenu').mouseleave(function () {
                    j(this).siblings('a').removeClass('select');
                });

                //tab top menu iniciate tabs
                j('#tabs').tabs();
                PON.showMenuTab(j('#tabs .topSubMenu li').first().find('a'));

                //accordion top menu
                j('.thirdLevel .expandModule').hide();
                j('.handler').click(function (e) {
                    e.preventDefault();
                    if (j(this).siblings('.expandModule').is(':hidden')) {
                        j('.handler')
                            .removeClass('open')
                            .siblings('.expandModule')
                            .hide();
                        j(this).toggleClass('open')
                            .siblings('.expandModule').show();
                    }
                    return false;
                });

                j('#tabs .topSubMenu li a').click(function (e) {
                    e.preventDefault();
                    var $el = j(e.currentTarget);
                    PON.showMenuTab($el);
                    return false;
                });
            },

            loadShareTab: function () {
                //console.log('loadShareTab');
                var account_user = "lcanaveral";
                //TODO: look for pubid
                j.getScript('http://s7.addthis.com/js/300/addthis_widget.js#pubid=xa-4f0327b92db25c1');
            }
        };

        var j = jQuery.noConflict();
        var addthis_share = {
            templates: {
                twitter: 'ConheÃ§a os produtos Palmolive Naturals e o poder de seus ingredientes 100% naturais. Sinta sua beleza e sua alma cantarem. {{url}} (via @palmolive)'
            }
        };
        var tpls = {
            searchItem_producto: '<li><a href="{{urlsearch}}"><div class="preview-img-search"><img src="{{image}}" height="48" width="48" alt="{{label}}"></div><p>{{label}}</p></a></li>',
            searchItem_dicas: '<li><a href="{{urlsearch}}"><div class="preview-img-search"><img src="{{image}}" height="48" width="48" alt="{{label}}"></div><p>{{label}}</p></a></li>',
            searchItem_info: '<li><a href="{{urlsearch}}"><div class="preview-img-search"><img src="{{image}}" height="48" width="48" alt="{{label}}"></div><p>{{label}}</p></a></li>',
            menuResponsive: '<ul class="main-list"><li class="menu-title"><h3>Cuidados para os cabelos</h3><ul class="sub-menu"><li class="menu-item"><a href="{{urlXpHair}}anti-armado.cvsp">Anti-Armado</a></li><li class="menu-item"><a href="{{urlXpHair}}anticaspa-classico.cvsp">Anticaspa ClÃ¡ssico</a></li><li class="menu-item"><a href="{{urlXpHair}}anticaspa-2-em-1.cvsp">Anticaspa 2 em 1</a></li><li class="menu-item"><a href="{{urlXpHair}}anticaspa-men.cvsp">Anticaspa for Men</a></li><li class="menu-item"><a href="{{urlXpHair}}cachos-control.cvsp">Cachos Control</a></li><li class="menu-item"><a href="{{urlXpHair}}ceramidas.cvsp">Ceramidas Force</a></li><li class="menu-item"><a href="{{urlXpHair}}cores-brilhantes.cvsp">Cores Brilhantes</a></li><li class="menu-item"><a href="{{urlXpHair}}hidratacao-luminosa.cvsp">HidrataÃ§Ã£o Luminosa</a></li><li class="menu-item"><a href="{{urlXpHair}}iluminador-pretos.cvsp">Iluminador Pretos</a></li><li class="menu-item"><a href="{{urlXpHair}}longo-sedutor.cvsp">Longo Sedutor</a></li><li class="menu-item"><a href="{{urlXpHair}}maciez-prolongada.cvsp">Maciez Prolongada</a></li><li class="menu-item"><a href="{{urlXpHair}}neutro.cvsp">Neutro</a></li><li class="menu-item"><a href="{{urlXpHair}}nutri-liss.cvsp">Nutri-liss</a></li><li class="menu-item"><a href="{{urlXp}}kids.cvsp">Palmolive Kids</a></li><li class="menu-item"><a href="{{urlXpHair}}queda-resist.cvsp">Queda Resist</a></li><li class="menu-item"><a href="{{urlXpHair}}renovacao-pos-quimica.cvsp">RenovaÃ§Ã£o PÃ³s-QuÃ­mica</a></li><li class="menu-item"><a href="{{urlXpHair}}reparacao-completa.cvsp">ReparaÃ§Ã£o Completa</a></li><li><a href="{{urlXpHair}}oleo-surpreendente.cvsp">Ã“leo Surpreenedente</a></li></ul></li><li class="menu-title"><h3>Cuidados para o corpo</h3><ul class="sub-menu"><li class="menu-item"><a href="{{urlXpBody}}hidratacao-saudavel.cvsp">Aloe e Oliva</a></li><li class="menu-item"><a href="{{urlXpBody}}aromatherapy-relax.cvsp">Aromatherapy Relax</a></li><li class="menu-item"><a href="{{urlXpBody}}esfoliacao-suave.cvsp">Coco e AlgodÃ£o</a></li><li class="menu-item"><a href="{{urlXpBody}}segredo-sedutor.cvsp">Framboesa e Turmalina</a></li><li class="menu-item"><a href="{{urlXpBody}}nutricao-e-suavidade.cvsp">GelÃ©ia Real e ProteÃ­na da Seda</a></li><li class="menu-item"><a href="{{urlXpBody}}hidratacao-intensiva.cvsp">KaritÃ©</a></li><li class="menu-item"><a href="{{urlXpBody}}nutri-milk.cvsp">Nutri-Milk</a></li><li class="menu-item"><a href="{{urlXpBody}}nutri-milk-esfoliante.cvsp">Nutri-Milk Esfoliante</a></li><li class="menu-item"><a href="{{urlXpBody}}nutri-milk-karite.cvsp">Nutri-Milk KaritÃ©</a></li><li class="menu-item"><a href="{{urlXpBody}}nutre-hidrata.cvsp">Ã“leo de AmÃªndoas & Lanolina</a></li><li class="menu-item"><a href="{{urlXpBody}}sensacao-luminosa.cvsp">Ã“leo de Argan e Oil Complex</a></li><li><a href="{{urlXpBody}}oleo-nutritivo.cvsp">Ã“leo Nutritivo</a></li></ul></li><li class="menu-title"><h3>Cuidados completos</h3><ul class="sub-menu"><li class="menu-item"><a href="{{urlXp}}anticaspa.cvsp"> Ideal para tratar a caspa</a></li><li class="menu-item"><a href="{{urlXp}}queda-resist.cvsp"> A queratina para ajudar a queda de cabelo</a></li><li class="menu-item"><a href="{{urlXp}}kids.cvsp"> Banho divertido para as crianÃ§as</a></li><li class="menu-item"><a href="{{urlXp}}cachos-control.cvsp"> Aloe vera para corpo e cabelo</a></li><li class="menu-item"><a href="{{urlXp}}cores-brilhantes.cvsp"> O poder da romÃ¤</a></li><li class="menu-item"><a href="{{urlXp}}ceramidas.cvsp"> A forÃ§a das ceramidas</a></li><li class="menu-item"><a href="{{urlXp}}renovacao-pos-quimica.cvsp"> As propriedades do karitÃ©</a></li><li class="menu-item"><a href="{{urlXp}}hidratacao-luminosa.cvsp"> Argan, o poder da hidrataÃ§Ã£o</a></li><li class="menu-item"><a href="{{urlXp}}reparacao-completa.cvsp"> Renove-se com gelÃ©ia real</a></li><li class="menu-item"><a href="{{urlXp}}nutri-milk.cvsp"> Pele hidratada com as proteÃ­nas do leite</a></li><li class="menu-item"><a href="{{urlXp}}nutri-liss.cvsp"> Maciez da cabeÃ§a aos pÃ©s com proteÃ­nas</a></li><li class="menu-item"><a href="{{urlXp}}longo-sedutor.cvsp"> Seduza com os microcristais de turmalina</a></li><li class="menu-item"><a href="{{urlXp}}oleo-surpreendente.cvsp"> Excelente poder de hidrataÃ§Ã£o para o cabelo e para a pele</a></li></ul></li><li class="menu-title"><h3>Artigos</h3><ul class="sub-menu"><li class="menu-item"><a href="{{urlXp}}artigos.cvsp">Dicas de beleza, banho, penteados, moda e muito mais!</a></li></ul></li><li class="menu-title"><h3><a href="https://www.youtube.com/user/palmolivebrasil", target="_blank">VÃ­deos</a></h3></li></ul>',
            menu: '<ul class="principalMenu clearfix"><li><a href="{{url}}hair-care.cvsp" class="main-link-hair">Cuidados para os cabelos</a><div id="tabs" class="subMenu shadowBlack clearfix"><ul class="topSubMenu clearfix"><li><a href="#tabs-1">Por soluÃ§Ã£o</a></li><li><a href="#tabs-2">Por tipo de cabelo</a></li></ul><div id="tabs-1" class="contentSubMenu clearfix"><div class="colSubMenu fL separator clearfix"><ul class="thirdLevel clearfix"><li><a href="#" class="handler">ReparaÃ§Ã£o e Cuidado</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}ceramidas.cvsp">Ceramidas Force</a></li><li><a href="{{urlXpHair}}longo-sedutor.cvsp">Longo Sedutor</a></li><li><a href="{{urlXpHair}}hidratacao-luminosa.cvsp">HidrataÃ§Ã£o Luminosa</a></li><li><a href="{{urlXpHair}}maciez-prolongada.cvsp">Maciez Prolongada</a></li><li><a href="{{urlXpHair}}renovacao-pos-quimica.cvsp">RenovaÃ§Ã£o PÃ³s-QuÃ­mica</a></li><li><a href="{{urlXpHair}}reparacao-completa.cvsp">ReparaÃ§Ã£o Completa</a></li><li><a href="{{urlXpHair}}oleo-surpreendente.cvsp">Ã“leo Surpreendente</a></li></ul></li><li><a href="#" class="handler">ColoraÃ§Ã£o</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}cores-brilhantes.cvsp">Cores Brilhantes</a></li><li><a href="{{urlXpHair}}iluminador-pretos.cvsp">Iluminador Pretos</a></li></ul></li><li><a href="#" class="handler">Volume e Formas</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}anti-armado.cvsp">Anti-Armado</a></li><li><a href="{{urlXpHair}}cachos-control.cvsp">Cachos Control</a></li><li><a href="{{urlXpHair}}nutri-liss.cvsp">Nutri-liss</a></li></ul></li></ul></div><div class="colSubMenu fL clearfix"><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Tratamento</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}anticaspa-classico.cvsp">Anticaspa ClÃ¡ssico</a></li><li><a href="{{urlXpHair}}anticaspa-2-em-1.cvsp">Anticaspa 2 em 1</a></li><li><a href="{{urlXpHair}}anticaspa-men.cvsp">Anticaspa for Men</a></li><li><a href="{{urlXpHair}}queda-resist.cvsp">Queda Resist</a></li></ul></li><li><a href="#" class="handler">RefrescÃ¢ncia e Limpeza</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}neutro.cvsp">Neutro</a></li></ul></li><li><a href="#" class="handler">Para CrianÃ§as</a><ul class="expandModule clearfix"><li><a href="{{urlXp}}kids.cvsp">Palmolive Kids</a></li></ul></li></ul></div></div><div id="tabs-2" class="contentSubMenu clearfix"><div class="colSubMenu fL separator clearfix"><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Opaco</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}hidratacao-luminosa.cvsp">HidrataÃ§Ã£o Luminosa</a></li><li><a href="{{urlXpHair}}reparacao-completa.cvsp">ReparaÃ§Ã£o Completa</a></li><li><a href="{{urlXpHair}}renovacao-pos-quimica.cvsp">RenovaÃ§Ã£o PÃ³s-QuÃ­mica</a></li><li><a href="{{urlXpHair}}cores-brilhantes.cvsp">Cores Brilhantes</a></li><li><a href="{{urlXpHair}}iluminador-pretos.cvsp">Iluminador Pretos</a></li><li><a href="{{urlXpHair}}maciez-prolongada.cvsp">Maciez Prolongada</a></li><li><a href="{{urlXpHair}}ceramidas.cvsp">Ceramidas Force</a></li></ul></li><li><a href="#" class="handler">QuebradiÃ§o</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}anticaspa-classico.cvsp">Anticaspa ClÃ¡ssico</a></li><li><a href="{{urlXpHair}}anticaspa-2-em-1.cvsp">Anticaspa 2 em 1</a></li><li><a href="{{urlXpHair}}anticaspa-men.cvsp">Anticaspa for Men</a></li><li><a href="{{urlXpHair}}ceramidas.cvsp">Ceramidas Force</a></li><li><a href="{{urlXpHair}}hidratacao-luminosa.cvsp">HidrataÃ§Ã£o Luminosa</a></li><li><a href="{{urlXpHair}}queda-resist.cvsp">Queda Resist</a></li><li><a href="{{urlXpHair}}renovacao-pos-quimica.cvsp">RenovaÃ§Ã£o PÃ³s-QuÃ­mica</a></li><li><a href="{{urlXpHair}}reparacao-completa.cvsp">ReparaÃ§Ã£o Completa</a></li></ul></li><li><a href="#" class="handler">Seco</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}anti-armado.cvsp">Anti-Armado</a></li><li><a href="{{urlXpHair}}anticaspa-2-em-1.cvsp">Anticaspa 2 em 1</a></li><li><a href="{{urlXpHair}}cachos-control.cvsp">Cachos Control</a></li><li><a href="{{urlXpHair}}ceramidas.cvsp">Ceramidas Force</a></li><li><a href="{{urlXpHair}}cores-brilhantes.cvsp">Cores Brilhantes</a></li><li><a href="{{urlXpHair}}hidratacao-luminosa.cvsp">HidrataÃ§Ã£o Luminosa</a></li><li><a href="{{urlXpHair}}iluminador-pretos.cvsp">Iluminador Pretos</a></li><li><a href="{{urlXpHair}}maciez-prolongada.cvsp">Maciez Prolongada</a></li><li><a href="{{urlXpHair}}nutri-liss.cvsp">Nutri-liss</a></li><li><a href="{{urlXpHair}}renovacao-pos-quimica.cvsp">RenovaÃ§Ã£o PÃ³s-QuÃ­mica</a></li><li><a href="{{urlXpHair}}reparacao-completa.cvsp">ReparaÃ§Ã£o Completa</a></li></ul></li><li><a href="#" class="handler">Danificado</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}ceramidas.cvsp">Ceramidas Force</a></li><li><a href="{{urlXpHair}}hidratacao-luminosa.cvsp">HidrataÃ§Ã£o Luminosa</a></li><li><a href="{{urlXpHair}}maciez-prolongada.cvsp">Maciez Prolongada</a></li><li><a href="{{urlXpHair}}queda-resist.cvsp">Queda Resist</a></li><li><a href="{{urlXpHair}}renovacao-pos-quimica.cvsp">RenovaÃ§Ã£o PÃ³s-QuÃ­mica</a></li><li><a href="{{urlXpHair}}reparacao-completa.cvsp">ReparaÃ§Ã£o Completa</a></li><li><a href="{{urlXpHair}}oleo-surpreendente.cvsp">Ã“leo Surpreendente</a></li></ul></li></ul></div><div class="colSubMenu fL separator clearfix"><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Cacheado</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}cachos-control.cvsp">Cachos Control</a></li></ul></li><li><a href="#" class="handler">Rebelde</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}anti-armado.cvsp">Anti-Armado</a></li><li><a href="{{urlXpHair}}cachos-control.cvsp">Cachos Control</a></li></ul></li><li><a href="#" class="handler">Armado</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}anti-armado.cvsp">Anti-Armado</a></li><li><a href="{{urlXpHair}}cachos-control.cvsp">Cachos Control</a></li></ul></li><li><a href="#" class="handler">Normal</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}anticaspa-classico.cvsp">Anticaspa ClÃ¡ssico</a></li><li><a href="{{urlXpHair}}hidratacao-luminosa.cvsp">HidrataÃ§Ã£o Luminosa</a></li><li><a href="{{urlXpHair}}neutro.cvsp">Neutro</a></li></ul></li></ul></div><div class="colSubMenu fL separator clearfix"><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Oleoso</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}anticaspa-classico.cvsp">Anticaspa ClÃ¡ssico</a></li><li><a href="{{urlXpHair}}hidratacao-luminosa.cvsp">HidrataÃ§Ã£o Luminosa</a></li><li><a href="{{urlXpHair}}neutro.cvsp">Neutro</a></li></ul></li><li><a href="#" class="handler">Coloridos</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}cores-brilhantes.cvsp">Cores Brilhantes</a></li><li><a href="{{urlXpHair}}iluminador-pretos.cvsp">Iluminador Pretos</a></li></ul></li><li><a href="#" class="handler">Preto</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}cores-brilhantes.cvsp">Cores Brilhantes</a></li><li><a href="{{urlXpHair}}hidratacao-luminosa.cvsp">HidrataÃ§Ã£o Luminosa</a></li><li><a href="{{urlXpHair}}iluminador-pretos.cvsp">Iluminador Pretos</a></li></ul></li><li><a href="#" class="handler">Longo</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}longo-sedutor.cvsp">Longo Sedutor</a></li></ul></li></ul></div><div class="colSubMenu fL clearfix"><ul class="thirdLevel clearfix"><li><a href="#" class="handler">FrÃ¡gil</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}anti-armado.cvsp">Anti-Armado</a></li><li><a href="{{urlXpHair}}ceramidas.cvsp">Ceramidas Force</a></li><li><a href="{{urlXpHair}}renovacao-pos-quimica.cvsp">RenovaÃ§Ã£o PÃ³s-QuÃ­mica</a></li><li><a href="{{urlXpHair}}reparacao-completa.cvsp">ReparaÃ§Ã£o Completa</a></li></ul></li><li><a href="#" class="handler">Queda</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}anticaspa-classico.cvsp">Anticaspa ClÃ¡ssico</a></li><li><a href="{{urlXpHair}}anticaspa-men.cvsp">Anticaspa for Men</a></li><li><a href="{{urlXpHair}}queda-resist.cvsp">Queda Resist</a></li></ul></li><li><a href="#" class="handler">Caspa</a><ul class="expandModule clearfix"><li><a href="{{urlXpHair}}anticaspa-classico.cvsp">Anticaspa ClÃ¡ssico</a></li><li><a href="{{urlXpHair}}anticaspa-2-em-1.cvsp">Anticaspa 2 em 1</a></li><li><a href="{{urlXpHair}}anticaspa-men.cvsp">Anticaspa for Men</a></li></ul></li></ul></div></div></div></li><li><a href="{{urlFiles}}body-care.cvsp">Cuidados para o corpo</a><div class="subMenu noBg shadowBlack clearfix"><div class="contentSubMenu clearfix"><div class="colSubMenu fL separator clearfix"><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Envolva-se</a><ul class="clearfix"><li><a href="{{urlXpBody}}hidratacao-saudavel.cvsp">Aloe e Oliva</a></li><li><a href="{{urlXpBody}}segredo-sedutor.cvsp">Framboesa e Turmalina</a></li><li><a href="{{urlXpBody}}nutricao-e-suavidade.cvsp">GelÃ©ia Real e ProteÃ­na da Seda</a></li><li><a href="{{urlXpBody}}hidratacao-intensiva.cvsp">KaritÃ©</a></li><li><a href="{{urlXpBody}}hidrata-perfuma.cvsp">Leite e PÃ©talas de Rosa</a></li><li><a href="{{urlXpBody}}nutre-hidrata.cvsp">Ã“leo de AmÃªndoas & Lanolina</a></li><li><a href="{{urlXpBody}}sensacao-luminosa.cvsp">Ã“leo de Argan e Oil Complex</a></li><li><a href="{{urlXpBody}}oleo-nutritivo.cvsp">Ã“leo Nutritivo</a></li></ul></div><div class="colSubMenu fL clearfix"><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Relaxe</a><ul class="clearfix"><li><a href="{{urlXpBody}}aromatherapy-relax.cvsp">Aromatherapy Relax</a></li></ul></li></ul><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Renove-se</a><ul class="clearfix"><li><a href="{{urlXpBody}}esfoliacao-suave.cvsp">Coco e AlgodÃ£o</a></li></ul></li></ul><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Hidrate-se</a><ul class="clearfix"><li><a href="{{urlXpBody}}nutri-milk.cvsp">Nutri-Milk</a></li><li><a href="{{urlXpBody}}nutri-milk-esfoliante.cvsp">Nutri-Milk Esfoliante</a></li><li><a href="{{urlXpBody}}nutri-milk-karite.cvsp">Nutri-Milk KaritÃ©</a></li></ul></li></ul></div></div></div></li><li><a href="#">Cuidados completos</a><div class="subMenu submenu_cuidados hadowBlack noBg clearfix"><div class="contentSubMenu clearfix"><div class="colSubMenu fL clearfix"><ul class="thirdLevel clearfix"><li class="menu-item"><a href="{{urlXp}}anticaspa.cvsp"> Ideal para tratar a caspa</a></li><li class="menu-item"><a href="{{urlXp}}queda-resist.cvsp"> A queratina para ajudar a queda de cabelo</a></li><li class="menu-item"><a href="{{urlXp}}kids.cvsp"> Banho divertido para as crianÃ§as</a></li><li class="menu-item"><a href="{{urlXp}}cachos-control.cvsp"> Aloe vera para corpo e cabelo</a></li><li class="menu-item"><a href="{{urlXp}}cores-brilhantes.cvsp"> O poder da romÃ¤</a></li><li class="menu-item"><a href="{{urlXp}}ceramidas.cvsp"> A forÃ§a das ceramidas</a></li><li class="menu-item"><a href="{{urlXp}}renovacao-pos-quimica.cvsp"> As propriedades do karitÃ©</a></li><li class="menu-item"><a href="{{urlXp}}hidratacao-luminosa.cvsp"> Argan, o poder da hidrataÃ§Ã£o</a></li><li class="menu-item"><a href="{{urlXp}}reparacao-completa.cvsp"> Renove-se com gelÃ©ia real</a></li><li class="menu-item"><a href="{{urlXp}}nutri-milk.cvsp"> Pele hidratada com as proteÃ­nas do leite</a></li><li class="menu-item"><a href="{{urlXp}}nutri-liss.cvsp"> Maciez da cabeÃ§a aos pÃ©s com proteÃ­nas</a></li><li class="menu-item"><a href="{{urlXp}}longo-sedutor.cvsp"> Seduza com os microcristais de turmalina</a></li><li class="menu-item"><a href="{{urlXp}}oleo-surpreendente.cvsp"> Excelente poder de hidrataÃ§Ã£o para o cabelo e para a pele</a></li></ul></div></div></div></li><li><a href="{{urlXp}}artigos.cvsp">Artigos</a></li><li><a href="https://www.youtube.com/user/palmolivebrasil", target="_blank">VÃ­deos</a></li></ul><div class="searchBox"><form id="form1" name="form1" method="post" action=""><input type="text" name="textfield" id="searchInput" /><input type="image" src="{{urlAssets}}images/icon-search.png" alt="Search" class="btnSearch" /></form><div class="subMenuSearch shadowBlack clearfix"><ul class="clearfix" style="display:block!important"><li><span class="title-list">Produtos</span><ul data-category="producto" class="clearfix"></ul></li><li><span class="title-list">Dicas</span><ul data-category="dicas" class="clearfix"></ul></li><li><span class="title-list">Info</span><ul data-category="info" class="clearfix"></ul></li></ul></div></div>', footer: '<div class="wrap clearfix"><div class="footerLinks clearfix"><div class="footerColBox clearfix"><h3>Cuidados para os cabelos</h3><ul><li><a href="{{urlXpHair}}anti-armado.cvsp">Anti-Armado</a></li><li><a href="{{urlXpHair}}anticaspa-classico.cvsp">Anticaspa ClÃ¡ssico</a></li><li><a href="{{urlXpHair}}anticaspa-2-em-1.cvsp">Anticaspa 2 em 1</a></li><li><a href="{{urlXpHair}}anticaspa-men.cvsp">Anticaspa for Men</a></li>   <li><a href="{{urlXpHair}}cachos-control.cvsp">Cachos Control</a></li><li><a href="{{urlXpHair}}ceramidas.cvsp">Ceramidas Force</a></li><li><a href="{{urlXpHair}}cores-brilhantes.cvsp">Cores Brilhantes</a></li><li><a href="{{urlXpHair}}hidratacao-luminosa.cvsp">HidrataÃ§Ã£o Luminosa</a></li><li><a href="{{urlXpHair}}iluminador-pretos.cvsp">Iluminador Pretos</a></li><li><a href="{{urlXpHair}}longo-sedutor.cvsp">Longo Sedutor</a></li><li><a href="{{urlXpHair}}maciez-prolongada.cvsp">Maciez Prolongada</a></li><li><a href="{{urlXpHair}}neutro.cvsp">Neutro</a></li><li><a href="{{urlXpHair}}nutri-liss.cvsp">Nutri-liss</a></li><li><a href="{{urlXp}}kids.cvsp">Palmolive Kids</a></li><li><a href="{{urlXpHair}}queda-resist.cvsp">Queda Resist</a></li><li><a href="{{urlXpHair}}renovacao-pos-quimica.cvsp">RenovaÃ§Ã£o PÃ³s-QuÃ­mica</a></li><li><a href="{{urlXpHair}}reparacao-completa.cvsp">ReparaÃ§Ã£o Completa</a></li><li><a href="{{urlXpHair}}oleo-surpreendente.cvsp">Ã“leo Surpreendente</a></li></ul></div><div class="footerColBox clearfix"><h3>Cuidados para o corpo</h3><ul><li><a href="{{urlXpBody}}hidratacao-saudavel.cvsp">Aloe e Oliva</a></li><li><a href="{{urlXpBody}}aromatherapy-relax.cvsp">Aromatherapy Relax</a></li><li><a href="{{urlXpBody}}esfoliacao-suave.cvsp">Coco e AlgodÃ£o</a></li><li><a href="{{urlXpBody}}segredo-sedutor.cvsp">Framboesa e Turmalina</a></li><li><a href="{{urlXpBody}}nutricao-e-suavidade.cvsp">GelÃ©ia Real e ProteÃ­na da Seda</a></li><li><a href="{{urlXpBody}}hidratacao-intensiva.cvsp">KaritÃ©</a></li>  <li><a href="{{urlXpBody}}nutri-milk.cvsp">Nutri-Milk</a></li><li><a href="{{urlXpBody}}nutri-milk-esfoliante.cvsp">Nutri-Milk Esfoliante</a></li><li><a href="{{urlXpBody}}nutri-milk-karite.cvsp">Nutri-Milk KaritÃ©</a></li><li><a href="{{urlXpBody}}nutre-hidrata.cvsp">Ã“leo de AmÃªndoas & Lanolina</a></li><li><a href="{{urlXpBody}}sensacao-luminosa.cvsp">Ã“leo de Argan e Oil Complex</a></li><li><a href="{{urlXpBody}}oleo-nutritivo.cvsp">Ã“leo Nutritivo</a></li></ul></div><div class="footerColBox clearfix"><h3>Cuidados completos</h3><ul><li> <a href="{{urlXp}}anticaspa.cvsp"> Ideal para tratar a caspa</a></li><li> <a href="{{urlXp}}queda-resist.cvsp"> A queratina para ajudar a queda de cabelo</a></li><li> <a href="{{urlXp}}kids.cvsp"> Banho divertido para as crianÃ§as</a></li><li> <a href="{{urlXp}}cachos-control.cvsp"> Aloe vera para corpo e cabelo</a></li><li> <a href="{{urlXp}}cores-brilhantes.cvsp"> O poder da romÃ¤</a></li><li> <a href="{{urlXp}}ceramidas.cvsp"> A forÃ§a das ceramidas</a></li><li> <a href="{{urlXp}}renovacao-pos-quimica.cvsp"> As propriedades do karitÃ©</a></li><li> <a href="{{urlXp}}hidratacao-luminosa.cvsp"> Argan, o poder da hidrataÃ§Ã£o</a></li><li> <a href="{{urlXp}}reparacao-completa.cvsp"> Renove-se com gelÃ©ia real</a></li><li> <a href="{{urlXp}}nutri-milk.cvsp"> Pele hidratada com as proteÃ­nas do leite</a></li><li> <a href="{{urlXp}}nutri-liss.cvsp"> Maciez da cabeÃ§a aos pÃ©s com proteÃ­nas</a></li><li><a href="{{urlXp}}longo-sedutor.cvsp"> Seduza com os microcristais de turmalina</a></li><li class="menu-item"><a href="{{urlXp}}oleo-surpreendente.cvsp"> Excelente poder de hidrataÃ§Ã£o para o cabelo e para a pele</a></li></ul></div><div class="footerColBox clearfix"><h3>Artigos</h3><p>Dicas de beleza, banho, penteados, moda e muito mais!</p><p class="suscribeLink marginTop10 marginBottom20"><a href="{{urlXp}}artigos.cvsp">Saiba mais</a></p><br><h3>Newsletter</h3><p>Deseja receber informaÃ§Ãµes sobre os produtos e promoÃ§Ãµes da Colgate-Palmolive? Nossa newsletter a manterÃ¡ atualizada.</p><p class="suscribeLink marginTop10 marginBottom20"><a href="{{urlXp}}cadastro.cvsp">Cadastre-se</a></p></div><div class="footerBoxSocial clearfix"><h3>VÃ­deos</h3><p>Assista aos comerciais de Palmolive.</p><p class="suscribeLink marginTop10 marginBottom20"><a href="https://www.youtube.com/user/palmolivebrasil", target="_blank">Assista agora</a></p><br><h3>PromoÃ§Ã£o</h3><p>Compre productos Palmolive* e ganhe desconto** na Riachuelo.</p><p class="suscribeLink marginTop10 marginBottom20"><a href="{{urlXp}}promotions.cvsp", target="_blank">Confira o regulamento</a></p><br><p class="suscribeLink marginTop10 marginBottom10">Compartilhe:</p><p><a href="#" class="marginTopRight5 addthis_button_facebook"><img src="{{urlAssets}}images/icon-fb.png" width="16" height="16" /></a><a href="#" class="marginTopRight5 addthis_button_twitter" tw:text="I LOVE AddThis!"><img src="{{urlAssets}}images/icon-tw.png" width="16" height="16" /></a></p></div></div><div class="legalsCopy clearfix"></div></div>'
        };

        function OmnitureTag(tag) { if (tag) { sendPageViewEvent('', '/Palmolive/BR/HomePage/' + tag); console.log('tagged: /Palmolive/BR/HomePage/' + tag); } }


        var resizeFunctions = [];

        j(document).ready(function () {
            PON.init();
            PON.setWidthClass();
            if (typeof tipsObj === "object") {
                tipsObj.init();
            }

            if (typeof RelatedObj === "function") {
                var appRelated = new RelatedObj();
                appRelated.init();
            }

            j(window).on('resize', function () {

                //set class depending on size
                PON.setWidthClass();

                for (var i in resizeFunctions) {
                    if (typeof resizeFunctions[i] === 'function') {
                        resizeFunctions[i]();
                    }
                }
            });
        });

        //teset
    </script>

    <%--<script type="text/javascript">

        //var valorInicial = 1001;
        //$(function () {
        //    $('#btnAdd').on('click', addElemento);

        //    $('#btnSend').on('click', prepararParaEnvio);

        //    $('#btnRemove').on('click', removeElemento);

        //    $('#btnValores').on('click', valores);

        //    $('#btnRemoveAll').on('click', removeTodosElementos);
        //});

        
        function removeElemento() {
            var id = "#<%=lbFiliais.ClientID%> option:selected";
            $(id).remove();
            return false;
        }

        function removeTodosElementos() {
            $('#<%=lbFiliais.ClientID%>').empty();
            return false;
        }

        function addElemento() {
            verificaItensExistentes();

            //var vl = "Teste - " + new Date().getTime();
            var vl = valorInicial + 1;
            valorInicial = vl;
            $('#<%=lbFiliais.ClientID%>').append(
                $('<option>').val(vl).text(vl)
            );
            return false;
        }

        function prepararParaEnvio() {
            console.log('oi');
            var arrElementos2 = [];
            var id = "#<%=lbFiliais.ClientID%> option";
            $(id).each(function (indice, elemento) {
                arrElementos2.push($(elemento).val());
            });
            $('[id*=hdFiliais2]').val(arrElementos2.join());
        }

        function verificaItensExistentes() {
            var arrElementos = [];
            var id = "#<%=lbFiliais.ClientID%> option";
            $(id).each(function (indice, elemento) {
                arrElementos.push($(elemento).val());
            });
            console.log('itensExistentes = ' + arrElementos);
        }

        function valores() {
            //var value = $('#btnValores').each(function (indice, elemento) {
            //    console.log('valoreBotão = ' + elemento);
            //    console.log('valoreBotãoindice = ' + indice);
            //});
            console.log('valoreBotão = ' + $('#btnValores').text);
            $('#btnValores').empty();
            $('#btnValores').append("Remover");
            return false;
        }

        function runScript(e) {
            if (e.keyCode == 13) {
                clearTable();
                btnBuscarFilial.click();
            }

            if (e.keyCode == 46) {
                removeTodosElementos();
            }

        }
    </script>--%>

    <script language="JavaScript" src="http://www.colgate.com.br/Palmolive/BR/HomePage/assets/js/lib/libs_palmolive.min.js" type="text/javascript"></script>

    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1><%: Title %>.</h1>
                <h2>Modify this template to jump-start your ASP.NET application.</h2>
            </hgroup>
            <p>
                To learn more about ASP.NET, visit <a href="http://asp.net" title="ASP.NET Website">http://asp.net</a>.
                The page features <mark>videos, tutorials, and samples</mark> to help you get the most from ASP.NET.
                If you have any questions about ASP.NET visit
                <a href="http://forums.asp.net/18.aspx" title="ASP.NET Forum">our forums</a>.
            </p>
        </div>
    </section>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <div class="topMenu" id="topMenu"><ul class="principalMenu clearfix"><li><a href="/app/Palmolive/BR/HomePage/hair-care.cvsp" class="main-link-hair">Cuidados para os cabelos</a><div id="tabs" class="subMenu shadowBlack clearfix ui-tabs ui-widget ui-widget-content ui-corner-all"><ul class="topSubMenu clearfix ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all"><li class="ui-state-default ui-corner-top ui-state-active ui-tabs-selected"><a href="#tabs-1">Por solução</a></li><li class="ui-state-default ui-corner-top"><a href="#tabs-2">Por tipo de cabelo</a></li></ul><div id="tabs-1" class="contentSubMenu clearfix ui-tabs-panel ui-widget-content ui-corner-bottom" style="display: block;"><div class="colSubMenu fL separator clearfix"><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Reparação e Cuidado</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/ceramidas.cvsp">Ceramidas Force</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/longo-sedutor.cvsp">Longo Sedutor</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/hidratacao-luminosa.cvsp">Hidratação Luminosa</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/maciez-prolongada.cvsp">Maciez Prolongada</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/renovacao-pos-quimica.cvsp">Renovação Pós-Química</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/reparacao-completa.cvsp">Reparação Completa</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/oleo-surpreendente.cvsp">Óleo Surpreendente</a></li></ul></li><li><a href="#" class="handler">Coloração</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/cores-brilhantes.cvsp">Cores Brilhantes</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/iluminador-pretos.cvsp">Iluminador Pretos</a></li></ul></li><li><a href="#" class="handler">Volume e Formas</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/anti-armado.cvsp">Anti-Armado</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/cachos-control.cvsp">Cachos Control</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/nutri-liss.cvsp">Nutri-liss</a></li></ul></li></ul></div><div class="colSubMenu fL clearfix"><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Tratamento</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/anticaspa-classico.cvsp">Anticaspa Clássico</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/anticaspa-2-em-1.cvsp">Anticaspa 2 em 1</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/anticaspa-men.cvsp">Anticaspa for Men</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/queda-resist.cvsp">Queda Resist</a></li></ul></li><li><a href="#" class="handler">Refrescância e Limpeza</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/neutro.cvsp">Neutro</a></li></ul></li><li><a href="#" class="handler">Para Crianças</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/experiencias/kids.cvsp">Palmolive Kids</a></li></ul></li></ul></div></div><div id="tabs-2" class="contentSubMenu clearfix ui-tabs-panel ui-widget-content ui-corner-bottom ui-tabs-hide" style="display: none;"><div class="colSubMenu fL separator clearfix"><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Opaco</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/hidratacao-luminosa.cvsp">Hidratação Luminosa</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/reparacao-completa.cvsp">Reparação Completa</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/renovacao-pos-quimica.cvsp">Renovação Pós-Química</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/cores-brilhantes.cvsp">Cores Brilhantes</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/iluminador-pretos.cvsp">Iluminador Pretos</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/maciez-prolongada.cvsp">Maciez Prolongada</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/ceramidas.cvsp">Ceramidas Force</a></li></ul></li><li><a href="#" class="handler">Quebradiço</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/anticaspa-classico.cvsp">Anticaspa Clássico</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/anticaspa-2-em-1.cvsp">Anticaspa 2 em 1</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/anticaspa-men.cvsp">Anticaspa for Men</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/ceramidas.cvsp">Ceramidas Force</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/hidratacao-luminosa.cvsp">Hidratação Luminosa</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/queda-resist.cvsp">Queda Resist</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/renovacao-pos-quimica.cvsp">Renovação Pós-Química</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/reparacao-completa.cvsp">Reparação Completa</a></li></ul></li><li><a href="#" class="handler">Seco</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/anti-armado.cvsp">Anti-Armado</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/anticaspa-2-em-1.cvsp">Anticaspa 2 em 1</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/cachos-control.cvsp">Cachos Control</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/ceramidas.cvsp">Ceramidas Force</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/cores-brilhantes.cvsp">Cores Brilhantes</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/hidratacao-luminosa.cvsp">Hidratação Luminosa</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/iluminador-pretos.cvsp">Iluminador Pretos</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/maciez-prolongada.cvsp">Maciez Prolongada</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/nutri-liss.cvsp">Nutri-liss</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/renovacao-pos-quimica.cvsp">Renovação Pós-Química</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/reparacao-completa.cvsp">Reparação Completa</a></li></ul></li><li><a href="#" class="handler">Danificado</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/ceramidas.cvsp">Ceramidas Force</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/hidratacao-luminosa.cvsp">Hidratação Luminosa</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/maciez-prolongada.cvsp">Maciez Prolongada</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/queda-resist.cvsp">Queda Resist</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/renovacao-pos-quimica.cvsp">Renovação Pós-Química</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/reparacao-completa.cvsp">Reparação Completa</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/oleo-surpreendente.cvsp">Óleo Surpreendente</a></li></ul></li></ul></div><div class="colSubMenu fL separator clearfix"><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Cacheado</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/cachos-control.cvsp">Cachos Control</a></li></ul></li><li><a href="#" class="handler">Rebelde</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/anti-armado.cvsp">Anti-Armado</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/cachos-control.cvsp">Cachos Control</a></li></ul></li><li><a href="#" class="handler">Armado</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/anti-armado.cvsp">Anti-Armado</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/cachos-control.cvsp">Cachos Control</a></li></ul></li><li><a href="#" class="handler">Normal</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/anticaspa-classico.cvsp">Anticaspa Clássico</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/hidratacao-luminosa.cvsp">Hidratação Luminosa</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/neutro.cvsp">Neutro</a></li></ul></li></ul></div><div class="colSubMenu fL separator clearfix"><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Oleoso</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/anticaspa-classico.cvsp">Anticaspa Clássico</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/hidratacao-luminosa.cvsp">Hidratação Luminosa</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/neutro.cvsp">Neutro</a></li></ul></li><li><a href="#" class="handler">Coloridos</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/cores-brilhantes.cvsp">Cores Brilhantes</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/iluminador-pretos.cvsp">Iluminador Pretos</a></li></ul></li><li><a href="#" class="handler">Preto</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/cores-brilhantes.cvsp">Cores Brilhantes</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/hidratacao-luminosa.cvsp">Hidratação Luminosa</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/iluminador-pretos.cvsp">Iluminador Pretos</a></li></ul></li><li><a href="#" class="handler">Longo</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/longo-sedutor.cvsp">Longo Sedutor</a></li></ul></li></ul></div><div class="colSubMenu fL clearfix"><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Frágil</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/anti-armado.cvsp">Anti-Armado</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/ceramidas.cvsp">Ceramidas Force</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/renovacao-pos-quimica.cvsp">Renovação Pós-Química</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/reparacao-completa.cvsp">Reparação Completa</a></li></ul></li><li><a href="#" class="handler">Queda</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/anticaspa-classico.cvsp">Anticaspa Clássico</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/anticaspa-men.cvsp">Anticaspa for Men</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/queda-resist.cvsp">Queda Resist</a></li></ul></li><li><a href="#" class="handler">Caspa</a><ul class="expandModule clearfix" style="display: none;"><li><a href="/app/Palmolive/BR/produtos/hair-care/anticaspa-classico.cvsp">Anticaspa Clássico</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/anticaspa-2-em-1.cvsp">Anticaspa 2 em 1</a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/anticaspa-men.cvsp">Anticaspa for Men</a></li></ul></li></ul></div></div></div></li><li><a href="/app/Palmolive/BR/HomePage/body-care.cvsp">Cuidados para o corpo</a><div class="subMenu noBg shadowBlack clearfix"><div class="contentSubMenu clearfix"><div class="colSubMenu fL separator clearfix"><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Envolva-se</a><ul class="clearfix"><li><a href="/app/Palmolive/BR/produtos/body-care/hidratacao-saudavel.cvsp">Aloe e Oliva</a></li><li><a href="/app/Palmolive/BR/produtos/body-care/segredo-sedutor.cvsp">Framboesa e Turmalina</a></li><li><a href="/app/Palmolive/BR/produtos/body-care/nutricao-e-suavidade.cvsp">Geléia Real e Proteína da Seda</a></li><li><a href="/app/Palmolive/BR/produtos/body-care/hidratacao-intensiva.cvsp">Karité</a></li><li><a href="/app/Palmolive/BR/produtos/body-care/hidrata-perfuma.cvsp">Leite e Pétalas de Rosa</a></li><li><a href="/app/Palmolive/BR/produtos/body-care/nutre-hidrata.cvsp">Óleo de Amêndoas &amp; Lanolina</a></li><li><a href="/app/Palmolive/BR/produtos/body-care/sensacao-luminosa.cvsp">Óleo de Argan e Oil Complex</a></li><li><a href="/app/Palmolive/BR/produtos/body-care/oleo-nutritivo.cvsp">Óleo Nutritivo</a></li></ul></li></ul></div><div class="colSubMenu fL clearfix"><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Relaxe</a><ul class="clearfix"><li><a href="/app/Palmolive/BR/produtos/body-care/aromatherapy-relax.cvsp">Aromatherapy Relax</a></li></ul></li></ul><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Renove-se</a><ul class="clearfix"><li><a href="/app/Palmolive/BR/produtos/body-care/esfoliacao-suave.cvsp">Coco e Algodão</a></li></ul></li></ul><ul class="thirdLevel clearfix"><li><a href="#" class="handler">Hidrate-se</a><ul class="clearfix"><li><a href="/app/Palmolive/BR/produtos/body-care/nutri-milk.cvsp">Nutri-Milk</a></li><li><a href="/app/Palmolive/BR/produtos/body-care/nutri-milk-esfoliante.cvsp">Nutri-Milk Esfoliante</a></li><li><a href="/app/Palmolive/BR/produtos/body-care/nutri-milk-karite.cvsp">Nutri-Milk Karité</a></li></ul></li></ul></div></div></div></li><li><a href="#">Cuidados completos</a><div class="subMenu submenu_cuidados hadowBlack noBg clearfix"><div class="contentSubMenu clearfix"><div class="colSubMenu fL clearfix"><ul class="thirdLevel clearfix"><li class="menu-item"><a href="/app/Palmolive/BR/experiencias/anticaspa.cvsp"> Ideal para tratar a caspa</a></li><li class="menu-item"><a href="/app/Palmolive/BR/experiencias/queda-resist.cvsp"> A queratina para ajudar a queda de cabelo</a></li><li class="menu-item"><a href="/app/Palmolive/BR/experiencias/kids.cvsp"> Banho divertido para as crianças</a></li><li class="menu-item"><a href="/app/Palmolive/BR/experiencias/cachos-control.cvsp"> Aloe vera para corpo e cabelo</a></li><li class="menu-item"><a href="/app/Palmolive/BR/experiencias/cores-brilhantes.cvsp"> O poder da romä</a></li><li class="menu-item"><a href="/app/Palmolive/BR/experiencias/ceramidas.cvsp"> A força das ceramidas</a></li><li class="menu-item"><a href="/app/Palmolive/BR/experiencias/renovacao-pos-quimica.cvsp"> As propriedades do karité</a></li><li class="menu-item"><a href="/app/Palmolive/BR/experiencias/hidratacao-luminosa.cvsp"> Argan, o poder da hidratação</a></li><li class="menu-item"><a href="/app/Palmolive/BR/experiencias/reparacao-completa.cvsp"> Renove-se com geléia real</a></li><li class="menu-item"><a href="/app/Palmolive/BR/experiencias/nutri-milk.cvsp"> Pele hidratada com as proteínas do leite</a></li><li class="menu-item"><a href="/app/Palmolive/BR/experiencias/nutri-liss.cvsp"> Maciez da cabeça aos pés com proteínas</a></li><li class="menu-item"><a href="/app/Palmolive/BR/experiencias/longo-sedutor.cvsp"> Seduza com os microcristais de turmalina</a></li><li class="menu-item"><a href="/app/Palmolive/BR/experiencias/oleo-surpreendente.cvsp"> Excelente poder de hidratação para o cabelo e para a pele</a></li></ul></div></div></div></li><li><a href="/app/Palmolive/BR/experiencias/artigos.cvsp">Artigos</a></li><li><a href="https://www.youtube.com/user/palmolivebrasil" ,="" target="_blank">Vídeos</a></li></ul><div class="searchBox"><form id="form1" name="form1" method="post" action=""><input type="text" name="textfield" id="Text1"><input type="image" src="/Palmolive/BR/HomePage/assets/images/icon-search.png" alt="Search" class="btnSearch active"></form><div class="subMenuSearch shadowBlack clearfix" style="display: block;"><ul class="clearfix" style="display:block!important"><li><span class="title-list">Produtos</span><ul data-category="producto" class="clearfix"><li><a href="/app/Palmolive/BR/produtos/hair-care/nutri-liss.cvsp"><div class="preview-img-search"><img src="/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-care/product_haircare_01.png" height="48" width="48" alt="Nutri-liss - Proteína de Trigo &amp; Óleo de Palmeira"></div><p>Nutri-liss - Proteína de Trigo &amp; Óleo de Palmeira</p></a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/longo-sedutor.cvsp"><div class="preview-img-search"><img src="/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-care/product_haircare_02.png" height="48" width="48" alt="Longo Sedutor - Microcristais de Turmalina"></div><p>Longo Sedutor - Microcristais de Turmalina</p></a></li><li><a href="/app/Palmolive/BR/produtos/hair-care/oleo-surpreendente.cvsp"><div class="preview-img-search"><img src="/Palmolive/BR/HomePage/assets/images/experiencias/produtos/hair-care/product_haircare_00.png" height="48" width="48" alt="Óleo Surpreendente"></div><p>Óleo Surpreendente</p></a></li></ul></li><li><span class="title-list">Dicas</span><ul data-category="dicas" class="clearfix"><li><a href="/app/Palmolive/BR/experiencias/nutri-liss/tips/como-manter-cabelo-liso-por-mais-tempo.cvsp"><div class="preview-img-search"><img src="/Palmolive/BR/HomePage/assets/images/experiencias/artigos/artigo_01.jpg" height="48" width="48" alt="Como manter o cabelo liso por mais tempo"></div><p>Como manter o cabelo liso por mais tempo</p></a></li><li><a href="/app/Palmolive/BR/experiencias/nutri-liss/tips/penteados-para-cabelos-lisos.cvsp"><div class="preview-img-search"><img src="/Palmolive/BR/HomePage/assets/images/experiencias/artigos/artigo_02.jpg" height="48" width="48" alt="Penteados para cabelos lisos"></div><p>Penteados para cabelos lisos</p></a></li><li><a href="/app/Palmolive/BR/experiencias/nutri-liss/tips/como-escolher-pentes-e-escovas.cvsp"><div class="preview-img-search"><img src="/Palmolive/BR/HomePage/assets/images/experiencias/artigos/artigo_03.jpg" height="48" width="48" alt="Como escolher pentes e escovas"></div><p>Como escolher pentes e escovas</p></a></li></ul></li></ul></div></div></div>
    
    <%--<asp:HiddenField runat="server" ID="hdFiliais2"/>--%>
    
    <%--<asp:ListBox runat="server" ID="lbFiliais" CssClass="tamanho" onkeypress="return runScript(event)">
        <asp:ListItem Value="1001">1001</asp:ListItem>
        <asp:ListItem Value="1002">1002</asp:ListItem>
        <asp:ListItem Value="1003">1003</asp:ListItem>
        <asp:ListItem Value="1003">1003</asp:ListItem>
        <asp:ListItem Value="1003">1003</asp:ListItem>
        <asp:ListItem Value="1003">1003</asp:ListItem>
        <asp:ListItem Value="1003">1003</asp:ListItem>
    </asp:ListBox>--%>

   <%-- <select id="selectFiliais" class="tamanho" multiple="multiple">
        <option value="Teste - 101">Teste - 101</option>
    </select>--%>   


    <%--<asp:ListBox runat="server" ID="lbResultado" CssClass="tamanho" >
    </asp:ListBox>
    <div>
        <button id="btnAdd">adicionar elementos</button>
        <button id="btnRemove">remover elementos</button>
        <button id="btnValores" value="0">Adicionar</button>
        <button id="btnRemoveAll">remover todos</button>
    </div>
    <div>
        <asp:Button id="btnSend" runat="server" ClientIDMode="Static" Text="Enviar"></asp:Button>
    </div>--%>

    <asp:Button id="btnSend" runat="server" ClientIDMode="Static" Text="Enviar"></asp:Button>

</asp:Content>
