<%@ Page Title="TimeStamp" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1._Default" %>




<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Basic Modal -->
    <link type='text/css' href='Scripts/basicmodal/css/demo.css' rel='stylesheet' media='screen' />
    <link type='text/css' href='Scripts/basicmodal/css/basic.css' rel='stylesheet' media='screen' />
    <script type='text/javascript' src="Scripts/basicmodal/js/jquery.simplemodal.js"></script>

    <style type="text/css">
        .cssMsgMaquinaPos { width: 26%; float: right; margin-top: -245px; color: red; font-style: oblique; font-size: 15px; background: rgb(236,241,249); width: 360px !important; }

        .somenteWebPart { font-size: 16px; margin-left: 10px; margin-top: 8px; font-weight: bold; font-style: normal; }

        label { font-weight: normal; }

        p.mensagem { margin-left: 10px; color: black; font-style: normal; margin-top: 10px; font-size: 12px; font-weight: bold; }

        #divCorrecaoAluguel { margin-left: 10px; margin-right: 10px; margin-bottom: 10px; }

        #divMensagemImportante { margin-left: 10px; margin-right: 10px; margin-bottom: 10px; }

        .semMargin { margin-left: 0px !important; }

        #bannerRodape { margin-top: 30px; float: right; margin-right: -79px; }

        #footer #rodape { margin-top: 2px !important; }

        .btnCancelar{visibility:hidden;}
    </style>

    <script type="text/javascript">

        function isValidDate(d) {
            return !isNaN((new Date(d)).getTime());
        }

        function validate() {
            var dtInicio = document.getElementById('dtInicio').value;
            var dtFim = document.getElementById('dtFim').value;

            if (!isValidDate(dtInicio)) {
                alert("A data inicial não é valida");
                return false;
            }

            if (!isValidDate(dtFim)) {
                alert("A data final não é valida");
                return false;
            }

<%--            <%# ViewState["dtInicio"] %> = dtInicio;
            <%# ViewState["dtFim"] %> = dtFim;--%>

            return true;
        }

        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Confirma o cancelamento desta antecipação?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }

        function ConfirmacaoOK() {
            <%--document.getElementById('<%=btnConfirmar.ClientID%>').click();--%>
            document.getElementById('btnNao').click();
        }

        $(document).on("click", "[id*=est]", function () {
            $('#basic-modal-content').modal();
            divModalFiliais.style.visibility = 'visible';
            return false;
        });

        $(function () {
            var container = $('.cssMsgMaquinaPos');
            container.html('');
            var textoMensagem = '<p style="color: red; margin-top: 10px" class="somenteWebPart">Importante</p> ' +
            '<div id="divMensagemImportante"> ' +
                '<p class="semMargin mensagem"> ' +
                '<label>' +
                    'Prezado cliente, informamos que devido ao expediente bancário de fim de ano, ' +
                    'os pagamentos de transações de débito realizadas nos dias 29/12, 30/12, 31/12 e 01/01 ' +
                    'e as de crédito agendados para essas datas, serão pagas no dia <strong>02/01/17</strong>. <br />' +
                    'As operações de PREPAG - antecipação de recebíveis - que realizadas no dia 29/12 serão pagas também em <strong>02/01/17</strong>. ' +
                    '<br /><br />  ' +
                    'Desejamos boas festas e excelentes negócios em 2017! <br /><br />' +
                '</label> ' +
                '</p> ' +
            '</div> ' +

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
            '';

            container.append(textoMensagem);
        });
    </script>

    <div class="jumbotron">
        <h1 id="lblTopo" runat="server">ASP.NET</h1>
        <p class="lead">ASP.NET is a free web framework for building great Web sites.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
    </div>

    <div class="row">
        <div class="col-md-3">
            <h3>DateTime.now to TimeStamp</h3>
            <p>
                <input id="inGetTimeStamp" runat="server" />
            </p>
            <p>
                <asp:Button ID="btnGetTimeStamp" runat="server" OnClick="GetTimeStamp_Click" Text="GetTimeStamp" />
            </p>
        </div>
        <div class="col-md-3">
            <h3>TimeStamp to Date</h3>
            <p>
                <input id="inTimeStampToDateTime" runat="server" />
            </p>
            <p>
                <asp:Button ID="btnTimeStampToDateTime" runat="server" OnClick="TimeStampToDateTime_Click" Text="TimeStampToDateTime" />
            </p>
            <p>
                <label id="resultTimeStampToDateTime" runat="server"></label>
            </p>
        </div>

        <div class="col-md-3">
            <h3>Date to TimeStamp</h3>
            <p>
                <input id="inDateTimeToTimeStamp" runat="server" type="datetime-local" name="bdaytime">
            </p>
            <p>
                <asp:Button ID="btnDateTimeToTimeStamp" runat="server" OnClick="DateTimeToTimeStamp_Click" Text="DateTimeToTimeStamp" />
            </p>
            <p>
                <label id="resultDateTimeToTimeStamp" runat="server"></label>
            </p>
        </div>

        <div id="divMaquinaPos" class="cssMsgMaquinaPos">
        </div>

        <div class="col-md-3">
            <h2 id="h2Teste" runat="server"></h2>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" />
                    <asp:BoundField DataField="Nome" HeaderText="Nome" />
                </Columns>
            </asp:GridView>

            <input type="text" id="inputText" runat="server" />

        </div>
    </div>

    <div class="row">
        <div class="col-md-3">
            <h3>Teste mensagem de confirmação</h3>
            <p>
                <button class="btnMensagem" type="button" id="est">Abrir mensagem</button>
                <asp:Button ID="btnConfirmar" runat="server" OnClick="GetTimeStamp_Click" Text="Sim-Cancelar" CssClass="btnCancelar"/>
            </p>
        </div>

<%--        <div class="col-md-3">
            <h3>Teste mensagem de confirmação - 2</h3>
            <p>
                <asp:Button ID="btnConfirm" runat="server" OnClick = "OnConfirm" Text = "Raise Confirm" OnClientClick = "Confirm()"/>
            </p>
        </div>--%>
    </div>

    <!-- MODAL -->
    <div id='content' runat="server" class="esconder modalN1">
        <!-- modal content -->
        <div id="basic-modal-content">
            <div id="divModalFiliais" style="visibility: hidden;">
                <h2 class="labelModalN1">Confirma o cancelamento para esta antecipação?</h2>
                <div class="linhaModalN1"></div>
                <div id="div2" class="bt" runat="server">
                    <button type="button" onclick="ConfirmacaoOK();" aria-hidden="true">Sim</button>
                    <button id="btnNao" type="button" class="botaoFecharSuperior modalCloseImg simplemodal-close" aria-hidden="true">Não</button>
                </div>
            </div>
        </div>
    </div>
    <!-- MODAL -->

    <div class="row">
        <div class="col-md-3">
            <input type="date" id="dtInicio"/>
        </div>
        <div class="col-md-3">
            <input type="date" id="dtFim" />
        </div>
        <div class="col-md-3">
            <button type="button" onclick="validate();">Consultar</button>
            <asp:Button ID="btnConsultar" runat="server" Text="Consultar - Asp:Button" OnClick="GetTimeStamp_Click" OnClientClick="return validate();"/>
        </div>
        <div class="col-md-3">
            <%--<asp:Label ID="lblResultado" runat="server"><%# string.Format(new System.Globalization.CultureInfo.CurrentCulture() GetCultureInfo("pt-BR"), "{0:C}", decimal.Parse("414112,58"))  %></asp:Label>--%>

            <asp:Label ID="Label1" runat="server">teste</asp:Label>
            <%--<asp:Label ID="Label2" runat="server" Visible="true"><%= string.Format("{0:C}", 11963.25)  %></asp:Label>--%>

            <%--<h4>Teste Preencher a esquerda</h4>
            <asp:Label ID="Label3" runat="server" Visible="true"></asp:Label>

            <asp:Label ID="lblCNPJ" runat="server"></asp:Label>--%>
        </div>
    </div>

</asp:Content>
