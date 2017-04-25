using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GP_Extranet_Mock_WebApi_Rest.Models
{
    public class OperacaoModel
    {
        public int codigoEC { get; set; }
        public long dataOperacao { get; set; }
        public long dataPagamento { get; set; }
        public string documento { get; set; }
        public int idCanal { get; set; }
        public int idOperacao { get; set; }
        public string nome { get; set; }
        public string nomeCanal { get; set; }
        public int situacao { get; set; }
        public string situacaoDesc { get; set; }
        public string tipoPessoa { get; set; }
        public string tipoSelecao { get; set; }
        public double valorBruto { get; set; }
        public double valorDesconto { get; set; }
        public double valorLiquido { get; set; }
    }
}