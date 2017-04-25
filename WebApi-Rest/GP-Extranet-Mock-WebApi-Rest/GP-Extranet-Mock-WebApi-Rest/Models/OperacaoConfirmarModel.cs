using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GP_Extranet_Mock_WebApi_Rest.Models
{
    public class OperacaoConfirmarModel
    {
        public int codigoRetorno { get; set; }
        public int idOperacao { get; set; }
        public string mensagem { get; set; }
    }
}