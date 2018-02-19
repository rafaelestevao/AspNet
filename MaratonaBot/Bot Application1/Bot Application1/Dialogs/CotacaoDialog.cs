using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Bot.Builder.Dialogs;
using Microsoft.Bot.Builder.Luis;
using Microsoft.Bot.Builder.Luis.Models;
using System.Net.Http;
using Newtonsoft.Json;
using System.Configuration;

namespace Bot_Application1.Dialogs
{
    [Serializable]
    [LuisModel("fe1fd0eb-7a5e-4395-bf56-45a1ac0c5c49", "24a644fa2f114a8a9665a30a819f0393")]
    public class CotacaoDialog : LuisDialog<object>
    {
        private string urlApiMaratonaBots = ConfigurationManager.AppSettings["urlApiMaratonaBots"];

        [LuisIntent("None")]
        private async Task None(IDialogContext context, LuisResult result)
        {
            await context.PostAsync($"Desculpe, não consegui entender a frase {result.Query}");
        }

        [LuisIntent("Sobre")]
        private async Task Sobre(IDialogContext context, LuisResult result)
        {
            await context.PostAsync("Eu sou um bot e estou sempre aprendendo. Tenha paciencia comigo.");
        }

        [LuisIntent("Cumprimento")]
        private async Task Cumprimento(IDialogContext context, LuisResult result)
        {
            await context.PostAsync("Olá! Eu sou um bot que faz cotação de moedas.");
        }

        [LuisIntent("Cotacao")]
        private async Task Cotacao(IDialogContext context, LuisResult result)
        {
            var moedas = result.Entities?.Select(e => e.Entity);

            //aplicando api do azure para cotar as moedas
            var filtro = string.Join(",", moedas.ToArray());
            var endpoint = $"{urlApiMaratonaBots}{filtro}";

            await context.PostAsync("Aguarde um momento enquanto eu obtenho as informações...");

            using (var cliente = new HttpClient())
            {
                var response = await cliente.GetAsync(endpoint);
                if (!response.IsSuccessStatusCode)
                {
                    await context.PostAsync("Ocorreu algum erro. Pf, tente novamente mais tarde...");
                    return;
                }
                else
                {
                    var json = await response.Content.ReadAsStringAsync();
                    var resultado = JsonConvert.DeserializeObject<Models.Cotacao[]>(json);
                    var cotacoes = resultado.Select(c => $"{c.Nome}: {c.Valor}");
                    await context.PostAsync($"{string.Join(",", cotacoes.ToArray())}");
                }
            }
            //aplicando api do azure para cotar as moedas

            
        }
    }
}