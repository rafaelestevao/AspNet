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

namespace WebApplication1
{
    public partial class _Default : Page
    {
        public HttpClient client;
        public Uri usuarioUri;

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

            long timestamp = GetTimeStamp();

            inputText.Value = "Gerando[timestamp]" + timestamp.ToString() + System.Environment.NewLine;
            inputText.Value = "Convertendo[timestamp>>data]" + TimeStampToDateTime(timestamp).ToString();



            //inputText.Value = GetJSONString("http://localhost:63117/api/cliente");
            //getAll();



        }

        public void GetTimeStamp_Click(object sender, EventArgs e)
        {
            long timestamp = GetTimeStamp();
            inGetTimeStamp.Value = timestamp.ToString();
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
            dtDateTime = dtDateTime.AddMilliseconds(unixTimeStamp).ToLocalTime();
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
            catch(Exception ex)
            {
                lblTopo.InnerText = "ERRO ao enviar Email." + DateTime.Now.ToString() + "ERRO - ["+ ex.ToString()+"]";
            }
        }
    }
}