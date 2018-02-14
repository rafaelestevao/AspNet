using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Bot.Builder.Dialogs;
using Microsoft.Bot.Builder.Luis;
using Microsoft.Bot.Builder.Luis.Models;

namespace Bot_Application1.Dialogs
{
    [Serializable]
    [LuisModel("fe1fd0eb-7a5e-4395-bf56-45a1ac0c5c49", "24a644fa2f114a8a9665a30a819f0393")]
    public class CotacaoDialog : LuisDialog<object>
    {
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
            await context.PostAsync($"Eu farei uma cotação para as moedas {string.Join("," ,moedas.ToArray())}");
        }
    }
}