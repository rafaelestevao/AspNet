using Microsoft.Bot.Builder.Dialogs;
using Microsoft.Bot.Builder.FormFlow;
using System;

namespace Bot_Application1.Formulario
{
    [Serializable]
    [Template(TemplateUsage.NotUnderstood, "Desculpe, não entendi \"{0}\". ")]
    public class Pedido
    {
        public Salgadinhos Salgadinhos { get; set; }

        public Bebidas Bebidas { get; set; }

        public TipoEntrega TipoEntrega { get; set; }

        public CPFNaNota CPFNaNota { get; set; }

        public string Nome { get; set; }

        public string Telefone { get; set; }

        public string Endereco { get; set; }

        public static IForm<Pedido> BuildForm()
        {
            var form = new FormBuilder<Pedido>();
            form.Configuration.DefaultPrompt.ChoiceStyle = ChoiceStyleOptions.Buttons;
            form.Configuration.Yes = new string[] { "sim", "yes", "s", "y", "yep" };
            form.Configuration.No = new string[] { "não", "não", "no", "not", "n", "nao", "nope" };
            form.Message("Olá, seja bem vindo. Será um prazer atender você.");
            form.OnCompletion(async (context, pedido) =>
            {
                //Salvar na base de dados
                //Gerar pedido
                //Integrar com xpto.
                await context.PostAsync("Seu pedido número 123456 foi gerado e em instantes será entregue.");
            });
            return form.Build();
        }
    }

    public enum TipoEntrega
    {
        [Terms("RetirarNoLocal", "retirar")]
        [Describe("Retirar no local")]
        RetirarNoLocal = 1,

        [Terms("Motoboy", "motoca", "boy", "cachorro loko")]
        Motoboy
    }

    public enum Salgadinhos
    {
        [Terms("Esfirra", "esfira", "isfirra", "Esfira")]
        Esfirra = 1,

        [Terms("Quibe", "kibe", "k", "q")]
        Quibe,

        [Terms("Coxinha", "cochinha", "coxa", "c")]
        Coxinha
    }

    public enum Bebidas
    {
        [Terms("Água", "água", "agua", "h2o", "a")]
        [Describe("Água")]
        Agua = 1,

        [Terms("Refrigerante", "refri", "r")]
        [Describe("Refrigerante")]
        Refrigerante,

        [Terms("Suco", "s")]
        [Describe("Suco")]
        Suco
    }

    [Describe("CPF na nota")]
    public enum CPFNaNota
    {
        [Terms("Sim", "s", "yep")]
        Sim = 1,

        [Terms("Não", "nao", "n", "not", "nope")]
        [Describe("Não")]
        Nao
    }
}