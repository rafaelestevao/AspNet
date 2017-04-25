using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WFA_Consume_WebApi_Rest
{
    public class ServicoAntecipacao
    {
        private string url = "http://localhost:8085";//"http://hom10.cardsutility.eds.com.br/CMS-ACQUIRER-APS";
        private string usuarioServico = "portal_gp2";
        private string tokenServico = "QALLVWNFWHCH0XE55CMI1FMP6KWQU9XNU1WW07VEFR7IJWZMNG13VCN069O5H33Z";
        private string canalServico = "WEB";
        private string cookieServico = "authaccess_v2";

        /// <summary>
        /// TIPO DO CONTEUDO QUE VAMOS USAR
        /// </summary>
        private string contentType = "application/json; charset=utf-8";

        /// <summary>
        /// OBJETO PARA REALIZAR REQUISIÇÕES
        /// </summary>
        private System.Net.WebRequest webRequest;

        /// <summary>
        /// PREPARA O NOSSO OBJETO DE REQUISIÇÕES PARA CADA OPERAÇÃO
        /// </summary>
        /// <param name="operacao"></param>
        /// <param name="metodo"></param>
        public void PreparaWebRequest(string operacao, string metodo)
        {
            webRequest = System.Net.WebRequest.Create(url + "/" + operacao);
            webRequest.Method = metodo;
            webRequest.Headers["Cookie"] = cookieServico + "=\"" + usuarioServico + "|" + tokenServico + "|" + canalServico + "\"";
            //webRequest.ContentLength = 0; //caso tenha erro, add esse parâmetro
            webRequest.ContentType = this.contentType;
        }

        /// <summary>
        /// ESSE MÉTODO RETORNA UM Dictionary QUANDO O JSON PASSADO FOR UMA STRING COM CHAVE E VALOR
        /// ----------------------------------------------------------------------------------------
        /// EXEMPLO: "{\"InserirNovoRegistroResult\":\"Registro inserido com sucesso!\"}" 
        /// ----------------------------------------------------------------------------------------
        /// </summary>
        /// <param name="json"></param>
        /// <returns></returns>
        public Dictionary<string, string> DeserializeString(string json)
        {

            string[] resultado = json.Replace("{", string.Empty)
                                .Replace("}", string.Empty)
                                .Replace(@"\", string.Empty)
                                .Replace("\"", string.Empty).Split(':');

            Dictionary<string, string> saida = new Dictionary<string, string>();

            saida.Add(resultado[0], resultado[1]);

            return saida;
        }
        /// <summary>
        /// ESSE MÉTODO TORNAR UM OBJETO EM STRING JSON PARA ENVIARMOS PARA O SERVIÇO REST
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="objeto"></param>
        /// <returns></returns>
        public string Serialize<T>(T objeto)
        {
            System.Runtime.Serialization.Json.DataContractJsonSerializer serializer = new System.Runtime.Serialization.Json.DataContractJsonSerializer(objeto.GetType());

            System.IO.MemoryStream memoryStream = new System.IO.MemoryStream();

            serializer.WriteObject(memoryStream, objeto);

            string stringJson = Encoding.UTF8.GetString(memoryStream.ToArray());

            return stringJson;
        }
        /// <summary>
        /// ESSE MÉTODO TRANSFORMA UMA STRING JSON EM UM OBJETO QUE É PASSADO NO TIPO GENÉRICO (T)
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="stringJson"></param>
        /// <returns></returns>
        public T Deserialize<T>(string stringJson)
        {
            T objeto = Activator.CreateInstance<T>();

            System.IO.MemoryStream memoryStream = new System.IO.MemoryStream(Encoding.Unicode.GetBytes(stringJson));

            System.Runtime.Serialization.Json.DataContractJsonSerializer serializer = new System.Runtime.Serialization.Json.DataContractJsonSerializer(objeto.GetType());

            objeto = (T)serializer.ReadObject(memoryStream);

            memoryStream.Close();

            return objeto;
        }



        /// <summary>
        /// ESSE MÉTODO VAI CHAMAR A OPERAÇÃO PARA INSERIR UM NOVO REGISTRO DO SERVIÇO REST
        /// </summary>
        /// <param name="usuarioEntity"></param>
        /// <returns></returns>
        public Estabelecimento[] ListarCentrais(FiltroEstabelecimentos filtro, ref int iqtdTotalRegistros)
        {
            PreparaWebRequest("estabelecimentos/listar-centrais", "POST");
            string jsonSerialize = Serialize<FiltroEstabelecimentos>(filtro);

            using (var streamWriter = new System.IO.StreamWriter(webRequest.GetRequestStream()))
            {
                streamWriter.Write(jsonSerialize);
                streamWriter.Flush();
                streamWriter.Close();
            }

            var response = (System.Net.HttpWebResponse)webRequest.GetResponse();
            string resultadoJson = null;

            using (var streamReader = new System.IO.StreamReader(response.GetResponseStream()))
                resultadoJson = streamReader.ReadToEnd();

            if (!string.IsNullOrEmpty(resultadoJson))
            {
                iqtdTotalRegistros = Deserialize<List<Estabelecimento>>(resultadoJson).ToArray().Count();
                return Deserialize<List<Estabelecimento>>(resultadoJson).ToArray();
            }
            else
                return null;
        }

        //public Simulacao[] Simulacao(FiltroSimulacao filtro, ref int iqtdTotalRegistros)
        //{
        //    PreparaWebRequest("simulacao", "POST");
        //    string jsonSerialize = Serialize<FiltroSimulacao>(filtro);

        //    using (var streamWriter = new System.IO.StreamWriter(webRequest.GetRequestStream()))
        //    {
        //        streamWriter.Write(jsonSerialize);
        //        streamWriter.Flush();
        //        streamWriter.Close();
        //    }

        //    var response = (System.Net.HttpWebResponse)webRequest.GetResponse();
        //    string resultadoJson = null;

        //    using (var streamReader = new System.IO.StreamReader(response.GetResponseStream()))
        //        resultadoJson = streamReader.ReadToEnd();

        //    if (!string.IsNullOrEmpty(resultadoJson))
        //    {
        //        iqtdTotalRegistros = Deserialize<List<Simulacao>>(resultadoJson).ToArray().Count();
        //        return Deserialize<List<Simulacao>>(resultadoJson).ToArray();
        //    }
        //    else
        //        return null;
        //}

        //public OperacaoConfirmar Confirmar(FiltroConfirmaOperacao filtro)
        //{
        //    PreparaWebRequest("simulacao", "POST");
        //    string jsonSerialize = Serialize<FiltroConfirmaOperacao>(filtro);

        //    using (var streamWriter = new System.IO.StreamWriter(webRequest.GetRequestStream()))
        //    {
        //        streamWriter.Write(jsonSerialize);
        //        streamWriter.Flush();
        //        streamWriter.Close();
        //    }

        //    var response = (System.Net.HttpWebResponse)webRequest.GetResponse();
        //    string resultadoJson = null;

        //    using (var streamReader = new System.IO.StreamReader(response.GetResponseStream()))
        //        resultadoJson = streamReader.ReadToEnd();

        //    if (!string.IsNullOrEmpty(resultadoJson))
        //        return Deserialize<List<OperacaoConfirmar>>(resultadoJson).First();
        //    else
        //        return null;
        //}

        //public OperacaoCancelar Cancelar(FiltroConfirmaOperacao filtro)
        //{
        //    PreparaWebRequest("simulacao", "POST");
        //    string jsonSerialize = Serialize<FiltroConfirmaOperacao>(filtro);

        //    using (var streamWriter = new System.IO.StreamWriter(webRequest.GetRequestStream()))
        //    {
        //        streamWriter.Write(jsonSerialize);
        //        streamWriter.Flush();
        //        streamWriter.Close();
        //    }

        //    var response = (System.Net.HttpWebResponse)webRequest.GetResponse();
        //    string resultadoJson = null;

        //    using (var streamReader = new System.IO.StreamReader(response.GetResponseStream()))
        //        resultadoJson = streamReader.ReadToEnd();

        //    if (!string.IsNullOrEmpty(resultadoJson))
        //        return Deserialize<List<OperacaoCancelar>>(resultadoJson).First();
        //    else
        //        return null;
        //}

        //public Operacao[] Lista(FiltroOperacaoLista filtro, ref int iqtdTotalRegistros)
        //{
        //    PreparaWebRequest("simulacao", "POST");
        //    string jsonSerialize = Serialize<FiltroOperacaoLista>(filtro);

        //    using (var streamWriter = new System.IO.StreamWriter(webRequest.GetRequestStream()))
        //    {
        //        streamWriter.Write(jsonSerialize);
        //        streamWriter.Flush();
        //        streamWriter.Close();
        //    }

        //    var response = (System.Net.HttpWebResponse)webRequest.GetResponse();
        //    string resultadoJson = null;

        //    using (var streamReader = new System.IO.StreamReader(response.GetResponseStream()))
        //        resultadoJson = streamReader.ReadToEnd();

        //    if (!string.IsNullOrEmpty(resultadoJson))
        //    {
        //        iqtdTotalRegistros = Deserialize<List<Operacao>>(resultadoJson).ToArray().Count();
        //        return Deserialize<List<Operacao>>(resultadoJson).ToArray();
        //    }
        //    else
        //        return null;
        //}

        //public Simulacao[] Detalhe(FiltroConfirmaOperacao filtro, ref int iqtdTotalRegistros)
        //{
        //    PreparaWebRequest("simulacao", "POST");
        //    string jsonSerialize = Serialize<FiltroConfirmaOperacao>(filtro);

        //    using (var streamWriter = new System.IO.StreamWriter(webRequest.GetRequestStream()))
        //    {
        //        streamWriter.Write(jsonSerialize);
        //        streamWriter.Flush();
        //        streamWriter.Close();
        //    }

        //    var response = (System.Net.HttpWebResponse)webRequest.GetResponse();
        //    string resultadoJson = null;

        //    using (var streamReader = new System.IO.StreamReader(response.GetResponseStream()))
        //        resultadoJson = streamReader.ReadToEnd();

        //    if (!string.IsNullOrEmpty(resultadoJson))
        //    {
        //        iqtdTotalRegistros = Deserialize<List<Simulacao>>(resultadoJson).ToArray().Count();
        //        return Deserialize<List<Simulacao>>(resultadoJson).ToArray();
        //    }
        //    else
        //        return null;
        //}
    }
}
