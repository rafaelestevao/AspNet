//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace GP_Extranet_Mock_WebApi_Rest.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class mk_simulacao
    {
        public int simulacaoID { get; set; }
        public Nullable<int> idEC { get; set; }
        public Nullable<int> codigoEc { get; set; }
        public string nome { get; set; }
        public string documento { get; set; }
        public string tipoPagamento { get; set; }
        public Nullable<int> categoria { get; set; }
        public string categoriaDescricao { get; set; }
        public Nullable<int> taxaPromocional { get; set; }
        public string taxaPromocionalDescricao { get; set; }
        public Nullable<double> taxa { get; set; }
        public string tipoTaxa { get; set; }
        public string taxaDescricao { get; set; }
        public Nullable<int> numeroOperacao { get; set; }
        public string dataOperacao { get; set; }
        public string dataPagamento { get; set; }
        public Nullable<double> taxaAntecipada { get; set; }
        public Nullable<double> custoOperacao { get; set; }
        public Nullable<double> spreadOperacao { get; set; }
        public Nullable<double> valorBruto { get; set; }
        public Nullable<double> valorTaxaAntecipada { get; set; }
        public Nullable<double> valorLiquido { get; set; }
        public Nullable<System.DateTime> primeiroVencimento { get; set; }
        public Nullable<System.DateTime> ultimoVencimento { get; set; }
        public Nullable<double> prazoMedio { get; set; }
        public string origemTaxa { get; set; }
        public Nullable<double> valorLiquidoDestacado { get; set; }
        public Nullable<bool> icConcluida { get; set; }
        public string domicilioBancario { get; set; }
        public Nullable<int> situacao { get; set; }
        public string situacaoDesc { get; set; }
    }
}