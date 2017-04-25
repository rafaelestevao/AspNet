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
    [RoutePrefix("operacao")]
    public class OperacaoController : ApiController
    {
        private string cookie = "authaccess_v2=\"portal_gp2|QALLVWNFWHCH0XE55CMI1FMP6KWQU9XNU1WW07VEFR7IJWZMNG13VCN069O5H33Z|WEB\"";
        TimeStamp timeStamp = new TimeStamp();

        [AcceptVerbs("POST")]
        [Route("confirmar")]
        public OperacaoConfirmarModel confirmar(FiltroConfirmaOperacaoModel filtro)
        {
            if (Request.Headers.Contains("Cookie"))
                if (cookie != Request.Headers.GetValues("Cookie").First())
                    return null;

            //Data.GPContainer1 db = new Data.GPContainer1();
            OperacaoConfirmarModel retorno = new OperacaoConfirmarModel();
            int idOperacao = filtro.idOperacao;
            if (idOperacao != 0)
            {
                using (var db = new Data.GPContainer1())
                {
                    var result = db.mk_simulacao.SingleOrDefault(c => (c.icConcluida == false || c.icConcluida == null) && c.numeroOperacao == idOperacao);
                    if (result != null)
                    {
                        result.icConcluida = true;
                        db.SaveChanges();

                        retorno.codigoRetorno = 0;
                        retorno.idOperacao = idOperacao;
                        retorno.mensagem = "Antecipação gerada com sucesso. Num Operação " + idOperacao.ToString() + "";
                    }
                    else
                    {
                        retorno.codigoRetorno = 999;
                        retorno.idOperacao = idOperacao;
                        retorno.mensagem = "Antecipação " + idOperacao.ToString() + " não encontrada.";
                    }
                }
            }
            else
            {
                retorno.codigoRetorno = -1;
                retorno.idOperacao = 0;
                retorno.mensagem = "Nr. de operação " + idOperacao.ToString() + " não existe!";
            }

            return retorno;
        }

        [AcceptVerbs("POST")]
        [Route("cancelar")]
        public OperacaoCancelarModel cancelar(FiltroConfirmaOperacaoModel filtro)
        {
            if (Request.Headers.Contains("Cookie"))
                if (cookie != Request.Headers.GetValues("Cookie").First())
                    return null;

            //Data.GPContainer1 db = new Data.GPContainer1();
            OperacaoCancelarModel retorno = new OperacaoCancelarModel();
            int idOperacao = filtro.idOperacao;
            if (idOperacao != 0)
            {
                using (var db = new Data.GPContainer1())
                {
                    var result = db.mk_simulacao.SingleOrDefault(c => (c.icConcluida == true) && c.numeroOperacao == idOperacao);
                    if (result != null)
                    {
                        result.icConcluida = false;
                        db.SaveChanges();

                        retorno.mensagem = "Antecipação cancelada com sucesso. Num Operação " + idOperacao.ToString() + "";
                    }
                    else
                        retorno.mensagem = "Antecipação " + idOperacao.ToString() + " não encontrada.";
                }
            }
            else
                retorno.mensagem = "Nr. de operação " + idOperacao.ToString() + " não existe!";

            return retorno;
        }

        [AcceptVerbs("POST")]
        [Route("")]
        public OperacaoModel[] lista(FiltroOperacaoListaModel filtro)
        {
            if (Request.Headers.Contains("Cookie"))
                if (cookie != Request.Headers.GetValues("Cookie").First())
                    return null;

            Data.GPContainer1 db = new Data.GPContainer1();
            List<Data.mk_simulacao> query = db.mk_simulacao.Where(c => c.icConcluida == true).ToList();
            string valorConsulta = filtro.valorConsulta;

            if (filtro.tipoConsulta != 0 && filtro.tipoConsulta != 6)
            {
                if (filtro.periodoDe != null && filtro.periodoAte != null)
                {
                    //filtro.periodoAte = filtro.periodoAte.Value.AddDays(1);
                    query = query.Where(c => long.Parse(c.dataOperacao) >= filtro.periodoDe && long.Parse(c.dataOperacao) <= filtro.periodoAte).ToList();
                }
                else if (filtro.periodoDe != null && filtro.periodoAte == null)
                {
                    query = query.Where(c => long.Parse(c.dataOperacao) >= filtro.periodoDe).ToList();
                }
                else if (filtro.periodoDe == null && filtro.periodoAte != null)
                {
                    //filtro.periodoAte = timeStamp.UnixTimeStampToDateTime(filtro.periodoAte).Value.AddDays(1);
                    query = query.Where(c => long.Parse(c.dataOperacao) <= filtro.periodoAte).ToList();
                }
            }

            if (!string.IsNullOrEmpty(filtro.situacao))
                query = query.Where(c => c.situacaoDesc == filtro.situacao).ToList();

            if (filtro.tipoConsulta == 1)//Codigo EC
                query = query.Where(c => c.codigoEc == int.Parse(valorConsulta)).ToList();
            else if (filtro.tipoConsulta == 2)//raiz de cnpj
                query = query.Where(c => c.documento == valorConsulta).ToList();
            else if (filtro.tipoConsulta == 3)//cnpj
                query = query.Where(c => c.documento == valorConsulta).ToList();
            else if (filtro.tipoConsulta == 4)//cpf
                query = query.Where(c => c.documento == valorConsulta).ToList();
            else if (filtro.tipoConsulta == 5)//domicílio bancário
                query = query.Where(c => c.domicilioBancario == valorConsulta).ToList();
            else if (filtro.tipoConsulta == 6)//nr de operação
                query = query.Where(c => c.numeroOperacao == int.Parse(valorConsulta)).ToList();

            OperacaoModel retorno = new OperacaoModel();

            if (query.Count() > 0)
            {
                List<OperacaoModel> vetor = new List<OperacaoModel>();

                foreach (Data.mk_simulacao saiBD in query)
                {
                    OperacaoModel saiTemp = new OperacaoModel();
                    saiTemp.codigoEC = Convert.ToInt32(saiBD.codigoEc);
                    saiTemp.dataOperacao = timeStamp.GetTimeStamp();
                    saiTemp.dataPagamento = timeStamp.GetTimeStamp();
                    saiTemp.documento = saiBD.documento;
                    saiTemp.idCanal = 7;
                    saiTemp.idOperacao = Convert.ToInt32(saiBD.numeroOperacao);
                    saiTemp.nome = saiBD.nome;
                    saiTemp.nomeCanal = "PORTAL";
                    saiTemp.situacao = Convert.ToInt32(saiBD.situacao);
                    saiTemp.situacaoDesc = saiBD.situacaoDesc;
                    saiTemp.tipoPessoa = "J";
                    saiTemp.tipoSelecao = "1";
                    saiTemp.valorBruto = Convert.ToDouble(saiBD.valorBruto);
                    saiTemp.valorDesconto = Convert.ToDouble(saiBD.valorBruto = saiBD.valorLiquido);
                    saiTemp.valorLiquido = Convert.ToDouble(saiBD.valorLiquido); ;

                    vetor.Add(saiTemp);
                }

                return vetor.ToArray();
            }
            else
                return null;
        }

        [AcceptVerbs("POST")]
        [Route("detalhe")]
        public SimulacaoModel[] detalhe(FiltroConfirmaOperacaoModel filtro)
        {
            if (Request.Headers.Contains("Cookie"))
                if (cookie != Request.Headers.GetValues("Cookie").First())
                    return null;

            Data.GPContainer1 db = new Data.GPContainer1();
            int idEC = 0;
            int idOperacao = filtro.idOperacao;

            if (idOperacao != 0)
            {
                List<Data.mk_simulacao> query = db.mk_simulacao.Where(c => (c.icConcluida == true) && c.numeroOperacao == idOperacao).ToList();

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
                        idEC = Convert.ToInt32(saiBD.idEC);

                        dadOpList.Add(dadOp);
                        saiTemp.dadosOperacao = dadOpList;

                        

                        //agendas
                        List<Data.mk_agendas> queryAgendas = db.mk_agendas.Where(c => c.idEC == idEC).ToList();
                        List<SimulacaoModel.Agendas> dadosAgendas = new List<SimulacaoModel.Agendas>();
                        if (queryAgendas.Count() > 0)
                        {
                            foreach (Data.mk_agendas saiDBagendas in queryAgendas)
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
                            foreach (Data.mk_lojas saiDBlojas in queryLojas)
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
