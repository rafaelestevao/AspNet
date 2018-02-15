using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bot_Application1.Models
{
    public class Cotacao
    {
        [JsonProperty("nome")]
        public int Nome { get; set; }

        [JsonProperty("sigla")]
        public int Sigla { get; set; }

        [JsonProperty("valor")]
        public int Valor { get; set; }
    }
}