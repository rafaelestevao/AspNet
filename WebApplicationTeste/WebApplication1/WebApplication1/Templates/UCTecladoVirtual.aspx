<!-- jQuery & jQuery UI + theme (required) -->
<link href="../Scripts/css/jquery-ui-1.9.2.css" rel="stylesheet" />
<script src="../Scripts/JS/jquery-ui-1.9.2.min.js"></script>
<!-- keyboard widget css & script (required) -->
<link href="../Scripts/Keyboard-master2/css/keyboard.css" rel="stylesheet" />
<script src="../Scripts/Keyboard-master2/js/jquery.keyboard.js"></script>  
<!-- keyboard extensions (optional) -->
<script src="../Scripts/Keyboard-master2/js/jquery.mousewheel.js"></script>
<script src="../Scripts/Keyboard-master2/js/jquery.keyboard.extension-typing.js"></script>
<script src="../Scripts/Keyboard-master2/js/jquery.keyboard.extension-autocomplete.js"></script>
<!-- tooltips -->
<script src="../Scripts/Keyboard-master2/demo/jquery.chili-2.2.js"></script>  
<!-- syntax highlighting -->
<script src="../Scripts/Keyboard-master2/demo/recipes.js"></script>

<script type="text/javascript">
    $("body").prepend("<div id='bgFloaters'></div>");

    function ConfigurarKeyBoard(idCampo, idCampoFalso) {
        $('#' + idCampo).hide();

        $.keyboard.keyaction.panic = function (base) {
            $('.ui-keyboard-preview-wrapper input').val('');
        };

        var layoutSemMaiusculo = {
            'default': [
                    'q w e r t y u i o p {panic!!}',
                    'a s d f g h j k l',
                    '{meta1} z x c v b n m {meta1}',
                    '{cancel} {space} {accept}'
                    ],
            'meta1': [
                    '1 2 3 4 5 6 7 8 9 0 {panic!!}',
                    '- / : ; ( ) \u20ac & @ ',
                    '{meta2} . , ? ! \' " {meta2}',
                    '{default} {space} {default} {accept}'
                    ],
            'meta2': [
                    '[ ] { } # % ^ * + = {panic!!}',
                    '_ \\ | ~ < > $ \u00a3 \u00a5 ',
                    '{meta1} . , ? ! \' " {meta1}',
                    '{default} {space} {default} {accept}'
                    ]
        };

        $('#' + idCampo).keyboard({
            display: {
                'bksp': "\u2190",
                'panic': "Limpar",
                'accept': 'OK',
                'cancel': 'Cancelar',
                'default': 'ABC',
                'meta1': '.?123',
                'meta2': '#+='
            },
            lockInput: true,
            layout: 'custom',
            customLayout: layoutSemMaiusculo,
            hidden: function (e, keyboard, el) {
                FechaTeclado(idCampo, idCampoFalso);
            }
        });
    }

    var idBotao = "";

    function AbreTeclado(idCampo, pIdBotao) {
        idBotao = pIdBotao;
        //atribuir altura
        $("#bgFloaters").css("height", $(document).height() + "px");
        $("#bgFloaters").show();
        $('.ui-keyboard-preview-wrapper input').val('');
        $('#' + idCampo).val("");
        $('#' + idCampo).show();
        $('#' + idCampo).focus();
    }

    function FechaTeclado(idCampo, idCampoFalso) {
        $('#' + idCampo).hide();

        if ($('#' + idCampo).val() == "") {
            $("#" + idCampoFalso).hide();
            $("#" + idBotao).val("Clique aqui para digitar a senha");
        }
        else {
            $("#" + idCampoFalso).show();
            $("#" + idBotao).val("Clique aqui para re-digitar a senha");
        }

        $("#bgFloaters").hide();
    }
   
</script>

<style type="text/css">
#bgFloaters{
	background-color: #000000;
	width: 100%;
	position: absolute;
	top: 0px;
	left: 0px;
	-moz-opacity:.60;
	filter:alpha(opacity=60);
	opacity:.60;
	z-index: 11;
	display:none;
}
</style>

