<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication1.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style type="text/css">
    #content #corpo #guardaFormCadastro {
        width: 996px !important;
    }
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

<%--<UCTeclado:Teclado runat="server" id="ucTeclado" />--%>

<script type="text/javascript">
    $(function () {
        //Config Teclado <asp:literal id="ltrTexto" runat="server" />

        ConfigurarKeyBoard("<%=txtSenha.ClientID %>", "txtSenhaFalsa");
    });


    $('#Captchaload').live('click', function() { 
        Capt = new Date(); 
        $("#Captchaim").attr("src", "/Pages/imagem-captcha.aspx?"+Capt.getTime()); 
    });  

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

<div id="guardaFormCadastro">
    <br />
    <h2>Para acessar, informe suas credenciais corretamente. Se ainda não tiver usuário, <a href="/Pages/cadastro.aspx">clique aqui</a> para criar o seu.</h2>
    <p>Caso ainda não seja nosso cliente, conheça <a href="https://globalpayments.com.br/">nossos produtos e serviços</a> e preencha on-line uma <a href="/pages/credenciamento.aspx">proposta de credenciamento</a>.</p>
    <asp:ValidationSummary ID="vdsErros" runat="server" DisplayMode="BulletList" class="erro" ValidationGroup="g_login" />
    <br class="clear" />
    <div id="infosGerais">
        <ul>
            <li>
                <label>Nº do Estabelecimento*</label>
                <asp:TextBox ID="txtMerchantNumber" runat="server" ValidationGroup="g_login" MaxLength="9" />
                <%--<asp:RequiredFieldValidator ID="rfvMerchNumber" runat="server" ErrorMessage="O “nº do Estabelecimento” deve ser informado." Text="*"
                    ControlToValidate="txtMerchantNumber" ValidationGroup="g_login" />
                <asp:CustomValidator ID="cvMerchantNumber" runat="server" ErrorMessage="Falha no login: por favor, verifique os dados informados e tente novamente."
                    OnServerValidate="cvMerchantNumber_Valida" ControlToValidate="txtMerchantNumber" Text="*" ValidationGroup="g_login" />--%>
            </li>
            <li>
                <label>Usuário*</label>
                <asp:TextBox ID="txtUserName" runat="server" ValidationGroup="g_login" MaxLength="256" />
                <%--<asp:RequiredFieldValidator ID="rfvUserName" runat="server" ErrorMessage="O “usuário” deve ser informado." Text="*" Display="Dynamic"
                    ControlToValidate="txtUserName" ValidationGroup="g_login" Style="float: left" />
                <label style="float: left">&nbsp;&nbsp;<a href="/Pages/esqueci-meu-usuario.aspx"><i>Esqueci meu usuário</i></a></label>--%>
            </li>


            <li>
                <label>Senha*</label>
                <label style="width: 600px;">
                    <asp:TextBox ID="txtSenha" runat="server" TextMode="Password" ValidationGroup="g_login" />
                    <input type="password" value="xxxxxxxxxxxxxxx" id="txtSenhaFalsa" style="display: none; float: left; margin-right: 5px;" readonly="readonly" />
                    <%--<asp:RequiredFieldValidator ID="rfvSenha" runat="server" ErrorMessage="A “senha” deve ser informada." Text="*"
                        ControlToValidate="txtSenha" ValidationGroup="g_login" Display="Dynamic" Style="float: left; margin: 0px 5px 0px 0px;" />--%>
                    <div class="bt" style="margin: -5px 0px 0px 0px">
                        <div class="bgEsq"></div>
                        <input type="button" id="btnSenha" onclick="AbreTeclado('<%=txtSenha.ClientID %>    ','btnSenha'); " value="Clique aqui para digitar a senha"
                            class="bgMeio ajustaClickErro" />
                        <div class="bgDir"></div>
                    </div>
                    <label>&nbsp;&nbsp;<a href="/Pages/esqueci-minha-senha.aspx"><i>Esqueci minha senha</i></a></label>
                </label>
            </li>


            <li id="captchaOffline" runat="server" visible="true">
                <label>Palavras de verificação*</label>
                <div class="newRecaptcha floatLeft">
                    <p>
                        <img id="Captchaim" src="/Pages/imagem-captcha.aspx" alt="" class="cssimagemcaptcha" />
                        <a id="Captchaload">
                            <img src="/Style Library/GP-Extranet/images/refresh.png" title="Obter uma nova imagem" class="imgBtCaptcha" />
                        </a>
                    </p>
                    <asp:TextBox ID="txtPalavraVerifica" Visible="true" placeholder="Digite as palavras de verificação" runat="server" CssClass="cssInputCaptcha"></asp:TextBox>
                </div>
            </li>

        </ul>
        <%--<asp:CustomValidator ID="cvErro" runat="server" Display="None" ValidationGroup="g_login"></asp:CustomValidator>
        <asp:CustomValidator ID="cvErro2" runat="server" Display="None" ValidationGroup="g_login"
            ErrorMessage="Atenção: Seu usuário será bloqueado na próxima tentativa de login caso sua senha seja informada incorretamente."></asp:CustomValidator>
        <asp:CustomValidator ID="cvErroCaptcha" OnServerValidate="cvCaptcha_Valida" runat="server" Display="None" ValidationGroup="g_login" ErrorMessage="Palavras digitadas não coincidem com as 'Palavras de verificação' " />--%>


    </div>
    <div id="botoes">
        <div class="bt">
            <div class="bgEsq"></div>
            <asp:Button ID="btnLogin" Text="Login" CssClass="bgMeio ajustaClickErro" runat="server" ValidationGroup="g_login" />
            <div class="bgDir"></div>
        </div>
    </div>


</div>

</asp:Content>
