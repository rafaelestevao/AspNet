using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using MaratonaBotsAPI.Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860
namespace MaratonaBotsAPI.Controllers
{
    [Route("api/[controller]")]
    public class CotacaoController : Controller
    {
        // GET: api/<controller>
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/values/5
        [HttpGet("{value}")]
        public Cotacao[] Get(string value)
        {
            List<Cotacao> retorno = new List<Cotacao>();
            var valuesFiltro = value.Split(',');
            foreach (var filtro in valuesFiltro)
            {
                if (filtro.Contains("euro"))
                    retorno.Add(new Cotacao { Nome = filtro, Sigla = "EUR", Valor = "R$ 3,89" });
                else if (filtro.Contains("dólar") || filtro.Contains("dolar"))
                    retorno.Add(new Cotacao { Nome = filtro, Sigla = "USD", Valor = "R$ 3,25" });
                else if (filtro.Contains("bitcoin") || filtro.Contains("bit coin"))
                    retorno.Add(new Cotacao { Nome = filtro, Sigla = "BTC", Valor = "R$ 25.000,00" });
                else
                    retorno.Add(null);
            }

            return retorno.ToArray();
        }

        // POST api/<controller>
        [HttpPost]
        public void Post([FromBody]string value)
        {
        }

        // PUT api/<controller>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
