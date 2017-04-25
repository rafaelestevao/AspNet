using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GP_Extranet_Mock_WebApi_Rest.Models
{
    public class SimulacaoModel
    {
        public int codigoEc { get; set; }
        public string nome { get; set; }
        public string documento { get; set; }
        public string tipoPagamento { get; set; }
        public int categoria { get; set; }
        public string categoriaDescricao { get; set; }
        public int taxaPromocional { get; set; }
        public string taxaPromocionalDescricao { get; set; }
        public double taxa { get; set; }
        public string tipoTaxa { get; set; }
        public string taxaDescricao { get; set; }
        public List<DadosOperacao> dadosOperacao { get; set; }
        public List<Agendas> agendas { get; set; }
        public List<Domicilios> domicilios { get; set; }
        public List<Lojas> lojas { get; set; }


        public class DadosOperacao
        {
            public int numeroOperacao { get; set; }
            public long dataOperacao { get; set; }
            public long dataPagamento { get; set; }
            public double taxaAntecipada { get; set; }
            public double custoOperacao { get; set; }
            public double spreadOperacao { get; set; }
            public double valorBruto { get; set; }
            public double valorTaxaAntecipada { get; set; }
            public double valorLiquido { get; set; }
            public long primeiroVencimento { get; set; }
            public long ultimoVencimento { get; set; }
            public double prazoMedio { get; set; }
            public string origemTaxa { get; set; }
            public string valorLiquidoDestacado { get; set; }
        }

        public class Agendas
        {
            public int id { get; set; }
            public long dataVencimento { get; set; }
            public string descricao { get; set; }
            public double valorDisponivel { get; set; }
            public double valorLiquido { get; set; }
            public string idAgendas { get; set; }
        }

        public class Domicilios
        {
            public int id { get; set; }
            public string descricao { get; set; }
            public double valor { get; set; }
            public double valorLiquido { get; set; }
        }

        public class Lojas
        {
            public int id { get; set; }
            public int codEC { get; set; }
            public string descricao { get; set; }
            public double valorDisponivel { get; set; }
        }
    }
}