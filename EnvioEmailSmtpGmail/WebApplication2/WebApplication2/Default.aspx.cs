using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Net;
using System.Net.Mail;

namespace WebApplication2
{
    public partial class _Default : Page
    {
        protected override void OnInit(EventArgs e)
        {
            btnSend.Click += btnSend_Click;
        }

        void btnSend_Click(object sender, EventArgs e)
        {
            SmtpClient client = new SmtpClient("smtp.gmail.com", 587);
            client.EnableSsl = true;
            MailAddress from = new MailAddress("noreply@foster.com.br", "Global Payments - Credenciais de Acesso");
            MailAddress to = new MailAddress("rafael.estevao@foster.com.br", "Rafael Estevão");
            MailMessage message = new MailMessage(from, to);
            message.Body = "Teste de envio de email, c#";
            message.Subject = "Teste de envio de e-mail via c#";
            NetworkCredential myCreds = new NetworkCredential("robot.valle@gmail.com", "Itsinthehand01", "");
            client.Credentials = myCreds;

            try
            {
                client.Send(message);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Exception is:" + ex.ToString());
            }

            Console.WriteLine("Goodbye.");

            //var filiais = hdFiliais.Value != "" ? hdFiliais.Value.Split(',') : new string[] { "" };

            //var filiais2 = hdFiliais2.Value != "" ? hdFiliais2.Value.Split(',') : new string[] { "" };
            //Dictionary<int, string> result = new Dictionary<int, string>();
            //foreach (var item in filiais2)
            //{
            //    if (result.Where(c => c.Key == int.Parse(item)).Count() == 0)
            //        result.Add(int.Parse(item), item);
            //}
            //lbResultado.DataSource = result;
            //lbResultado.DataValueField = "Value";
            //lbResultado.DataTextField = "Value";
            //lbResultado.DataBind();
        }


        protected void Page_Load(object sender, EventArgs e)
        {
        //    List<ListItem> itens = lbFiliais.Items.Cast<ListItem>().ToList();

        //    selectFiliais.DataSource = itens;
        //    selectFiliais.DataTextField = "Text";
        //    selectFiliais.DataValueField = "Value";
        //    selectFiliais.DataBind();
        }
    }
}