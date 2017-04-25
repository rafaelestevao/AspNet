using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WFA_Consume_WebApi_Rest
{
    public class FiltroEstabelecimentos
    {
        public int tipo { get; set; }
        public string valor { get; set; }
    }

    public class FiltroSimulacao
    {
        public int idEC { get; set; }
    }

    public class FiltroConfirmaOperacao
    {
        public int idOperacao { get; set; }
    }

    public class FiltroOperacaoLista
    {
        public long periodoAte { get; set; }
        public long periodoDe { get; set; }
        public string situacao { get; set; }
        public int tipoConsulta { get; set; }
        public string valorConsulta { get; set; }
    }
}
