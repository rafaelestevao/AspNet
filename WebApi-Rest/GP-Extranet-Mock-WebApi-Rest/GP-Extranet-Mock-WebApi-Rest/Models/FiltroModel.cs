using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GP_Extranet_Mock_WebApi_Rest.Models
{
    public class FiltroEstabelecimentosModel
    {
        public int tipo { get; set; }
        public string valor { get; set; }
    }

    public class FiltroSimulacaoModel
    {
        public int idEC { get; set; }
    }

    public class FiltroConfirmaOperacaoModel
    {
        public int idOperacao { get; set; }
    }

    public class FiltroOperacaoListaModel
    {
        public long periodoAte { get; set; }
        public long periodoDe { get; set; }
        public string situacao { get; set; }
        public int tipoConsulta { get; set; }
        public string valorConsulta { get; set; }
    }
}