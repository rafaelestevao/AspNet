using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using GP_Extranet_Mock_WebApi_Rest.Models;

namespace GP_Extranet_Mock_WebApi_Rest.Controllers
{
    [RoutePrefix("estabelecimentos")]
    public class EstabelecimentoController : ApiController
    {
        private string cookie = "authaccess_v2=\"portal_gp2|QALLVWNFWHCH0XE55CMI1FMP6KWQU9XNU1WW07VEFR7IJWZMNG13VCN069O5H33Z|WEB\"";

        [AcceptVerbs("POST")]
        [Route("listar-centrais")]
        public EstabelecimentoModel[] listarcentrais(FiltroEstabelecimentosModel filtro)
        {
            if (Request.Headers.Contains("Cookie"))
                if (cookie != Request.Headers.GetValues("Cookie").First())
                    return null;

            Data.GPContainer1 db = new Data.GPContainer1();
            List<Data.mk_listarCentrais> query = db.mk_listarCentrais.ToList();

            if (filtro.tipo == 1)//Filtro por Código Filial (EC)
                query = query.Where(c => c.codigoEc == Convert.ToInt32(filtro.valor)).ToList();
            else if (filtro.tipo == 2 || filtro.tipo == 3 || filtro.tipo == 4)//Filtro por Raiz CNPJ
                query = query.Where(c => c.documento == filtro.valor).ToList();
            else if (filtro.tipo == 5)//Domicílio bancário
                query = query.Where(c => c.documento == c.documento).ToList();
            else
                return null;

            if (query.Count() > 0)
            {
                List<EstabelecimentoModel> vetor = new List<EstabelecimentoModel>();

                foreach (Data.mk_listarCentrais saiBD in query)
                {
                    EstabelecimentoModel saiTemp = new EstabelecimentoModel();
                    saiTemp.id = Convert.ToInt32(saiBD.id);
                    saiTemp.codigoEc = Convert.ToInt32(saiBD.codigoEc);
                    saiTemp.documento = saiBD.documento;
                    saiTemp.nome = saiBD.nome;
                    saiTemp.tipoPagamento = saiBD.tipoPagamento;
                    saiTemp.tipoPessoa = saiBD.tipoPessoa;
                    saiTemp.valorBloqueado = Convert.ToDouble(saiBD.valorBloqueado);
                    saiTemp.valorBruto = Convert.ToDouble(saiBD.valorBruto);
                    saiTemp.valorDisponivel = Convert.ToDouble(saiBD.valorDisponivel);

                    vetor.Add(saiTemp);
                }

                return vetor.ToArray();
            }
            else
                return null;

        }
    }
}
