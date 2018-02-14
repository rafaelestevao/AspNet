// Scripts bepantol
// jQuery

// menu Hover
	$(function () {
	    $("ul#menuHover li").hover(
	        function () {
	            $(this).find(" > a").css("background-position", "bottom");
	        },
	        function () {
	            $(this).find(" > a").css("background-position", "top");
	        }
	    );

// menu dropDown	    
	    $("ul.menuDrop li").hover(
	        function () {
	            $(this).find(" > a").css("background-position", "bottom");
	            $(this).find("div.menuDropDown").css("display", "block");
	        },
	        function () {
	            $(this).find(" > a").css("background-position", "top");
	            $(this).find("div.menuDropDown").css("display", "none");
	        }
	    );

	    $("#header #topo #itensSuperior #menuSuperior ul.root > li:last-child").addClass("ultimoItem");
	    
	    //Chamado esta função para ajustar as LI quando é carregada a pagina com o erro. E não somente quando é clicado no botão
	    AjustaBoxErro();	    
	    
	    $(".ajustaClickErro").bind('click', function() {
			AjustaBoxErro();
		});
	});
	
	
	
	function AjustaBoxErro() {
	
		$("#guardaFormCadastro div.erro").each(function() {

            var qtdLi = $(this).find("li").length;

            if (qtdLi <= 6) {
                $(this).find("ul li").css("width", "500px");
            }
            else if(qtdLi <= 12) {
                $(this).find("ul li").css("width", "250px");
            }
            else{
                $(this).find("ul li").css("width", "160px");
            }
		});
    }
    
    function LimpaForm(idObjetoPai) {
        $('#' + idObjetoPai + " input[type='text']").val("");
        $('#' + idObjetoPai + " input[type='password']").val("");
        $('#' + idObjetoPai + " select").val("");
        $('#' + idObjetoPai + " textarea").val("");
        $('#' + idObjetoPai + " checkbox").attr("checked", "false");
        $('#' + idObjetoPai + " radio").attr("checked", "false");
    }


    // Expect input as d/m/y
    function isValidDate(oSrc, args) {
        var bits = args.Value.split('/');
        var d = new Date(bits[2], bits[1] - 1, bits[0], 1, 0, 0, 0);
        args.IsValid = (d.getMonth() + 1) == bits[1] && d.getDate() == Number(bits[0]);
    }

/* MENSAGEM HOME */
$(function () {
    var container = $('.cssMsgMaquinaPos');
    container.html('');
    var textoMensagem = '<p style="color: red; margin-top: 10px" class="somenteWebPart"> Importante </p> ' +
    '<p class="mensagem"> ' +
        'Manual POS ' +
        '<label class="msgFDA">(<a href="/Style Library/GP-Extranet/pdf/manualPOS.pdf" title="Manual Operacional do Terminal">download</a>)</label> ' +
    '</p> ' +
    ' ' +
    '<p class="mensagem"> ' +
        'Comunicado DIRF 2017 ' +
        '<label class="msgFDA">(competência 2016) (<a href="/Style Library/GP-Extranet/pdf/DIRF_2016.pdf" title="Comunicado DIRF 2016">download</a>)</label> ' +
    '</p> ' +
    ' <br/>';

    container.append(textoMensagem);
});
/* MENSAGEM HOME */