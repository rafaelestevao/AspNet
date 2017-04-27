<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

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
    </style>

    <script type="text/javascript">
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
                <input id="inGetTimeStamp" runat="server"/>
            </p>
            <p>
                <asp:Button id="btnGetTimeStamp" runat="server" onclick="GetTimeStamp_Click" Text="GetTimeStamp"/>
            </p>
        </div>
        <div class="col-md-3">
            <h3>TimeStamp to Date</h3>
            <p>
                <input id="inTimeStampToDateTime" runat="server"/>
            </p>
            <p>
                <asp:Button id="btnTimeStampToDateTime" runat="server" onclick="TimeStampToDateTime_Click" Text="TimeStampToDateTime"/>
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
                <asp:Button id="btnDateTimeToTimeStamp" runat="server" onclick="DateTimeToTimeStamp_Click" Text="DateTimeToTimeStamp"/>
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

            <input type="text" id="inputText" runat="server"/>
           
        </div>
    </div>

</asp:Content>
