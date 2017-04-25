using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GP_Extranet_Mock_WebApi_Rest.Models
{
    public class EstabelecimentoModel
    {
        public int id { get; set; }
        public int codigoEc { get; set; }
        public string nome { get; set; }
        public string documento { get; set; }
        public string tipoPessoa { get; set; }
        public string tipoPagamento { get; set; }
        public double valorBruto { get; set; }
        public double valorBloqueado { get; set; }
        public double valorDisponivel { get; set; }
    }
}