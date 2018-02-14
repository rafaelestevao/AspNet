using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using System.Net.Mail;
using System.Net.Http;
using System.Net;
using System.IO;
using WebApplication1.Models;
using System.Globalization;

namespace WebApplication1
{
    public partial class _Default : Page
    {
        public HttpClient client;
        public Uri usuarioUri;
        protected string QueueName = "RegistrosMesclados";
        private const string EventCount = "2000";

        public _Default()
        {
            if (client == null)
            {
                client = new HttpClient();
                client.BaseAddress = new Uri("http://localhost:63117");
                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
            }
        }

        public static string GetJSONString(string url)
        {
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.ContentType = "application/json";
            request.Headers["Cookie"] = "authaccess_v2=\"portal_gp2|QALLVWNFWHCH0XE55CMI1FMP6KWQU9XNU1WW07VEFR7IJWZMNG13VCN069O5H33Z|WEB\"";
            request.Method = "POST";
            request.ContentLength = 0;
            WebResponse response = request.GetResponse();

            using (Stream stream = response.GetResponseStream())
            {
                StreamReader reader = new StreamReader(
                    stream, Encoding.UTF8);
                return reader.ReadToEnd();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //string valor1 = "{2010,2011,2012,2013}";
            //string valor = "{{201670055566,CPF,2010},{11053272000176,CNPJ,2011}}";
            //string token = GerarToken("17500211000196");

            //var arrayString1 = valor1.Replace("{","").Replace("}","").Split(","[0]);
            //var arrayString = valor.Split(","[0]);

            //GerarEmail();

            //long timestamp = GetTimeStamp();

            //inputText.Value = "Gerando[timestamp]" + timestamp.ToString() + System.Environment.NewLine;
            //inputText.Value = "Convertendo[timestamp>>data]" + TimeStampToDateTime(timestamp).ToString();

            //inputText.Value = GetJSONString("http://localhost:63117/api/cliente");
            //getAll();

            //try
            //{
            //    string nomeReconhecedor = "Foster - Reconhecedor";
            //    string nomeReconhecido = "Foster - Reconhecido";
            //    string justificativaReconhecimento = "Teste de envio de email";
            //    string justificativaCancelamento = "Teste de cancelamento";
            //    string comportamento = "Teste de comportamento";
            //    DateTime dataReconhecimento = DateTime.Now;
            //    DateTime dataCancelamentoReconhecimento = DateTime.Now;

            //    var template = "<html>" +
            //                "<body>" +
            //                    "<img src='http://reconhecimento.bayer.foster.com.br/Content/images/logo-reconhecimento.png'>" +
            //                    "<br>" +
            //                    "<p style='padding-bottom:5px;padding-top:5px;'>Olá,</p>" +
            //                    "<br>" +
            //                    "<p style='font:16px/30px '';'>O reconhecimento feito por <span style='font-weight: bold'>" + nomeReconhecedor + "</span> em " + dataReconhecimento.ToString("dd/MM/yyyy") + " às " + dataReconhecimento.ToString("HH:mm") +
            //                    " para <span style='font-weight: bold'>" + nomeReconhecido + "</span> referente ao comportamento \"<span style='font-weight: bold'>" + comportamento + "</span>\" com a justificativa " +
            //                    "\"<i>" + justificativaReconhecimento + "</i>\" foi <span style='font-weight: bold'>CANCELADO</span> em " + dataCancelamentoReconhecimento.ToString("dd/MM/yyyy") + " " +
            //                    "às " + dataCancelamentoReconhecimento.ToString("HH:mm") + " pelo seguinte motivo:</p>" +
            //                    "<label style='padding-bottom:5px;padding-top:5px;'>\"<i>" + justificativaCancelamento + "</i>\"</label>" +
            //                    "<br>" +
            //                    "<p style='padding-bottom:5px;padding-top:5px;'>Equipe Bayer</p>" +
            //                "</body>" +
            //            "</html>";

            //    var template2 = "<html>" +
            //                "<body>" +
            //                    "<img src='http://reconhecimento.bayer.foster.com.br/Content/images/logo-reconhecimento.png'>" +
            //                    "<br>" +
            //                    "<p style='padding-bottom:5px;padding-top:5px;'>Olá <span style='font-weight: bold'>" + nomeReconhecido + "</span>,</p>" +
            //                    "<label style='font-weight: bold'>Parabéns!</label>" +
            //                    "<br>" +
            //                    "<p style='font:16px/30px '';'>Você foi reconhecido(a) por <span style='font-weight: bold'>" + nomeReconhecedor + "</span> em " + dataReconhecimento.ToString("dd/MM/yyyy") + " às " + dataReconhecimento.ToString("HH:mm") + " pelo comportamento \"<span style='font-weight: bold'>" + comportamento + "</span>\" pelo seguinte motivo:</p>" +
            //                    "<p style='padding-bottom:5px;padding-top:5px;'>\"<i>" + justificativaReconhecimento + "</i>\"</p>" +
            //                    "<p style='padding-bottom:5px;padding-top:5px;'>Equipe Bayer</p>" +
            //                "</body>" +
            //            "</html>";

            //    localhostSendEmail.ServiceEmail _cliente = new localhostSendEmail.ServiceEmail();
            //    _cliente.sendMail("rafaelestevaojp@gmail.com", "Teste de envio de e-mail-1", template, true);
            //    _cliente.sendMail("rafaelestevaojp@gmail.com", "Teste de envio de e-mail-2", template, true);

            //    _cliente.sendMail("rafael.estevao@foster.com.br", "Teste de envio de e-mail-3", template2, true);
            //    _cliente.sendMail("rafael.estevao@foster.com.br", "Teste de envio de e-mail-3", template2, true);
            //}
            //catch (Exception ex)
            //{
            //    Label1.Text = ex.InnerException.ToString();
            //}


            //try
            //{
            //    string nomeReconhecedor = "Foster - Reconhecedor";
            //    string nomeReconhecido = "Foster - Reconhecido";
            //    string justificativaReconhecimento = "Teste de envio de email";
            //    string justificativaCancelamento = "Teste de cancelamento";
            //    string comportamento = "Teste de comportamento";
            //    DateTime dataReconhecimento = DateTime.Now;
            //    DateTime dataCancelamentoReconhecimento = DateTime.Now;

            //    var template = "<html>" +
            //                "<body>" +
            //                    "<img src='http://reconhecimento.bayer.foster.com.br/Content/images/logo-reconhecimento.png'>" +
            //                    "<br>" +
            //                    "<p style='padding-bottom:5px;padding-top:5px;'>Olá,</p>" +
            //                    "<br>" +
            //                    "<p style='font:16px/30px '';'>O reconhecimento feito por <span style='font-weight: bold'>" + nomeReconhecedor + "</span> em " + dataReconhecimento.ToString("dd/MM/yyyy") + " às " + dataReconhecimento.ToString("HH:mm") +
            //                    " para <span style='font-weight: bold'>" + nomeReconhecido + "</span> referente ao comportamento \"<span style='font-weight: bold'>" + comportamento + "</span>\" com a justificativa " +
            //                    "\"<i>" + justificativaReconhecimento + "</i>\" foi <span style='font-weight: bold'>CANCELADO</span> em " + dataCancelamentoReconhecimento.ToString("dd/MM/yyyy") + " " +
            //                    "às " + dataCancelamentoReconhecimento.ToString("HH:mm") + " pelo seguinte motivo:</p>" +
            //                    "<label style='padding-bottom:5px;padding-top:5px;'>\"<i>" + justificativaCancelamento + "</i>\"</label>" +
            //                    "<br>" +
            //                    "<p style='padding-bottom:5px;padding-top:5px;'>Equipe Bayer</p>" +
            //                "</body>" +
            //            "</html>";

            //    var template2 = "<html>" +
            //                "<body>" +
            //                    "<img src='http://reconhecimento.bayer.foster.com.br/Content/images/logo-reconhecimento.png'>" +
            //                    "<br>" +
            //                    "<p style='padding-bottom:5px;padding-top:5px;'>Olá <span style='font-weight: bold'>" + nomeReconhecido + "</span>,</p>" +
            //                    "<label style='font-weight: bold'>Parabéns!</label>" +
            //                    "<br>" +
            //                    "<p style='font:16px/30px '';'>Você foi reconhecido(a) por <span style='font-weight: bold'>" + nomeReconhecedor + "</span> em " + dataReconhecimento.ToString("dd/MM/yyyy") + " às " + dataReconhecimento.ToString("HH:mm") + " pelo comportamento \"<span style='font-weight: bold'>" + comportamento + "</span>\" pelo seguinte motivo:</p>" +
            //                    "<p style='padding-bottom:5px;padding-top:5px;'>\"<i>" + justificativaReconhecimento + "</i>\"</p>" +
            //                    "<p style='padding-bottom:5px;padding-top:5px;'>Equipe Bayer</p>" +
            //                "</body>" +
            //            "</html>";

            //    fakescaEmailSender.ServiceEmail _cliente = new fakescaEmailSender.ServiceEmail();

            //    //System.Net.ServicePointManager.Expect100Continue = false;
            //    _cliente.sendMail("rafaelestevaojp@gmail.com", "Teste de envio de e-mail-1" + DateTime.Now.ToString(), template, true);
            //    _cliente.sendMail("rafaelestevaojp@gmail.com", "Teste de envio de e-mail-2" + DateTime.Now.ToString(), template, true);

            //    _cliente.sendMail("rafael.estevao@foster.com.br", "Teste de envio de e-mail-3" + DateTime.Now.ToString(), template2, true);
            //    _cliente.sendMail("rafael.estevao@foster.com.br", "Teste de envio de e-mail-3" + DateTime.Now.ToString(), template2, true);
            //}
            //catch (Exception ex)
            //{
            //    Label1.Text = ex.InnerException.ToString();
            //}


            using (var session = WebApplication1.Models.OracleSession.EstabilishOracleSession())
            {


                //var recordNumber = RemoveDiacritcs("HUM68113").ToUpper();

                //GetResponsavelOfPatientInOracle(session);
                //ExecutionLog.LogInfo(execution, "Connected to Oracle");

                //ExecutionLog.LogInfo(execution, "Sending Services Oracle");
                //SendServiceRequestOOD(session, execution);

                //ExecutionLog.LogInfo(execution, "Getting Services Oracle");
                //BuscarServiceRequestOOD(session, execution);

                //teste(session);

                //testeServiceRequest(session);

                DownloadServicosAbertos(session);

                //DownloadServicosCancelados(session);

                //DownloadServicosOutros(session);

                //SetConsentimentoOK_Account(session);

                //SetServicesOK(session);

                //GetInfoPatientInOracle(session);

                //GetResponsavelOfPatientInOracle(session);

                //string lastEventId;
                //var events = GetEventsFromQueue(session, QueueName, EventCount, out lastEventId);

            }


            //lblResultado.Text = string.Format(CultureInfo.GetCultureInfo("pt-BR"), "{0:C}", 11963.25);
            //Label1.Text = string.Format("{0:C}", 11963.25);

            //string cnpj = "22628842000125";
            //lblCNPJ.Text = cnpj.Substring(0, 5);

            //Dictionary<int, string> listaFiliais = new Dictionary<int, string> { };
            //List<int> key = new List<int>();
            //List<string> value = new List<string>();
            //key.Add(1);
            //key.Add(2);
            //key.Add(3);
            //key.Add(4);
            //key.Add(5);
            //value.Add("Teste01");
            //value.Add("Teste02");
            //value.Add("Teste03");
            //value.Add("Teste04");
            //value.Add("Teste05");

            //for (int i = 0; i < 5; i++)
            //{
            //    listaFiliais.Add(key[i], value[i]);
            //}

            //Aqui temos que fazer a regra de PAGINAÇÃO, com base nas filiais
            //int qtdTotalRegistros = listaFiliais.Count;
            //int iNumeroPagina = 1, iQtdeRegistrosPorPagina = 20;
            //List<int> dadosFiliais = new List<int>();
            //dadosFiliais = listaFiliais.Keys.ToList();


            //paginação da lista de filiais
            //int pagedFiliais = iNumeroPagina / iQtdeRegistrosPorPagina;
            //pagedFiliais++;
            //int skipFiliais = Math.Max(qtdTotalRegistros * (pagedFiliais - 1), 0);

            //if (iNumeroPagina != 0 && iNumeroPagina != 1)
            //    skipFiliais = (iNumeroPagina - 1) * iQtdeRegistrosPorPagina;

            //if (iQtdeRegistrosPorPagina == 1)
            //    listaFiliais = listaFiliais.Skip(0).Take(iQtdeRegistrosPorPagina).ToDictionary(k => k.Key, v => v.Value);
            //else
            //    listaFiliais = listaFiliais.Skip(skipFiliais).Take(iQtdeRegistrosPorPagina).ToDictionary(k => k.Key, v => v.Value);
            //paginação da lista de filiais
            //string iString = "2017-11-05T02:00:00Z";

            //DateTime d2 = DateTime.Parse(iString, null, System.Globalization.DateTimeStyles.RoundtripKind);

            //var date = DateTime.Parse(iString, new CultureInfo("en-US", true));

            //var dataCOnvert = DateTime.Parse(iString);


            //DateTime oDate = DateTime.ParseExact(iString, "yyyy-MM-dd HH:mm tt", null);
            //Label1.Text = oDate.ToString("dd/MM/yyyy");

            //long cnpj = long.Parse("07876219000106");
            //if (cnpj.ToString().Length < 14)
            //    Label3.Text = cnpj.ToString().PadLeft(14, '0').ToString();
            //int codeReturn = 01;
            //string retorno = MensagemErroAntecipacao(codeReturn);
            //Label1.Text = retorno;

        }

        public static String EditUrl(string idFicha, string email)
        {
            UrlBuilder URL = new UrlBuilder("~/Default.aspx");
            URL.AppendArgument("IdFicha", idFicha);
            URL.AppendArgument("Email", email);
            return URL.ToString();
        }

        public static string RemoveDiacritcs(string input)
        {
            if (string.IsNullOrEmpty(input))
            {
                return string.Empty;
            }
            else
            {
                var bytes = Encoding.GetEncoding("iso-8859-8").GetBytes(input);
                return Encoding.UTF8.GetString(bytes);
            }
        }

        public string MensagemErroAntecipacao(int codigoMensagem)
        {
            string retorno = string.Empty;
            int[] codigoMensagemA = new int[] { 11, 12, 13, 15, 19, 23, 24, 48, 35, 49, 64 };
            int[] codigoMensagemB = new int[] { 22 };

            if (codigoMensagemA.Contains(codigoMensagem))
                retorno = "Não é possivel prosseguir, contate a central de atendimento";

            if (codigoMensagemB.Contains(codigoMensagem))
                retorno = "Outras operações em andamento, contate a central de atendimento";

            return retorno;
        }

        public void SetServicesOK(OracleSession session)
        {
            try
            {
                OODServiceRequest.ServiceRequest prxySrvc = new OODServiceRequest.ServiceRequest();
                OODServiceRequest.ServiceRequestWS_ServiceRequestUpdate_Input qryParam = new OODServiceRequest.ServiceRequestWS_ServiceRequestUpdate_Input();
                qryParam.ListOfServiceRequest = new OODServiceRequest.ServiceRequest1[1];
                qryParam.ListOfServiceRequest[0] = new OODServiceRequest.ServiceRequest1();
                qryParam.ListOfServiceRequest[0].SRNumber = "507358-1045190820";
                qryParam.ListOfServiceRequest[0].Status = "Closed";
                qryParam.ListOfServiceRequest[0].Subject = "Teste de fechamento de serviço";
                qryParam.ListOfServiceRequest[0].Description = "Foi efetuado o Aceite eletrônico na data de " + String.Format("{0:d/M/yyyy HH:mm:ss}", DateTime.Now);
                qryParam.ListOfServiceRequest[0].dtData_de_envio_de_consentimento_via_email = String.Format("{0:M/d/yyyy HH:mm:ss}", DateTime.Now);
                qryParam.ListOfServiceRequest[0].dtData_de_recebimento_do_consentimento_via_email = String.Format("{0:M/d/yyyy HH:mm:ss}", DateTime.Now.AddDays(5));
                //qryParam.ListOfServiceRequest[0].stIndicacin = "Psoríase";
                //qryParam.ListOfServiceRequest[0].ContactEmail = "TESTE@FOSTER.COM.BR";

                prxySrvc.Url = session.GetUrl();
                prxySrvc.CookieContainer = session.GetCookieContainer();
                prxySrvc.ServiceRequestUpdate(qryParam);
            }
            catch (Exception ex)
            {

            }
        }

        public void GetInfoPatientInOracle(OracleSession session)
        {
            OODAccount2.Account proxy = new OODAccount2.Account();
            OODAccount2.AccountWS_AccountQueryPage_Input qryParam = new OODAccount2.AccountWS_AccountQueryPage_Input();
            OODAccount2.AccountWS_AccountQueryPage_Output qryOut = new OODAccount2.AccountWS_AccountQueryPage_Output();

            string sAccountId = "AVHA-HABDP9";
            string sAccountType = "Paciente";
            qryParam.PageSize = "1";
            qryParam.ListOfAccount = new OODAccount2.Account1[1];
            qryParam.ListOfAccount[0] = new OODAccount2.Account1();
            qryParam.ListOfAccount[0].AccountType = "LIKE '" + sAccountType + "'";
            qryParam.ListOfAccount[0].AccountId = "LIKE '" + sAccountId + "'";
            qryParam.ListOfAccount[0].bTermoElect = "";
            qryParam.ListOfAccount[0].plProducto = "";
            qryParam.ListOfAccount[0].plPrograma = "";

            // Prepara a chamada do Método
            proxy.Url = session.GetUrl();
            proxy.CookieContainer = session.GetCookieContainer();

            // Executa o Método no Oracle On Demand
            qryOut = proxy.AccountQueryPage(qryParam);

            //return proxy.AccountQueryPage(qryParam);

            //var result = proxy.AccountQueryPage(param);

            for (int i = 0; i < qryOut.ListOfAccount.Length; i++)
            {

            }
        }

        public void SetConsentimentoOK_Account(OracleSession session)
        {
            try
            {
                string texto = "S", texto2 = "Não";
                string strplHumira_Pen = "Pen";
                string strplIndicacao = "Artrite relacionada à entesite";
                string strAccountId = "AVHA-HABDP9";
                string strplEspecialidad = "";

                OODAccount2.Account proxy = new OODAccount2.Account();
                OODAccount2.AccountWS_AccountUpdate_Input param = new OODAccount2.AccountWS_AccountUpdate_Input();
                param.ListOfAccount = new OODAccount2.Account1[1];
                param.ListOfAccount[0] = new OODAccount2.Account1();

                param.ListOfAccount[0].AccountType = "Paciente";
                //param.ListOfAccount[0].AccountType = "Médico";

                param.ListOfAccount[0].AccountId = strAccountId;
                param.ListOfAccount[0].plConsentimiento_Informado = texto2;
                param.ListOfAccount[0].bTermoElect = texto;
                param.ListOfAccount[0].plHumira_Pen = strplHumira_Pen;
                param.ListOfAccount[0].plIndicacao = strplIndicacao;
                param.ListOfAccount[0].plEspecialidad = strplEspecialidad;

                proxy.Url = session.GetUrl();
                proxy.CookieContainer = session.GetCookieContainer();
                proxy.AccountUpdate(param);
            }
            catch (Exception e)
            {

            }
        }

        private string GetResponsavelOfPatientInOracle(OracleSession mSession)
        {
            try
            {
                OODAccount2.Account prxySrvcAccount = new OODAccount2.Account();
                OODAccount2.AccountWS_AccountQueryPage_Input objAccQryParam = new OODAccount2.AccountWS_AccountQueryPage_Input();
                OODAccount2.AccountWS_AccountQueryPage_Output objAccQryOut = new OODAccount2.AccountWS_AccountQueryPage_Output();

                objAccQryParam.PageSize = "1";
                objAccQryParam.ListOfAccount = new OODAccount2.Account1[1];
                objAccQryParam.ListOfAccount[0] = new OODAccount2.Account1();
                objAccQryParam.ListOfAccount[0].AccountType = "LIKE '" + "Paciente" + "'";//"Paciente";
                objAccQryParam.ListOfAccount[0].AccountName = "";
                objAccQryParam.ListOfAccount[0].AccountId = "LIKE '" + "AVHA-HABDP9" + "'";
                objAccQryParam.ListOfAccount[0].Location = "";
                objAccQryParam.ListOfAccount[0].ltNome_completo = "";
                objAccQryParam.ListOfAccount[0].plCodigo_de_termino = "";
                objAccQryParam.ListOfAccount[0].CurrencyCode = "";
                objAccQryParam.ListOfAccount[0].ExternalSystemId = "";

                //objAccQryParam.ListOfAccount[0].ExternalSystemId = "";
                //objAccQryParam.ListOfAccount[0].IndexedShortText1 = "";
                objAccQryParam.ListOfAccount[0].ltNomes_dos_pais_ou_responsaveis = "";

                // Prepara a chamada do Método
                prxySrvcAccount.Url = mSession.GetUrl();
                prxySrvcAccount.CookieContainer = mSession.GetCookieContainer();

                // Executa o Método no Oracle On Demand
                objAccQryOut = prxySrvcAccount.AccountQueryPage(objAccQryParam);

                //return proxy.AccountQueryPage(qryParam);
                return objAccQryOut.ListOfAccount[0].ltNomes_dos_pais_ou_responsaveis;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public void DownloadServicosAbertos(OracleSession session)
        {
            OODServiceRequest.ServiceRequest prxySrvc = new OODServiceRequest.ServiceRequest();
            OODServiceRequest.ServiceRequestWS_ServiceRequestQueryPage_Input qryParam = new OODServiceRequest.ServiceRequestWS_ServiceRequestQueryPage_Input();
            OODServiceRequest.ServiceRequestWS_ServiceRequestQueryPage_Output qryOut = new OODServiceRequest.ServiceRequestWS_ServiceRequestQueryPage_Output();
            List<OODServiceRequest.ServiceRequest1> itens = new List<OODServiceRequest.ServiceRequest1>();

            string sType = "Px Consentimento Eletrônico";
            string sStatus = "Open";
            //qryParam.PageSize = "100";
            qryParam.ListOfServiceRequest = new OODServiceRequest.ServiceRequest1[1];
            qryParam.ListOfServiceRequest[0] = new OODServiceRequest.ServiceRequest1();
            qryParam.ListOfServiceRequest[0].SRNumber = "";
            qryParam.ListOfServiceRequest[0].IntegrationId = "";
            qryParam.ListOfServiceRequest[0].AccountId = "";
            qryParam.ListOfServiceRequest[0].AccountName = "";
            qryParam.ListOfServiceRequest[0].Type = "LIKE '" + sType + "'";
            qryParam.ListOfServiceRequest[0].Subject = "";
            qryParam.ListOfServiceRequest[0].Description = "";
            qryParam.ListOfServiceRequest[0].Status = "LIKE '" + sStatus + "' ";
            //qryParam.ListOfServiceRequest[0].Status = "NOT LIKE '" + sStatus2 + "' ";
            qryParam.ListOfServiceRequest[0].Priority = "";
            qryParam.ListOfServiceRequest[0].CreatedDate = "";
            qryParam.ListOfServiceRequest[0].OwnerPartnerName = "";
            qryParam.ListOfServiceRequest[0].ContactEmail = "";
            qryParam.ListOfServiceRequest[0].stIndicacin = "";
            qryParam.ListOfServiceRequest[0].dtData_de_envio_de_consentimento_via_email = "";
            qryParam.ListOfServiceRequest[0].dtData_de_recebimento_do_consentimento_via_email = "";
            qryParam.ListOfServiceRequest[0].ContactEmail = "";
            qryParam.ListOfServiceRequest[0].plResponsable = "";
            qryParam.ListOfServiceRequest[0].ltEmail_do_paciente = ""; //ltEmail_do_paciente

            // Prepara a chamada do Método
            prxySrvc.Url = session.GetUrl();
            prxySrvc.CookieContainer = session.GetCookieContainer();

            // Executa o Método no Oracle On Demand
            qryOut = prxySrvc.ServiceRequestQueryPage(qryParam);
            //itens = qryOut.ListOfServiceRequest.Where(c => c.Status.ToLower() != "closed" && c.Status.ToLower() != "em andamento").ToList();
            itens = qryOut.ListOfServiceRequest.ToList();

            for (int i = 0; i < itens.Count(); i++)
            {

            }
        }

        public void DownloadServicosCancelados(OracleSession session)
        {
            OODServiceRequest.ServiceRequest prxySrvc = new OODServiceRequest.ServiceRequest();
            OODServiceRequest.ServiceRequestWS_ServiceRequestQueryPage_Input qryParam = new OODServiceRequest.ServiceRequestWS_ServiceRequestQueryPage_Input();
            OODServiceRequest.ServiceRequestWS_ServiceRequestQueryPage_Output qryOut = new OODServiceRequest.ServiceRequestWS_ServiceRequestQueryPage_Output();
            List<OODServiceRequest.ServiceRequest1> itens = new List<OODServiceRequest.ServiceRequest1>();

            string sType = "Px Consentimento Eletrônico";
            string sStatus = "Cancelled";
            //qryParam.PageSize = "100";
            qryParam.ListOfServiceRequest = new OODServiceRequest.ServiceRequest1[1];
            qryParam.ListOfServiceRequest[0] = new OODServiceRequest.ServiceRequest1();
            qryParam.ListOfServiceRequest[0].SRNumber = "";
            qryParam.ListOfServiceRequest[0].IntegrationId = "";
            qryParam.ListOfServiceRequest[0].AccountId = "";
            qryParam.ListOfServiceRequest[0].AccountName = "";
            qryParam.ListOfServiceRequest[0].Type = "LIKE '" + sType + "'";
            qryParam.ListOfServiceRequest[0].Subject = "";
            qryParam.ListOfServiceRequest[0].Description = "";
            qryParam.ListOfServiceRequest[0].Status = "LIKE '" + sStatus + "' ";
            qryParam.ListOfServiceRequest[0].Priority = "";
            qryParam.ListOfServiceRequest[0].CreatedDate = "";
            qryParam.ListOfServiceRequest[0].OwnerPartnerName = "";
            qryParam.ListOfServiceRequest[0].ContactEmail = "";
            qryParam.ListOfServiceRequest[0].stIndicacin = "";
            qryParam.ListOfServiceRequest[0].dtData_de_envio_de_consentimento_via_email = "";
            qryParam.ListOfServiceRequest[0].dtData_de_recebimento_do_consentimento_via_email = "";
            qryParam.ListOfServiceRequest[0].ContactEmail = "";
            qryParam.ListOfServiceRequest[0].plResponsable = "";
            qryParam.ListOfServiceRequest[0].ltEmail_do_paciente = ""; //ltEmail_do_paciente

            // Prepara a chamada do Método
            prxySrvc.Url = session.GetUrl();
            prxySrvc.CookieContainer = session.GetCookieContainer();

            // Executa o Método no Oracle On Demand
            qryOut = prxySrvc.ServiceRequestQueryPage(qryParam);
            //itens = qryOut.ListOfServiceRequest.Where(c => c.Status.ToLower() != "closed" && c.Status.ToLower() != "em andamento").ToList();
            itens = qryOut.ListOfServiceRequest.ToList();

            for (int i = 0; i < itens.Count(); i++)
            {

            }
        }

        public void DownloadServicosOutros(OracleSession session)
        {
            OODServiceRequest.ServiceRequest prxySrvc = new OODServiceRequest.ServiceRequest();
            OODServiceRequest.ServiceRequestWS_ServiceRequestQueryPage_Input qryParam = new OODServiceRequest.ServiceRequestWS_ServiceRequestQueryPage_Input();
            OODServiceRequest.ServiceRequestWS_ServiceRequestQueryPage_Output qryOut = new OODServiceRequest.ServiceRequestWS_ServiceRequestQueryPage_Output();
            List<OODServiceRequest.ServiceRequest1> itens = new List<OODServiceRequest.ServiceRequest1>();

            string sType = "Px Consentimento Eletrônico";
            string sStatus = "Cancelled";
            //qryParam.PageSize = "100";
            qryParam.ListOfServiceRequest = new OODServiceRequest.ServiceRequest1[1];
            qryParam.ListOfServiceRequest[0] = new OODServiceRequest.ServiceRequest1();
            qryParam.ListOfServiceRequest[0].SRNumber = "";
            qryParam.ListOfServiceRequest[0].IntegrationId = "";
            qryParam.ListOfServiceRequest[0].AccountId = "";
            qryParam.ListOfServiceRequest[0].AccountName = "";
            qryParam.ListOfServiceRequest[0].Type = "LIKE '" + sType + "'";
            qryParam.ListOfServiceRequest[0].Subject = "";
            qryParam.ListOfServiceRequest[0].Description = "";
            qryParam.ListOfServiceRequest[0].Status = "LIKE '" + sStatus + "' ";
            qryParam.ListOfServiceRequest[0].Priority = "";
            qryParam.ListOfServiceRequest[0].CreatedDate = "";
            qryParam.ListOfServiceRequest[0].OwnerPartnerName = "";
            qryParam.ListOfServiceRequest[0].ContactEmail = "";
            qryParam.ListOfServiceRequest[0].stIndicacin = "";
            qryParam.ListOfServiceRequest[0].dtData_de_envio_de_consentimento_via_email = "";
            qryParam.ListOfServiceRequest[0].dtData_de_recebimento_do_consentimento_via_email = "";
            qryParam.ListOfServiceRequest[0].ContactEmail = "";
            qryParam.ListOfServiceRequest[0].plResponsable = "";
            qryParam.ListOfServiceRequest[0].ltEmail_do_paciente = ""; //ltEmail_do_paciente
            qryParam.ListOfServiceRequest[0].ModifiedDate = "> '04/27/2017 12:10:43' ";

            // Prepara a chamada do Método
            prxySrvc.Url = session.GetUrl();
            prxySrvc.CookieContainer = session.GetCookieContainer();

            // Executa o Método no Oracle On Demand
            qryOut = prxySrvc.ServiceRequestQueryPage(qryParam);
            //itens = qryOut.ListOfServiceRequest.Where(c => c.Status.ToLower() != "closed" && c.Status.ToLower() != "em andamento").ToList();
            itens = qryOut.ListOfServiceRequest.ToList();

            for (int i = 0; i < itens.Count(); i++)
            {

            }
        }

        public void teste(OracleSession session)
        {
            OODAccount2.Account proxy = new OODAccount2.Account();
            OODAccount2.AccountWS_AccountUpdate_Input param = new OODAccount2.AccountWS_AccountUpdate_Input();
            param.ListOfAccount = new OODAccount2.Account1[1];
            param.ListOfAccount[0] = new OODAccount2.Account1();
            param.ListOfAccount[0].AccountType = "Paciente";
            param.ListOfAccount[0].AccountId = "xpto";
            param.ListOfAccount[0].bConsentimiento_Verbal = "1"; //VERIFICAR, NÃO ESTÁ ENVIANDO PARA ORACLE, JÁ TENTEI OUTROS VALOES (S/N, 0/1, T/F, C/E);
            param.ListOfAccount[0].plConsentimiento_Informado = "Sim";
            //param.ListOfAccount[0];

            proxy.Url = session.GetUrl();
            proxy.CookieContainer = session.GetCookieContainer();
            proxy.AccountUpdate(param);
        }

        public void testeServiceRequest(OracleSession session)
        {
            OODServiceRequest.ServiceRequest prxySrvc = new OODServiceRequest.ServiceRequest();
            OODServiceRequest.ServiceRequestWS_ServiceRequestUpdate_Input qryParam = new OODServiceRequest.ServiceRequestWS_ServiceRequestUpdate_Input();
            qryParam.ListOfServiceRequest = new OODServiceRequest.ServiceRequest1[1];
            qryParam.ListOfServiceRequest[0] = new OODServiceRequest.ServiceRequest1();
            qryParam.ListOfServiceRequest[0].SRNumber = "gasdsdg21515";
            qryParam.ListOfServiceRequest[0].Description = "Foi efetuado o Aceite eletrônico.";
            qryParam.ListOfServiceRequest[0].Status = "Closed";
            qryParam.ListOfServiceRequest[0].dtData_de_envio_de_consentimento_via_email = "";
            //Data de envio do consententimento (envio do e-mail) qryParam.ListOfServiceRequest[0].dtData_de_envio_de_consentimento_via_email

            qryParam.ListOfServiceRequest[0].dtData_de_recebimento_do_consentimento_via_email = "";
            //Data do aceite   qryParam.ListOfServiceRequest[0].dtData_de_recebimento_do_consentimento_via_email

            prxySrvc.Url = session.GetUrl();
            prxySrvc.CookieContainer = session.GetCookieContainer();
            prxySrvc.ServiceRequestUpdate(qryParam);
        }

        public void GetTimeStamp_Click(object sender, EventArgs e)
        {
            long timestamp = GetTimeStamp();
            inGetTimeStamp.Value = timestamp.ToString();

            var dtInicio = ViewState["dtInicio"];
            var dtFim = ViewState["dtFim"];
        }

        public void TimeStampToDateTime_Click(object sender, EventArgs e)
        {
            DateTime data = TimeStampToDateTime(long.Parse(inTimeStampToDateTime.Value));
            resultTimeStampToDateTime.InnerText = data.ToString();
        }

        public void DateTimeToTimeStamp_Click(object sender, EventArgs e)
        {
            long timestamp = DateTimeToTimeStamp(Convert.ToDateTime(inDateTimeToTimeStamp.Value));
            resultDateTimeToTimeStamp.InnerText = timestamp.ToString();
        }

        public long GetTimeStamp()
        {
            /// <summary>
            /// gero um timestamp a partir do datetime.now
            /// </summary>
            long unixTimeStamp;
            DateTime currentTime = DateTime.Now;
            DateTime zuluTime = currentTime.ToUniversalTime();
            DateTime unixEpoch = new DateTime(1970, 1, 1);
            unixTimeStamp = (long)(zuluTime.Subtract(unixEpoch)).TotalMilliseconds;
            return unixTimeStamp;
        }

        public long DateTimeToTimeStamp(DateTime date)
        {
            /// <summary>
            /// gero um timestamp a partir de uma data que foi passada
            /// </summary>
            long unixTimeStamp;
            DateTime currentTime = date;
            DateTime zuluTime = currentTime.ToUniversalTime();
            DateTime unixEpoch = new DateTime(1970, 1, 1);
            unixTimeStamp = (long)(zuluTime.Subtract(unixEpoch)).TotalMilliseconds;
            return unixTimeStamp;
        }

        public DateTime TimeStampToDateTime(long unixTimeStamp)
        {
            /// <summary>
            /// Converto um timestamp para datetime
            /// </summary>
            System.DateTime dtDateTime = new DateTime(1970, 1, 1);
            dtDateTime = dtDateTime.AddMilliseconds(unixTimeStamp).ToUniversalTime();// ToLocalTime();
            return dtDateTime;
        }

        private void getAll()
        {
            //chamando a api pela url
            System.Net.Http.HttpResponseMessage response = client.GetAsync("api/cliente").Result;

            //se retornar com sucesso busca os dados
            if (response.IsSuccessStatusCode)
            {
                //pegando o cabeçalho
                usuarioUri = response.Headers.Location;

                //Pegando os dados do Rest e armazenando na variável usuários
                //var clientes = response.Content.ReadAsAsync<IEnumerable<WebApplication1.Models.cliente>>().Result;
                //var clientes = response.Content.ReadAsDataContract<IEnumerable<WebApplication1.Models.cliente>>().Result;



                //preenchendo a lista com os dados retornados da variável
                //GridView1.DataSource = clientes;
                //GridView1.DataBind();
            }
            //Se der erro na chamada, mostra o status do código de erro.
            else
                Response.Write(response.StatusCode.ToString() + " - " + response.ReasonPhrase);
        }


        protected string GerarToken(string MERCHANT_NUMBER)
        {
            string chaveAutenticacao = "gpaydirfchaveautenticacao";
            string concatenacao = MERCHANT_NUMBER.ToString() + DateTime.Now.ToString("yyyyMMdd");
            string retorno = string.Empty;

            using (var encoder = new HMACSHA512(Encoding.UTF8.GetBytes(chaveAutenticacao)))
            {
                var hash = encoder.ComputeHash(Encoding.UTF8.GetBytes(concatenacao));
                var signature = Convert.ToBase64String(hash);
                retorno = signature;
            }

            return retorno;
        }

        public void OnConfirm(object sender, EventArgs e)
        {
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('You clicked YES!')", true);
            }
            else
            {
                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('You clicked NO!')", true);
            }
        }

        protected void GerarEmail()
        {
            StringBuilder Body = new StringBuilder();
            Body.Append("<p>TESTE DE ENVIO DE E-MAIL</p>");

            String FromEmail = "rafael.estevao@foster.com.br";
            String DisplayNameFromEmailMedico = "Teste de envio de email";
            MailMessage message = new MailMessage();
            message.From = new MailAddress(FromEmail, DisplayNameFromEmailMedico);
            message.To.Add(new MailAddress("rafael.estevao@foster.com.br"));
            message.Subject = "TESTE DE ENVIO DE EMAIL";
            message.IsBodyHtml = true;
            message.Body = Body.ToString();
            SmtpClient client = new SmtpClient();

            try
            {
                client.Send(message);
                lblTopo.InnerText = "Email enviado com SUCESSO! " + DateTime.Now.ToString();
            }
            catch (Exception ex)
            {
                lblTopo.InnerText = "ERRO ao enviar Email." + DateTime.Now.ToString() + "ERRO - [" + ex.ToString() + "]";
            }
        }

        protected void btnEncript_Click(object sender, EventArgs e)
        {
            string valor = txtEncript.Text;

        }
    }
}