using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using GP_Extranet_Mock_WebApi_Rest.Models;
using System.Globalization;

namespace GP_Extranet_Mock_WebApi_Rest.Controllers
{
    [RoutePrefix("simulacao")]
    public class SimulacaoController : ApiController
    {
        private string cookie = "authaccess_v2=\"portal_gp2|QALLVWNFWHCH0XE55CMI1FMP6KWQU9XNU1WW07VEFR7IJWZMNG13VCN069O5H33Z|WEB\"";
        TimeStamp timeStamp = new TimeStamp();

        [AcceptVerbs("POST")]
        [Route("")]
        public SimulacaoModel[] simulacao(FiltroSimulacaoModel filtro)
        {
            if (Request.Headers.Contains("Cookie"))
                if (cookie != Request.Headers.GetValues("Cookie").First())
                    return null;

            Data.GPContainer1 db = new Data.GPContainer1();
            int idEC = filtro.idEC;

            if (idEC != 0)
            {
                List<Data.mk_simulacao> query = db.mk_simulacao.Where(c => (c.icConcluida == false || c.icConcluida == null) && c.idEC == idEC).ToList();

                if (query.Count() > 0)
                {
                    List<SimulacaoModel> vetor = new List<SimulacaoModel>();

                    foreach (Data.mk_simulacao saiBD in query)
                    {
                        SimulacaoModel saiTemp = new SimulacaoModel();
                        saiTemp.codigoEc = Convert.ToInt32(saiBD.codigoEc);
                        saiTemp.documento = saiBD.documento;
                        saiTemp.nome = saiBD.nome;
                        saiTemp.tipoPagamento = saiBD.tipoPagamento;
                        saiTemp.categoria = Convert.ToInt32(saiBD.categoria);
                        saiTemp.categoriaDescricao = saiBD.categoriaDescricao;
                        saiTemp.taxaPromocional = Convert.ToInt32(saiBD.taxaPromocional);
                        saiTemp.taxaPromocionalDescricao = saiBD.taxaPromocionalDescricao;
                        saiTemp.taxa = Convert.ToDouble(saiBD.taxa);
                        saiTemp.tipoTaxa = saiBD.tipoTaxa;
                        saiTemp.taxaDescricao = saiBD.taxaDescricao;

                        SimulacaoModel.DadosOperacao dadOp = new SimulacaoModel.DadosOperacao();
                        List<SimulacaoModel.DadosOperacao> dadOpList = new List<SimulacaoModel.DadosOperacao>();
                        dadOp.numeroOperacao = Convert.ToInt32(saiBD.numeroOperacao);
                        dadOp.dataOperacao = timeStamp.GetTimeStamp();
                        dadOp.dataPagamento = timeStamp.GetTimeStamp();
                        dadOp.taxaAntecipada = Convert.ToDouble(saiBD.taxaAntecipada);
                        dadOp.custoOperacao = Convert.ToDouble(saiBD.custoOperacao);
                        dadOp.spreadOperacao = Convert.ToDouble(saiBD.spreadOperacao);
                        dadOp.valorBruto = Convert.ToDouble(saiBD.valorBruto);
                        dadOp.valorTaxaAntecipada = Convert.ToDouble(saiBD.valorTaxaAntecipada);
                        dadOp.valorLiquido = Convert.ToDouble(saiBD.valorLiquido);
                        dadOp.primeiroVencimento = timeStamp.GetTimeStamp();
                        dadOp.ultimoVencimento = timeStamp.GetTimeStamp();
                        dadOp.prazoMedio = Convert.ToDouble(saiBD.prazoMedio);
                        dadOp.origemTaxa = saiBD.origemTaxa;
                        dadOp.valorLiquidoDestacado = null;
                        dadOpList.Add(dadOp);
                        saiTemp.dadosOperacao = dadOpList;

                        //agendas
                        List<Data.mk_agendas> queryAgendas = db.mk_agendas.Where(c => c.idEC == idEC).ToList();
                        List<SimulacaoModel.Agendas> dadosAgendas = new List<SimulacaoModel.Agendas>();
                        if (queryAgendas.Count() > 0)
                        {
                            foreach(Data.mk_agendas saiDBagendas in queryAgendas)
                            {
                                SimulacaoModel.Agendas dadAgenda = new SimulacaoModel.Agendas();
                                dadAgenda.dataVencimento = timeStamp.GetTimeStamp();
                                dadAgenda.descricao = saiDBagendas.descricao;
                                dadAgenda.id = Convert.ToInt32(saiDBagendas.id);
                                dadAgenda.idAgendas = saiDBagendas.idAgendas;
                                dadAgenda.valorDisponivel = Convert.ToDouble(saiDBagendas.valorDisponivel);
                                dadAgenda.valorLiquido = Convert.ToDouble(saiDBagendas.valorLiquido);

                                dadosAgendas.Add(dadAgenda);
                            }

                            saiTemp.agendas = dadosAgendas;
                        }
                        //agendas


                        //domicílios
                        List<Data.mk_domicilios> queryDomicilios = db.mk_domicilios.Where(c => c.id == idEC).ToList();
                        List<SimulacaoModel.Domicilios> dadosDomicilios = new List<SimulacaoModel.Domicilios>();
                        if (queryDomicilios.Count() > 0)
                        {
                            foreach (Data.mk_domicilios saiDBdomicilios in queryDomicilios)
                            {
                                SimulacaoModel.Domicilios dadDomicilio = new SimulacaoModel.Domicilios();
                                dadDomicilio.descricao = saiDBdomicilios.descricao;
                                dadDomicilio.id = Convert.ToInt32(saiDBdomicilios.id);
                                dadDomicilio.valor = Convert.ToDouble(saiDBdomicilios.valor);
                                dadDomicilio.valorLiquido = Convert.ToDouble(saiDBdomicilios.valorLiquido);

                                dadosDomicilios.Add(dadDomicilio);
                            }

                            saiTemp.domicilios = dadosDomicilios;
                        }
                        //domicílios

                        //lojas
                        List<Data.mk_lojas> queryLojas = db.mk_lojas.Where(c => c.id == idEC).ToList();
                        List<SimulacaoModel.Lojas> dadosLojas = new List<SimulacaoModel.Lojas>();
                        if (queryLojas.Count() > 0)
                        {
                            foreach(Data.mk_lojas saiDBlojas in queryLojas)
                            {
                                SimulacaoModel.Lojas dadLojas = new SimulacaoModel.Lojas();
                                dadLojas.codEC = Convert.ToInt32(saiDBlojas.codEC);
                                dadLojas.descricao = saiDBlojas.descricao;
                                dadLojas.id = Convert.ToInt32(saiDBlojas.id);
                                dadLojas.valorDisponivel = Convert.ToDouble(saiDBlojas.valorDisponivel);

                                dadosLojas.Add(dadLojas);
                            }

                            saiTemp.lojas = dadosLojas;
                        }
                        //lojas

                        vetor.Add(saiTemp);
                    }

                    return vetor.ToArray();
                }
                else
                    return null;
            }
            else
                return null;

        }
    }
}
